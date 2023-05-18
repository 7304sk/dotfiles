#### fzf 
function pick_history
    set -lu ph $(history --show-time='%Y-%m-%d %H:%M:%S    ' | fzf +m | awk -F '    ' '{print $2}') ; echo -n $ph | pbcopy ; pbpaste
end

function fd
    set -lu dir $(find * -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) ; and cd $dir
end

function fl
    set -lu dir $(find . -type d -maxdepth 1 -not -name '.' | fzf +m) ; and cd $dir
end

function fbd -d 'cd backwards'
	pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
	[ "$result" ]; and cd $result
	commandline -f repaint
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
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