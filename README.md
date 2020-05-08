## Stow usage
    * default action should be:
        stow -t ~ <name> --no-folding
    * --no-folding creates directories instead of linking them
    * to unstow:
        stow -t ~ -D app_folder
    * enable services with:
        systemctl --user enable <service_name>

## Environment variables
* As a rule of a thumb we want to set options in files that are used by
  login shells, not interactive shells so they're set only once, not every
  time you create new tmux window
* Use '~/.bash_profile' for vars that are read on login and are inherited
  by all new shells
* Use '~/.bashrc' for functions and aliases
* Don't edit '/etc/profile' create '/etc/profile.d/<name>.sh' script instead
* '/etc/environment' can be used for simple 'key=value' options

GNUPG: mkdir --mode=700 $GNUPGHOME

## TODO
- write stow script
