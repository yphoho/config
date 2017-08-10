let mapleader = ","

set nocompatible

" set nu
set nobackup
set nowritebackup
set fileformat=unix

" set backspace=2
set backspace=indent,eol,start


set ruler

set expandtab
set tabstop=4
set shiftwidth=4
" set softtabstop=4

set autochdir

" " search no wrap
" set nowrapscan

syntax on

set hlsearch

set autoindent
set smartindent
set cindent

" " File type detection for Tagbar
" filetype on

filetype plugin on
filetype plugin indent on

" set foldmethod=indent

hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


autocmd FileType make set noexpandtab
autocmd FileType javascript set tabstop=2 shiftwidth=2


"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" " strip trailing whitespace before saving

" autocmd BufWritePre *.py :%s/\s\+$//e

fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" see syntastic doc file for detail
if !exists("g:syntastic_mode_map")
    let g:syntastic_mode_map = {}
endif
let g:syntastic_mode_map['mode'] = 'passive'
" let g:syntastic_mode_map['active_filetypes'] = ['c', 'cpp']
" the checker for objc is urgly, so we dissable it even in passive mode
let g:syntastic_mode_map['passive_filetypes'] = ['objc']
"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}


"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" for Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 30
"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}


"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" simple auto complete
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {<CR>}<ESC>O
" inoremap ' ''<left>
" inoremap " ""<left>
"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}


"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{
" add header for new python file
function HeaderPython()
    call setline(1, '#!/usr/bin/env python')
    call append(1, '# -*- coding: utf-8 -*-')
    call append(2, '# yp @ ' . strftime('%Y-%m-%d %T', localtime()))
    call append(3, '')
    call append(4, 'import sys')
    call append(5, '')
    call append(6, '')
    call append(7, "if __name__ == '__main__':")
    normal G
endf

function HeaderShell()
    call setline(1, '#!/bin/sh -x')
    call append(1, 'set -e')
    call append(2, 'set -u')
    call append(3, '')
    normal G
endf

function HeaderC()
    call setline(1, '#include<stdio.h>')
    call append(1, '')
    call append(2, '')
    call append(3, 'int main(int argc, char *argv[]) {')
    call append(4, '')
    call append(5, '    return 0;')
    call append(6, '}')
endf

autocmd bufnewfile *.py call HeaderPython()
autocmd bufnewfile *.sh call HeaderShell()
autocmd bufnewfile *.c call HeaderC()
autocmd bufnewfile *.cc call HeaderC()
autocmd bufnewfile *.cpp call HeaderC()
"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}



"" vim Vundle
"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

"" https://github.com/gmarik/Vundle.vim
"" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"" " The following are examples of different formats supported.
"" " Keep Plugin commands between vundle#begin/end.
"" " plugin on GitHub repo
"" Plugin 'tpope/vim-fugitive'
"" " plugin from http://vim-scripts.org/vim/scripts.html
"" Plugin 'L9'
"" " Git plugin not hosted on GitHub
"" Plugin 'git://git.wincent.com/command-t.git'
"" " git repos on your local machine (i.e. when working on your own plugin)
"" Plugin 'file:///home/gmarik/path/to/plugin'
"" " The sparkup vim script is in a subdirectory of this repo called vim.
"" " Pass the path to set the runtimepath properly.
"" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" " Avoid a name conflict with L9
"" Plugin 'user/L9', {'name': 'newL9'}


"" " YouCompleteMe need Vim 7.3.584+
"" if v:version >= 704
""     Plugin 'Valloric/YouCompleteMe'
""     let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
""     " let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
"" endif

Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'nvie/vim-flake8'
" Plugin 'scrooloose/syntastic'
Plugin 'derekwyatt/vim-scala'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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


"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}




"" vim-flake8
"" {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{

"" https://github.com/nvie/vim-flake8


" autocmd FileType python map <buffer> <F7> :call Flake8()<CR>

" let g:flake8_ignore="E501,W293"
let g:flake8_max_line_length=120

" " To customize the location of your flake8 binary, set g:flake8_cmd:
" let g:flake8_cmd="/opt/strangebin/flake8000"
"
" " To customize the location of quick fix window, set g:flake8_quickfix_location:
" let g:flake8_quickfix_location="topleft"

" autocmd BufWritePost *.py call Flake8()

"" }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
