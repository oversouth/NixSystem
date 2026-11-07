#!/usr/bin/env python3
"""Small helpers for Hyprland touchpad gestures."""

import json
import subprocess
import sys


def hyprctl(*args):
    return subprocess.check_output(["hyprctl", *args], text=True)


def switch_workspace(direction):
    current = int(json.loads(hyprctl("-j", "activeworkspace"))["id"])
    target = (current - 1 + direction) % 2 + 1
    subprocess.run(["hyprctl", "dispatch", "workspace", str(target)], check=False)


def close_under_cursor():
    cursor = json.loads(hyprctl("-j", "cursorpos"))
    x, y = cursor["x"], cursor["y"]
    clients = json.loads(hyprctl("-j", "clients"))
    candidates = []
    for client in clients:
        if not client.get("mapped", True):
            continue
        left, top = client.get("at", [0, 0])
        width, height = client.get("size", [0, 0])
        if left <= x < left + width and top <= y < top + height:
            # When surfaces overlap, prefer the most recently focused match.
            candidates.append(client)
    if candidates:
        target = min(candidates, key=lambda client: client.get("focusHistoryID", 1 << 30))
        subprocess.run(
            ["hyprctl", "dispatch", "closewindow", f"address:{target['address']}"],
            check=False,
        )


if __name__ == "__main__":
    action = sys.argv[1]
    if action == "next":
        switch_workspace(1)
    elif action == "previous":
        switch_workspace(-1)
    elif action == "close-under-cursor":
        close_under_cursor()
