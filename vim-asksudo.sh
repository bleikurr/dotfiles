#!/usr/bin/env bash
# vim — permission-aware wrapper around the real vim/nvim (or really  an editor
# of choice). If the user lacks write access, offers to re-open with sudo.

set -euo pipefail

# User options
EDITOR=nvim

# In
VIM_ARGS=("$@")

# ── locate the real vim (skip this script if it lives on PATH) ───────────────
REAL_VIM="$(command -v $EDITOR 2>/dev/null || true)"
if [[ -z "$REAL_VIM" ]]; then
    echo "vim: $EDITOR not found in PATH" >&2
    exit 1
fi
# Guard against calling ourselves when this script is on PATH
if [[ "$(realpath "$REAL_VIM")" == "$(realpath "$0")" ]]; then
    echo "vim: could not locate the real $EDITOR binary" >&2
    exit 1
fi

# ── helpers ──────────────────────────────────────────────────────────────────
ask_sudo() {
    local file="$1"
    printf 'You do not have write permission for "%s".\n' "$file" >&2
    printf 'Open with sudo? [y/N] '
    read -r answer </dev/tty
    case "$answer" in
        [yY])
            exec sudo "$REAL_VIM" "${VIM_ARGS[@]}"
            ;;
        *)
            exec "$REAL_VIM" "${VIM_ARGS[@]}"
            ;;
    esac
}

# ── find the first plain file/path argument ──────────────────────────────────
# (skip vim option flags that start with - or +)
TARGET=""
for arg in "${VIM_ARGS[@]}"; do
    case "$arg" in
        -*|+*) continue ;;
        *)     TARGET="$arg"; break ;;
    esac
done

# ── no file argument → just open vim normally ────────────────────────────────
if [[ -z "$TARGET" ]]; then
    exec "$REAL_VIM" "${VIM_ARGS[@]}"
fi

# ── permission check ─────────────────────────────────────────────────────────
if [[ -e "$TARGET" ]]; then
    # File (or directory) exists — check write permission directly
    if [[ ! -w "$TARGET" ]]; then
        ask_sudo "$TARGET" "${VIM_ARGS[@]}"
    fi
else
    # File does not exist — check write permission on the parent directory
    PARENT_DIR="$(dirname "$TARGET")"
    # dirname returns "." for bare filenames; resolve it
    PARENT_DIR="$(realpath -m "$PARENT_DIR" 2>/dev/null || echo "$PARENT_DIR")"

    if [[ ! -d "$PARENT_DIR" ]]; then
        # Parent directory itself doesn't exist; let vim handle the error
        exec "$REAL_VIM" "${VIM_ARGS[@]}"
    fi

    if [[ ! -w "$PARENT_DIR" ]]; then
        printf 'File "%s" does not exist and you do not have write permission in "%s".\n' \
               "$TARGET" "$PARENT_DIR" >&2
        printf 'Open with sudo? [y/N] '
        read -r answer </dev/tty
        case "$answer" in
            [yY]|[yY][eE][sS])
                exec sudo "$REAL_VIM" "${VIM_ARGS[@]}"
                ;;
            *)
                exec "$REAL_VIM" "${VIM_ARGS[@]}"
                ;;
        esac
    fi
fi

# ── all good — open normally ─────────────────────────────────────────────────
exec "$REAL_VIM" "${VIM_ARGS[@]}"
