" Some of the configuration of this file is based on the info
" provided at http://dougblack.io/words/a-good-vimrc.html

" Setup {{{
set nocompatible        " This must be first
" Set internal encoding
set encoding=utf-8
set hidden                          " TextEdit might fail if hidden is not set.
" Some language servers have issues with backup files, see coc issue #649.
set nobackup
set nowritebackup
" }}}
" Vim Plug {{{
call plug#begin('~/.local/share/vim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

" Generic plugins
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sainnhe/gruvbox-material'

if has('nvim')
  Plug 'norcalli/nvim-colorizer.lua'

  " LSP and completion plugins
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'm-pilia/vim-ccls'

  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Vimspector
  Plug 'puremourning/vimspector'

  " Themes
  Plug 'rebelot/kanagawa.nvim'
  Plug 'shaunsingh/nord.nvim'
else
  Plug 'ap/vim-css-color'
  " Theme
  Plug 'morhetz/gruvbox'
  Plug 'nordtheme/vim'
endif

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
" }}}
" Syntax {{{  
" Spaces and Tabs
set tabstop=4 softtabstop=4 expandtab
" }}}
" UI Config {{{  
if has('nvim')
  colorscheme kanagawa                 " set color scheme
  " colorscheme gruvbox-material      " set color scheme
else
  " colorscheme gruvbox-material      " set color scheme
  colorscheme nord                 " set color scheme
endif
set background=dark                 " or light if you want light mode
set termguicolors
set title                           " Set the title of the window
set mouse=a                         " mouse support
set encoding=utf-8                  " set encoding
set number                          " show line numbers
set showcmd                         " show command in bottom bar
set showmatch                       " match brackets
set splitright                      " open new files on the right split
set splitbelow                      " open new files on the bottom split
set laststatus=2                    " Always display the statusline
set showtabline=2                   " Always display the tabline
set noshowmode                      " Hide the default mode text
set backspace=indent,eol,start      " Backspace go to earlier line 
" Vim loves to redraw the screen during things it probably doesn't need
" to, like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros.
set lazyredraw
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" }}}
" Key Remapping {{{
let mapleader=","                   " mapping the leader key to comma
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
cnoremap w!! %!sudo tee > /dev/null %
"Mapping to select the last-changed text
noremap gV `[v`]

" }}}
" Plugins {{{
" Indent lines
let g:indentLine_char = ''
" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
" NERDTree
let NERDTreeShowHidden = 1
let g:NERDTreeDirArrowExpandable = '► '
let g:NERDTreeDirArrowCollapsible = '▼ '
let g:NERDTreeIgnore = ['.git', 'node_modules', '__pycache__']      " Things to hide
" map nerdtree plugin to Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
" Navigation using arrows and h,l
autocmd FileType nerdtree nmap <buffer> <right> o 
autocmd FileType nerdtree nmap <buffer> l o 
autocmd FileType nerdtree nmap <buffer> <left> x 
autocmd FileType nerdtree nmap <buffer> h x
" Lightline
" in some cases lightline does not show up at startup, this fix it
autocmd VimEnter * call lightline#update()


let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'component_function': {
      \   'filetype'            : 'MyFiletype',
      \   'fileformat'          : 'MyFileformat',
      \ },
      \ 'component': {
      \   'vim_logo'            : " ",
      \ },
      \ 'component_type': {
      \   'git_info'            : 'middle',  
      \ },
      \ 'component_expand': {
      \ },
      \ 'tabline' : {
      \   'left': [ [ 'vim_logo', 'tabs' ] ],
      \   },
      \ }


let g:lightline.separator = { 'left': "", 'right': "" }
let g:lightline.subseparator = { 'left': "", 'right': "" }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

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

" LS command
command! -complete=dir -nargs=? LS call fzf#run(fzf#wrap({'source': 'ls', 'dir': <q-args>}))
" Dotfiles
let dotfiles = 'git --git-dir=$HOME/.dotfiles/.git ls-tree --full-tree --name-only -r HEAD | sed "s,^,$HOME/.dotfiles/,"'
command! Dotfiles call fzf#run(fzf#wrap({ 'source': dotfiles, 'window': { 'height': 0.3, 'width': 0.4 }}))
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
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.c,*.h,*.css,*.html,*.rs,*.ts
        \ :call <SID>StripTrailingWhitespaces()
  autocmd BufRead * call SetWorkingDirectoryGit()
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

"Adapted from <http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/>

" If in a Git repo, sets the working directory to its root,
" or if not, to the directory of the current file.
function! SetWorkingDirectoryGit()
  " Default to the current file's directory (resolving symlinks.)
  let current_file = expand('%:p')
  if getftype(current_file) == 'link'
    let current_file = resolve(current_file)
  endif
  exe ':lcd' . fnamemodify(current_file, ':h')

  " Get the path to `.git` if we're inside a Git repo.
  " Works both when inside a worktree, or inside an internal `.git` folder.
  :silent let git_dir = system('git rev-parse --git-dir')[:-2]
  " Check whether the command output starts with 'fatal'; if it does, we're not inside a Git repo.
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " If we're inside a Git repo, change the working directory to its root.
  if empty(is_not_git_dir)
    " Expand path -> Remove trailing slash -> Remove trailing `.git`.
    exe ':lcd' . fnamemodify(git_dir, ':p:h:h')
  endif
endfunction

" }}}

