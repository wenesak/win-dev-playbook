noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>

nnoremap <silent><M-t> :tabnew<CR>
noremap <C-t> :tabnew split<CR>

" Alt \ and Control \ move between tabs
nnoremap <silent><M-\> gt
nnoremap <silent><C-\> gT

let g:buffet_powerline_separators = 1
let g:buffet_show_index = 1
let g:buffet_use_devicons = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"

