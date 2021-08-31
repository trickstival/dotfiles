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
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'colepeters/spacemacs-theme.vim'


Plug 'morhetz/gruvbox'
Plug 'markonm/traces.vim'
Plug 'plasticboy/vim-markdown'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': 'NERDTreeToggle'}

" Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'pangloss/vim-javascript'
Plug 'jparise/vim-graphql'
Plug 'puremourning/vimspector'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'hrsh7th/nvim-compe'
Plug 'L3MON4D3/LuaSnip'

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

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'


call plug#end()

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

" Install Language Server Clients
lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'dockerls', 'vuels', 'cssls' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    -- You will probably want to add a custom on_attach here to locally map keybinds to buffers with an active client
    -- on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert'

-- Compe setup
require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = true,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menu
--- jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functions
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })


EOF
set completeopt=menuone,noselect

" NOTE: Order is important. You can't lazy loading lexima.vim.
let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
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

" Comment in vue files
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


