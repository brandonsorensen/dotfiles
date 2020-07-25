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

" Gets the OS and works around the wonkiness of OS checks
" in the various versions of Vim avalable for macOS.
" https://vi.stackexchange.com/questions/2572/detect-os-in-vimscript/2577#2577
if !exists("g:os")
	if has("win64") || has("win32") || has("win16")
		let g:os = "Windows"
	else
		let g:os = substitute(system('uname'), '\n', '', '')
	endif
endif

let g:is_mac = g:os == "Darwin"
let g:is_linux = g:os == "Linux"
let g:is_windows = g:os == "Windows"

" For vimtex completion
set completeopt=longest,menuone 
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
if g:is_mac
	let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
	let g:vimtex_view_general_options = '-r @line @pdf @tex'
	set termguicolors
elseif g:is_linux
	let g:vimtex_view_general_view = '/usr/bin/zathura'
endif

autocmd BufEnter *.tex set spell spelllang=en_us
autocmd BufEnter *.tex set tw=85

if &compatible
  set nocompatible               " Be iMproved
endif

" Always show statusline
set laststatus=2

set rtp+=/usr/local/lib/python3.7/site-packages/powerline/bindings/vim

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Required:
filetype plugin indent on

set clipboard=unnamed

let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1

colorscheme edge

if has("gui_running")
	set background=dark
endif

if g:is_mac
	set guifont=Roboto\ Mono\ Light\ for\ Powerline:h16
endif

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
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
call plug#end()

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nmap <F5> <Esc>:w<CR>:!clear;python3 %<CR>

" ---- vim-airline ----
"  " require powerline-symbol patched font installed
"  " install Roboto Mono given in .vim/fonts/
let g:airline_powerline_fonts = 1
"  " remove empty angle at the end
let g:airline_skip_empty_sections = 1
"  " set airline theme
let g:airline_theme='deus'

"  " extension for tab line
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'