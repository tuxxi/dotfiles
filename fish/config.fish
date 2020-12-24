export EDITOR=nvim
export VISUAL=$EDITOR

# emacs ansi-term support
if test -n "$EMACS"
  set -x TERM eterm-color
end

# this function may be required
function fish_title
  true
end

alias fd fdfind
