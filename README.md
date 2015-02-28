# README #

Install stow:
brew install stow
yum install stow

ssh-add ~/.ssh/bitbucket

git clone git@bitbucket.org:soehlert21/dotfiles.git

cd dotfiles; stow vim

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim

:BundleInstall

### What is this repository for? ###

* My dotfiles to use with stow
* 1.0
