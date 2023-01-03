""" Plugins

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " Libraries
    Plug 'nvim-lua/plenary.nvim'

    " Tools
    Plug 'williamboman/mason.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason-lspconfig.nvim'

    " Completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Formatting
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'dhruvasagar/vim-table-mode'

    " Search
    Plug 'tpope/vim-abolish'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'dyng/ctrlsf.vim'

    " File manager
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-renderer-nerdfont.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'lambdalisue/fern-hijack.vim'

    " Status-line and command-line
    Plug 'bluz71/vim-mistfly-statusline'

    " Theme
    Plug 'lambdalisue/nerdfont.vim'
    Plug 'lambdalisue/glyph-palette.vim'
    Plug 'bluz71/vim-moonfly-colors'
    Plug 'bluz71/vim-nightfly-guicolors'
call plug#end()

" Include plugin configurations
source ~/.config/nvim/mason.lua
source ~/.config/nvim/coc.vim
source ~/.config/nvim/table-mode.vim
source ~/.config/nvim/fern.vim
source ~/.config/nvim/fern-renderer-nerdfont.vim
source ~/.config/nvim/glyph-palette.vim

""" Settings

" Theme
set termguicolors
colorscheme moonfly " moonfly, nightfly

set cc=121

" Tab behavior
set expandtab
set smartindent
set tabstop=4
set shiftwidth=4

" Formatting
set nowrap
set linebreak
set breakindent

set list
set listchars=tab:··,extends:›,precedes:‹,nbsp:·
set showbreak=\ \ 

" Comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Clipboard
set clipboard=unnamedplus

" Paste without yanking
vnoremap p "0p
vnoremap P "0P

" Text
set spell spelllang=en_us " en_us, en_gb

" Search
set ignorecase
set smartcase

" Scroll and mouse
set mouse=a

" Cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
set cursorline

" Line numbers
set number
augroup numbertoggle
    autocmd!
    autocmd bufenter,focusgained,insertleave,winenter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Status-line and command-line
set wildmode=longest,list,full

set noshowmode

" Use the semicolon to enter command mode without shift
nnoremap ; :

" Windows
set splitright
set splitbelow

" Files
set nobackup
set nowritebackup

autocmd BufEnter * silent! lcd %:p:h
