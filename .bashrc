# Custom

# Codes to color our prompt
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
     PURPLE="\[\033[1;35m\]"
       CYAN="\[\033[1;36m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

# Determine active Python virtualenv details.
function set_virtualenv() {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE}"
    fi
}

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

# Set the full bash prompt
function set_bash_prompt () {
    # Set the PYTHON_VIRTUALENV variable.
    set_virtualenv

    PS1="${debian_chroot:+($debian_chroot)}${CYAN}\u ${LIGHT_GRAY}\w ${PYTHON_VIRTUALENV} ${LIGHT_GREEN}$(git_branch)${COLOR_NONE}\n → "
}

# Execute this function before displaying prompt
PROMPT_COMMAND=set_bash_prompt
