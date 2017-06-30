# README #

##Install stow:
        brew install stow
        yum install stow

## Add ssh key (may need to use different name)
        ssh-add ~/.ssh/github

## Clone dotfiles repo
        cd; git clone git@github.com:soehlert/dotfiles.git

## Vim setup
        cd dotfiles; stow common; stow (home|work|server)
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
        vim
        :BundleInstall

### What is this repository for? ###

* My dotfiles to use with stow
