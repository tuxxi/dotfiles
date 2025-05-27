autocmd BufRead,BufNewFile * if getline(1) =~ '^# A Perforce Change Specification.' | setlocal noexpandtab | endif
