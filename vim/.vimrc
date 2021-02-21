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
set splitright          " open new files on the right split
set splitbelow          " open new files on the bottom split
" enable truecolors in st
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
" Vim loves to redraw the screen during things it probably doesn't need
" to, like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros.
set lazyredraw
" }}}
" Plugins {{{
" NERDTree
let g:NERDTreeDirArrowExpandable = '► '
let g:NERDTreeDirArrowCollapsible = '▼ '
let NERDTreeShowHidden=1
" map nerdtree plugin to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Powerline
set laststatus=2        " Always display the statusline
set showtabline=2       " Always display the tabline
set noshowmode          " Hide the default mode text
" }}}
" Key Remapping {{{
" Fix scrolling bug with st terminal
map <ScrollWheelUp> <C-Y>
" Navigation between split with alt+arrows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
" Mistakes!
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee %
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
   autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
   autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab
   autocmd FileType java setlocal noexpandtab list listchars=tab:+\ ,eol:-
   autocmd FileType java setlocal formatprg=par\ -w80\ -T4
   autocmd FileType php setlocal expandtab list listchars=tab:+\ ,eol:-
   autocmd FileType php setlocal formatprg=par\ -w80\ -T4
   autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2
   autocmd FileType ruby setlocal commentstring=#\ %s
   autocmd FileType python setlocal commentstring=#\ %s tabstop=4 softtabstop=4 expandtab
   autocmd FileType python setlocal commentstring=#\ %s 
   autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
   autocmd FileType python match Excess /\%80v.*/
   autocmd FileType python set nowrap
   autocmd FileType perl setlocal tabstop=8 softtabstop=8 expandtab commentstring=#\ %s
   autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
   autocmd Filetype sh setlocal tabstop=2 shiftwidth=2 softtabstop=2
   autocmd Filetype zsh setlocal tabstop=2 shiftwidth=2 softtabstop=2
   autocmd BufEnter *.cls setlocal filetype=java
   autocmd BufEnter *.zsh-theme setlocal filetype=zsh
   autocmd BufEnter Makefile setlocal noexpandtab
   autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END
" }}}
" Custom Functions {{{
" Capture command output in new buffer
command! -nargs=1 Capture new | r ! <args>
command! -nargs=1 C Capture <args>
" Convert binary file to hexdump
function ToBinary()
        %!xxd
        set ft=xxd
endfunction
function ToAscii()
        %!xxd -r
        set ft=
endfunction
command! Binary call ToBinary()
command! Ascii call ToAscii()
" Menu selection of some characters
function Pars()
        set cmdheight=2
        echohl Title | echom 'Scelte:' | echohl None
        echo '1. ()    2. &'
        let choice = getchar()
        if choice == 49 
                normal i()
        elseif choice == 50 
                normal i&
        endif
        set cmdheight=1
        echo
endfunction
imap <C-B> <C-O>:call Pars()<CR>
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
