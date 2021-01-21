" Some of the configuration of this file is based on the info
" provided at http://dougblack.io/words/a-good-vimrc.html

" Pathogen {{{
" use pathogen
call pathogen#infect()                      
" }}}
" Syntax {{{
syntax on

" Wrap gitcommit file types at the appropriate length
filetype indent plugin on
" }}}
" Spaces and Tabs  {{{
set tabstop=4
set softtabstop=4
set expandtab
 " }}}
" UI Config {{{
" set color scheme
set background=dark
colorscheme hybrid
" mouse support
set mouse=a
" set encoding
set encoding=utf-8
" show line numbers
set number
" show command in bottom bar
set showcmd
" Vim loves to redraw the screen during things it probably doesn't need
" to, like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros.
set lazyredraw
" match brackets
set showmatch
" set status bar always visible
set laststatus=2
" }}}
" Key Remapping {{{
" map nerdtree plugin to F2
map <F2> :NERDTreeToggle<CR>
" Navigation between split with alt+arrows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" }}}
" Searching {{{
" search as characters are entered
set incsearch
" highlight matches
set hlsearch
" alias to turn off search highlight
nnoremap <A-Space> :nohlsearch<CR>
" }}}
 " Folding {{{
set foldenable
" open most folds by default
set foldlevelstart=10
" 10 nested fold max
set foldnestmax=10
"space open/closes folds
nnoremap <space> za
" fold based on indent level
set foldmethod=indent

" }}}
" Vim per file settings {{{
" allows per file settings
set modelines=1
" autogroups
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.c,*.h
                          \ :call <SID>StripTrailingWhitespaces()
  autocmd FileType java setlocal noexpandtab
  autocmd FileType java setlocal list
  autocmd FileType java setlocal listchars=tab:+\ ,eol:-
  autocmd FileType java setlocal formatprg=par\ -w80\ -T4
  autocmd FileType php setlocal expandtab
  autocmd FileType php setlocal list
  autocmd FileType php setlocal listchars=tab:+\ ,eol:-
  autocmd FileType php setlocal formatprg=par\ -w80\ -T4
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal expandtab
  autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType python match Excess /\%80v.*/
  autocmd FileType python set nowrap
  autocmd FileType perl setlocal commentstring=#\ %s
  autocmd FileType perl setlocal tabstop=8
  autocmd FileType perl setlocal softtabstop=8
  autocmd FileType perl setlocal expandtab
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
 augroup END
" }}}
" System {{{ 

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %
" }}}
" Custom Functions {{{
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0