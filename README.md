# dotfiles

## Prerequisites

1. Installed arch linux instance
2. [Paru](https://github.com/morganamilo/paru) or some other AUR helper
  - Install `python-pywal` from the AUR
3. My build of [dwm](https://github.com/pmihaly/dwm), [dmenu](https://github.com/pmihaly/dmenu), [slock](https://github.com/pmihaly/slock), [slstatus](https://github.com/pmihaly/slstatus) and [st](https://github.com/pmihaly/st) compiled and installed
  - Run `wal --theme base16-nord` to compile the colorscheme into the programs, **otherwise the compilation fails**
  - Don't forget to set `wifi_` and `battery_` commands in `config.h` of slstatus (or strip it out if you don't need it)

## Installation

**REPLACE <USER HERE> WITH YOUR USERNAME**
1. `sudo pacman -S opendoas && su root -c 'echo "permit persist keepenv <USER HERE> as root" > /etc/doas.conf' && sudo pacman -Rns sudo`
2. `sudo pacman -S zsh && sudo chsh $USER && sudo pacman -Rns bash`
3. `rm .bash*`
4. `git clone --bare https://github.com/pmihaly/dotfiles $HOME/.dotfiles`
5. `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout`
6. `source .zshrc && dotfiles config --local status.showUntrackedFiles no`
7. `paru -S --needed - < .config/pkgs`

## Usage

To manage the dotfiles, use the `dfs` git alias.
If no arguments are provided, it'll run `git status`
