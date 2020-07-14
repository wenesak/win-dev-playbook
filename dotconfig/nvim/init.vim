"" My Neovim settings

"" Although I am running NeoVIM, I still set nocompatible, so that I more
"" easily can drop this file as vimrc into VIM.
"" This disables compatibility with VI and older behaviour on VIM.
set nocompatible

"" Enable the buildin syntax highlighting
syntax on

"" Set Relative line number, except for the current line. 
"" For the current line, show the absolute line number
set relativenumber
set number

"" Load syntax highlighting, indentation and a filetype specific plugin if
"" available.
filetype indent plugin on

""
"" My custom keybindings
""

"" Disable the arrow keys in normal mode.
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

""
"" Make <SPACE> my leader key
""
let mapleader = " "

""
"" Toggle paste mode on or off.
"" This prevents vim autindenting a paste when pasting existing well formatted
"" text.
""
"" Toggle paste mode from normal mode.
nnoremap <silent> <leader>p :set invpaste paste?<CR>
"" Toggle paste mode from insert mode.
set pastetoggle=<leader>p
"" Show the mode that is currently active.
set showmode

""
"" Function to toggle the status bar on and off with F4.
""
let s:hidden_all = 0
function! ToggleHiddenAll()
  if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
  else
    let s:hidden_all = 0
    set showmode
    set ruler
    set laststatus=2
    set showcmd
  endif
endfunction

nnoremap <silent> <leader>s :call ToggleHiddenAll()<CR>

" Hilight cursorcolumn & cursorline on leader c
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <silent> <Leader>c :set cursorline! cursorcolumn!<CR>

call plug#begin()
call plug#end()
