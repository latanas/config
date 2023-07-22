syntax on
colorscheme pablo

set laststatus=2
set showmode
set showcmd

if has('gui_running')
    set title
    set guioptions=-t
else
    set notitle
endif

let g:statline_fugitive = 1


set cursorline
set ruler
set number

nnoremap <silent> <leader>n :set number! number?<cr>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | execute 'normal! g`"zvzz' | endif

set expandtab
set tabstop=3
set softtabstop=3
set shiftwidth=3

nnoremap <leader>T :Stab<cr>

if has('gui_running')
    set guifont=Monospace:h14
    set antialias
else
    set background=dark
endif

