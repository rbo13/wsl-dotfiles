" Load runtime path
set runtimepath^=~/.vim runtimepath+=~/.vim/after runtimepath+=/usr/local/opt/fzf
let &packpath = &runtimepath

" Install Plugins using `vim-plug`
" ===============================
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ap/vim-buftabline'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'ggreer/the_silver_searcher'
Plug 'zivyangll/git-blame.vim'
Plug 'chrisbra/unicode.vim'
Plug 'airblade/vim-gitgutter'

" Code Completion Engine/Intellisense
" Note: LSP must be installed first
Plug 'natebosch/vim-lsc'
" End: Code Completion Plugin

" Language Specific Plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'iloginow/vim-stylus'
Plug 'storyn26383/vim-vue'
" End: Language Plugins

" Tools: Debugger/Linter/Syntax-Highlighting
Plug 'sebdah/vim-delve'
Plug 'w0rp/ale'
" End: Tools

" Editor Theme
" Plug 'ajmwagar/vim-deus'
Plug 'chriskempson/base16-vim'
" End: Editor Theme

call plug#end()
" End `vim-plug`

" Load Theme
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
" colorscheme deus " old colorscheme
" let g:deus_termcolors=256
" End: Theme Loaded


" ----------------------------------------------------------------------
" | Neovim General Settings                                             |
" ----------------------------------------------------------------------
set ttyfast
set encoding=utf-8 nobomb
set nocompatible                    " Don't make Vim vi-compatible.
syntax on                           " Enable syntax highlighting.

if has('autocmd')
  filetype plugin indent on
endif

set autoindent
set backspace=indent
set backspace+=eol
set backspace+=start

set backupdir=~/.vim/backups

if has('wildignore')
  set backupskip=/tmp/*
  set backupskip+=/private/tmp/*
endif

set clipboard=unnamed
if has('unnamedplus')
  set clipboard+=unnamedplus
endif

set cpoptions+=$

if has('syntax')
  set colorcolumn=101
  set cursorline
  set synmaxcol=2500
endif

set directory=~/.vim/swaps

if has('cmdline_hist')
  set history=5000
endif

if has('extra_search')
  set hlsearch
  set incsearch
endif

set ignorecase
set laststatus=2

set magic
set mousehide

set nojoinspaces
set nomodeline
set nostartofline
set relativenumber

if has('linebreak')
  set numberwidth=5
endif

set report=0

if has('cmdline_info')
  set ruler
  set showcmd
endif

set scrolloff=5

set completeopt+=preview
set shortmess=aAItW
set shortmess-=F
set noshowmode

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set hidden

if has('persistent_undo')
  set undodir=~/.vim/undos
  set undofile
endif

if has('virtual_edit')
  set virtualedit=all
endif

set visualbell
set noerrorbells
set t_vb=

if has('wildmenu')
  set wildmenu
endif

if has('windows')
  set winminheight=0
endif

set wildmode=list:longest,full

set binary
set noeol


" ----------------------------------------------------------------------
" | Remapping                                                           |
" ----------------------------------------------------------------------

" Use <Space> to search
map <space> /

" Prevent arrow keys on normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" move up/down consider wrapped lines
nnoremap j gj
nnoremap k gk

" move to different tab
nnoremap <C-D> :bnext<CR>
nnoremap <C-S> :bprev<CR>

" Create Splits
set splitbelow
set splitright

" Make `Tab` autocomplete.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Prevent `Enter` to create new line when selecting from omni-completion
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" Keep a menu item always highlighted
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" ----------------------------------------------------------------------
" | Define Map Leader                                                   |
" ----------------------------------------------------------------------
let mapleader=","                                       " Set , as leader

" Toggle NerdTree
nmap <leader>t :NERDTreeToggle<cr>

" Clear highlight search
map <leader>cs :nohlsearch<cr>

" [,w] Close current buffer
map <leader>w :bd<cr>

" [,* ] Search and replace the word under the cursor.
nmap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" [,ss] Strip trailing whitespace.
nmap <leader>ss :call StripTrailingWhitespaces()<CR>

" [,cc] Toggle code comments.
" https://github.com/tomtom/tcomment_vim
map <leader>cc :TComment<CR>

" [,w] Close current buffer
map <leader>w :bdelete<CR>

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>

" ----------------------------------------------------------------------
" | Define User Functions                                               |
" ----------------------------------------------------------------------
function! StripTrailingWhitespaces()
	let searchHistory = @/
	let cursorLine = line(".")
	let cursorColumn = col(".")

	%s/\s\+$//e

	let @/ = searchHistory
	call cursor(cursorLine, cursorColumn)
endfunction

function! ToggleRelativeLineNumbers()
	if ( &relativenumber == 1 )
		set number
	else
		set relativenumber
	endif
endfunction

" ----------------------------------------------------------------------
" | Plugin Settings                                                     |
" ----------------------------------------------------------------------

" natebosch/vim-lsc
autocmd CompleteDone * silent! pclose
let g:lsc_server_commands = {
\  "go": {
\    "command": "gopls serve",
\    "log_level": -1,
\    "suppress_stderr": v:true,
\  },
\ "javascript": "typescript-language-server --stdio",
\ }

" NerdTree
let NERDTreeShowHidden=1      " Show hidden files when toggling NerdTree

" Ale
let g:ale_linters = {
			\   'go': ['gopls', 'golint', 'go vet'],
      \   'javascript': ['eslint'],
			\ }

let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'

" silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" fzf
nnoremap <C-p> :FZF<CR>

" Lightline
let g:lightline = {}

let g:lightline.colorscheme = 'deus'

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [[ 'fileformat', 'fileencoding', 'percent', 'filetype', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]],
			\										 'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]
			\	}

let g:lightline.component_function = {
      \     'gitbranch': 'fugitive#head',
      \ }

"----------------------------------------------
"
" Plugin: 'ctrlpvim/ctrlp.vim'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depends
" on it to run GoDecls(Dir).
" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.
let g:ctrlp_map = ''

" Open Ag
nnoremap <leader>a :Ag<space>

" ----------------------------------------------------------------------
" | Language Specific Settings                                          |
" ----------------------------------------------------------------------

" GO
let g:go_version_warning = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
" let g:go_snippet_engine = "neosnippet"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Mappings
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap gc <Plug>(go-coverage-toggle)
au FileType go nmap gt <Plug>(go-test)
au FileType go nmap gf <Plug>(go-test-func)
au FileType go nmap gr <Plug>(go-run)
" END GO
