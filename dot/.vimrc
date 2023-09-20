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

" ;s で置換コマンドを展開
cabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s//gc<Left><Left><Left>" : 's'

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
" 全選択
nnoremap <Leader>a ggVG
" scroll
nnoremap <Leader>d <C-d>
nnoremap <Leader>s <C-u>
" undo, redo
nnoremap <Leader>z :undo<CR>
nnoremap <Leader>y :redo<CR>
" 検索を解除
nnoremap <silent> <Leader>c :<C-u>nohlsearch<CR><C-l>
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
" git status
nnoremap <Leader>gs :G<CR>
" git add
nnoremap <Leader>ga :Gwrite<CR>
" git commit
nnoremap <Leader>gc :G commit<CR>
" git push
nnoremap <Leader>gp :G push<CR>
" git fetch
nnoremap <Leader>gf :G fetch --prune<CR>
" git branch
nnoremap <Leader>gb :G! -p branch -a<CR>
" git diff
nnoremap <Leader>gd :Gdiffsplit 
" git switch
nnoremap <Leader>gw :GRead 
" git blame
nnoremap <Leader>gm :G blame<CR>
" git log
nnoremap <Leader>gl :G! tree<CR>
" 直前のgit変更箇所へ移動する
nnoremap <Leader>gk :GitGutterPrevHunk<CR>
" 次のgit変更箇所へ移動する
nnoremap <Leader>gj :GitGutterNextHunk<CR>
" git diffをハイライトする
nnoremap <Leader>gh :GitGutterLineHighlightsToggle<CR>
" Gitguuter記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red
""""" fzf.vim
" Space fnでファイル名検索を開く。 git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <Leader>fn :call FzfOmniFiles()<CR>
cabbrev fn call FzfOmniFiles()
" Space faでワークスペース内の文字列検索を開く。 <?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --follow --ignore-case --no-heading --color=always --glob "!.git/*" '.shellescape(<q-args>), 1,
\ <bang>1 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'up:60%:hidden', '?'),
\ <bang>0)
nnoremap <Leader>fa :Rg<CR>
cabbrev fa execute ":Rg"
" Space fで開いているファイルの文字列検索を開く
nnoremap <Leader>ff :BLines<CR>
cabbrev f execute ":BLines"
" (Visual) Space fで選択した単語をファイル間で文字列検索する
xnoremap <Leader>f y:Rg <C-R>"<CR>
""""" edgemotion
" ブロック移動（縦方向）
nnoremap <Leader>] <Plug>(edgemotion-j)
xnoremap <Leader>] <Plug>(edgemotion-j)
nnoremap <Leader>[ <Plug>(edgemotion-k)
xnoremap <Leader>[ <Plug>(edgemotion-k)

