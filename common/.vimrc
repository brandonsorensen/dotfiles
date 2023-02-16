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

" Scroll through the document instead of terminal with mouse wheel, GUI-style
set mouse=a

let g:is_mac = g:os == "Darwin"
let g:is_linux = g:os == "Linux"
let g:is_windows = g:os == "Windows"

if g:is_mac
	let s:theme = system("defaults read -g AppleInterfaceStyle 2&>/dev/null")
	if s:theme =~ '^Dark' 
		let g:dark_mode = 1
	else
		let g:dark_mode = 0
	endif
endif

" For NERDTree toggle
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" For vimtex completion
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set completeopt=longest,menuone 
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
if g:is_mac
	let g:vimtex_view_general_options = '-r @line @pdf @tex'
	let g:vimtex_view_method = 'skim'
elseif g:is_linux
	let g:vimtex_view_method = '/usr/bin/zathura'
endif

let g:vimtex_fold_enabled = 1
let g:vimtex_syntax_packages = {
      \ 'tabularx': {'load': 2},
      \}
let g:vimtex_quickfix_autoclose_after_keystroke = 1

autocmd FileType tex set spell spelllang=en_us
autocmd FileType tex set tw=85
autocmd FileType tex setlocal foldmethod=expr foldexpr=3

autocmd FileType text set spell spelllang=en_us

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

if g:is_mac && !g:dark_mode 
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
	set guifont=MesloLGS\ NF:h16
endif


highlight Comment cterm=italic gui=italic

let g:ycm_filetype_blacklist = {
      \ 'tex': 1,
      \}

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

call plug#begin('~/.vim/plugged')
	Plug 'lervag/vimtex'
	Plug 'scrooloose/syntastic'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'ayu-theme/ayu-vim'
	Plug 'sonph/onehalf', {'rtp': 'vim/'}
	Plug 'vim-python/python-syntax'
	Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
	Plug 'sainnhe/edge'
	Plug 'flrnprz/plastic.vim'
	Plug 'edkolev/tmuxline.vim'
	Plug 'arcticicestudio/nord-vim'
	Plug 'arzg/vim-colors-xcode'
	Plug 'preservim/nerdtree'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'alvan/vim-closetag'
	Plug 'Raimondi/delimitMate'

call plug#end()

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

nmap <F5> <Esc>:w<CR>:!clear;python3 %<CR>

" CocCompletion
" Tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set updatetime=300

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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
let g:one_allow_italics = 1

" Make Python colorful!
let g:python_highlight_all = 1

" close-tag settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.plist'

" Python 3 syntax checking, please
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_tex_checkers = ['chktex']

let g:coc_global_extensions = [
			\'coc-json', 'coc-git', 'coc-vimtex',
			\'coc-jedi', 'coc-yaml', 'coc-xml'
			\]


" Activates PyDocString template
nmap <silent> <C-_> <Plug>(pydocstring)

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

