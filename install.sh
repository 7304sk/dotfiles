#!/bin/bash
set -ue

helpmsg() {
    command echo "Usage: $0 [--help | -h]" 0>&2
    command echo ""
}

create_dotfiles() {
    command echo "backup old dotfiles..."
    if [ ! -d "$HOME/.dotbackup" ];then
        command echo "$HOME/.dotbackup not found. Auto Make it"
        command mkdir "$HOME/.dotbackup"
    fi

    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
    local dotdir="${script_dir}/dot"
    if [[ "$HOME" != "$dotdir" ]];then
        for f in $dotdir/.??*; do
            [[ `basename $f` == ".git" ]] && continue
            if [[ -e "$HOME/`basename $f`" ]];then
                command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
            fi
            command ln -snf $f $HOME
        done
    else
        command echo "same install src dest"
    fi
}

create_config() {
    command echo "backup old configrations..."
    if [ ! -d "$HOME/.confbackup" ];then
        command echo "$HOME/.confbackup not found. Auto Make it"
        command mkdir "$HOME/.confbackup"
    fi
    if [ ! -d "$HOME/.config" ];then
        command echo "$HOME/.config not found. Auto Make it"
        command mkdir "$HOME/.config"
    fi

    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
    local confdir="${script_dir}/config"
    local homeconf="${HOME}/.config"
    if [[ "$HOME" != "$confdir" ]];then
        for f in $confdir/*; do
            if [ -d $f ];then
                [[ `basename $f` == ".git" ]] && continue
                if [[ -e "$homeconf/`basename $f`" ]];then
                    command mv "$homeconf/`basename $f`" "$HOME/.confbackup"
                fi
                command ln -snf $f $homeconf
            fi
        done
    else
        command echo "same install src dest"
    fi
}

while [ $# -gt 0 ];do
    case ${1} in
        --debug|-d)
        set -uex
        ;;
        --help|-h)
        helpmsg
        exit 1
        ;;
        *)
        ;;
    esac
    shift
done

ESC=$(printf '\033')

command printf "${ESC}[36m >>> Installing dotfiles... ${ESC}[m\n"
create_dotfiles
command printf "${ESC}[36m >>> Installing config dirs... ${ESC}[m\n"
create_config
command printf "${ESC}[33m <<< Install completed! ${ESC}[m\n"