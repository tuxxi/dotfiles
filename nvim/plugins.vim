" auto install plug.vim if it doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')

" required
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
" tpope the GOD
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
" nice to have
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'machakann/vim-swap'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'conornewton/vim-pandoc-markdown-preview'  
Plug 'justinmk/vim-sneak'

" aestheic 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" color themes
Plug 'rakr/vim-one'

call plug#end()

filetype plugin indent on
