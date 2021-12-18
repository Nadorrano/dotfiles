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
colorscheme nord     " set color scheme
set termguicolors
hi Normal guibg=#10171f
set title               " Set the title of the window
set mouse=a             " mouse support
set encoding=utf-8      " set encoding
set number              " show line numbers
set showcmd             " show command in bottom bar
set showmatch           " match brackets
set splitright          " open new files on the right split
set splitbelow          " open new files on the bottom split
set backspace=indent,eol,start      " Backspace go to earlier line 
" enable truecolors in st
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" Vim loves to redraw the screen during things it probably doesn't need
" to, like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros.
set lazyredraw
" }}}
" Plugins {{{
" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '► '
let g:NERDTreeDirArrowCollapsible = '▼ '
let g:NERDTreeIgnore = ['.git', 'node_modules', '__pycache__']      " Things to hide
" map nerdtree plugin to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Lightline
set laststatus=2        " Always display the statusline
set showtabline=2       " Always display the tabline
set noshowmode          " Hide the default mode text
" fzf
let g:fzf_buffers_jump = 1                                          " Jump to the existing window if possible
let g:fzf_preview_window = ['right:50%,border-left', 'ctrl-/']      " Preview buffer on the right side of the window with 60% width
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'highlight': 'Normal'} }    " Fzf window layout configs for default search

let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'], 
            \ 'hl':      ['fg', 'Comment'], 
            \ 'fg+':     ['fg', 'IncSearch', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'Normal'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Normal'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endifk
" LS command
command! -complete=dir -nargs=? LS call fzf#run(fzf#wrap({'source': 'ls', 'dir': <q-args>}))
" Dotfiles
let dotfiles = 'git --git-dir=$HOME/.dotfiles/.git ls-tree --full-tree --name-only -r HEAD | sed "s,^,$HOME/.dotfiles/,"'
command! Dotfiles call fzf#run(fzf#wrap({ 'source': dotfiles, 'window': { 'height': 0.3, 'width': 0.4 }}))
" }}}
" Key Remapping {{{
" Fix scrolling bug with st terminal
map <ScrollWheelUp> <C-Y>
" Navigation between split with alt+arrows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
" Window Resizing, change the width of windows using {+, -}
nnoremap + :vertical resize +2<CR>
nnoremap - :vertical resize -2<CR>
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
set incsearch           " Search as characters are entered
set hlsearch            " Highlight matches
set ignorecase          " Case insensitive search
set smartcase           " Case sensitive search with uppercase search terms
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
   autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.c,*.h,*.css,*.html,*.rs
                           \ :call <SID>StripTrailingWhitespaces()
   autocmd BufEnter *.cls setlocal filetype=java
   autocmd BufEnter *.zsh-theme setlocal filetype=zsh
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
" Menu selection of some characters not working on my keyboard
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
