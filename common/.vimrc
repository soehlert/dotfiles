" Vim-plugs 
"""""""""""
call plug#begin('~/.vim/plugged')
" Vim looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ericbn/vim-solarized'
" Tmux statusline looks like vim-airline
Plug 'edkolev/tmuxline.vim'

" Auto add closing brackets/quotes/parens
Plug 'Raimondi/delimitMate'
" Quickly line up things with :Tab command
Plug 'godlygeek/tabular'
" Expand region allows you to grow/shrink your visual block
Plug 'terryma/vim-expand-region'

" Full path fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Allow vim to work well with csv files
Plug 'chrisbra/csv.vim'

" Syntax highlighter
" Need ultisnips first
Plug 'SirVer/ultisnips'
Plug 'pearofducks/ansible-vim', { 'do': 'cd ~/.vim/plugged/ultisnips; python2 generate.py' }
call plug#end()

" Vim settings
""""""""""""""
" Use delete like normal
set backspace=indent,eol,start

" Autoindent
set autoindent

" Need to download and install the fonts first
" (https://github.com/powerline/fonts)
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
