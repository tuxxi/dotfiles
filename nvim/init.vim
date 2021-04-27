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
set cursorline

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

set shell=/usr/bin/fish

"neovim only
if has('nvim') 
  set inccommand=nosplit
endif 

" statusline
let g:lightline = {
	\ 'colorscheme': 'deus',
	\ }
" don't show mode below statusline
set noshowmode     

let g:pandoc#syntax#conceal#use = 0

" spellcheck
augroup spellcheck
  au! FileType gitcommit setlocal spell spelllang=en_us
  au! FileType pandoc setlocal spell spelllang=en_us
  au! FileType markdown setlocal spell spelllang=en_us
  au! FileType tex setlocal spell spelllang=en_us
augroup END

" RainbowParentheses in Lisps
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END
" List of colors that you do not want. ANSI code or #RRGGBB
let g:rainbow#blacklist = [248]

augroup tab_langs
  au!
  au! FileType go set noexpandtab tabstop=4 shiftwidth=4
augroup END


" FZF settings
" make fzf in a floating window at the top of the screen
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.3, 'yoffset': 0.1 } }
" use Rg to respect gitignore when showing files list
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow -g "!{node_modules,.git}"'
" search content of files, without searching for the filename
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Sometimes I fat-finger :W, want that to be the same as :w
command! W w
" get rid of Q for ex mode. No one wants that ...
nmap Q q
" command for write-make
command! Wm w | Make
cnoreabbrev wm Wm
" Leader settings
let mapleader=' '
let maplocalleader=' '
nnoremap <silent> <leader>o :NERDTreeToggle<CR>
" delete current buffer
nnoremap <silent> <leader>d :bd!<CR>

" fzf binds
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>; :Buffers<CR>
nnoremap <silent> <leader>/ :Rg<CR>

" Other binds
nnoremap <silent> <esc><esc> :noh<return>
nnoremap <silent> <leader>u :UndotreeToggle<return>

" Map alt+move to move lines around
nnoremap <A-Up>   :<C-u>silent! move-2<CR>==
xnoremap <A-Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
nnoremap <A-Down> :<C-u>silent! move+<CR>==
xnoremap <A-Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv

" spellcheck binds
" select and replace first spell suggestion backwards from current cursor
imap <c-f> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap <c-f> [s1z=

" Wayland clipboard provider that strips carriage returns (GTK3 issue).
" This is needed because currently there's an issue where GTK3 applications on
" Wayland contain carriage returns at the end of the lines (this is a root
" issue that needs to be fixed).
" let g:clipboard = {
"       \   'name': 'wayland-strip-carriage',
"       \   'copy': {
"       \      '+': 'wl-copy --foreground --type text/plain',
"       \      '*': 'wl-copy --foreground --type text/plain --primary',
"       \    },
"       \   'paste': {
"       \      '+': {-> systemlist('wl-paste --no-newline | tr -d "\r"')},
"       \      '*': {-> systemlist('wl-paste --no-newline --primary | tr -d "\r"')},
"       \   },
"       \   'cache_enabled': 1,
"       \ }
