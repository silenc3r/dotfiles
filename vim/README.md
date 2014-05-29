Vim configuration files

to install YouCompleteMe with C-family semantic completion:
    cd $HOME/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer --system-libclang

to update plugins:
    vim +PluginUpdate +PluginClean +qall
