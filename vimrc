execute pathogen#infect()

set nocompatible
set backspace=2

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
"set showbreak=⇇
set relativenumber
au BufRead,BufNewFile *.thor set filetype=ruby
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

"let g:ctrlp_custom_ignore = '/home/marko/'
let g:ctrlp_root_markers = ['.ruby-version', 'GEMFILE', 'project.clj']

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
nnoremap b w 
nnoremap B W
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
nnoremap <Leader>y "+y
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

" Should this go in clojure.vim?
function! TestToplevel() abort  
    "Eval the toplevel clojure form (a deftest) and then test-var the result."
    normal! ^
    let line1 = searchpair('(','',')', 'bcrn', g:fireplace#skip)
    let line2 = searchpair('(','',')', 'rn', g:fireplace#skip)
    let expr = join(getline(line1, line2), "\n")
    let var = fireplace#session_eval(expr)
    let result = fireplace#echo_session_eval("(clojure.test/test-var " . var . ")")
    return result
endfunction  

au Filetype clojure nmap <Leader>t :call TestToplevel()<CR> 
au Filetype clojure nmap <Leader>T :RunTests<CR> 
au Filetype clojure let g:sexp_mappings = {
  \ 'sexp_round_head_wrap_list':    '<Leader>I',
  \ 'sexp_round_head_wrap_element': '<Leader>i'
  \ }
au Filetype clojure nmap <Leader>cf F(i#_<Esc> " FIXME
