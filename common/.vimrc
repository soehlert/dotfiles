" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim-plugs
"""""""""""
call plug#begin('~/.vim/plugged')
" Vim looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
" Tmux statusline looks like vim-airline
Plug 'edkolev/tmuxline.vim'
" Play nicely with git
Plug 'tpope/vim-fugitive'
" Auto add closing brackets/quotes/parens
Plug 'Raimondi/delimitMate'
" Comment/uncomment easily
Plug 'tpope/vim-commentary' " Quickly line up things with :Tab command
Plug 'godlygeek/tabular' " Set up easy alignment
Plug 'junegunn/vim-easy-align'
" Expand region allows you to grow/shrink your visual block
Plug 'terryma/vim-expand-region'
" Allow vim to work well with csv files
Plug 'chrisbra/csv.vim'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" NERD tree git
Plug 'Xuyuanp/nerdtree-git-plugin'
" Use vim to create prompt and match it to vim/tmux
Plug 'edkolev/promptline.vim'
" Vim treat camelcase and underscores as word boundaries
Plug 'chaoren/vim-wordmotion'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Tab to select multiple results

" Syntax stuff
Plug 'plasticboy/vim-markdown'
Plug 'vim-syntastic/syntastic'
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'ambv/black', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
call plug#end()

" Vim settings
""""""""""""""
" Use delete like normal
set backspace=indent,eol,start

" No swap file
set noswapfile

" Show incomplete commands
set showcmd

" Incremental searching (search as you type)
set incsearch

" Autoload files that have changed outside of vim
set autoread

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
set wildmenu

" Allow substitutions to dynamically be represented in the buffer
" https://asciinema.org/a/92207
:silent! set inccommand=nosplit

filetype indent plugin on
" Autoindent
set autoindent
" Allows for dynamic variables depending on file type
set modeline
" Intelligently indent on new line
set smartindent
" Convert tabs to spaces
set expandtab
" Manual indenting tab size in spaces
set tabstop=2
" Automatic indenting tab size in spaces
set shiftwidth=2

autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd FileType sh,ruby,yaml,vim setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType php,python setlocal shiftwidth=4 tabstop=4 expandtab
" See `:h fo-table` for details of formatoptions `t` to force wrapping of text
autocmd FileType python,ruby,go,sh,javascript setlocal textwidth=79 formatoptions+=t

" FZF (search files)
" Shift-Tab to select multiple files
" Ctrl-t = tab
" Ctrl-x = split
" Ctrl-y = vertical
map <leader>t :FZF<CR>
map <leader>y :Buffers<CR>
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store " Files matched are ignored when expanding wildcards
set wildmode=list:longest,list:full

" Nerdtree settings
" Open up nerdtree automatically when starting vim
autocmd vimenter * NERDTree
" Set focus to actual file by default instead of nerdtree
autocmd VimEnter * wincmd p
" Auto close vim if nerdtree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Map ctrl-n to toggle nerdtree
map <C-n> :NERDTreeToggle<CR>
" Ignore rnd file permissions issue
let NERDTreeIgnore = [ '.rnd' ]
" Show hidden files
let NERDTreeShowHidden=1

" Need to download and install the fonts first
" (https://github.com/powerline/fonts)
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" Solarized settings
set t_Co=256
syntax enable
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_solarized_normal_green = 1
colorscheme solarized

" Promptline settings
let g:promptline_preset = {
	\'a' : [ promptline#slices#host() ],
	\'b' : [ promptline#slices#cwd() ],
	\'c' : [ promptline#slices#vcs_branch() ],
	\'y' : [ promptline#slices#git_status() ],
	\'z' : [ promptline#slices#python_virtualenv() ]}

" Alignment settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Run black formatter for python files on save
autocmd BufWritePre *.py execute ':Black'

" Syntax highlighting for specific files
autocmd BufRead,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?
" Set yaml.ansible file type on playbooks as well
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_ansible_checkers=['ansible_lint']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E305,E302 --max-line-length=88'
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
