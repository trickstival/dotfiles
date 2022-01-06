" Auto install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"# All plugins
call plug#begin()

set title


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'


" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'colepeters/spacemacs-theme.vim'


Plug 'morhetz/gruvbox'
Plug 'markonm/traces.vim'
Plug 'plasticboy/vim-markdown'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'folke/trouble.nvim'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}

" Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'jparise/vim-graphql'
Plug 'puremourning/vimspector'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'hrsh7th/nvim-compe'
Plug 'L3MON4D3/LuaSnip'
Plug 'numToStr/Comment.nvim'

" Other
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'cohama/lexima.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-surround'

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'


call plug#end()


lua require('Comment').setup()

set completeopt=menuone,noselect

" NOTE: Order is important. You can't lazy loading lexima.vim.
let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <C-x> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

highlight link CompeDocumentation NormalFloat


let g:indent_guides_enable_on_vim_startup = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mode='godef'

let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeWinSize=60

function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

"ALE
let g:ale_fix_on_save = 1

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_fixers = {'vue': ['eslint']}
let g:ale_fixers.javascript = ['prettier', 'eslint']
let g:ale_linters = {'vue': ['eslint', 'vls']}


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"# Mappings
let mapleader=","

" keep it centered when finding
nnoremap n nzzzv
nnoremap N Nzzzv

" Alternate between files
nnoremap <leader>a :e #<CR>

" Open File Tree
nnoremap <leader>n :call MyNerdToggle()<CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" Macro in multiple lines: commend, uncomment and generic macro
vnoremap <leader>qc :normal s/^\(\s*\)/\1\/\/ <cr>
vnoremap <leader>qu :normal s/^\(\s*\)\/\/\s/\1<cr>
vnoremap <leader>qq :normal @q<cr>

" Comment in vue files
let NERDSpaceDelims=1

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif



"# Vim configs

command! CleanReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

"Theme Config
let g:gruvbox_italic=1

set number
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


" Insert Mode cursor

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Optionally reset the cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


