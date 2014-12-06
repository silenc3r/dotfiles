#!/bin/bash

# Shift+Super+number moves window to given workspace
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1 "['<Shift><Super>exclam']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2 "['<Shift><Super>at']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3 "['<Shift><Super>numbersign']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4 "['<Shift><Super>dollar']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5 "['<Shift><Super>percent']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6 "['<Shift><Super>asciicircum']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7 "['<Shift><Super>ampersand']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8 "['<Shift><Super>asterisk']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-9 "['<Shift><Super>parenleft']"
# Super+number switches to workspace
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "[<Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "[<Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "[<Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "[<Super>4']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "[<Super>5']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "[<Super>6']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "[<Super>7']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "[<Super>8']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "[<Super>9']"

# terminal
dconf write /org/gnome/terminal/legacy/dark-theme true
dconf write /org/gnome/terminal/legacy/default-show-menubar false
