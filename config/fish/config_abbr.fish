# reset
for a in (abbr --list); abbr --erase $a; end

####
#  set abbreviations
abbr -a abr     cat ~/.config/fish/config_abbr.fish
abbr -a l       ls -Fa
abbr -a ll      ls -alFgx
abbr -a lt      ls -alFgx --ignore-glob=.git --tree
abbr -a .       cd ../
abbr -a ..      cd ../../
abbr -a ...     cd ../../../
abbr -a h       thistory
abbr -a fda     fd --all 99
abbr -a home    cd $WORK_HOME
abbr -a wi      which
abbr -a s       source
abbr -a c       clear
abbr -a py      python
abbr -a e       exit
abbr -a v       vi
abbr -a vw      view
abbr -a gz      tar zcvf
abbr -a ungz    tar zxvf
abbr -a bz      tar jcvf
abbr -a unbz    tar jxvf
abbr -a dig     dig +noall +answer any
abbr -a digr    dig +noall +answer any -x
abbr -a ln      ln -snf
abbr -a dif     diff -b
# apt
abbr -a sai     sudo apt install -y
abbr -a sar     sudo apt remove
abbr -a sas     sudo apt search
# mac
abbr -a hb      brew
abbr -a hbu     'brew update && brew upgrade'
abbr -a nb      nodebrew
# git
abbr -a g       git
abbr -a gi      git init
abbr -a ga      git add -A
abbr -a gc      git commit
abbr -a gp      git push
abbr -a gf      git fetch --prune
abbr -a gpl     git pull origin
abbr -a gm      git merge
abbr -a grt     git reset
abbr -a gk      git checkout
abbr -a gw      git switch
abbr -a gr      git restore
abbr -a gb      git branch
abbr -a gcy     git cherry-pick
abbr -a gd      git diff --color-words --word-diff
abbr -a gs      git status -s
abbr -a gss     git stash save
abbr -a gsp     git stash pop stash@{0}
abbr -a gsl     git stash list
abbr -a gt      git tag
abbr -a gl      git tree
abbr -a gcl     git clone
# docker
abbr -a d       docker
abbr -a de      docker exec -it
abbr -a da      docker attach
abbr -a di      docker images
abbr -a dp      docker ps -a
abbr -a dcp     docker-compose
abbr -a dcpb    docker-compose build
abbr -a dcpu    docker-compose up -d
abbr -a dcpd    docker-compose down
