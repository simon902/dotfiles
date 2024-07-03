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
        delete_backup = input("Backup from earlier install exists. Do you want do delete it y/N: ")
        if delete_backup == "" or delete_backup == "y" or delete_backup == "n":
            break
        print("Input \"y\" or \"n\"!")
    
    if delete_backup == "y":
        return True
    
    print("Aborting installation: Either delete the backup or enter \"y\"!")
    exit(-1)


def checkForBackup(config):

    do_backup = False

    for file in config["files"]:
        link_src = CONFIG_ROOT_PATH / file
        link_dest = HOME_PATH / file

        if link_dest.exists() and not link_src == link_dest.resolve():
            print(f"DO backup: {link_dest}")
            do_backup = True
            if checkAndPromptBackupDeletion():
                shutil.rmtree(CONFIG_ROOT_PATH / ".backup")
            break

    return do_backup


def runExecutable(exe : str, root_path=True, *args):
    first_args = [exe]
    if root_path:
        first_args.append(CONFIG_ROOT_PATH)
    subprocess.run(first_args + list(args), stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def handleDependencies(dependency_type : DependencyType):
    dependency_path = CONFIG_ROOT_PATH / "install" / "dependencies" / dependency_type.value

    for dependency in dependency_path.iterdir():
        runExecutable(dependency)


def createDirectory(path : Path):
    path.mkdir(parents=True, exist_ok=True)


def createDirectories(config):
    for directory in config["directories"]:
        createDirectory(HOME_PATH / directory)


def linkConfigs(config, do_backup : bool):

    for file in config["files"]:
        link_src = CONFIG_ROOT_PATH / file
        link_dest = HOME_PATH / file

        if do_backup and link_dest.exists() and not link_src == link_dest.resolve():
            backup_path = CONFIG_ROOT_PATH / ".backup" / file
            if link_dest.is_dir():
                shutil.copytree(link_dest, backup_path)
            else:
                createDirectory(backup_path.parent)
                backup_path.write_bytes(link_dest.read_bytes())

        if link_dest.exists():
            if link_dest.is_dir() and not link_dest.is_symlink():
                shutil.rmtree(link_dest)
            else:
                link_dest.unlink()


        link_dest.symlink_to(link_src)


def handleMultipleConfigs(config):
    # TODO
    pass


def main():
    setConfigRoot()
    config_file = getConfigJsonFilePath()

    with open(config_file) as f:
        config = json.load(f)

    do_backup = checkForBackup(config)

    handleDependencies(DependencyType.PRE)
    createDirectories(config)

    linkConfigs(config, do_backup)
    handleMultipleConfigs(config)

    handleDependencies(DependencyType.POST)

if __name__ == '__main__':
    main()