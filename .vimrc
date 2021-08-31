" Auto install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"# All plugins
call plug#begin()

" Tmux

set title
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'markonm/traces.vim'
Plug 'plasticboy/vim-markdown'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}

" Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'jparise/vim-graphql'
Plug 'metakirby5/codi.vim'
Plug 'szw/vim-maximizer'
Plug 'puremourning/vimspector'
Plug 'nathanaelkane/vim-indent-guides'

" Other
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'posva/vim-vue'
Plug 'tpope/vim-obsession'
" Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"# Plugin configs
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-vetur',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-yaml',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-jest',
      \ 'coc-pairs'
      \ ]

inoremap <silent><expr> <C-d> coc#refresh()

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



" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"FZF

let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--vimgrep --smart-case', <bang>0)
" command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)













"# Mappings
let mapleader=","

nnoremap <leader>a :e #<CR>
nnoremap Y y$

" keep it centered when finding
nnoremap n nzzzv
nnoremap N Nzzzv
" nnoremap <c-o> <c-o>zzzv

" undo breakpoints
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u

"# Vimspector bindings

fun! GotoWindow(id)
  call win_gotoid(a:id)
  MaximizerToggle
endfun

nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nnoremap <leader>m :MaximizerToggle!<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

"# Move up or down 
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
inoremap <leader>j <Esc>:m .+1<CR>==gi
inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv


"# Fugitive bindings
nnoremap <leader>gs :G<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>
nnoremap <leader>gb :GBranches<CR>

"map <Leader> <Plug>(easymotion-prefix)
nnoremap <leader>n :call MyNerdToggle()<CR>
" noremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

noremap <leader>f :Fixmyjs<cr>
noremap <leader>p :Files<cr>
noremap <leader>b :Buffers<cr>
noremap <leader>h :History<cr>
noremap <leader><S-p> :RG<cr>

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position
" Coc only does snippet and additional edit on confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Emmet
let g:user_emmet_settings = {
  \  'javascript' : {
  \      'extends' : 'jsx',
  \  },
  \  'typescript' : {
  \      'extends' : 'jsx',
  \  },
  \}

let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
let NERDSpaceDelims=1

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif



"# Vim configs

command! CleanReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

set nocompatible
set ttyfast

"Theme Config
let g:gruvbox_italic=1
colorscheme gruvbox

set number
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


set title
set wildmenu
set mouse=a
set clipboard+=unnamedplus
set path+=$(pwd)/**
set encoding=UTF-8
set sts=2
set ts=2
set smartindent
set autoindent
set splitbelow
set splitright
set sw=2
set ignorecase
set laststatus=2
set smartcase
set ruler
set expandtab
set tabstop=2
set shiftwidth=2
set title
set list
set cursorline
set nowrap
set hidden
set foldmethod=indent " use decent folding
set foldlevelstart=50 " files open expanded
set autoread
set updatetime=300
set noswapfile
set noshowmode
set background=dark
set hlsearch
let g:autoclosepairs_del = "`"

" Insert Mode cursor

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Optionally reset the cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


