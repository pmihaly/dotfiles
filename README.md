# dotfiles

## Prerequisites

1. Installed arch linux instance
2. [Paru](https://github.com/morganamilo/paru) or some other AUR helper
  - Install `python-pywal` from the AUR
3. My build of [dwm](https://github.com/pmihaly/dwm), [dmenu](https://github.com/pmihaly/dmenu), [slock](https://github.com/pmihaly/slock), [slstatus](https://github.com/pmihaly/slstatus) and [st](https://github.com/pmihaly/st) compiled and installed
  - Run `wal --theme base16-nord` to compile the colorscheme into the programs, **otherwise the compilation fails**
  - Don't forget to set `wifi_` and `battery_` commands in `config.h` of slstatus (or strip it out if you don't need it)

## Installation

1. Remove `.bashrc` and `.bash_profile`
2. `git clone --bare https://github.com/pmihaly/dotfiles $HOME/.dotfiles`
3. `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout`

## Usage

To manage the dotfiles, use the `dfs` git alias.
If no arguments are provided, it'll run `git status`
