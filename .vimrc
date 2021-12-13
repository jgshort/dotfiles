execute pathogen#infect()

set nocompatible

set rtp+=/opt/homebrew/bin/fzf

set fileencoding=utf8
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set path+=**
set wildmenu
set wildmode=longest:full,full
set wildignore+=**/node_modules/**
set foldmethod=marker

set t_Co=256
syntax on
filetype plugin indent on

syntax enable
set background=dark
colorscheme dracula

ino jj <esc>
cno jj <c-c>

set autoindent
set smartindent
set ignorecase
set smartcase

set spell
set title

set expandtab
set tabstop=2
set shiftwidth=2

set relativenumber
set number
set showmatch

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

set confirm
set mouse=a
set scrolloff=8
set sidescrolloff=8

set dir=~/.vimtmp
set backup
set backupdir=~/.vimtmp/backup

set list
set listchars=tab:▸\ ,trail:·

command! MakeTags !/opt/homebrew/bin/ctags --exclude=.git --exclude=node_modules -R .

let mapleader = "\<space>"

nmap <Leader>ve :edit ~/.vimrc<cr>

nnoremap <Leader>nt :NERDTree<cr>
nnoremap <Leader>ntf :NERDTreeFocus<cr>
nnoremap <Leader>ntt :NERDTreeToggle<cr>
nnoremap <Leader>ntF :NERDTreeFind<cr>

vnoremap < <gv
vnoremap > >gv

nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

function! LF()
    let temp = tempname()
    exec 'silent !lf -selection-path=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        return
    endif
    exec 'edit ' . fnameescape(names[0])
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar LF call LF()

autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

let g:ackprg = 'rg --vimgrep --smart-case --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1
cnoreabbrev Ack Ack!
nnoremap <Leader>/ :Ack!<Space>

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>