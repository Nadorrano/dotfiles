" Python specific settings.

" Indentation
setlocal autoindent smartindent
" Folding
setlocal foldmethod=indent foldnestmax=2 foldlevel=2
" Text
setlocal textwidth=79 nowrap colorcolumn=80
" Others
setlocal wildignore+=__pycache__
setlocal formatoptions=croql
" Set makeprg to python
setlocal makeprg=python\ %

