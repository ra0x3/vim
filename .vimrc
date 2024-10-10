" Configuration file for Vi Improved, save as ~/.vimrc to use.
" Written on 2014-07-16 by Miko Bartnicki <mikobartnicki@gmail.com>.

" use Vim mode instead of pure Vi, it must be the first instruction
set nocompatible

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode

" write settings
set confirm " confirm :q in case of unsaved changes
set fileencoding=utf-8 " encoding used when saving file
set nobackup " do not keep the backup~ file

" edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode
set expandtab " fill tabs with spaces
set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=8 " set indentation depth to 8 columns
set softtabstop=8 " backspacing over 8 spaces like over tabs
set tabstop=8 " set tabulator length to 8 columns
"set textwidth=80 " wrap lines automatically at 80th column

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ...unless capital letters are used

" file type specific settings
filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code

" syntax highlighting
" colorscheme solarized " set color scheme, must be installed first
set background=dark " dark background for console
syntax enable " enable syntax highlighting

" characters for displaying non-printable characters
set listchars=eol:$,tab:>-,trail:.,nbsp:_,extends:+,precedes:+

" tuning for gVim only
if has('gui_running')
        set background=light " light background for GUI
        set columns=84 lines=48 " GUI window geometry
        set guifont=Monospace\ 12 " font for GUI window
        set number " show line numbers
endif

" automatic commands
if has('autocmd')
        " file type specific automatic commands

        " tuning textwidth for Java code
        autocmd FileType java setlocal textwidth=132
        if has('gui_running')
                autocmd FileType java setlocal columns=136
        endif

        " don't replace Tabs with spaces when editing makefiles
        autocmd Filetype makefile setlocal noexpandtab

        " disable automatic code indentation when editing TeX and XML files
        autocmd FileType tex,xml setlocal indentexpr=

        " clean-up commands that run automatically on write; use with caution

        " delete empty or whitespaces-only lines at the end of file
        autocmd BufWritePre * :%s/\(\s*\n\)\+\%$//ge

        " replace groups of empty or whitespaces-only lines with one empty line
        autocmd BufWritePre * :%s/\(\s*\n\)\{3,}/\r\r/ge

        " delete any trailing whitespaces
        autocmd BufWritePre * :%s/\s\+$//ge
endif

" general key mappings

" center view on the search result
noremap n nzz
noremap N Nzz

" press F4 to fix indentation in whole file; overwrites marker 'q' position
noremap <F4> mqggVG=`qzz
inoremap <F4> <Esc>mqggVG=`qzza

" press F5 to sort selection or paragraph
vnoremap <F5> :sort i<CR>
nnoremap <F5> Vip:sort i<CR>

" press F8 to turn the search results highlight off
noremap <F8> :nohl<CR>
inoremap <F8> <Esc>:nohl<CR>a

" press F12 to toggle showing the non-printable charactes
noremap <F12> :set list!<CR>
inoremap <F12> <Esc>:set list!<CR>a

" Note: Make sure the function is defined before `vim-buffet` is loaded.
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=bold ctermbg=Red ctermfg=White guibg=NONE guifg=NONE
endfunction

call plug#begin()
"  Plug 'ryanoasis/vim-devicons'
  Plug 'bagrat/vim-buffet'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'preservim/nerdtree'
  Plug 'sheerun/vim-polyglot'
  Plug 'koryschneider/vim-trim'
  Plug 'dense-analysis/ale'
  "Plug 'rust-lang/rust.vim'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'sbdchd/neoformat'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
call plug#end()

let NERDTreeMapOpenInTab='\r'

" Tab navigation (works only in gvim, not in console)
nnoremap <C-tab>   gt
nnoremap <C-S-tab> gT

" As-you-type autocomplete
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

nnoremap <C-LeftMouse> :ALEGoToDefinition<CR>

" let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

" Required, explicitly enable Elixir LS
" let g:ale_linters = { 'rust': ['analyzer'] }

" You can use Ag with ack.vim by adding the following line to your .vimrc
let g:ackprg = 'ag --nogroup --nocolor --column'

" Set to 1, use powerline separators in between buffers and tabs in the tabline (see the first screenshot)
let g:buffet_powerline_separators = 1

" The character to be used for separating items in the tabline
let g:buffet_separator = "   "

" If set to 1 and vim-devicons plugin is installed, show file type icons for each buffer in the tabline. If the vim-devicons plugin is not present, the option will automatically default to 0 (Note: you need to have vim-devicons loaded before vim-buffet in order to make this work)
let g:buffet_use_devicons = 0

let g:buffet_show_index = 1

set guifont=Monaco:h12

" https://github.com/fatih/vim-go/issues/3171#issuecomment-804548360
"set re=2
" https://prettier.io/docs/en/vim.html
"let g:neoformat_try_node_exe = 1
"autocmd BufWritePre *.{tsx,js} Neoformat

" https://github.com/sonph/onehalf/tree/master/vim
syntax on
set t_Co=256
set cursorline
set number
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" lightline
" let g:lightline = { 'colorscheme': 'onehalfdark' }
"
set colorcolumn=80

let NERDTreeMapOpenInTab='\r'

au VimEnter *  NERDTree | wincmd p

" Close nerdtree when all tabs close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" https://vi.stackexchange.com/a/28721
set re=2
