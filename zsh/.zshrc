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

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

autoload compinit && compinit
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# https://github.com/zsh-users/zsh-autosuggestions/issues/512
_zsh_autosuggest_capture_postcompletion() {
  unset 'compstate[list]'
}
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
