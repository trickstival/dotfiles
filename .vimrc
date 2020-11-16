set number
set splitbelow

let g:netrw_liststyle = 3
let g:netrw_altv = 1
set tabstop=2
set expandtab	 
set shiftwidth=2
set encoding=UTF-8


set guifont="Fira Code:h13"

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'


" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'puremourning/vimspector'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-eunuch' 
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'as': 'dracula' }

" Interface

" Visual
Plug 'ryanoasis/vim-devicons'

" Utilities

" Langs
Plug 'pangloss/vim-javascript'

call plug#end()

colorscheme dracula

set laststatus=2
set noshowmode

" NerdTREE
let NERDTreeShowHidden=1
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:plug_window = 'noautocmd vertical topleft new'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <C-f> :call MyNerdToggle()<CR>

" Fuzzy finder
nnoremap <silent> <C-p> :Files<cr>

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

let b:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1

" -- Language Server --
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

let mapleader = ","

" -- YANKING --

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

