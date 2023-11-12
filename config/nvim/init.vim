" Load vimrc
source ~/.vimrc

" dein.vim
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
    call dein#begin('~/.cache/dein')
    call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
    call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")

if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax enable

if !exists('g:vscode')
    " for IndentBlankline
    autocmd Colorscheme * highlight IndentBlanklineIndent1 guifg=#662121
    autocmd Colorscheme * highlight IndentBlanklineIndent2 guifg=#767621
    autocmd Colorscheme * highlight IndentBlanklineIndent3 guifg=#216631
    autocmd Colorscheme * highlight IndentBlanklineIndent4 guifg=#325a5e
    autocmd Colorscheme * highlight IndentBlanklineIndent5 guifg=#324b7b
    autocmd Colorscheme * highlight IndentBlanklineIndent6 guifg=#562155
    " color theme
    colorscheme codedark
    " 背景透過
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight LineNr guibg=none
    highlight Folded guibg=none
    highlight EndOfBuffer guibg=none
    " 全角スペースを強調
    autocmd Colorscheme * highlight FullWidthSpace ctermbg=237 guibg=#3d3d40
    autocmd VimEnter * match FullWidthSpace /　/
endif

" Fern
" preview
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <Space>d <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <Space>s <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" TreeSitter
" markdown は conceal の設定が気に食わないのでオフにする
lua <<EOF
if vim.fn.exists("g:vscode") ~= 1 then
    require'nvim-treesitter.configs'.setup {
        ensure_installed = 'all',
        highlight = {
            enable = true,
            disable = {
                'markdown'
            }
        },
    }
end
EOF

" fzf
let g:fzf_preview_window = ['up,60%', 'ctrl-/']

" Committia
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" vim-makdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" coc.nvim
nnoremap <silent> <leader>cd <Plug>(coc-definition)
nnoremap <silent> <leader>ct <Plug>(coc-type-definition)
nnoremap <silent> <leader>ci <Plug>(coc-implementation)
nnoremap <silent> <leader>cr <Plug>(coc-references)
nnoremap <silent> <leader>cn <Plug>(coc-rename)
nnoremap <silent> <leader>ca <Plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>cg :CocDiagnostics<cr>
nnoremap <leader>cl :CocList<cr>

" copilot
let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'markdown': v:true,
    \ 'yaml': v:true
    \ }
" tab は coc.nvim で使っているので、copilot では Shift-tab にする
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <S-tab> copilot#Accept("\<CR>")

" gitsessions.vim
" auto load をそのままだとtreeSitter が効かないので、遅延実行する
let g:gitsessions_disable_auto_load = 1
call timer_start(1, {-> execute('GitSessionLoad')})

" ddu
let win_border = 'single'
let win_height = '&lines - 8'
let win_width = '&columns - 4'
let win_col = 1
let win_row = 4
let preview_row = 1
let preview_height = '&lines - 5'
let preview_width = '&columns / 2 - 3'
let preview_col = '&columns / 2'
call ddu#custom#patch_global({
\   'ui': 'ff',
\   'uiParams': {
\      'ff': {
\           'autoAction': { 'name': 'preview', 'delay': 0, },
\           'startAutoAction': v:true,
\           'ignoreEmpty': v:false,
\           'split': 'floating',
\           'prompt': '> ',
\           'cursorPos': 0,
\           'startFilter': v:true,
\           'filterSplitDirection': 'floating',
\           'filterFloatingPosition': 'top',
\           'filterFloatingTitle': 'Text in Current Buffer',
\           'floatingBorder': win_border,
\           'winHeight': win_height,
\           'winWidth': win_width,
\           'winRow': win_row,
\           'winCol': win_col,
\           'previewFloating': v:true,
\           'previewSplit': 'vertical',
\           'previewFloatingBorder': win_border,
\           'previewHeight': preview_height,
\           'previewWidth': preview_width,
\           'previewRow': preview_row,
\           'previewCol': preview_col,
\       },
\       'filer': {
\           'autoAction': { 'name': 'preview', 'delay': 0, },
\           'startAutoAction': v:true,
\           'split': 'floating',
\           'floatingBorder': win_border,
\           'winHeight': win_height,
\           'winWidth': win_width,
\           'winRow': win_row,
\           'winCol': win_col,
\           'previewFloating': v:true,
\           'previewSplit': 'vertical',
\           'previewFloatingBorder': win_border,
\           'previewHeight': preview_height,
\           'previewWidth': preview_width,
\           'previewRow': preview_row,
\           'previewCol': preview_col,
\       },
\   },
\   'sourceOptions': {
\       '_': {
\           'matchers': ['matcher_fzf'],
\           'sorters': ['sorter_fzf'],
\           'ignoreCase': v:true,
\       },
\       'file': {
\           'columns': ['icon_filename'],
\       },
\       'line': {
\           'sorters': [],
\       },
\   },
\   'filterParams': {
\       'matcher_fzf': {
\           'highlightMatched': 'Search',
\       },
\   },
\   'kindOptions': {
\       'file': {
\           'defaultAction': 'open',
\       },
\       'word': {
\           'defaultAction': 'append',
\       },
\       'lsp': {
\           'defaultAction': 'open',
\       },
\       'lsp_codeAction': {
\           'defaultAction': 'apply',
\       },
\   },
\   'actionOptions': {
\       'narrow': {
\           'quit': v:true,
\       },
\   },
\})

call ddu#custom#patch_local('noFilter', {
\   'uiParams': {'ff': {
\       'winRow': preview_row,
\       'winHeight': preview_height,
\   }},
\})

call ddu#custom#patch_local('file_rec', {
\   'uiParams': {'ff': {'filterFloatingTitle': 'Filename'}},
\   'sources': [{
\       'name':'file_rec',
\       'params': {
\           'ignoredDirectories': ['.git', 'var', 'node_modules', ]
\       },
\   }],
\})

call ddu#custom#patch_local('filer', {
\   'ui': 'filer',
\   'uiParams': {'filer': {
\       'winRow': preview_row,
\       'winHeight': preview_height,
\   }},
\   'sources': [
\       {'name': 'file', 'params': {}},
\   ],
\   'resume': v:true,
\ })

call ddu#custom#patch_local('grep', {
\   'uiParams': {'ff': {'filterFloatingTitle': 'Text in Workspace'}},
\   'sourceParams' : {
\       'rg' : {
\           'args': ['--column', '--no-heading', '--color', 'never', '-i'],
\       },
\   },
\ })

call ddu#custom#patch_local('lsp_definition', {
\   'sync': v:true,
\   'sources': [{
\       'name':'lsp_definition',
\       'params': {'method': 'textDocument/definition'},
\   }],
\   'uiParams': {'ff': {
\       'immidiateAction': 'open',
\       'filterFloatingTitle': 'Definition',
\   }},
\ })
call ddu#custom#patch_local('lsp_declaration', {
\   'sync': v:true,
\   'sources': [{
\       'name':'lsp_definition',
\       'params': {'method': 'textDocument/declaration'},
\   }],
\   'uiParams': {'ff': {
\       'immidiateAction': 'open',
\       'filterFloatingTitle': 'Declaration',
\   }},
\ })
call ddu#custom#patch_local('lsp_typeDefinition', {
\   'sync': v:true,
\   'sources': [{
\       'name':'lsp_definition',
\       'params': {'method': 'textDocument/typeDefinition'},
\   }],
\   'uiParams': {'ff': {
\       'immidiateAction': 'open',
\       'filterFloatingTitle': 'Type Definition',
\   }},
\ })
call ddu#custom#patch_local('lsp_implementation', {
\   'sync': v:true,
\   'sources': [{
\       'name':'lsp_definition',
\       'params': {'method': 'textDocument/implementation'},
\   }],
\   'uiParams': {'ff': {
\       'immidiateAction': 'open',
\       'filterFloatingTitle': 'Implementation',
\   }},
\ })

call ddu#custom#patch_local('references', {
\   'uiParams': {'ff': {
\       'immidiateAction': 'open',
\       'filterFloatingTitle': 'References',
\   }},
\ })

call ddu#custom#patch_local('codeAction', {
\   'uiParams': {'ff': {'filterFloatingTitle': 'Code Actions'}},
\ })

call ddu#custom#patch_local('lsp_documentSymbol', {
\   'sources': [{
\       'name':'lsp_documentSymbol',
\       'options': {'converters': ['converter_lsp_symbol']},
\   }],
\ })

call ddu#custom#patch_local('lsp_workspaceSymbol', {
\   'sources': [{
\       'name':'lsp_workspaceSymbol',
\       'options': {'volatile': v:true},
\   }],
\  'uiParams': {
\       'ff': {'ignoreEmpty': v:false},
\   },
\ })

call ddu#custom#patch_local('lsp_diagnostic', {
\   'uiParams': {'ff': {'filterFloatingTitle': 'Diagnostics in Current Buffer'}},
\   'sources': [{
\       'name':'lsp_diagnostic',
\       'params': {'buffer': 0},
\   }],
\ })

call ddu#custom#patch_local('lsp_diagnosticAll', {
\   'uiParams': {'ff': {'filterFloatingTitle': 'Diagnostics in All Buffers'}},
\   'sources': [{
\       'name':'lsp_diagnostic',
\       'params': {'buffer': v:null},
\   }],
\ })

" keymap
cabbrev <expr> f getcmdtype() .. getcmdline() ==# ':f' ? [getchar(), ''][1] .. "Ddu line<cr>" : 'f'
cabbrev <expr> fb getcmdtype() .. getcmdline() ==# ':fb' ? [getchar(), ''][1] .. "Ddu buffer -name=noFilter -ui-param-ff-startFilter=v:false<cr>" : 'fb'
cabbrev <expr> fr getcmdtype() .. getcmdline() ==# ':fr' ? [getchar(), ''][1] .. "Ddu register -name=noFilter -ui-param-ff-startFilter=v:false<cr>" : 'fr'
cabbrev <expr> fn getcmdtype() .. getcmdline() ==# ':fn' ? [getchar(), ''][1] .. "Ddu -name=file_rec<cr>" : 'fn'
cabbrev <expr> ff getcmdtype() .. getcmdline() ==# ':ff' ? [getchar(), ''][1] .. "Ddu -name=filer<cr>" : 'ff'
cabbrev <expr> fa getcmdtype() .. getcmdline() ==# ':fa' ? [getchar(), ''][1] .. "Ddu rg -name=grep -source-param-rg-input='.'<cr>" : 'fa'
" for lsp
cabbrev <expr> ld getcmdtype() .. getcmdline() ==# ':ld' ? [getchar(), ''][1] .. "Ddu -name=lsp_definition<cr>" : 'ld'
cabbrev <expr> ldc getcmdtype() .. getcmdline() ==# ':ldc' ? [getchar(), ''][1] .. "Ddu -name=lsp_declaration<cr>" : 'ldc'
cabbrev <expr> ldt getcmdtype() .. getcmdline() ==# ':ldt' ? [getchar(), ''][1] .. "Ddu -name=lsp_typeDefinition<cr>" : 'ldt'
cabbrev <expr> lr getcmdtype() .. getcmdline() ==# ':lr' ? [getchar(), ''][1] .. "Ddu lsp_references -name=references<cr>" : 'lr'
cabbrev <expr> la getcmdtype() .. getcmdline() ==# ':la' ? [getchar(), ''][1] .. "Ddu lsp_codeAction -name=codeAction<cr>" : 'la'
cabbrev <expr> ls getcmdtype() .. getcmdline() ==# ':ls' ? [getchar(), ''][1] .. "Ddu -name=lsp_documentSymbol<cr>" : 'ls'
cabbrev <expr> lsw getcmdtype() .. getcmdline() ==# ':lsw' ? [getchar(), ''][1] .. "Ddu -name=lsp_workspaceSymbol<cr>" : 'lsw'
cabbrev <expr> lg getcmdtype() .. getcmdline() ==# ':lg' ? [getchar(), ''][1] .. "Ddu -name=lsp_diagnostic<cr>" : 'lg'
cabbrev <expr> lga getcmdtype() .. getcmdline() ==# ':lga' ? [getchar(), ''][1] .. "Ddu -name=lsp_diagnosticAll<cr>" : 'lga'

" FF
autocmd FileType ddu-ff call s:ddu_ff_settings()
function! s:ddu_ff_settings() abort
    nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
    nnoremap <buffer><silent> s <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
    nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> <esc> <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> <C-g> <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction
autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
    inoremap <buffer> <C-n> <Nop>
    inoremap <buffer> <C-p> <Nop>
    inoremap <buffer><silent> <esc> <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> <esc> <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>
    nnoremap <buffer> <CR> <Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>
    inoremap <buffer><silent> <CR> <ESC><Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>
endfunction
" filter
autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
    nnoremap <buffer><silent><expr> <CR>
    \   ddu#ui#get_item()->get('isTree', v:false) ?
    \       "<Cmd>call ddu#ui#filer#do_action('expandItem', {'mode': 'toggle'})<CR>" :
    \       "<Cmd>call ddu#ui#filer#do_action('itemAction')<CR>"
    nnoremap <buffer><silent><expr> h
    \   ddu#ui#get_item()->get('isTree', v:false) ?
    \       "<Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>" :
    \       "<Cmd>call ddu#ui#filer#do_action('preview')<CR>"
    nnoremap <buffer><silent><expr> l
    \   ddu#ui#get_item()->get('isTree', v:false) ?
    \       "<Cmd>call ddu#ui#filer#do_action('expandItem')<CR>" :
    \       "<Cmd>call ddu#ui#filer#do_action('preview')<CR>"
    nnoremap <buffer><silent> j j<Cmd>call ddu#ui#do_action('preview')<CR>
    nnoremap <buffer><silent> k k<Cmd>cal ddu#ui#do_action('preview')<CR>
    nnoremap <buffer><silent> <C-d> <C-d><Cmd>cal ddu#ui#do_action('preview')<CR>
    nnoremap <buffer><silent> <C-u> <C-u><Cmd>cal ddu#ui#do_action('preview')<CR>
    nnoremap <buffer><silent> q <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer><silent> cp <Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>
    nnoremap <buffer><silent> p <Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>
    nnoremap <buffer><silent> rm <Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>
    nnoremap <buffer><silent> mv <Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>
    nnoremap <buffer><silent> cu <Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>
    nnoremap <buffer><silent> to <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>
    nnoremap <buffer><silent> mk <Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>
    nnoremap <buffer><silent> yy <Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>
endfunction
