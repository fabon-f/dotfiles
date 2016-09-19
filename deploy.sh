#!/bin/sh
set -eu

usage() {
    cat <<USAGE
Deploy dotfiles

-h, --help   Print this help.
--verobose   Enable verbose mode.
-f, --force  Make symlink with -f option
USAGE
}

deploy() {
    cd $SCRIPT_DIR
    find dots -depth 1 -name ".*" | grep -v '.DS_Store' | cut -c 6- | while read file; do
        [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/dots/$file" ] && continue;
        ln -sn$($FORCE && printf "f") "$SCRIPT_DIR/dots/$file" "$HOME/$file" || continue
    done
    [ "$(readlink "$HOME/bin")" = "$SCRIPT_DIR/bin" ] || ln -sn "$SCRIPT_DIR/bin" "$HOME/bin"
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"
    FORCE=false
    VERBOSE=false
    for arg in "$@"
    do
        case $arg in
            -h | --help) usage; exit 0;;
            --verbose) set -x; VERBOSE=true;;
            -f | --force) FORCE=true;;
            *) echo "Unknown arguments: $@" >&2 && exit 1;;
        esac
    done
    deploy
}

main "$@"
