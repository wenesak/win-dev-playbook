scriptencoding utf-8
" auto-install vim-plug
if empty(glob('~/.local/share/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/autoload/plugged')
    " Better Syntax Support
    "Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    "Plug 'jiangmiao/auto-pairs'
    " Theme
    Plug 'morhetz/gruvbox'
    " Bottom bar with Git info and more
    Plug 'vim-airline/vim-airline'
    " Themes for bottom bar, gruvbox compatible theme available
    Plug 'vim-airline/vim-airline-themes'
    " Have the file system follow you around
    Plug 'airblade/vim-rooter'
    Plug 'tpope/vim-fugitive'
    "Plug 'shumphrey/fugitive-gitlab.vim'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-markdown'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    " Highlight f,t,F and T targets.
    Plug 'unblevable/quick-scope'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf'
    Plug 'junegunn/vim-easy-align'
    Plug 'rhysd/vim-grammarous'
    Plug 'voldikss/vim-floaterm'
    Plug 'ryanoasis/vim-devicons'
    Plug 'mhinz/vim-startify'
    " Distraction free writing
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Pressing leader and wait a moment will popup a menu with all the leader keys
    " you forgot
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
call plug#end()
