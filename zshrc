zle_highlight=('paste:none')

setopt nonomatch

alias c='cargo'

zstyle ':completion:*' use-cache on

autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{blue}%r%f %F{cyan}%b%f %F{yellow}%S%f'
zstyle ':vcs_info:git:*' actionformats '%F{blue}%r%f %F{cyan}%b%f %F{magenta}%a%f %F{yellow}%S%f'

setopt PROMPT_SUBST
PROMPT='${vcs_info_msg_0_:-"%F{blue}%~%f"}$ '
