if has('vim_starting')
  " Required:
  set runtimepath+=/home/whothey/.config/nvim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/whothey/.config/nvim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'matchit.zip'
NeoBundle 'townk/vim-autoclose'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'w0rp/ale'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'jwalton512/vim-blade'
NeoBundle 'tpope/vim-haml'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Plugins configuration
set hidden
set expandtab
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set ignorecase
set autoindent
set hlsearch " Highlight at each digit
set mouse=a " Enable mouse

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:racer_cmd = '/home/whothey/.cargo/bin/racer'
let g:ycm_rust_src_path = '/home/whothey/Repositories/rust/src'
let g:ale_rust_cargo_use_check = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:airline_powerline_fonts = 1
let g:racer_experimental_completer = 1

" Themes
" Tomorrow, Tomorrow-Night, Revolution
colorscheme Tomorrow

set number

" Preferences

" My Remaps
let mapleader="\<SPACE>"

" Spacemacs-like M-Backspace
inoremap <M-BS> <ESC>ldbi

" New line + indent after { [ and (
" imap {<CR> {<CR><ESC>O<TAB>}

" Remmaping Plugs
" ALE <Leader> e: Errors
nmap <Leader>en <Plug>(ale_next)
nmap <Leader>ep <Plug>(ale_previous)
nmap <Leader>et <Plug>(ale_toggle)
nmap <Leader>ed <Plug>(ale_details)

" Tabs
nnoremap th  :tabfirst<CR>
nnoremap tp  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

