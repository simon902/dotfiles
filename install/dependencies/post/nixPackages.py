#!/usr/bin/env python3
# Install the packages from install/nix-packages.txt that aren't in the Nix profile yet (non-Arch hosts only).

import json
import shutil
import subprocess
import sys
from pathlib import Path

if shutil.which("pacman") or not shutil.which("nix"):
    sys.exit(0)

config_root = Path(sys.argv[1])
package_file = config_root / "install" / "nix-packages.txt"

# Whole-line comments only, since installables themselves contain "#"
wanted = [
    line.strip() for line in package_file.read_text().splitlines()
    if line.strip() and not line.strip().startswith("#")
]

profile = json.loads(subprocess.run(
    ["nix", "profile", "list", "--json"], capture_output=True, text=True, check=True
).stdout)


def is_installed(installable):
    # nixpkgs#foo.bar -> originalUrl "flake:nixpkgs", attrPath "legacyPackages.<system>.foo.bar"
    # github:owner/repo -> originalUrl "github:owner/repo", attrPath "packages.<system>.default"
    flake, _, attr = installable.partition("#")
    url = "flake:" + flake if ":" not in flake else flake
    for element in profile.get("elements", {}).values():
        if element.get("originalUrl") != url:
            continue
        attr_path = element.get("attrPath", "")
        if (attr and attr_path.split(".", 2)[-1] == attr) or (not attr and attr_path.endswith(".default")):
            return True
    return False


missing = [p for p in wanted if not is_installed(p)]
if not missing:
    print("nix: all packages from nix-packages.txt are installed")
    sys.exit(0)

print("nix: installing " + " ".join(missing))
# --impure is needed by nixGL, which detects the host's GPU driver
subprocess.run(["nix", "profile", "install", "--impure", *missing], check=False)
