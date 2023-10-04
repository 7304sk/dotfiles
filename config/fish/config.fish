#! alias
alias vi='nvim'
alias view='nvim -R'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='eza --icons --git --time-style long-iso'

#! global variables
set -xg LANG ja_JP.UTF-8
set -xg GREP_OPTIONS '--color=auto'
set -xg PYTHONPATH $HOME/__pylib__ $PYTHONPATH
set -xg RUNEWIDTH_EASTASIAN 0
set -xg FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'
set -xg FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set -xg FZF_DEFAULT_OPTS '--height 30% --layout=reverse
    --color=fg:#d0d0d0,hl:#d1cf75
    --color=fg+:#d0d0d0,hl+:#7ddef1
    --color=info:#87afb7,prompt:#cf6f72,pointer:#7ddef1
    --color=marker:#ad95c4,spinner:#b7ba7e,header:#D39B76'
set -xg FZF_TMUX_OPTS '-p 80%'
set -xg VOLTA_HOME $HOME/.volta


#! load configurations
source $HOME/.config/fish/config_unique__before.fish
source $HOME/.config/fish/config_abbr.fish
source $HOME/.config/fish/config_functions.fish

#! Configuration by OS
if test (uname -s) = Darwin
    #! for Mac
    set -xg PATH $VOLTA_HOME/bin /usr/local/mysql/bin /opt/homebrew/opt/gnu-sed/libexec/gnubin /opt/homebrew/opt/gnu-tar/libexec/gnubin /opt/homebrew/opt/grep/libexec/gnubin /opt/homebrew/opt/gawk/libexec/gnubin /opt/homebrew/opt/findutils/libexec/gnubin /opt/homebrew/opt/coreutils/libexec/gnubin /opt/homebrew/sbin /opt/homebrew/bin $PATH
else
    #! for other (Linux)
    eval ~/anaconda3/bin/conda "shell.fish" hook $argv | source
    set -xg PATH $HOME/.npm-global/bin $PATH
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
    alias update='echo -e "\n\e[33m##### Update list of packages. #####\e[m\n" && sudo apt update && echo -e "\n\e[33m##### List of packages is updated. #####\n##### NEXT: Upgrade all packages #####\e[m\n" && sudo apt upgrade && echo -e "\n\e[33m##### All installed packages are upgraded. #####\n##### NEXT: Remove packages that are no longer needed #####\e[m\n" && sudo apt autoremove && echo -e "\n\e[33m##### Packages that are no longer needed for the update are removed. #####\n##### NEXT: Clean up cached files #####\e[m\n" && sudo apt clean && echo -e "\n\e[33m##### all cached deb files are deleted. #####\e[m\n"'
end

#! set bobthefish
set -g theme_color_scheme dracula
set -g theme_display_user no
set -g theme_display_hostname no
set -g theme_newline_cursor yes
set -g theme_display_vi yes
set -g theme_date_format "+[%H:%M:%S]"
set -g theme_newline_prompt "\e[32m\e[m "

#! load after configurations
source $HOME/.config/fish/config_unique__after.fish

#! start tmux
if set -q __in_hyper__; and status --is-login; and not set -q TMUX
    if test -z (tmux ls | grep -E '^default: ')
        tmux new -s default
    else
        tmux a -t default
    end
end
