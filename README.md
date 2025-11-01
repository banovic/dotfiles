# How Bash Profile Files Work
Bash reads different configuration files depending on how it's invoked:

## File Loading Order

### 1. For Login Shells (e.g., SSH, console login, using `su -`):

`/etc/profile` - System-wide settings (on Slackware it runs scripts in `/etc/profile.d/*`)
Then the first found of these (in order):

`~/.bash_profile`
`~/.bash_login`
`~/.profile`


On logout: `~/.bash_logout`

### 2. For Interactive Non-Login Shells (e.g., opening a terminal in GUI):

`/etc/bash.bashrc` (on some systems)
`~/.bashrc`

Best Practice: Keep `~/.profile` minimal and have it source `~/.bashrc` so settings work in both login and non-login shells.
Use `~/.bash_profile` if commited to bash or if specific bash functionality is needed.
