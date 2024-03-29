# Shoalwave's dotfiles

***Hyper (ターミナル) + fish (シェル) + Neovim (エディタ) = 最強***

```Bash
cd
git clone git@github.com:7304sk/dotfiles.git
cd dotfiles
vi ./dot/.gitconfig.local  # rewrite your Git user
git update-index --skip-worktree ./config/fish/config_unique__before.fish ./config/fish/config_unique__after.fish ./dot/.gitconfig.local
./install.sh
```

## set up

### Mac

```Bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --global
# powerline
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
# fish
sudo echo "$(which fish)" >> /etc/shells
chsh -s "$(which fish)"
fish
# node
volta install node@stable
# tmux (tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# neovim (dein.nvim)
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein && rm ./installer.sh
vi # lauch Neovim once to install plugins. It takes time. If it looks different, close Neovim with ';q'.
cd ~/.cache/dein/repos/github.com/iamcco/markdown-preview.nvim/app/ && npm install # Install using npm instead of yarn
```

