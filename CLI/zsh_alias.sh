alias clear_history='fc -R; fc -p; history -c; print -s "$(fc -ln -1)"; clear'

alias zsh_del_history='fc -p; rm -f ~/.zsh_history; touch ~/.zsh_history; fc -R; clear; printf "\033c"'
