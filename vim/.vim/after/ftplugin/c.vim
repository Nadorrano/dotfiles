" c specific settings.
setlocal nowrap tabstop=4 shiftwidth=4 expandtab
setlocal textwidth=79 colorcolumn=80

" set makprg to gcc if Makefile is not found
if !filereadable(expand("%:p:h")."/Makefile")
    setlocal makeprg=gcc\ -Wall\ -Wextra\ -o\ %<\ %
endif

