set nocompatible  " be iMproved, required
filetype off      " required

" ************************************
" In order to set up VundleVim:
"
"   $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" ************************************

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-ruby/vim-ruby'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()          " required

filetype plugin indent on  " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set encoding=utf-8
scriptencoding utf-8

set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,ucs-boms
set fileformats=unix,dos,mac

set ambiwidth=double

language en_US.UTF-8

set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

set nowrapscan
set hlsearch

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" 以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]

set laststatus=2
set showcmd

set cindent
set backspace=indent,eol,start

source $VIMRUNTIME/macros/matchit.vim

set wildmenu

" Search .vimrc and so on in the current directory
set exrc

syntax on
highlight Comment ctermfg=blue guifg=blue

au BufRead,BufNewFile *.scss set filetype=sass

" Map double <Esc> to toggle hlsearch
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" vimdiffの色設定
highlight DiffAdd    ctermfg=white ctermbg=2
highlight DiffChange ctermfg=black ctermbg=3
highlight DiffDelete ctermfg=black ctermbg=6
highlight DiffText   ctermfg=black ctermbg=7

source ~/vimscript/toggle_tab_win.vim

"[EOF]
