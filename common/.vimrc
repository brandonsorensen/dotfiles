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

if g:is_mac
	let s:theme = system("defaults read -g AppleInterfaceStyle 2&>/dev/null")
	if s:theme ==? 'dark'
		let g:dark_mode = 1
	else
		let g:dark_mode = 0
	endif
endif

" For NERDTree toggle
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

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

if !empty($VIM_THEME)
	colorscheme $VIM_THEME
	if empty($VIM_AIRLINE_THEME)
		let g:airline_theme = $VIM_THEME
	endif
else
	colorscheme edge
endif

if !empty($VIM_AIRLINE_THEME)
	let g:airline_theme = $VIM_AIRLINE_THEME
else
	let g:airline_theme = 'edge'
endif

if !empty($AYU_LIGHT)
	if $AYU_LIGHT == 1
		let g:ayucolor = 'light'
	else
		let g:ayucolor = 'dark'
	endif
else
	let g:ayucolor = 'dark'
endif

if g:is_mac && !g:dark_mode && g:ayucolor == 'light'
	set background=light
	highlight CursorLine guibg=lightgray ctermbg=lightgray
else
	set background=dark
	highlight CursorLine guibg=#211f1f ctermbg=darkgray
endif

" macOS uses the GUI background even in the terminal.
" This works for my use case. Don't know why. Don't care.
if has("gui_running") 
	if !g:is_mac 
		hi Normal guibg=#211f1f ctermbg=NONE
		hi nonText guibg=#211f1f ctermbg=NONE
		hi EndofBuffer guibg=#211f1f ctermbg=NONE
	else 
		if exists('+termguicolors')
			let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
			let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
			set termguicolors
		endif

		if g:dark_mode == 1
			hi Normal guibg=#211f1f ctermbg=NONE
			hi nonText guibg=#211f1f ctermbg=NONE
			hi EndofBuffer guibg=#211f1f ctermbg=NONE
		else
			hi Normal guibg=NONE ctermbg=NONE guifg=black ctermfg=black
			hi nonText guibg=NONE ctermbg=NONE
			hi EndofBuffer guibg=NONE ctermbg=NONE
			hi CursorLine guibg=darkgray ctermbg=darkgray
		endif
	endif
else 
	if g:is_mac
		if $ITERM_PROFILE == 'Xcode'
			colorscheme xcodewwdc
			let g:airline_theme = 'xcodewwdc'
			hi CursorLine guibg=#292c35 ctermbg=NONE
		endif
	endif
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
	" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ayu-theme/ayu-vim'
	Plug 'vim-python/python-syntax'
	Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
	Plug 'sainnhe/edge'
	Plug 'flrnprz/plastic.vim'
	Plug 'edkolev/tmuxline.vim'
	Plug 'arcticicestudio/nord-vim'
	Plug 'preservim/nerdtree'
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

"  " extension for tab line
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Nord settings
let g:nord_italic_comments = 1

" Make Python colorful!
let g:python_highlight_all = 1

" Python 3 syntax checking, please
let g:syntastic_python_checkers = ['flake8']


" Activates PyDocString template
nmap <silent> <C-_> <Plug>(pydocstring)
