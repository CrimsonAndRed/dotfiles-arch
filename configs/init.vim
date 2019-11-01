set noshowmode


call plug#begin(stdpath('data') . '/plugged')

Plug 'itchyny/lightline.vim'
let g:lightline = {
	\ 'colorscheme': 'one',
	\ }
Plug 'machakann/vim-highlightedyank'
Plug 'dense-analysis/ale'

let g:ale_completion_enabled = 1
let g:ale_linters = {'rust': ['rls']}


Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'


call plug#end()
