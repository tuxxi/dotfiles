" add all plugins
so ~/.vim/plugins.vim
" set up COC settings
so ~/.vim/coc-settings.vim
" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
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
let g:airline_section_warning = ''
let g:airline_theme = 'base16_spacemacs'
 " don't show mode below airline
set noshowmode     

let g:pandoc#syntax#conceal#use = 0
let g:md_pdf_viewer="zathura"

" autogroups
augroup pandoc_syntax
  au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" spellcheck
augroup spellcheck
  au BufNewFile,BufFilePre,BufRead *md setlocal spell spelllang=en_us
  au FileType gitcommit setlocal spell spelllang=en_us
augroup END

" FZF settings
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(10)
  let width = float2nr(90)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  call fzf#vim#grep(initial_command, a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" replace W with w, i never want to use W
command! W w

nnoremap <S-h> :call ToggleHiddenAll()<CR>
" Leader settings
let mapleader=' '
nmap <silent> <leader>o :NERDTreeToggle<CR>
" delete current buffer
nmap <silent> <leader>d :bd<CR>

" fzf binds
nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>p :call fzf#vim#gitfiles('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>; :Buffers<CR>
nnoremap <silent> <leader>/ :RG<CR>

" Other binds
nnoremap <silent> <esc><esc> :noh<return>
nnoremap <silent> <F5> :UndotreeToggle<return>
" map shift-tab to unindent in insert mode
nnoremap <S-Tab> <C-d>

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
