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
Plug 'tpope/vim-commentary'
" Quickly line up things with :Tab command
Plug 'godlygeek/tabular'
" Set up easy alignment
Plug 'junegunn/vim-easy-align'
" Expand region allows you to grow/shrink your visual block
Plug 'terryma/vim-expand-region'
" Full path fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Allow vim to work well with csv files
Plug 'chrisbra/csv.vim'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" NERD tree git 
Plug 'Xuyuanp/nerdtree-git-plugin'
" Use vim to create prompt and match it to vim/tmux
Plug 'edkolev/promptline.vim'

" Fuzzy finder
Plug '/usr/local/opt/fzf'

" Syntax stuff
Plug 'vim-syntastic/syntastic'
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
call plug#end()

" Vim settings
""""""""""""""
" Use delete like normal
set backspace=indent,eol,start

" Autoindent
"set autoindent
set smartindent
set smarttab
set shiftwidth=4
set ts=4

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

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
