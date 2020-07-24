syntax on
set rnu
set number
set noexpandtab
set tabstop=4
set shiftwidth=4
set cursorline
set clipboard=unnamed
set backspace=indent,eol,start
set ignorecase
set smartcase
imap <F5> <Esc>:w<CR>:!clear;python %<CR>

" For vimtex completion
set completeopt=longest,menuone 
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

autocmd BufEnter *.tex set spell spelllang=en_us
autocmd BufEnter *.tex set tw=85

if &compatible
  set nocompatible               " Be iMproved
endif

" Always show statusline
set laststatus=2

set rtp+=/usr/local/lib/python3.7/site-packages/powerline/bindings/vim

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
" set t_Co=256

" Required:
filetype plugin indent on

set clipboard=unnamed

set termguicolors
let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1

colorscheme edge

if has("gui_running")
	set background=dark
endif

set guifont=Roboto\ Mono\ Light\ for\ Powerline:h16

hi Normal guibg=#211f1f ctermbg=NONE
hi nonText guibg=#211f1f ctermbg=NONE
hi EndofBuffer guibg=#211f1f ctermbg=NONE

highlight Comment cterm=italic gui=italic

let g:ycm_filetype_blacklist = {
      \ 'tex': 1,
      \}

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

call plug#begin('~/.vim/plugged')
	Plug 'lervag/vimtex'
	Plug 'scrooloose/syntastic'
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nmap <F5> <Esc>:w<CR>:!clear;python3 %<CR>
