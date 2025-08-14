call plug#begin('~/.vim/plugged')

Plug 'nanotech/jellybeans.vim'

" A pretty statusline, bufferline integration
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'

call plug#end()

syntax on
set background=dark
colorscheme jellybeans
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap

augroup TrimWhitespace
  autocmd!
  autocmd BufWritePre *.c,*.h,*.cpp,*.hpp,*.go,*.py,*.rs,*.txt,*.md,*.rst,*.tsx,*.ts,*.toml :%s/\s\+$//e
augroup END

