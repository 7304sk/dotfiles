"""""""""" 基本設定
set fenc=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set nobomb
set binary
set ttyfast
set backspace=indent,eol,start
set softtabstop=0
set expandtab
set tabstop=4
set shiftwidth=4
set splitright
set splitbelow
set hidden
set hlsearch
set incsearch
set ignorecase
set smartcase
set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac
syntax on
set ruler
set number
set gcr=a:blinkon0
set scrolloff=3
set laststatus=2
set modeline
set modelines=10
set title
set titleold="Terminal"
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set autoread
set noerrorbells visualbell t_vb=
set clipboard+=unnamedplus
set mouse=a
set whichwrap=b,s,h,l,<,>,[,]
" guicursor
set guicursor=n:block
set guicursor+=i-c-ci-ve-sm:ver25
set guicursor+=r-cr:hor15
set guicursor+=v:hor30
set guicursor+=o:hor50
set guicursor+=a:blinkwait700-blinkon600-blinkoff200
" undo
if has('persistent_undo')
  set undodir=$HOME/.vi_undo
  set undofile
endif
set shortmess+=c
set signcolumn=yes
" <leader> を Space キーに割り当て
let mapleader = ","
"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250
" checks if your terminal has 24-bit color support
if has("termguicolors")
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
" 特殊文字を表示
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%,space:･

" カーソル形状をモードで変更（使用するターミナル依存）
let &t_SI .= "\e[6 q"
let &t_EI .= "\e[2 q"
let &t_SR .= "\e[4 q"

