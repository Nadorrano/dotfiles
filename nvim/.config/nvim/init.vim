" Load Vim plugin folder. The Vim8 plugin system is used.
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

" Load Vim settings
source ~/.vimrc

" Load nvim-cmp settings
lua require('config/nvim-cmp')

" Load lsp settings
lua require('config/lsp')

" Load treesitter settings
lua require('config/treesitter')

lua require('kanagawa').setup({ theme = "wave"})

