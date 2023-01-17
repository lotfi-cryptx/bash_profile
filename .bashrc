# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE= HISTFILESIZE= # infinite

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='lsd --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='lsd -alF'
alias la='lsd -A'
alias l='lsd -CF'


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Codes to color our prompt
        RED="\[\033[0;31m\]"
      GREEN="\[\033[0;32m\]"
     YELLOW="\[\033[0;33m\]"
       BLUE="\[\033[0;34m\]"
     PURPLE="\[\033[0;35m\]"
       CYAN="\[\033[0;36m\]"
       GRAY="\[\033[0;37m\]"
  
   RED_BOLD="\[\033[1;31m\]"
 GREEN_BOLD="\[\033[1;32m\]"
YELLOW_BOLD="\[\033[1;33m\]"
  BLUE_BOLD="\[\033[1;34m\]"
PURPLE_BOLD="\[\033[1;35m\]"
  CYAN_BOLD="\[\033[1;36m\]"
  GRAY_BOLD="\[\033[1;37m\]"

 COLOR_NONE="\[\e[0m\]"


# Return the prompt symbol to use,
# make it red if first parameter is non-zero
set_prompt_symbol ()
{
    if [ $1 -eq 0 ]
    then
        PROMPT_SYMBOL="${GRAY_BOLD}→${COLOR_NONE}"
    else
        PROMPT_SYMBOL="${RED_BOLD}→${COLOR_NONE}"
    fi
}

# Determine the branch/state information for this git repository.
set_git_branch()
{
    if git status &> /dev/null;
    then
        GIT_BRANCH="${GREEN_BOLD}[$(git branch --show-current)]${COLOR_NONE}"
    else
        GIT_BRANCH=
    fi
}

# Determine active Python virtualenv details.
set_virtualenv ()
{
    if [[ ! -z "${VIRTUAL_ENV}" ]];
    then
        PYTHON_VIRTUALENV="${YELLOW_BOLD}(`basename \"$VIRTUAL_ENV\"`) "
    else
        PYTHON_VIRTUALENV=
    fi
}

# Set the full bash prompt.
set_bash_prompt()
{
    # Set the PROMPT_SYMBOL variable.
    # based on the return value of the previous command.
    # should be first command to not lose return value
    set_prompt_symbol $?

    # Set the GIT_BRANCH variable.
    set_git_branch

    # Set the PYTHON_VIRTUALENV variable.
    set_virtualenv

    # Set the bash prompt variable.
    PS1="\n${PYTHON_VIRTUALENV}${GRAY_BOLD}\t - ${CYAN_BOLD}\u ${GRAY_BOLD}\w"
    PS1="$PS1 ${GIT_BRANCH}\n"
    PS1="$PS1 ${PROMPT_SYMBOL} "

}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt

# Add default scripts folders to PATH
export PATH="$PATH:~/.local/bin:~/scripts"