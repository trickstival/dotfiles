call plug#begin('~/.vim/plugged')
if has('nvim')
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif
call plug#end()
