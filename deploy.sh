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
            set +e
            [ -f "$HOME/$file" ] && note="(conflict)" || note=""
            set -e
            echo "$SCRIPT_DIR/dots/$file -> $HOME/$file $note"
        else
            set +e
            [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/dots/$file" ] && echo "$file already deployed" && continue;
            [ -f "$HOME/$file" ] && echo "$HOME/$file already exists" && continue;
            set -e
            ln -s "$SCRIPT_DIR/dots/$file" "$HOME/$file"
        fi
    done
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"
    for arg in "$@"
    do
        case $arg in
            --help) usage; exit 0;;
            --verbose) set -x;;
            --dry-run) deploy --dry-run; exit 0;;
        esac
    done
    deploy
}

main "$@"
