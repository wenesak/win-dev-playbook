"" My Neovim settings.
"" I am not an export and just trying to set it up unplugged.
"" I am both old new and old to Vim but started learning it for real in 202.
"" I Started with SpaceVIM at first, but it was not fast enough for me.
"" I restarted configuring vim and growing both my dotfiles and vim from
"" scratch.

"" Although I am running NeoVIM, I still set nocompatible, so that I more
"" easily can drop this file as vimrc into VIM.
"" This disables compatibility with VI and older behaviour on VIM.
set nocompatible

"" do not show commands by default
set noshowcmd

"" By default use spaces instead of tabs.
"" Use an indent of 2.
set shiftwidth=2
set tabstop=2
set expandtab

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

nnoremap <silent> <F4> :call ToggleHiddenAll()<CR>

" Hilight cursorcolumn & cursorline on leader c
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <silent> <Leader>c :set cursorline! cursorcolumn!<CR>

""
"" Cycle through relativenumber + number, number (only), and no numbering.
""
function! CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!
  endif
endfunction
nnoremap <silent> <Leader>n :call CycleNumbering() <CR>

""
"" Sensible maping for navigating through splits.
"" No <CONTROLL><W> needed, Just <CONTROL> hjkl will do.
""
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""
"" Open horizontal and vertical split with leader h and leader v.
""
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" 
"" Open splits below and right by default
""
set splitbelow
set splitright


""
""Enable mouse support.
"" This allows resizing splits with the mouse, amongst other things.
""
set mouse=a


"" 
"" Tabs. This breaks <CONTROL><I>, I know.
""
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

""
"" Integrate with OS clipboard, if possible.
"" 
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

""
"" Clean highlights with <LEADER>/
""
nnoremap <silent> <leader>/ :noh<cr>
