import json
from pathlib import Path
import os
import shutil
import subprocess
from enum import Enum

class DependencyType(Enum):
    PRE = "pre"
    POST = "post"


HOME_PATH = Path(os.environ["HOME"])
CONFIG_ROOT_PATH = Path()


def setConfigRoot():
    global CONFIG_ROOT_PATH
    CONFIG_ROOT_PATH = Path(__file__).parent.parent.resolve()


def getConfigJsonFilePath():
    new_path = CONFIG_ROOT_PATH / "install" / "config.json"
    if not new_path.exists():
        raise Exception("config.json path does not exist.") 
    
    return new_path


def checkAndPromptBackupDeletion():
    backup_dir = CONFIG_ROOT_PATH / ".backup"
    
    if not backup_dir.exists():
        return False
    
    while True:
        print("Backup from earlier install exists.\nDo you want do delete it y/N:")
        delete_backup = input("==> ")
        if delete_backup == "" or delete_backup == "y" or delete_backup == "n":
            break
        print("Input \"y\" or \"n\"!")
    
    if delete_backup == "y":
        return True
    
    print("Aborting installation: Either delete the backup or enter \"y\"!")
    exit(-1)


def checkForBackup(config):

    def innerCeckForBackup(files, multi_config=False):
        do_backup = False

        for file in files:
            link_src = CONFIG_ROOT_PATH / file
            link_dest = HOME_PATH / file

            if not link_dest.exists():
                continue
            if not multi_config and link_src == link_dest.resolve():
                continue
            if multi_config and link_src == link_dest.resolve().parent:
                continue

            # print(f"DO backup: {link_dest}")
            do_backup = True
            if checkAndPromptBackupDeletion():
                shutil.rmtree(CONFIG_ROOT_PATH / ".backup")
            break

        return do_backup
    
    if innerCeckForBackup(config["files"]):
        return True
    if innerCeckForBackup(config["multi-configs"].values(), True):
        return True
    return False


def runExecutable(exe, *args):
    command = [exe] + list(args)

    subprocess.run(command, stderr=subprocess.DEVNULL)


def handleDependencies(dependency_type : DependencyType):
    dependency_path = CONFIG_ROOT_PATH / "install" / "dependencies" / dependency_type.value

    template_path = dependency_path / "templates"

    for dependency in dependency_path.iterdir():
        if dependency.is_dir():
            continue

        runExecutable(dependency, CONFIG_ROOT_PATH, template_path)


def createDirectory(path : Path):
    path.mkdir(parents=True, exist_ok=True)


def createDirectories(config):
    for directory in config["directories"]:
        createDirectory(HOME_PATH / directory)


def backupAndLinkFile(src : str, dest : str, do_backup : bool):
    link_src = CONFIG_ROOT_PATH / src
    link_dest = HOME_PATH / dest

    if do_backup and link_dest.exists() and not link_src == link_dest.resolve():
        backup_path = CONFIG_ROOT_PATH / ".backup" / dest
        if link_dest.is_dir():
            shutil.copytree(link_dest, backup_path, symlinks=True)
        else:
            createDirectory(backup_path.parent)
            backup_path.write_bytes(link_dest.read_bytes())

    if link_dest.exists(follow_symlinks=False):
        if link_dest.is_dir() and not link_dest.is_symlink():
            shutil.rmtree(link_dest)
        else:
            link_dest.unlink()

    createDirectory(link_dest.parent)
    link_dest.symlink_to(link_src)


def linkConfigs(config, do_backup : bool):

    for file in config["files"]:
        backupAndLinkFile(file, file, do_backup)


def handleMultipleConfigs(config, do_backup : bool):
    for prog, path in config["multi-configs"].items():
        path_ext = CONFIG_ROOT_PATH / path
        config_dirs = [file.name for file in path_ext.iterdir()]
        config_dirs.sort()

        print(f"Multiple configs for {prog} found:")
        for i, name in enumerate(config_dirs):
            print(f"[{i + 1}] \t {name}")
        print("\nPlease select an option by entering the number (default 1)")
        while True:
            user_choice = input("==> ")
            if user_choice == "" or user_choice in [str(i) for i in range(1, len(config_dirs) + 1)]:
                break
        
        user_choice = config_dirs[0] if user_choice == "" else config_dirs[int(user_choice) - 1]

        backupAndLinkFile(Path(path) / user_choice, path, do_backup)



def main():
    setConfigRoot()
    config_file = getConfigJsonFilePath()

    with open(config_file) as f:
        config = json.load(f)

    do_backup = checkForBackup(config)

    handleDependencies(DependencyType.PRE)
    createDirectories(config)

    linkConfigs(config, do_backup)
    handleMultipleConfigs(config, do_backup)

    handleDependencies(DependencyType.POST)

if __name__ == '__main__':
    main()