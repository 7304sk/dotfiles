#### fzf 
function thistory
    set -lu ph $(history --show-time='%Y-%m-%d %H:%M:%S    ' | fzf-tmux -p 80% +m | awk -F '    ' '{print $2}') ; echo -n $ph | pbcopy ; pbpaste
end

function fd -d 'continuous cd forwards'
    set -lu _from (pwd)
    set -lu _to $(find . -maxdepth 1 -type d 2> /dev/null | fzf-tmux -p 80% +m --preview 'ls -a {}')

    while test -n "$_to"; and test "$_to" != "."
        cd $_to
        set _to $(find . -maxdepth 1 -type d 2> /dev/null | fzf-tmux -p 80% +m --preview 'ls -a {}')
    end

    if test $_from != (pwd)
        echo "FROM: $_from"
        echo "TO:   $(pwd)"
    else
        echo "Canceled."
        return 1
    end
end

function bd -d 'cd backwards'
	pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | fzf-tmux -p 80% +m --preview 'ls -a {}' | read -l result
    if test -n "$result"
        set -lu from (pwd)
        cd $result
        set -lu to (pwd)
        echo "FROM: $from"
        echo "TO:   $to"
    else
        echo "Canceled."
        return 1
    end
end

function fb -d "Fuzzy-find and switch a branch"
    set -l __branches (git branch -a | grep -v "^\*" | grep -v HEAD | string trim)
    if [ "$__branches" = "" ]
        echo "Here is no other branches."
        return 1
    else
        for __branch in $__branches
            echo $__branch
        end | fzf-tmux -p 40% | read -l __result
        if [ "$(string match 'remotes/*' $__result)" != "" ]
            set -l __target (string replace -r '^remotes/.+?/(.+)$' '$1' $__result)
            git switch "$__target"
        else
            git switch "$__result"
        end
    end
end

function db -d "Fuzzy-find and delete branches"
    set -l __branches (git branch | grep -v "^\*" | grep -v HEAD | string trim)
    if [ "$__branches" = "" ]
        echo "Here is no other branches."
        return 1
    else
        set -l __selected (for __branch in $__branches
            echo $__branch
        end | fzf-tmux -p 40% -m)
        for __b in $__selected
            set -l __input 'n'
            while [ "$__input" = "y" ]; or [ "$__input" = "n" ]
                read -n1 -p  'echo -e "$__b\t -- Are you sure to delete? (y/n): "' __input
                if [ "$__input" = "y" ]
                    git branch -D $__b
                    break
                end
                if [ "$__input" = "n" ]
                    echo "skipped."
                    break
                end
            end
        end
    end
end

function rep -d "find ghq repositories"
    set -l __src $(ghq list | fzf-tmux -p 80% --preview "ls -algx $(ghq root)/{}")
    set -l __target "$(ghq root)/$__src"
    if test -d $__target; and test "$__src" != ""
        cd $__target
        echo $__target
    else
        echo "Canceled."
        return 1
    end
end

function memo -d "make memo with vim"
    set -l save_current_dir (pwd)
    cd $MEMO_ROOT
    vi
    # git 管理している場合自動でコミット
    if git rev-parse 2> /dev/null
        git add -A
        git commit -m "update memo: $(date '+%Y-%m-%dT%H:%M:%S')"
        # remote もある場合は自動で push まで
        if test -n "$(git remote -v)"
            git push
        end
    end
    cd $save_current_dir
end

#### Mac
function bupdate
    set_color yellow; and echo '>>> Update homebrew'; and set_color normal
    brew update
    set_color yellow; and echo '>>> Update all installed formulas'; and set_color normal
    brew upgrade
    set_color yellow; and echo '>>> Remove useless formulas'; and set_color normal
    brew autoremove
    set_color yellow; and echo '>>> System check'; and set_color normal
    brew doctor
end

#### other
function cleanjs -d "Minimize javascript"
    argparse -n cleanjs 'o/output=' -- $argv
    or return 1

    set -lq _flag_output
    or set -l _flag_output '/dev/stdout'
    
    npx terser --compress --mangle -- $argv > $_flag_output
end

function rcm -d "recursively chmod"
    argparse -n rcm 'h/help' 't/type=' 'n/name=' -- $argv
    or return 1

    set -lq _flag_help
    and begin
        echo 'Change permissions recursively.
    -t  or  --type      select target type from f (file) or d (directory)
    -n  or  --name      Specify the name of the change target by regular expression
    -h  or  --help      show help'
        return 0
    end

    set -lq _flag_type
    or set -l _flag_type 'None'

    set -lq _flag_name
    or set -l _flag_name '*'

    switch $_flag_type
        case f
            echo 'target type -> file'
        case file
            set -l _flag_type 'f'
            echo 'target type -> file'
        case d
            echo 'target type -> directory'
        case directory
            set -l _flag_type 'd'
            echo 'target type -> directory'
        case '*'
            echo 'You have to select target type from f (file) or d (directory).
Please choose it with -t or --type'
            return 1
    end

    set -l pwd (pwd)
    echo "Warning!!! You are trying to make permission changes recursively in the directory you are now in. 
This operation will execute with sudoer authority, so that could be fatal to your computer!
target directory: $pwd"
    echo 'Are you sure you want to make the change? (y/n):'
    read confirm
    if test ( string match -r -i "\Ay(es)?\z" "$confirm" )
        find . -type $_flag_type -name $_flag_name -not -name '.' -exec sudo chmod $argv \{\} \;
        and echo 'All permissions are changed.'
    else
        echo 'Canceled.'
        return 0
    end
end

function rco -d "recursively chown"
    argparse -n rco 'h/help' 't/type=' 'n/name=' -- $argv
    or return 1

    set -lq _flag_help
    and begin
        echo 'Change ownerships recursively.
    -t  or  --type      select target type from f (file) or d (directory)
    -n  or  --name      Specify the name of the change target by regular expression
    -h  or  --help      show help'
        return 0
    end

    set -lq _flag_type
    or set -l _flag_type 'None'

    set -lq _flag_name
    or set -l _flag_name '*'

    switch $_flag_type
        case f
            echo 'target type -> file'
        case file
            set -l _flag_type 'f'
            echo 'target type -> file'
        case d
            echo 'target type -> directory'
        case directory
            set -l _flag_type 'd'
            echo 'target type -> directory'
        case '*'
            echo 'You have to select target type from f (file) or d (directory).
Please choose it with -t or --type'
            return 1
    end

    set -l pwd (pwd)
    echo "Warning!!! You are trying to make ownership changes recursively in the directory you are now in. 
This operation will execute with sudoer authority, so that could be fatal to your computer!
target directory: $pwd"
    echo 'Are you sure you want to make the change? (y/n):'
    read confirm
    if test ( string match -r -i "\Ay(es)?\z" "$confirm" )
        find . -type $_flag_type -name $_flag_name -not -name '.' -exec sudo chown $argv \{\} \;
        and echo 'All ownerships are changed.'
    else
        echo 'Canceled.'
        return 0
    end
end