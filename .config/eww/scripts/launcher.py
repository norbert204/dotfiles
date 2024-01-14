#!/usr/bin/env python3

import json
import os
from sys import argv

PATHS = {
    "default": "/usr/share/applications",
    "local": "~/.local/share/applications",
}

ICONS_DIR = "/usr/share/icons"
ICON_THEME = "Papirus-Dark"

CACHE = "/tmp/eww_launcher_cache.json"


def get_icon(icon_name: str) -> str:
    path = f"{ICONS_DIR}/{ICON_THEME}/24x24/apps/{icon_name}.svg"

    if os.path.exists(path):
        return path
    else:
        return f"{ICONS_DIR}/{ICON_THEME}/24x24/mimetypes/{icon_name}.svg"


def get_app_info(path: str, source: str) -> dict:
    # TODO: Use toml parsing instead!

    with open(path, "r") as f:
        content = f.read()

        icon = "application-x-executable"
        name = path

        lines = content.splitlines()

        for line in lines[::-1]:
            if line.startswith("Name="):
                name = line[line.index("=")+1:]

            if line.startswith("Icon="):
                icon = get_icon(line[line.index("=")+1:])

        return {
            "name": name,
            "icon": icon,
            "path": path,
            "flatpak": False,
            "from": source,
        }


def generate_cache_file():
    apps = []
    
    for name, path in PATHS.items():
        if path.startswith("~"):
            path = os.path.expanduser("~") + path[1:]

        files = [os.path.join(path, x) for x in os.listdir(path) if os.path.isfile(os.path.join(path, x)) and x.endswith(".desktop")]
        apps += [get_app_info(x, name) for x in files]

    apps = sorted(apps, key=lambda x: x["name"])

    with open(CACHE, "w") as f:
        json.dump(apps, f, indent=2)


def main():
    search_for = "" if len(argv) == 1 else argv[-1].lower()

    if len(argv) > 1 and argv[1] == "--regenare-cache" or not os.path.exists(CACHE):
        generate_cache_file()
    
    with open(CACHE, "r") as f:
        apps: list[dict] = json.load(f)

        apps = [x for x in apps if search_for in x["name"].lower() or search_for in x["path"].lower()]
        
        apps = sorted(apps, key=lambda x: x["name"])

        print(json.dumps(apps, indent=2))


if __name__ == "__main__":
    main()
