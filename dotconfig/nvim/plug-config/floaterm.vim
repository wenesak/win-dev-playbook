scriptencoding utf-8
" let g:floaterm_wintype='normal'
" let g:floaterm_height=6

let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1



nnoremap <silent><localleader>; :FloatermNew --wintype=popup --height=6<CR>
nnoremap <silent><localleader>f :FloatermNew fzf<CR>
nnoremap <silent><localleader>g :FloatermNew lazygit<CR>
nnoremap <silent><localleader>d :FloatermNew lazydocker<CR>
nnoremap <silent><localleader>n :FloatermNew node<CR>
nnoremap <silent><localleader>N :FloatermNew nnn<CR>
nnoremap <silent><localleader>p :FloatermNew python<CR>
nnoremap <silent><localleader>r :FloatermNew ranger<CR>
nnoremap <silent><localleader>t :FloatermToggle<CR>
nnoremap <silent><localleader>y :FloatermNew htop<CR>
nnoremap <silent><localleader>s :FloatermNew ncdu<CR>

let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=6'        , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 'y' : [':FloatermNew htop'                              , 'htop'],
      \ 's' : [':FloatermNew ncdu'                              , 'ncdu'],
      \ }
