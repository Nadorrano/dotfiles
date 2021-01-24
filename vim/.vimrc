" Some of the configuration of this file is based on the info
" provided at http://dougblack.io/words/a-good-vimrc.html

" Setup {{{
set nocompatible        " This must be first
" }}}
" Syntax {{{  
syntax enable           " Highlight syntax
" Wrap gitcommit file types at the appropriate length
filetype indent plugin on
" }}}
" Spaces and Tabs   {{{
set tabstop=4
set softtabstop=4
set expandtab
 " }}}
" UI Config {{{  
set background=dark     " dark mode
colorscheme gruvbox     " set color scheme
set mouse=a             " mouse support
set encoding=utf-8      " set encoding
set number              " show line numbers
set showcmd             " show command in bottom bar
set showmatch           " match brackets
" Vim loves to redraw the screen during things it probably doesn't need
" to, like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros.
set lazyredraw
" }}}
" Plugins {{{
" NERDTree
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowHidden=1
" map nerdtree plugin to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Powerline
set laststatus=2        " Always display the statusline
set showtabline=2       " Always display the tabline
set noshowmode          " Hide the default mode text
" }}}
" Key Remapping {{{
" Navigation between split with alt+arrows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" }}}
" Searching {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" alias to turn off search highlight
nnoremap <A-Space> :nohlsearch<CR>
" }}}
 " Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
" space open/closes folds
nnoremap <space> za
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
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
 augroup END
" }}}
" System {{{ 

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %
" }}}
" Custom Functions {{{
" Strips trailing whitespace at the end of files. this
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
