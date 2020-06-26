export PLASMA_USE_QT_SCALING=1
# export GDK_SCALE=2
# export GDK_DPI_SCALE=0.5 
export EDITOR=nvim
export VISUAL=$EDITOR
export MANPATH=/usr/share/man

# emacs ansi-term support
if test -n "$EMACS"
  set -x TERM eterm-color
end

# this function may be required
function fish_title
  true
end

alias fd fdfind
alias ocaml "rlwrap ocaml"
