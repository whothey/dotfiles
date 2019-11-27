let mapleader=' '

let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2
let g:indent_guides_size = 0.25

let g:UltiSnipsExpandTrigger="<M-CR>"
let g:UltiSnipsJumpForwardTrigger="<M-N>"
let g:UltiSnipsJumpBackwardTrigger="<M-B>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "privatesnippets"]

let g:airline_powerline_fonts=1
let g:airline_theme='dracula'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled = 1

let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1

let g:self#enable_php_plugins = $VIM_ENABLE_PHP_PLUGINS
let g:self#enable_erlang_plugins = $VIM_ENABLE_ERLANG_PLUGINS

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
set wildignore+="*.o,*.a,node_modules,dist"
set guifont="Fira Mono for Powerline:h14"

set list
set listchars=tab:»\ ,trail:·

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'

Plug 'flazz/vim-colorschemes'
Plug 'szorfein/fromthehell.vim'
Plug 'cseelus/vim-colors-tone'
Plug 'chriskempson/base16-vim'

Plug 'elixir-lang/vim-elixir'

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
Plug 'pbrisbin/vim-mkdir'

Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

if self#enable_php_plugins
  Plug 'phpactor/phpactor',  {'do': 'composer install', 'for': 'php'}
  Plug 'phpactor/ncm2-phpactor'
  Plug 'jwalton512/vim-blade'
  Plug 'posva/vim-vue'
endif

" Completer
" This first is the dependency
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

" Completer Plugins
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-ultisnips'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ncm2/ncm2-vim-lsp'
Plug 'ryanolsonx/vim-lsp-javascript'

if exists("gnvim")
  Plug 'vhakulinen/gnvim-lsp'
endif

" Syntax
Plug 'rust-lang/rust.vim'
Plug 'slashmili/alchemist.vim'

" Erlang
if self#enable_erlang_plugins
  Plug 'vim-erlang/vim-erlang-omnicomplete'
  Plug 'vim-erlang/vim-erlang-runtime'
  Plug 'vim-erlang/vim-erlang-tags'
  Plug 'vim-erlang/vim-erlang-compiler'
  Plug 'edkolev/erlang-motions.vim'
  Plug 'vim-erlang/vim-erlang-skeletons'
  Plug 'vim-erlang/vim-dialyzer'
endif

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

inoremap <c-c> <ESC>

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0]  }, <bang>0)


set completeopt=noinsert,menuone,noselect
set shortmess+=c

let g:NERDTreeShowHidden=1
let g:NERDTreeRespectWildIgnore=1

augroup NERDOpen
  au!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

" Enable NCM2
autocmd TextChangedI * call ncm2#auto_trigger()
autocmd BufEnter * call ncm2#enable_for_buffer()

" Or map each action separately
nnoremap <silent> gd :LspDeclaration<CR>
nnoremap <silent> gdd :LspDefinition<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

let g:ale_linters = {
      \ 'rust': ['rls'],
      \ 'php': 'php -l'
      \ }

let g:ale_fixers = {
      \ 'javascript': ['eslint', 'importjs'],
      \ 'rust': ['rustfmt'],
      \ 'php': ['php_cs_fixer']
      \ }

" ALE Lint
nmap <leader>ef <Plug>(ale_fix)
nmap <leader>en <Plug>(ale_next_wrap)
nmap <leader>ep <Plug>(ale_previous_wrap)
nmap <leader>el <Plug>(ale_detail)

let g:ale_pattern_options = {
      \ '.*\.[eh]rl$': { 'ale_enabled': 0 }
      \ }

"" Project
" Project terminal
nmap <leader>p' <C-w>s<C-w>j<C-w>-<C-w>- :terminal<CR>A
" Test
" nmap <leader>pT :tabnew<CR>:terminal<CR>Anpm test && exit<CR><C-\><C-n>:tabprev<CR>

nmap <leader>pT :!urxvtc -title "Test on $(basename $PWD) from nvim" -e zsh -ic "npm test \|\| (echo 'Press [Enter] to close...' && read -n 1)"<CR><CR>

nmap <leader>vc :tabedit $MYVIMRC<CR>

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F4> :LspHover<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F6> :LspRename<CR>
noremap <silent> <F7> :LspCodeAction<CR>
nnoremap <F8> :LspDocumentSymbol<CR>
nnoremap <F9> :LspWorkspaceSymbol<CR>
nnoremap <F10> <Plug>(ale_fix)

" Buffer fuzzy finder
nmap <leader>bf :Buffers<CR>
" File fuzzy finder
nmap <leader>pf :GFiles --exclude-standard --recurse-submodules --cached<CR>
nmap <leader>pF <leader>pf<C-\><C-n>pA
nmap <leader>ff :FZF<CR>
nmap <leader>ft :NERDTreeFind<CR>
nmap <leader>pg :GGrep<CR>
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
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprev<CR>

"Terminal
nmap <leader>Tn :tabnew<CR>:terminal<CR>A

" Search
nmap <M-/> /\<\><left><left>
nmap ;/ :nohlsearch<CR>

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

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" AutoCmds
augroup js_configfiles
" au! Remove all autocommands
  au!
  autocmd BufNewFile,BufRead *.babelrc set syntax=json
  autocmd BufNewFile,BufRead *.eslintrc set syntax=json
  autocmd BufNewFile,BufRead *.postcssrc set syntax=json
augroup END

function! MyLightTheme()
  colorscheme base16-atelier-plateau-light
  AirlineTheme base16_3024
endfunction

function! MyDarkTheme()
  colorscheme dracula
  AirlineTheme dracula
endfunction
