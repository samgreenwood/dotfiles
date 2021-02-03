syntax on
filetype off

"Vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-vinegar'
Plugin 'elixir-lang/vim-elixir'
Plugin 'jwalton512/vim-blade'
Plugin 'fatih/vim-go'
Plugin 'StanAngeloff/php.vim'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ervandew/supertab'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'posva/vim-vue'
Plugin 'mattn/emmet-vim'
Plugin 'lumiliet/vim-twig'
Plugin 'scrooloose/nerdcommenter'
Plugin 'adoy/vim-php-refactoring-toolbox'
Bundle 'OmniSharp/omnisharp-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'maxmellon/vim-jsx-pretty'

call vundle#end()

filetype plugin indent on

"
"Some sane defaults
set nocompatible   " Disable vi-compatibility
set t_Co=256
set background=dark
colorscheme atom-dark-256
set linespace=15
set noswapfile
set nobackup
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set smarttab
set tags=tags
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set visualbell           " don't beep
set noerrorbells         " don't beep
set autowrite "Save on buffer switch
set mouse=a
set complete=.,w,b,u
set autoread
set nobackup

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saves
nmap <leader>w :w!<cr>

"Fast exits
nmap <leader>q :q!<cr>

" Down is really the next line
nnoremap j gj
nnoremap k gk

"Easy escaping to normal model
imap jj <esc>

"Auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

"phpunit
nmap <Leader>t :!vendor/bin/phpunit --debug --colors --stop-on-error --stop-on-failure --coverage-html web/coverage<cr>
nmap <Leader>r :!vendor/bin/phpunit --debug --colors --stop-on-error --stop-on-failure %:p<cr>

"easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

"Resize vsplit
nmap <C-v> :vertical resize +5<cr>
nmap 25 :vertical resize 40<cr>
nmap 50 <c-w>=
nmap 75 :vertical resize 120<cr>

"Load the current buffer in Chrome
nmap ,c :!open -a Google\ Chrome<cr>

"Show (partial) command in the status line
set showcmd

"Airline
:set laststatus=2

"CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <D-p> :CtrlP<cr>
nmap <D-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>

"pdv
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <C-d> :call pdv#DocumentWithSnip()<CR>

" Fast file reindentation
map <F7> mzgg=G`z<CR>

" Regenerate ctags
nnoremap <F8> :!ctags -R --PHP-kinds=cfi --exclude==.git--exclude=node_modules --exclude=public<CR>

"Airline
let g:airline#extensions#tabline#enabled = 1

"NerdTREE
nmap <C-n> :NERDTreeToggle<cr>
let NERDTreeHijackNetrw = 0

nmap <leader>f :tag<space>

"Autoload .vimrc
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END


"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"PHPInsertUse
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

autocmd BufWritePost *.php :silent exec "!php-cs-fixer fix %:p > /dev/null 2>&1"
