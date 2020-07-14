"" My Neovim settings.
"" I am not an export and just trying to set it up unplugged.
"" I am both new and old to Vim but started learning it for real in 202.
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
"" No <CONTROL><W> needed, Just <Control> hjkl will do.
""
if has('nvim')
  " Normal mode:
  nnoremap <C-h> <c-w>h
  nnoremap <C-j> <c-w>j
  nnoremap <C-k> <c-w>k
  nnoremap <C-l> <c-w>l
endif

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
"" Open new tab with Shift T.
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
"" No longer do /zz or search anything else that does not exist to get rid of
"" the highlighting.
""
nnoremap <silent> <leader>/ :noh<cr>

""
"" Set scrollofset to 5
"" This makes zt/zb not go all the way to top or bottom but 5 lines from it.
""
set scrolloff=5

""
"" Search mappings: These will make it so that going to the next one in a
"" search will center on the line it's found in.
""
nnoremap n nzzzv
nnoremap N Nzzzv

""
"" Abbreviations for common casing mistakes.
""
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

augroup highlightYankedText
    autocmd!
    autocmd TextYankPost * call FlashYankedText(deepcopy(v:event))
augroup END

function! s:DeleteTemporaryMatch(timerId)
    while !empty(s:yankedTextMatches)
        let match = remove(s:yankedTextMatches, 0)
        let windowID = match[0]
        let matchID = match[1]

        try
            call matchdelete(matchID)
        endtry
    endwhile
endfunction

function! FlashYankedText(event)
    " Don't highlight if the last command was not a yank
    if (a:event.operator != 'y')
        return
    endif

    if (!exists('s:yankedTextMatches'))
        let s:yankedTextMatches = []
    endif

    let window = winnr()

    " Handle case of visual block using one match by line
    if (len(a:event.regtype) > 0 && a:event.regtype[0] == "\<C-V>")
        let lineStart = line("'<")
        let lineStop = line("'>")
        let columnStart = col("'<")
        let columnStop = col("'>")

        " For each line in the block selection create aattern using the first
        " and last column
        "         " Theattern looks like this:
        "   \%Xl\%Yc.*\%Zc
        " Where X is the line, Y the first column and Z the last column
        for line in range(lineStart, lineStop)
            let matchId = matchadd(get(g:, 'FYT_highlight_group', 'IncSearch'), "\\%" . line . "l\\%" . columnStart . "c.*\\%" . columnStop . "c")
            call add(s:yankedTextMatches, [window, matchId])
        endfor
    else " Other visual types
        let matchId = matchadd(get(g:, 'FYT_highlight_group', 'IncSearch'), ".\\%>'\\[\\_.*\\%<']..")
        call add(s:yankedTextMatches, [window,matchId])
    endif

    call timer_start(get(g:, 'FYT_flash_time', 500), function('<SID>DeleteTemporaryMatch'))
endfunction

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <silent> <A-t> :call TermToggle(12)<CR>
inoremap <silent> <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <silent> <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>
