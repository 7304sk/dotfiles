"""""""""" Fern
nnoremap <silent> <space>f :Fern . -reveal=% -drawer -toggle -width=50<cr>
cabbrev fe :Fern . -reveal=% -drawer -toggle -width=50

"""""""""" CoC
" <c-space> で補完を開始
inoremap <silent><expr> <C-space> coc#refresh()
" CoCの入力補完をEnterで決定
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
" <Tab>で次
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <tab>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<tab>" :
  \ coc#refresh()
nnoremap <silent> <tab> :call CocAction('doHover')<cr>
" アクション
nmap <silent> td <Plug>(coc-definition)
nmap <silent> ty <Plug>(coc-type-definition)
nmap <silent> ti <Plug>(coc-implementation)
nmap <silent> tr <Plug>(coc-references)
nmap <silent> tn <Plug>(coc-rename)
nmap <silent> ta <Plug>(coc-codeaction-cursor)
nnoremap <silent> tg :CocDiagnostics<cr>
nnoremap tl :CocList<cr>

"""""""""" Markdown 関連
" preview
nnoremap <space>m :MarkdownPreview<cr>
" markdown table
xnoremap mt :'<,'>MakeTable
xnoremap tm :'<,'>MakeTable!
nnoremap <space>t :UnmakeTable

"""""""""" git 関連
" git status
nnoremap <space>gs :G<cr>
" git add
nnoremap <space>ga :Gwrite<cr>
" git commit
nnoremap <space>gc :G commit<cr>
" git push
nnoremap <space>gp :G push<cr>
" git fetch
nnoremap <space>gf :G fetch --prune<cr>
" git branch
nnoremap <space>gb :G! -p branch -a<cr>
" git diff
nnoremap <space>gd :Gdiffsplit<cr>
" git switch
nnoremap <space>gw :G switch
" git blame
nnoremap <space>gm :G blame<cr>
" git log
nnoremap <space>gl :G! tree<cr>
" 直前のgit変更箇所へ移動する
nnoremap <space>gk :GitGutterPrevHunk<cr>
" 次のgit変更箇所へ移動する
nnoremap <space>gj :GitGutterNextHunk<cr>
" git diffをハイライトする
nnoremap <space>gh :GitGutterLineHighlightsToggle<cr>
" Gitguuter記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

"""""""""" Git Session
" セッションを保存、ロード
cabbrev <expr> gsl getcmdtype() .. getcmdline() ==# ':gsl' ? [getchar(), ''][1] .. "GitSessionLoad<cr>" : 'gsl'
cabbrev <expr> gss getcmdtype() .. getcmdline() ==# ':gss' ? [getchar(), ''][1] .. "GitSessionSave<cr>" : 'gss'

"""""""""" edgemotion
" ブロック移動（縦方向）
nmap <space>] <Plug>(edgemotion-j)
xmap <space>] <Plug>(edgemotion-j)
nmap <space>[ <Plug>(edgemotion-k)
xmap <space>[ <Plug>(edgemotion-k)

"""""""""" easymotion
" 設定
let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF' " ジャンプマーカーに使うキー
let g:EasyMotion_use_upper = 1              " 視認性向上のため大文字で表示するか
let g:EasyMotion_do_mapping = 0             " デフォルトのキーマッピングを有効化するか
let g:EasyMotion_smartcase = 1              " 検索時に大文字小文字を区別しないか
let g:EasyMotion_startofline = 0            " 行頭に移動するかどうか
let g:EasyMotion_enter_jump_first = 1       " enter で最初の候補にジャンプするか
" 既存の f を置き換え
map f <Plug>(easymotion-bd-fl)
map F <Plug>(easymotion-bd-tl)
" Find motion
nmap ss <Plug>(easymotion-s2)
xmap ss <Plug>(easymotion-s2)
omap zz <Plug>(easymotion-s2)
" Line motion
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
" Word motion
map sw <Plug>(easymotion-bd-w)
map sW <Plug>(easymotion-bd-W)
map se <Plug>(easymotion-bd-e)
map sE <Plug>(easymotion-bd-E)
" Search motion
nmap s/ <Plug>(easymotion-sn)
xmap s/ <Plug>(easymotion-sn)
omap s/ <Plug>(easymotion-tn)

