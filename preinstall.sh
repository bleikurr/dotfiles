#!/bin/bash

# Install Oh-My-Zsh
if [ "$ZSH" == "" -a -f "/bin/bash" ]; then
    rm -rf ~/.oh-my-zsh
    echo "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ -f ~/.zshrc ]; then
    if [ ! -L ~/.zshrc ]; then rm ~/.zshrc; fi
fi

if [ -f ~/.bashrc ]; then
    if [ ! -L ~/.bashrc ]; then rm ~/.bashrc; fi
fi


