source /usr/share/zsh-antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle command-not-found
antigen bundle subnixr/minimal

# Load the theme.
antigen theme subnixr/minimal

# Tell Antigen that you're done.
antigen apply

alias ls=exa fd=fdfind

export PATH=$PATH:/home/tuxxi/.local/bin:/home/tuxxi/.cargo/bin:/home/tuxxi/.cabal/bin
