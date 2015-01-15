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
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['<Super>7']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['<Super>8']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "['<Super>9']"
# other
dconf write /org/gnome/desktop/wm/keybindings/maximize-vertically "['<Super>backslash']"

# terminal
dconf write /org/gnome/terminal/legacy/dark-theme true
dconf write /org/gnome/terminal/legacy/default-show-menubar false
dconf write /org/gnome/terminal/legacy/mnemonics-enabled false
dconf write /org/gnome/terminal/legacy/schema-version 3
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-1 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-2 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-3 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-4 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-5 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-6 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-7 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-8 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-9 disabled
dconf write /org/gnome/terminal/legacy/keybindings/switch-to-tab-10 disabled
