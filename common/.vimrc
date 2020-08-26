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
	let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
elseif g:is_linux
	let g:vimtex_view_general_view = '/usr/bin/zathura'
endif

function! UpdateSkim(status)
	" This function updates Skim based based on the
	" status returned when a VimTeX compiles
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif

    if has('nvim')
        call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
        call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
        call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
endfunction

let g:vimtex_fold_enabled = 1
let g:vimtex_fold_comments = 1
autocmd FileType tex set spell spelllang=en_us
autocmd FileType tex set tw=85
autocmd FileType tex setlocal foldmethod=expr foldexpr=3

if &compatible
  set nocompatible               " Be iMproved
endif

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Required:
filetype plugin indent on

set clipboard=unnamed

let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1

colorscheme edge
set background=dark

" macOS uses the GUI background even in the terminal.
" This works for my use case. Don't know why. Don't care.
if has("gui_running") 
	hi Normal guibg=#211f1f ctermbg=NONE
	hi nonText guibg=#211f1f ctermbg=NONE
	hi EndofBuffer guibg=#211f1f ctermbg=NONE
	if g:is_mac 
		if exists('+termguicolors')
			let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
			let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
			set termguicolors
		endif
	endif
else 
	hi Normal guibg=NONE ctermbg=NONE
	hi nonText guibg=NONE ctermbg=NONE 
	hi EndofBuffer guibg=NONE ctermbg=NONE
endif

if g:is_mac
	set guifont=Roboto\ Mono\ Light\ for\ Powerline:h16
endif


highlight Comment cterm=italic gui=italic

let g:ycm_filetype_blacklist = {
      \ 'tex': 1,
      \}

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

call plug#begin('~/.vim/plugged')
	Plug 'lervag/vimtex'
	Plug 'scrooloose/syntastic'
	" Remember to install CMake
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-python/python-syntax'
	Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
	Plug 'sainnhe/edge'
	Plug 'flrnprz/plastic.vim'
	Plug 'edkolev/tmuxline.vim'
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
let g:airline_theme='edge'

"  " extension for tab line
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Make Python colorful!
let g:python_highlight_all = 1

" Python 3 syntax checking, please
let g:syntastic_python_checkers = ['flake8']

" Activates PyDocString template
nmap <silent> <C-_> <Plug>(pydocstring)
