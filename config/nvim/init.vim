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

" 全角スペースを強調
autocmd Colorscheme * highlight FullWidthSpace ctermbg=237 guibg=#3d3d40
autocmd VimEnter * match FullWidthSpace /　/
" color theme
colorscheme codedark

" Start Fern
" autocmd VimEnter * nested Fern . -reveal=% -drawer -toggle -width=40
" fern preview
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:auto:toggle)
  "nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
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
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {
            'markdown'
        }
    },
    ensure_installed = 'all'
}
EOF

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

