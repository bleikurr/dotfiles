# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc


export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'

export GOPATH=$HOME/Go


# ----------------------------------------------------------
# Text styling
# ----------------------------------------------------------
#bold=$(tput bold)
#underline=$(tput smul)
#italic=$(tput sitm)
#info=$(tput setaf 2)
#error=$(tput setaf 160)
#warn=$(tput setaf 214)
#reset=$(tput sgr0)


# ----------------------------------------------------------
# Alias'
# ----------------------------------------------------------
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# ----------------------------------------------------------
# PATH
# ----------------------------------------------------------
export PATH=$HOME/Go/bin:$HOME/.bin:$PATH

if [ -f ~/.cargo/env ]; then
    . "$HOME/.cargo/env"
fi



if [ -f ~/.config/bashrc.local ]; then
    source ~/.config/bashrc.local
fi

PS1="\w $ "
