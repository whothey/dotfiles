let mapleader=' '

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2
let g:indent_guides_size = 0.25

let g:UltiSnipsExpandTrigger="<M-CR>"
let g:UltiSnipsJumpForwardTrigger="<M-N>"
let g:UltiSnipsJumpBackwardTrigger="<M-B>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "privatesnippets"]

let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'javascript,typescript,jsx': ['.', '/', "re!\w\w+", "re![{('\"}]\s*", 're!import\s*', '<', 're!\<\w+\s*'],
  \   'cs,d,elixir,go,groovy,java,julia,perl6,python,scala,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

let g:ycm_auto_trigger = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:airline_powerline_fonts=1
let g:airline_theme='dracula'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled = 1

let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1

set mouse=a
set mousemodel=popup
set shell=zsh
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set number
set colorcolumn=100
set showmatch
set incsearch
set ignorecase
set smartcase
set autoread
set wildignore+="*.o,*.a,node_modules/*,dist"

set list
set listchars=tab:»\ ,trail:·

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'flazz/vim-colorschemes'
Plug 'szorfein/fromthehell.vim'
Plug 'cseelus/vim-colors-tone'
Plug 'chriskempson/base16-vim'

Plug 'junegunn/fzf'
Plug 'shougo/denite.nvim'
Plug 'easymotion/vim-easymotion'

Plug 'majutsushi/tagbar'

Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'valloric/youcompleteme', { 'do': 'python3 install.py --rust-completer --clang-completer --ts-completer' }

Plug 'phpactor/phpactor',  {'do': 'composer install', 'for': 'php'}
Plug 'phpactor/ncm2-phpactor'
Plug 'jwalton512/vim-blade'
Plug 'posva/vim-vue'

" Completer
" This first is the dependency
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

" Completer Plugins
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-ultisnips'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Syntax
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim'

" JS/JSX
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'rhysd/npm-debug-log.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown'

Plug 'cdata/vim-tagged-template'

Plug 'mattn/emmet-vim'

Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'cakebaker/scss-syntax.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-scripts/matchit.zip'
Plug 'raimondi/delimitmate'

Plug 'kana/vim-textobj-user'

call plug#end()

let g:LanguageClient_serverCommands = {
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'php': ['phpactor']
      \ }

set completeopt=noinsert,menuone,noselect

augroup NERDOpen
  au!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

" Enable NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> Ç :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

let g:ale_linters = {
      \ 'rust': ['rls'],
      \ 'php': 'php -l'
      \ }

let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'rust': ['rustfmt'],
      \ 'php': ['php_cs_fixer']
      \ }

" ALE Lint
nmap <leader>ef <Plug>(ale_fix)
nmap <leader>en <Plug>(ale_next_wrap)
nmap <leader>ep <Plug>(ale_previous_wrap)
nmap <leader>el <Plug>(ale_detail)

call denite#custom#var('file/rec',
      \ 'command',
      \ ['git', 'ls-files', '--cached', '--others', '--exclude-standard'])

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

"" Project
" Project terminal
nmap <leader>p' <C-w>s<C-w>j<C-w>-<C-w>- :terminal<CR>A
" Test
" nmap <leader>pT :tabnew<CR>:terminal<CR>Anpm test && exit<CR><C-\><C-n>:tabprev<CR>

nmap <leader>pT :!urxvtc -title "Test on $(basename $PWD) from nvim" -e zsh -ic "npm test \|\| (echo 'Press [Enter] to close...' && read -n 1)"<CR><CR>

nmap <leader>vc :tabedit $MYVIMRC<CR>

nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>

" Buffer fuzzy finder
nmap <leader>bf :Denite buffer<CR>
" File fuzzy finder
nmap <leader>pf :Denite file/rec<CR>
nmap <leader>ff :NERDTreeFind<CR>
" Git
nmap <leader>gs :Gstatus<CR>

" Buffer
nmap <leader>bd :bd<CR>
nmap <leader>bp :bd<CR>
nmap <leader>bt :TagbarToggle<CR>
nmap <leader>bn :bnext<CR>
nmap <leader>bp :bprevious<CR>

"Tabs
nmap <leader>tn :tabnext<CR>
nmap <leader>tN :tabnew<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>te :tabedit

"Terminal
nmap <leader>Tn :tabnew<CR>:terminal<CR>A

" Search
nmap <M-/> /\<\><left><left>

" Move lines
vmap <M-k> :'<,'>m-2<CR>
vmap <M-j> :'<,'>m+1<CR>
nmap <M-k> :m-2<CR>
nmap <M-j> :m+1<CR>
imap <M-k> <ESC>:m-2<CR>i
imap <M-j> <ESC>:m+1<CR>i

" Helper bindings
imap <M-L> <ESC>L
imap <M-H> <ESC>H

" Emu shell meta-backspace
imap <M-BS> <ESC>dBxa

" Paste fix on GUI editors
imap <S-Insert> <C-R>*

" Map C-Esc to enter on nomal mode
tnoremap <C-Esc> <C-\><C-n>

cnoreabbrev gs Gstatus

" colorscheme molokai_dark
" colorscheme fromthehell

" Purple Theme
colorscheme dracula

" White Theme
"colorscheme sol
"AirlineTheme base16_ashes

" Better CSS Config
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

highlight VendorPrefix guifg=#00ffff gui=bold
match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

" AutoCmds
augroup js_configfiles
" au! Remove all autocommands
  au!
  autocmd BufNewFile,BufRead *.babelrc set syntax=json
  autocmd BufNewFile,BufRead *.eslintrc set syntax=json
  autocmd BufNewFile,BufRead *.postcssrc set syntax=json
augroup END

function MyLightTheme()
  colorscheme base16-atelier-plateau-light
  AirlineTheme base16_3024
endfunction

function MyDarkTheme()
  colorscheme dracula
  AirlineTheme dracula
endfunction

" function NERDTreeFindOrToggle()
  " Current NERDTree Buffer t:NERDTreeBufferName
  " Check if it is Open: g:NERDTree.IsOpen()

  " if (g:NERDTree.IsOpen())
  "   NERDTreeClose
  " else
" endfunction
