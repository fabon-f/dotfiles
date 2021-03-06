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

ignore="${IGNORE- apm-sync .bash_profile .bashrc }"

is_ignored() {
    echo "$ignore" | grep -q " $1 "
}

deploy() {
    cd $SCRIPT_DIR
    find dots -maxdepth 1 -name ".*" | grep -v '.DS_Store' | cut -c 6- | while read file; do
        is_ignored "$file" && echo "$file is ignored" && continue
        [ "$(readlink "$HOME/$file")" = "$SCRIPT_DIR/dots/$file" ] && continue;
        ln -sn$($FORCE && printf "f") "$SCRIPT_DIR/dots/$file" "$HOME/$file" || continue
    done

    mkdir -p "$HOME/bin"
    find bin -maxdepth 1 -mindepth 1 -not -name ".*" | cut -c 5- | while read file; do
        is_ignored "$file" && echo "$file is ignored" && continue
        [ "$(readlink "$HOME/bin/$file")" = "$SCRIPT_DIR/bin/$file" ] && continue;
        ln -sn$($FORCE && printf "f") "$SCRIPT_DIR/bin/$file" "$HOME/bin/$file" || continue
    done
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
            *) echo "Unknown argument: $arg" >&2 && exit 1;;
        esac
    done
    deploy
}

main "$@"
