#!/bin/sh
set -eu

usage() {
    cat <<USAGE
Deploy dotfiles

--help      Print this help.
--verobose  Enables verbose mode.
--dry-run   Dry run
USAGE
}

deploy() {
    find dots -type f | cut -c 6- | while read file; do
        if [ $# -eq 1 ]; then
            [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/dots/$file" ] && continue;
            set +e
            [ -f "$HOME/$file" ] && note="(conflict)" || note=""
            set -e
            echo "$SCRIPT_DIR/dots/$file -> $HOME/$file $note"
        else
            set +e
            [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/dots/$file" ] && continue;
            [ -f "$HOME/$file" ] && echo "$HOME/$file already exists" && continue;
            set -e
            ln -s "$SCRIPT_DIR/dots/$file" "$HOME/$file"
        fi
    done
    find bin -type f | while read file; do
        if [ $# -eq 1 ]; then
            [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/$file" ] && continue;
            [ -f "$HOME/$file" ] && note="(conflict)" || note=""
            echo "$SCRIPT_DIR/$file -> $HOME/$file $note"
        else
            [ -d "$HOME/bin" ] || mkdir "$HOME/bin"
            [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/$file" ] && continue;
            [ -f "$HOME/$file" ] && echo "$HOME/$file already exists" && continue;
            ln -s "$SCRIPT_DIR/$file" "$HOME/$file"
        fi
    done
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"
    for arg in "$@"
    do
        case $arg in
            --help) usage; exit 0;;
            -h) usage; exit 0;;
            --verbose) set -x;;
            --dry-run) deploy --dry-run; exit 0;;
            *) echo "Unknown arguments: $@" >&2 && exit 1;;
        esac
    done
    deploy
}

main "$@"
