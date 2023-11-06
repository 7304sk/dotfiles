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
" <leader> を Space キーに割り当て
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

"""""""""" abbreviation
" ;r で置換コマンドを展開
cabbrev <expr> r getcmdtype() .. getcmdline() ==# ':r' ? [getchar(), ''][1] .. "%s//gc<Left><Left><Left>" : 'r'
" load session
cabbrev <expr> gsl getcmdtype() .. getcmdline() ==# ':gsl' ? [getchar(), ''][1] .. "GitSessionLoad<cr>" : 'gsl'
cabbrev <expr> gss getcmdtype() .. getcmdline() ==# ':gss' ? [getchar(), ''][1] .. "GitSessionSave<cr>" : 'gss'

"""""""""" keymap
" : Swap colon and semicolon
nnoremap ; :
nnoremap : ;
" escape
inoremap <silent> jj <Esc>:w<CR>
inoremap jf <Esc>:wqa<CR>
" save files with session
nnoremap <leader>wq :GitSessionSave<CR>:wqa<CR>
" increment, decrement
nnoremap + <C-a>
nnoremap - <C-x>
" indent, outdent
nnoremap <leader>. >>
xnoremap <leader>. >
nnoremap <leader>, <<
xnoremap <leader>, <
" jump
nnoremap <leader>4 $
xnoremap <leader>4 $
nnoremap <leader>5 %
xnoremap <leader>5 %
nnoremap <leader>6 ^
xnoremap <leader>6 ^
nnoremap <leader>8 *
xnoremap <leader>8 *
" 全選択
nnoremap <leader>a ggVG
" undo, redo
nnoremap <leader>z :undo<CR>
nnoremap <leader>y :redo<CR>
" 検索を解除
nnoremap <silent> <leader>q :<C-u>nohlsearch<CR><C-l>
" バッファ移動
nnoremap <leader>b :bp<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>x :bd<CR>
" ペイン分割
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>
" ペイン移動
nnoremap <leader><Left> <C-w><Left>
nnoremap <leader><Down> <C-w><Down>
nnoremap <leader><Up> <C-w><Up>
nnoremap <leader><Right> <C-w><Right>
nnoremap <leader>h <C-w><Left>
nnoremap <leader>j <C-w><Down>
nnoremap <leader>k <C-w><Up>
nnoremap <leader>l <C-w><Right>

"""""""""" プラグイン関連
""""" Fern
nnoremap <leader><leader> :Fern . -reveal=% -drawer -toggle -width=50<CR>
cabbrev fe :Fern . -reveal=% -drawer -toggle -width=50
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
nnoremap <silent> <tab> :call CocAction('doHover')<CR>
""""" Markdown
" preview
nnoremap <leader>m :MarkdownPreview<CR>
" markdown table
vnoremap mt :'<,'>MakeTable
vnoremap tm :'<,'>MakeTable!
nnoremap <leader>t :UnmakeTable
""""" git
" git status
nnoremap <leader>gs :G<CR>
" git add
nnoremap <leader>ga :Gwrite<CR>
" git commit
nnoremap <leader>gc :G commit<CR>
" git push
nnoremap <leader>gp :G push<CR>
" git fetch
nnoremap <leader>gf :G fetch --prune<CR>
" git branch
nnoremap <leader>gb :G! -p branch -a<CR>
" git diff
nnoremap <leader>gd :Gdiffsplit<CR>
" git switch
nnoremap <leader>gw :G switch 
" git blame
nnoremap <leader>gm :G blame<CR>
" git log
nnoremap <leader>gl :G! tree<CR>
" 直前のgit変更箇所へ移動する
nnoremap <leader>gk :GitGutterPrevHunk<CR>
" 次のgit変更箇所へ移動する
nnoremap <leader>gj :GitGutterNextHunk<CR>
" git diffをハイライトする
nnoremap <leader>gh :GitGutterLineHighlightsToggle<CR>
" Gitguuter記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red
""""" fzf.vim
" ;fnでファイル名検索を開く。 git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
cabbrev fn call FzfOmniFiles()
" ;faでワークスペース内の文字列検索を開く。 <?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --follow --ignore-case --no-heading --color=always --glob "!.git/*" '.shellescape(<q-args>), 1,
\ <bang>1 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'up:60%:hidden', '?'),
\ <bang>0)
cabbrev fa Rg
" ;fで開いているファイルの文字列検索を開く
cabbrev f BLines
""""" edgemotion
" ブロック移動（縦方向）
nnoremap <leader>] <Plug>(edgemotion-j)
xnoremap <leader>] <Plug>(edgemotion-j)
nnoremap <leader>[ <Plug>(edgemotion-k)
xnoremap <leader>[ <Plug>(edgemotion-k)
""""" jumpcursor
nnoremap <leader>f <Plug>(jumpcursor-jump)

