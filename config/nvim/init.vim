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
    autocmd Colorscheme * highlight IndentBlanklineIndent1 guifg=#662121
    autocmd Colorscheme * highlight IndentBlanklineIndent2 guifg=#767621
    autocmd Colorscheme * highlight IndentBlanklineIndent3 guifg=#216631
    autocmd Colorscheme * highlight IndentBlanklineIndent4 guifg=#325a5e
    autocmd Colorscheme * highlight IndentBlanklineIndent5 guifg=#324b7b
    autocmd Colorscheme * highlight IndentBlanklineIndent6 guifg=#562155
    " 全角スペースを強調
    autocmd Colorscheme * highlight FullWidthSpace ctermbg=237 guibg=#3d3d40
    autocmd VimEnter * match FullWidthSpace /　/
    " color theme
    colorscheme codedark
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
        rainbow = {
            enable = true,
            query = 'rainbow-parens',
            strategy = require('ts-rainbow').strategy.global,
        }
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

