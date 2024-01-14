#!/usr/bin/env python3

import json
import subprocess


def get_clients() -> list[dict]:
    cmd = ["hyprctl", "clients", "-j"]

    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    return json.loads(str(p.stdout.decode()))


def get_clients_per_workspaces(clients: list[dict]) -> dict[int, list]:
    workspaces: dict[int, list] = {}

    for client in clients:
        workspace = client["workspace"]["id"]

        if workspace == -1:
            continue

        if workspace not in workspaces:
            workspaces[workspace] = []

        workspaces[workspace].append(client["address"])

    return workspaces


def trim_workspaces(workspaces: dict[int, list]) -> None:
    ordered_workspaces = sorted(list(workspaces.keys()))
    target_workspaces = [i for i in range(1, len(workspaces.keys()) + 1)]

    for current, target in zip(ordered_workspaces, target_workspaces):
        if current != target:
            for address in workspaces[current]:
                cmd = ["hyprctl", "dispatch", "movetoworkspacesilent", f"{target},address:{address}"]

                subprocess.run(cmd)


def switch_current_workspace(old_workspaces: list[int], new_workspaces: list[int]) -> None:
    cmd = ["hyprctl", "activeworkspace", "-j"]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    active_workspace = json.loads(p.stdout.decode())["id"]
    
    new_workspace = new_workspaces[old_workspaces.index(active_workspace)]
    cmd = ["hyprctl", "dispatch", "workspace", str(new_workspace)]
    subprocess.run(cmd)


def main():
    clients = get_clients()
    workspaces = get_clients_per_workspaces(clients)

    old_workspaces = sorted(list(workspaces.keys()))
    new_workspaces = [i for i in range(1, len(workspaces.keys()) + 1)]

    trim_workspaces(workspaces)
    switch_current_workspace(old_workspaces, new_workspaces)


if __name__ == "__main__":
    main()
