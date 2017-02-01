" PLUGINS
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'tomtom/tlib_vim'
Plug 'ervandew/supertab'
Plug 'myusuf3/numbers.vim'
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'airblade/vim-gitgutter'
Plug 'helino/vim-json'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'thoughtbot/vim-rspec'
"Plug 'tpope/vim-sensible'
Plug 'guns/vim-sexp', { 'for': ['clojure', 'racket'] }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': ['clojure', 'racket'] }
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'kchmck/vim-coffee-script'
Plug 'altercation/vim-colors-solarized'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'https://github.com/elixir-lang/vim-elixir', { 'for': 'elixir' }

call plug#end()

set nocompatible
set backspace=2
set smartcase

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
 set mouse=a
set cmdheight=2
set number
set shiftwidth=2
set tabstop=2
set expandtab
"set showbreak=⇇
set relativenumber
au BufRead,BufNewFile *.thor set filetype=ruby
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

let g:ctrlp_custom_ignore = 'target'
let g:ctrlp_root_markers = ['.ruby-version', 'GEMFILE', 'project.clj']
let g:ctrlp_use_caching=1
let g:ctrlp_clear_cache_on_exit = 0

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"inoremap ( ()<Esc>i
map! ;; <Esc> " map ;; to Esc
imap ii <Esc> " map ii to Esc
imap kj <Esc> " map kj to Esc
imap jk <Esc> " map jk to Esc
" map! <CAPS> <Esc> 
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

" LEADER MAPPINGS
let mapleader=" "
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wa<CR>:qa<CR>
nnoremap <Leader>v :vsplit<CR><C-w>l
"nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <Leader>b :bn<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>N :NERDTreeFind<CR>
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
map <Leader>t :call RunCurrentSpecFile()<CR>

"COMMANDS
command! Transparent hi Normal guibg=NONE ctermbg=NONE
"command  Wc '!wc %'

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

if filereadable(".vim.custom")
    so .vim.custom
endif
