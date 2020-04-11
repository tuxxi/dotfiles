source /usr/share/zsh-antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
# Other bundles
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle larkery/zsh-histdb

# Tell Antigen that you're done.
antigen apply

# Load the theme
# Shamelessly stolen from here: 
# https://github.com/dikiaap/dotfiles/blob/master/.oh-my-zsh/themes/oxide.zsh-theme
source $HOME/dotfiles/zsh/oxide.zsh-theme

# aliases
alias ls=exa fd=fdfind
alias open=xdg-open

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.cabal/bin

# set up zsh-histdb and compinit
autoload -Uz add-zsh-hook compinit && compinit
add-zsh-hook precmd histdb-update-outcome

export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_STRATEGY=(histdb completion history)
# https://github.com/zsh-users/zsh-autosuggestions/issues/489
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# use histdb completion 
# https://github.com/zsh-users/zsh-autosuggestions/issues/340
_zsh_autosuggest_strategy_histdb() {
  typeset -g suggestion
  suggestion=$(_histdb_query "
		  SELECT commands.argv
		  FROM history
		    LEFT JOIN commands ON history.command_id = commands.rowid
		    LEFT JOIN places ON history.place_id = places.rowid
		  WHERE
		    commands.argv LIKE '$(sql_escape $1)%' AND
		    places.dir = '$(sql_escape $PWD)'
		  GROUP BY commands.argv
		  ORDER BY history.start_time desc
		  LIMIT 1
  ")
}
# https://github.com/zsh-users/zsh-autosuggestions/issues/512
_zsh_autosuggest_capture_postcompletion() {
  unset 'compstate[list]'
}

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

