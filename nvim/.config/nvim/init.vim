" Load Vim plugin folder. The Vim8 plugin system is used.
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

" Load init.lua
lua require('lsp_config')

" Load Vim settings
source ~/.vimrc
