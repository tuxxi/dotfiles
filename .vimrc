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
colorscheme afterglow
set termguicolors
set background=dark
set number

set clipboard+=unnamedplus
set mouse=a
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set backup backupdir=/home/tuxxi/.vim/backup
if !isdirectory("/home/tuxxi/.vim/undodir")
    call mkdir("/home/tuxxi/.vim/undodir", "", 0700)
endif
set undofile undodir=/home/tuxxi/.vim/undodir

set shell=/usr/bin/zsh

" airline
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
 " don't show mode below airline
set noshowmode     

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
