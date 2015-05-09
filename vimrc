execute pathogen#infect()

syntax on
filetype plugin on
filetype indent on
set t_Co=256
set background=dark
"let g:solarized_termcolors=256
colo solarized
"hi Normal guibg=NONE ctermbg=NONE
call togglebg#map("<F5>")
set cursorline
set wildmenu
set showcmd
set autoindent
" set ruler
set confirm
"set visualbell
" set mouse=a
set cmdheight=2
set number
set shiftwidth=2
set tabstop=2
set expandtab
set showbreak=⇇
set relativenumber
au BufRead,BufNewFile *.thor set filetype=ruby

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"inoremap ( ()<Esc>i
map! ;; <Esc> " map ;; to Esc
imap ii <Esc> " map ii to Esc
imap kj <Esc> " map ii to Esc
imap jk <Esc> " map ii to Esc
map! <CAPS> <Esc> 
map Y y$
nnoremap w b
nnoremap W B

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"MAPPINGS
let mapleader=" "
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>:qa<CR>
nnoremap <Leader>v :vsplit<CR><C-w>l
"nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <Leader>b :bn<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>l :b#<CR> 
nnoremap <Leader>p "+p<CR>
nnoremap <Leader>y "+yy<CR>
nnoremap <Leader>. @:<CR>
nnoremap <Leader>o o<Esc>k
nnoremap <Leader>O O<Esc>j
nnoremap <Leader>r :RunInInteractiveShell<space>
nnoremap <Leader>a <C-a>
nnoremap <Leader>fb :! fbcmd msg 1<CR>
"Deletes last char of line
nnoremap <Leader>x :s/.$//<CR> 
"Deletes last word of line
nnoremap <Leader>X :s/\w*$//<CR>

"COMMANDS
command! Transparent hi Normal guibg=NONE ctermbg=NONE

