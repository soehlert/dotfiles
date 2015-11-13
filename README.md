# README #

##Install stow:
        brew install stow
        yum install stow

## Add ssh key (may need to use different name)
        ssh-add ~/.ssh/bitbucket

## Clone dotfiles repo
        cd; git clone git@bitbucket.org:soehlert21/dotfiles.git

## Vim setup
        cd dotfiles; stow vim
        git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle 
        vim
        :BundleInstall

### What is this repository for? ###

* My dotfiles to use with stow
* 1.0