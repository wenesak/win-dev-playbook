scriptencoding utf-8
"" My Neovim settings.
"" I am not an expert and just trying to set it up unplugged.
"" I am both new and old to Vim but started learning it for real in 2020.
"" I Started with SpaceVIM at first, but it was not fast enough for me.
"" I restarted configuring vim and growing both my dotfiles and vim from
"" scratch.

"" Although I am running NeoVIM, I still set nocompatible, so that I more
"" easily can drop this file as vimrc into VIM.
"" This disables compatibility with VI and older behaviour on VIM.
set nocompatible

set autoindent                                    " Maintain indent of current line.
set backspace=indent,start,eol                    " Allow unrestricted backspacing in insert mode.

if exists('$SUDO_USER')
  set nobackup                                    " Don't create root-owned files.
  set nowritebackup                               " Don't create root-owned files.
else
  set backupdir=~/.local/share/nvim/tmp/backup    " Keep backup files out of the way.
  set backupdir+=.
endif

if has('wildignore')
    set backupskip+=*.re,*.rei                      " Revent bsb's watch mode from getting confused.
endif

if exists('$SUDO_USER')
  set noswapfile                                    " Don't create root-owned files.
else
  set directory=~/.config/share/nvim/tmp/swap//     " Keep swap files out of the way.
  set directory+=.
endif

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                                  " Don't create root-owned files.
  else
    set undodir=~/.config/share/nvim/tmp/undo       " Keep undo files out of the way.
    set undodir+=.
    set undofile                                    " Actually use undo files.
  endif
endif

if has('viminfo') " ie. Vim.
  let s:viminfo='viminfo'
elseif has('shada') " ie. Neovim.
  let s:viminfo='shada'
endif

if exists('s:viminfo')
  if exists('$SUDO_USER')
    " Don't create root-owned files.
    execute 'set ' . s:viminfo . '='
  else
    " Defaults:
    "   Neovim: !,'100,<50,s10,h
    "   Vim:    '100,<50,s10,h
    "
    " - ! save/restore global variables (only all-uppercase variables)
    " - '100 save/restore marks from last 100 files
    " - <50 save/restore 50 lines from each register
    " - s10 max item size 10KB
    " - h do not save/restore 'hlsearch' setting
    "
    " Our overrides:
    " - '0 store marks for 0 files
    " - <0 don't save registers
    " - f0 don't store file marks
    " - n: store in ~/.vim/tmp
    "
    execute 'set ' . s:viminfo . "='0,<0,f0,n~/.local/share/nvim/tmp/" . s:viminfo

    if !empty(glob('~/.local/share/nvim/tmp/' . s:viminfo))
      if !filereadable(expand('~/.local/share/nvim/tmp/' . s:viminfo))
        echoerr 'warning: ~/.local/share/vim/tmp/' . s:viminfo . ' exists but is not readable'
      endif
    endif
  endif
endif

if has('mksession')
  set viewdir=~/.local/share/nvim/tmp/view        " override ~/.vim/view default
  set viewoptions=cursor,folds                    " save/restore just these (with `:{mk,load}view`)
endif

set updatecount=80                                " Update swapfiles every 80 typed chars.
set updatetime=2000                               " CursorHold interval

if has('virtualedit')
  set virtualedit=block                           " Allow cursor to move where there is no text in visual 
                                                  " block mode.
endif

set visualbell t_vb=                              " Stop annoying beeping for non-error errors.
set whichwrap=b,h,l,s,<,>,[,],~                   " Allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line 
                                                  " boundaries.
set wildcharm=<C-z>                               " Substitute for 'wildchar' (<Tab>) in macros.
if has('wildignore')
  set wildignore+=*.o,*.rej                       " Patterns to ignore during file-navigation.
endif
if has('wildmenu')
    set wildmenu                                  " show options as list when switching buffers etc.
endif
set wildmode=longest:full,full                    " Shell-like autocomplete to unambiguousortion.

if exists('&belloff')
  set belloff=all                                 " Never ring a bell.
endif

if has('linebreak')
  set breakindent                                 " Indent wrapped lines to match start.
  if exists('&breakindentopt')
    set breakindentopt=shift:2                    " Emphasize broken lines by indenting them.
  endif
endif

if has('folding')
  if has('window')
    set fillchars=diff:∙                          " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    set fillchars+=fold:·                         " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    set fillchars+=vert:┃                         " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif
  set foldmethod=indent                           " Faster than using syntax.
  set foldlevel=99                                " Start unfolded.
endif
set noshowcmd                                     " do not show commands by default.

"" By default use spaces instead of tabs.
"" Use an indent of 2.
set shiftwidth=2
set tabstop=2
set expandtab                                     " Always use spaces instead of tabs.
set noemoji                                       " Do not assume all emoji are double width.
set diffopt+=foldcolumn:0                         " Don't show fold column in diff view.

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                            " Remove comment leader when joining comment lines.
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists
set guioptions-=T                     " don't show toolbar
set hidden                            " allows you to hide buffers with unsaved changes without beingrompted

if !has('nvim')
  " Sync with corresponding nvim :highlight commands in ~/.vim/plugin/autocmds.vim:
  set highlight+=@:Conceal            " ~/@ at end of window, 'showbreak'
  set highlight+=D:Conceal            " override DiffDelete
  set highlight+=N:FoldColumn         " make current line number stand out a little
  set highlight+=c:LineNr             " blend vertical separators with line numbers
endif

if exists('&inccommand')
  set inccommand=split                " livereview of :s results
endif

set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macrolayback

if has('linebreak')
  set linebreak                       " wrap long lines at characters in 'breakat'
endif

set list                              " show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set modelines=5                       " scan this many lines looking for modeline
set nojoinspaces                      " don't autoinsert two spaces after '.', '?', '!' for join command
set number                            " show line numbers in gutter

if exists('+relativenumber')
  set relativenumber                  " show relative numbers in gutter
endif

"highlight LineNr ctermfg=darkgrey guifg=#bbbbbb

set scrolloff=5                       " start scrolling 3 lines before edge of viewport
set shell=sh                          " shell to use for `!`, `:!`, `system()` etc.
set noshiftround                      " don't always indent by multiple of shiftwidth
set shiftwidth=2                      " spaceser tab (when shifting)
set shortmess+=A                      " ignore annoying swapfile messages
set shortmess+=I                      " no splash screen
set shortmess+=O                      " file-read message overwritesrevious
set shortmess+=T                      " truncate non-file messages in middle
set shortmess+=W                      " don't echo "[w]"/"[written]" when writing
set shortmess+=a                      " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
if has('patch-7.4.314')
  set shortmess+=c                    " completion messages
endif
set shortmess+=o                      " overwrite file-written messages
set shortmess+=t                      " truncate file messages at start

if has('linebreak')
  let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

if has('showcmd')
  set noshowcmd                       " don't show extra info at end of command line
endif

set sidescroll=0                      " sidescroll in jumps because terminals are slow
set sidescrolloff=5                   " same as scrolloff, but for columns
set smarttab                          " <tab>/<BS> indent/dedent in leading whitespace

if v:progname !=# 'vi'
  set softtabstop=-1                  " use 'shiftwidth' for tab/bs at end of line
endif

if has('syntax')
  set spellcapcheck=                  " don't check for capital letters at start of sentence
endif

if has('windows')
  set splitbelow                      " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright                      " open vertical splits to the right of the current window
endif

if exists('&swapsync')
  set swapsync=                       " let OS sync swapfiles lazily
endif
set switchbuf=usetab                  " try to reuse windows/tabs when switching buffers

if has('syntax')
  set synmaxcol=200                   " don't bother syntax highlighting long lines
endif

set tabstop=2                         " spaceser tab

set textwidth=80                      " automatically hard wrap at 80 columns





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

" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>

" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'


" Visual mode mappings.

" Move between windows.
xnoremap <C-h> <C-w>h
xnoremap <C-j> <C-w>j
xnoremap <C-k> <C-w>k
xnoremap <C-l> <C-w>l

" Move VISUAL LINE selection within buffer.
xnoremap <silent> K :call wincent#mappings#visual#move_up()<CR>
xnoremap <silent> J :call wincent#mappings#visual#move_down()<CR>

let mapleader="\<Space>"
let maplocalleader=","


function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function Zap() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

" <Leader>zz -- Zap trailing whitespace in the current buffer.
" "
" "        As this one is somewhat destructive and relatively close to the
" "        oft-used <leader>a mapping, make this one a double key-stroke.
nnoremap <silent> <Leader>zz :call Zap()<CR>

" <LocalLeader>s -- Fix (most) syntax highlightingroblems in current buffer
" " (mnemonic: syntax).
nnoremap <silent> <LocalLeader>s :syntax sync fromstart<CR>

" <LocalLeader>e -- Edit file, starting in same directory as current file.
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

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

" Hilight cursorcolumn & cursorline on localleader c
hi CursorLine   cterm=NONE ctermbg=grey ctermfg=NONE guibg=#3a3a3a guifg=NONE
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
set cursorline
nnoremap <silent> <LocalLeader>c :set cursorcolumn!<CR>

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


if filereadable('/usr/local/bin/python3')
  " Avoid search, speeding up start-up.
  let g:python3_host_prog='/usr/local/bin/python3'
endif

set termguicolors                                 " Use more color
let g:gruvbox_italic=1

set spelllang=en_gb,nl
set spellfile=~/.config/nvim/spell/en.utf-8.add

call plug#begin(stdpath('data'))
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'rhysd/vim-grammarous'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()
let deoplete#enable_at_startup = 1

set background=dark
colorscheme gruvbox
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'gruvbox'

let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }

let g:grammarous#enable_spell_check = 1
let g:grammarous#lang = 'en'
noremap <F2> :NERDTreeToggle<CR>
noremap <leader>f :FZF<CR>

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
