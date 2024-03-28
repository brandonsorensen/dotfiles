syntax on
set rnu
set number
set noexpandtab
set tabstop=4
set shiftwidth=0   " use `tabstop` value
set softtabstop=0  " use `tabstop` value
set cursorline
set clipboard=unnamed
set backspace=indent,eol,start
set ignorecase
set smartcase
filetype plugin on
let mapleader = " "
imap <F5> <Esc>:w<CR>:!clear;python %<CR>

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

" fzf buffer list
nnoremap <silent><leader>r :Buffers<CR>
" fzf dir list
nnoremap <silent><leader>f :Files<CR>
" Explore
nnoremap <silent><leader>e :Lexplore<CR>
" Remap ctl-w to leader for window management
nnoremap <Leader>w <C-w>
" Close buffer without losing split
nnoremap <silent><leader>c :bp\|bd #<CR>
" Quickly switch to previous buffer
nnoremap <silent><leader>s <C-^>
" Clear highlight
nnoremap <silent><leader>h :noh<CR>
" Shortcut for scrolling in a terminal
tnoremap <c-b> <c-\><c-n>

call plug#begin('~/.vim/plugged')
	Plug 'lervag/vimtex'
	Plug 'ayu-theme/ayu-vim'
	Plug 'sonph/onehalf', {'rtp': 'vim/'}
	Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
	Plug 'sainnhe/edge'
	Plug 'flrnprz/plastic.vim'
	Plug 'edkolev/tmuxline.vim'
	Plug 'nordtheme/vim'
	Plug 'arzg/vim-colors-xcode'
	Plug 'alvan/vim-closetag'
	Plug 'cohama/lexima.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'tpope/vim-commentary'
	Plug 'kaarmu/typst.vim', {'branch': 'main'}
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'preservim/vimux'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'kdheepak/lazygit.nvim', {'branch': 'main'}
	if has('nvim')
		Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
		Plug 'neovim/nvim-lspconfig'
		Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
		Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
		Plug 'hrsh7th/cmp-path', {'branch': 'main'}
		Plug 'hrsh7th/cmp-cmdline', {'branch': 'main'}
		Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
		Plug 'L3MON4D3/LuaSnip'
		Plug 'shaunsingh/nord.nvim'
		Plug 'nvim-lualine/lualine.nvim'
		Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
		Plug 'daschw/leaf.nvim'
		Plug 'folke/flash.nvim', {'branch': 'main'}
		Plug 'folke/trouble.nvim', {'branch': 'main'}
		Plug 'shaunsingh/nord.nvim'
		Plug 'nvim-tree/nvim-web-devicons'
	else
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
	endif
call plug#end()


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
set guifont=MesloLGS\ NF:h14

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
autocmd FileType rust set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua set shiftwidth=2 tabstop=2 softtabstop=2


if &compatible
  set nocompatible               " Be iMproved
endif

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set clipboard=unnamed

let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1

if !empty($VIM_THEME)
	colorscheme $VIM_THEME
	if empty($VIM_AIRLINE_THEME)
		let g:airline_theme = $VIM_THEME
	endif
else
	if g:dark_mode
		colorscheme nord
	else
		" colorscheme leaf
		hi Normal guibg=None
	endif
endif

if !empty($VIM_AIRLINE_THEME)
	let g:airline_theme = $VIM_AIRLINE_THEME
else
	if g:dark_mode
		let g:airline_theme = 'nord'
	else
		let g:airline_theme = 'papercolor'
	endif
endif

if g:is_mac && !g:dark_mode 
	highlight CursorLine guibg=lightgray ctermbg=lightgray
	highlight Search guibg=lightgray ctermfg=3
	highlight Visual cterm=bold guibg=lightgray ctermbg=blue ctermfg=None
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
			hi CursorLine guibg=#424a5b 
		else
			hi Normal guibg=NONE ctermbg=NONE guifg=black ctermfg=black
			hi nonText guibg=NONE ctermbg=NONE
			hi EndofBuffer guibg=NONE ctermbg=NONE
			hi CursorLine guibg=darkgray ctermbg=darkgray
		endif
	endif
endif

if g:is_mac
	set guifont=MesloLGS\ NF:h16
endif


highlight Comment cterm=italic gui=italic
highlight VertSplit cterm=None ctermfg=None ctermbg=None
highlight Normal guibg=None
set fillchars+=vert:\▏

let g:ycm_filetype_blacklist = {
      \ 'tex': 1,
      \}

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Resolves conflicts between lexima and coc completion
" let g:lexima_no_default_rules = 1
" call lexima#set_default_rules()
" call lexima#insmode#map_hook('before', '<CR>', '')
" call lexima#add_rule({'char': '"', 'at': '\%#\s*\w'})
" call lexima#add_rule({'char': '"', 'at': '"\S\{-1,}\%#\|\%#\S\{-1,}"'})
" call lexima#add_rule({'char': "'", 'at': "'\S\{-1,}\%#\|\%#\S\{-1,}'"})
" call lexima#add_rule({'char': '`', 'at': '`\S\{-1,}\%#\|\%#\S\{-1,}`'})
" call lexima#add_rule({'char': '(', 'at': '\%#\S\{-1,})'})
" call lexima#add_rule({'char': '[', 'at': '\%#\S\{-1,}]'})
" call lexima#add_rule({'char': '{', 'at': '\%#\S\{-1,}}'})
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<CR>" : "\<CR>")

" if has("nvim")
"     au VimEnter * AirlineToggle
" endif

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


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

" if g:dark_mode
" 	" Rust  type hints
" 	hi CocInlayHint ctermbg=0 ctermfg=4
" endif


" typst
let g:typst_conceal = 1
let g:typst_conceal_math = 1
let g:typst_conceal_emoji = 1
let g:typst_embedded_languages = []

" Activates PyDocString template
nmap <silent> <C-_> <Plug>(pydocstring)
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

nmap <silent> <c-f> :Files<CR>

" highlight the visual selection after pressing enter.
set hlsearch
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
