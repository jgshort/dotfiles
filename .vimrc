execute pathogen#infect()

" Installed bundles:
" dracula    https://github.com/dracula/vim.git
" repeat     https://github.com/tpope/vim-repeat.git
" fugitive   https://github.com/tpope/vim-fugitive.git
" surround   https://github.com/tpope/vim-surround.git
" pathogen   https://github.com/tpope/vim-pathogen.git
" sensible   https://github.com/tpope/vim-sensible.git
" commentary https://github.com/tpope/vim-commentary.git
" fzf        https://github.com/junegunn/fzf.git
" fzf.vim    https://github.com/junegunn/fzf.vim.git
" airline    https://github.com/vim-airline/vim-airline.git
" floaterm   https://github.com/voldikss/vim-floaterm.git
" polyglot   https://github.com/sheerun/vim-polyglot.git
" nerdtree   https://github.com/preservim/nerdtree.git
" ale        https://github.com/dense-analysis/ale.git
" ack        https://github.com/mileszs/ack.vim.git
" coc        https://github.com/neoclide/coc.nvim.git
" lf         https://github.com/ptzz/lf.vim.git
" unimpaired https://github.com/tpope/vim-unimpaired.git

set nocompatible
set re=2
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

" set spell
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

let g:ackprg = 'rg --vimgrep --smart-case --hidden --follow --no-ignore-vcs -g "!{node_modules,.git,dist,build}"'
let g:ack_autoclose = 1
let g:ack_use_cword_for_empty_search = 1
cnoreabbrev Ack Ack!
nnoremap <Leader>/ :Ack!<Space>

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

set wildignore+=*.o,*.obj,*.DS_Store
let NERDTreeRespectWildIgnore=1

let NERDTreeShowHidden=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

