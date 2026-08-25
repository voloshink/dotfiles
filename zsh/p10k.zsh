# Powerlevel10k configuration.
# Start with the upstream Pure preset, then keep only useful, fast segments.
source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/config/p10k-pure.zsh"

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  vcs
  newline
  prompt_char
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  command_execution_time
  background_jobs
  virtualenv
  context
  newline
)

# Git status is loaded asynchronously, including in large repositories.
typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

# Keep previous prompts compact after a command runs.
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

# Let `p10k configure` update this file rather than the upstream preset.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ! $+functions[p10k] )) || p10k reload
