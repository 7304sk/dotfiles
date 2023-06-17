if has('vim_starting')
    set nocompatible
endif

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
if has('persistent_undo')
  set undodir=$HOME/.vi_undo
  set undofile
endif
set shortmess+=c
set signcolumn=yes
" <Leader> を Space キーに割り当て
let mapleader = "\<Space>"
"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250

"""""""""" keymap
" : Swap colon and semicolon
nnoremap ; :
nnoremap : ;
" escape
inoremap <silent> jj <Esc>:w<CR>
inoremap jf <Esc>:wq<CR>
" increment, decrement
nnoremap + <C-a>
nnoremap - <C-x>
" indent, outdent
nnoremap <Leader>. >>
xnoremap <Leader>. >
nnoremap <Leader>, <<
xnoremap <Leader>, <
" jump
nnoremap <Leader>4 $
xnoremap <leader>4 $
nnoremap <Leader>5 %
xnoremap <Leader>5 %
nnoremap <Leader>6 ^
xnoremap <Leader>6 ^
nnoremap <Leader>8 *
xnoremap <Leader>8 *
" 大きい数字
nnoremap <Leader>a 20
xnoremap <Leader>a 20
" scroll
nnoremap <Leader>d <C-d>
nnoremap <Leader>s <C-u>
" undo, redo
nnoremap <Leader>z :undo<CR>
nnoremap <Leader>y :redo<CR>
" カーソルが当たっている単語をハイライト
nnoremap <silent> <Leader>g :let @/ = '\<' . expand('<cword>') . '\>'<CR>:set hlsearch<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" バッファ移動
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>v :bd<CR>
" ペイン分割
nnoremap <Leader>w :vs<CR>
nnoremap <Leader>q :sp<CR>
" ペイン移動
nnoremap <Leader><Left> <C-w><Left>
nnoremap <Leader><Down> <C-w><Down>
nnoremap <Leader><Up> <C-w><Up>
nnoremap <Leader><Right> <C-w><Right>
nnoremap <Leader>h <C-w><Left>
nnoremap <Leader>j <C-w><Down>
nnoremap <Leader>k <C-w><Up>
nnoremap <Leader>l <C-w><Right>

"""""""""" プラグイン関連
""""" Fern
nnoremap <Leader><Leader> :Fern . -reveal=% -drawer -toggle -width=40<CR>
""""" CoC
" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()
" CoCの入力補完をEnterで決定
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" <Tab>で次、<S+Tab>で前
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>" " "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
""""" Markdown
" preview
nnoremap <Leader>m :MarkdownPreview<CR>
" markdown table
vnoremap mt :'<,'>MakeTable
vnoremap tm :'<,'>MakeTable!
nnoremap <Leader>t :UnmakeTable
""""" git
" 直前のgit変更箇所へ移動する
nnoremap <Leader>i :GitGutterPrevHunk<CR>
" 次のgit変更箇所へ移動する
nnoremap <Leader>o :GitGutterNextHunk<CR>
" git diffをハイライトする
nnoremap <Leader>u :GitGutterLineHighlightsToggle<CR>
" Gitguuter記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red
""""" fzf.vim
" Space cでファイル名検索を開く。 git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <Leader>c :call FzfOmniFiles()<CR>
" Ctrl+gで複数ファイルの文字列検索を開く。 <?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>
" Space rでカーソル位置の単語をファイル間で文字列検索する
nnoremap <Leader>r vawy:Rg <C-R>"<CR>
" Space fで開いているファイルの文字列検索を開く
nnoremap <Leader>f :BLines<CR>
" (Visual) Space fで選択した単語をファイル間で文字列検索する
xnoremap <Leader>f y:Rg <C-R>"<CR>
""""" edgemotion
" ブロック移動（縦方向）
nnoremap <Leader>] <Plug>(edgemotion-j)
xnoremap <Leader>] <Plug>(edgemotion-j)
nnoremap <Leader>[ <Plug>(edgemotion-k)
xnoremap <Leader>[ <Plug>(edgemotion-k)

