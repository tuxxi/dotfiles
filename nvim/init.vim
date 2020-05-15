" add all plugins
so ~/.vim/plugins.vim
" set up COC settings
so ~/.vim/coc-settings.vim
" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" ocaml autocomplete provided by opam
so ~/.vim/ocaml.vim

" Visual Settings
colorscheme one
set termguicolors
set background=dark
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif
set number
set incsearch
set gdefault " default to /g on seach-replace

set clipboard+=unnamedplus
set mouse=a
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set backup backupdir=/home/tuxxi/.config/nvim/backup
set undofile undodir=/home/tuxxi/.config/nvim/undodir

set shell=/usr/bin/zsh

"neovim only
if has('nvim') 
  set inccommand=nosplit
endif 

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_spacemacs'
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline_section_z = '%l/%L : %c'
 " don't show mode below airline
set noshowmode     

let g:pandoc#syntax#conceal#use = 0

" autogroups for pandoc syntax
augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" spellcheck
augroup spellcheck
  au! BufNewFile,BufFilePre,BufRead *md setlocal spell spelllang=en_us
  au! FileType gitcommit setlocal spell spelllang=en_us
augroup END

" FZF settings
" make fzf in a floating window at the top of the screen
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.3, 'yoffset': 0.1 } }

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  call fzf#vim#grep(initial_command, a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" replace W with w, i never want to use W
command! W w
" get rid of Q for ex mode. No one wants that ...
nmap Q q

" Leader settings
let mapleader=' '
nnoremap <silent> <leader>o :NERDTreeToggle<CR>
" delete current buffer
nnoremap <silent> <leader>d :bd<CR>

" fzf binds
nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>p :call fzf#vim#gitfiles('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>; :Buffers<CR>
nnoremap <silent> <leader>/ :RG<CR>

" Other binds
nnoremap <silent> <esc><esc> :noh<return>
nnoremap <silent> <leader>u :UndotreeToggle<return>
" map shift-tab to unindent in insert mode
inoremap <S-Tab> <C-d>

" Map alt+move to move lines around
nnoremap <A-Down> :m .+1<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Up> :m '<-2<CR>gv=gv

nnoremap <A-j> :m .+1<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
nnoremap <A-k> :m .-2<CR>==
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-k> :m '<-2<CR>gv=gv
