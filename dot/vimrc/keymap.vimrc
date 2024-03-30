"""""""""" 全体
" セミコロンとコロンを入れ替える
nnoremap ; :
nnoremap : ;
" escape
inoremap <silent> jj <esc>:w<cr>
inoremap jf <esc>:wqa<cr>
" インクリメント、デクリメント
nnoremap + <C-a>
nnoremap - <C-x>
" インデント、アウトデント
nnoremap <space>. >>
xnoremap <space>. >
nnoremap <space>, <<
xnoremap <space>, <
" x でレジスタに保存しない
nnoremap x "_x
" s, t は prefix として使うため無効化
noremap s <Nop>
noremap t <Nop>
" その他使わないものを無効化
noremap Q <Nop>
noremap ZZ <Nop>
noremap ZQ <Nop>
"""""""""" カーソル移動
" j, k を表示上の移動に入れ替え
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
xnoremap j gj
xnoremap gj j
xnoremap k gk
xnoremap gk k
" 行頭、行末
nnoremap H ^
xnoremap H ^
nnoremap L $
xnoremap L $
" 対応する括弧
nnoremap sp %
xnoremap sp %
" アスタリスク（次の同じ単語）
nnoremap sa *
xnoremap sa *
"""""""""" その他
" 全選択
nnoremap <space>a ggVG
" undo, redo
nnoremap <silent> <space>z :undo<cr>
nnoremap <silent> <space>Z :redo<cr>
" 検索を解除
nnoremap <silent> <esc><esc> :<C-u>nohlsearch<cr><C-l>
" バッファ移動
nnoremap <silent> <space>b :bp<cr>
nnoremap <silent> <space>n :bn<cr>
" バッファ削除
nnoremap <silent> <space>x :bd<cr>
nnoremap <silent> <space>X :%bd<cr>
" ペイン分割
nnoremap <silent> <space>\ :vs<cr>
nnoremap <silent> <space>- :sp<cr>
" ペイン移動
nnoremap <space><Left> <C-w><Left>
nnoremap <space><Down> <C-w><Down>
nnoremap <space><Up> <C-w><Up>
nnoremap <space><Right> <C-w><Right>
nnoremap <space>h <C-w><Left>
nnoremap <space>j <C-w><Down>
nnoremap <space>k <C-w><Up>
nnoremap <space>l <C-w><Right>

