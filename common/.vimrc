" ============================================================================
" Plugins
" ============================================================================
call plug#begin('~/.vim/plugged')

" UI
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'          " updated from scrooloose/nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'            " replaces ctrlp

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'        " replaces nerdcommenter, simpler
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" Linting + Completion
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " replaces YCM

" Syntax
Plug 'stephpy/vim-yaml'
Plug 'pearofducks/ansible-vim'
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-go'

call plug#end()

" ============================================================================
" General
" ============================================================================
set nocompatible
filetype plugin indent on
syntax enable

set encoding=utf-8
set number
set ruler
set showcmd
set showmatch
set cursorline

set wildmenu                   " needed for wildmode to work properly
set wildmode=list:longest

set scrolloff=5
set laststatus=2

" ============================================================================
" Leader
" ============================================================================
let mapleader = ","

" ============================================================================
" Theme
" ============================================================================
set background=dark
colorscheme solarized

" ============================================================================
" Whitespace
" ============================================================================
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap

" Strip trailing whitespace on save (scoped to common filetypes only)
autocmd BufWritePre *.py,*.js,*.rb,*.yml,*.yaml,*.sh,*.vim :%s/\s\+$//e

" ============================================================================
" Search
" ============================================================================
set hlsearch
set incsearch
set ignorecase
set smartcase

" ============================================================================
" Files & Backups
" ============================================================================
set nobackup
set noswapfile
set autoread

" ============================================================================
" Splits
" ============================================================================
set splitbelow
set splitright

" ============================================================================
" Key Mappings
" ============================================================================
" Toggle invisible characters
map <leader>l :set list!<CR>

" Clear search highlight
nnoremap <leader><space> :nohlsearch<CR>

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ============================================================================
" coc.nvim extensions
" ============================================================================
let g:coc_global_extensions = [
\  'coc-pyright',
\  'coc-tsserver',
\  'coc-html',
\  'coc-css',
\  'coc-yaml',
\  'coc-sh',
\  'coc-json',
\  'coc-prettier',
\]

" ============================================================================
" ALE
" ============================================================================
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'python':     ['flake8'],
\  'typescript': ['eslint', 'tsserver'],
\  'javascript': ['eslint'],
\  'yaml':       ['yamllint'],
\  'bash':       ['shellcheck'],
\  'html':       ['htmlhint'],
\}
let g:ale_fixers = {
\  '*':          ['remove_trailing_lines', 'trim_whitespace'],
\  'python':     ['black', 'isort'],
\  'typescript': ['prettier', 'eslint'],
\  'javascript': ['prettier', 'eslint'],
\  'yaml':       ['prettier'],
\  'html':       ['prettier'],
\  'bash':       ['shfmt'],
\}

" ============================================================================
" NERDTree
" ============================================================================
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
  \ && b:NERDTree.isTabTree()) | q | endif   " close vim if NERDTree is last window

" ============================================================================
" Airline
" ============================================================================
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1

" ============================================================================
" vim-go
" ============================================================================
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" ============================================================================
" Terraform
" ============================================================================
let g:terraform_align=1
let g:terraform_fmt_on_save=1
