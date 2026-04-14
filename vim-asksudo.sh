#!/usr/bin/env bash
# Open file as sudo if not allowed to write

file="$1"
editor=/usr/bin/nvim

# If no file provided, just run $editor normally
if [ -z "$file" ]; then
    command $editor
    exit $?
fi

# Function to prompt for sudo $editor
prompt_sudo() {
    read -p "No write permission. Open with sudo? (y/N/q): " choice
    case "$choice" in
        y|Y) sudo $editor "$file" ;;
        q|Q) echo "Aborted" ;;
        *) $editor $file ;;
    esac
}

# If file exists
if [ -e "$file" ]; then
    if [ -w "$file" ]; then
        command $editor "$file"
    else
        prompt_sudo
    fi
else
    # File does not exist — check directory permissions
    dir="$(dirname "$file")"

    # If directory doesn't exist, fallback to $editor error
    if [ ! -d "$dir" ]; then
        command $editor "$file"
        exit $?
    fi

    if [ -w "$dir" ]; then
        command $editor "$file"
    else
        prompt_sudo
    fi
fi
