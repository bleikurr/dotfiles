#!/usr/bin/env bash

NORMAL="\e[0m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
function _l() {
    # Make symbolic link
    target="$1"
    link="$2"

    if [[ -z "$target" ]]; then
        echo "Missing 'target' parameter"
        exit 1
    elif [[ -z "$link" ]]; then
        echo "Missing 'link' parameter"
        exit 1
    fi

    target="$PWD/$target"

    current_link=$(readlink $link)
    if [[ "$current_link" == "$target" ]]; then
        echo -e "${GREEN}$link  ${NORMAL}"
        return
    fi

    linkdir=$(dirname "$link")
    mkdir -p "$linkdir" # Create directories if don't exist

    ln_output=$(ln -svf "$target" "$link" &> /dev/null)
    if [[ $? -eq 0 ]]; then
        echo -e "${YELLOW}$target -> $link${NORMAL}"
    else
        echo -e "${RED}$target -> $link${NORMAL}"
    fi
}

mkdir -p ~/.local/var/log

_l backgrounds      ~/.local/share/backgrounds
_l vim-asksudo.sh   ~/.local/bin/vim
_l nvim             ~/.config/nvim 
_l sway             ~/.config/sway
_l dunstrc          ~/.config/dunst/dunstrc
_l waybar           ~/.config/waybar
_l swaylock         ~/.config/swaylock
