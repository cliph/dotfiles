# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
export HISTSIZE=1000000

if [ ${BASH_VERSINFO} -ge 4 ];
then
   shopt -s autocd
fi

shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-*color) color_prompt=yes;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	   color_prompt=yes
   else
	   color_prompt=
   fi
fi

if [ "$color_prompt" = yes ]; then
   dot="•"
   bul="\342\200\242"
   tblue=$(tput setaf 33)
   tdarkgrey=$(tput setaf 248)
   tgreybg=$(tput setab 236)
   tgreen=$(tput setaf 46)
   tgrey=$(tput setaf 240)
   tred=$(tput setaf 160)
   tyellow=$(tput setaf 226)
   tpurple=$(tput setaf 200)
   treset=$(tput sgr0)
   # tdot=$(tput sc; echo $dot; tput rc)
   tdot=$(tput sc; echo -n "\ \ "; tput rc; echo $dot)
   # tdot=$(echo $dot)
    blue="33"
    darkgrey="248"
    greybg="236"
    green="46"
    grey="240"
    red="160"
    yellow="226"
    purple="200"
    if [ `whoami` = "root" ]; then
       user_colour=$tpurple
    else
       user_colour=$tblue
    fi

# function _dot {
#    tedot="\[`tput sc`\]  \[`tput rc`\]\[$dot\] "
#    echo $tdot
# }
# 
# tdot=$(_dot)

function _clr {
    echo "\\[\\e[0m\\]"
    # tput sgr0
}

function _fg {
   # echo "\\[\\033[38;5;"$1"m\\]"
   tput setaf $1
}

function _bg {
   echo "\\[\\033[48;5;"$1"m\\]"
   # tput setab $1
}

function _jobs {
   jjs=`jobs | wc -l | awk '{print \$1}'`
   if [ $jjs = 0 ]; then
      echo $tdot
   else
      echo $jjs
   fi
}

function _lastcmd {
   ret=$?
   if [ $ret -eq 0 ]; then
      # echo -en "\033[38;5;"$green"m•";
      echo -en $tgreen$tdot;
   elif [ $ret -eq 1 ]; then
      # echo -en "\033[38;5;"$red"m•";
      echo -en $tred$tdot;
   else
      # echo -en "\033[38;5;"$red"m"$ret"";
      # echo -en "$(_fg $red)$ret";
      # echo -en $tred$ret;
      echo -en $tred$tdot;
   fi
}

# PS1="\
# \[$user_colour\]\u\
# \[$tdarkgrey\]@\
# \[$tgreen\]\h\
# \[$tdarkgrey\]:\
# \[$treset\]\[\$(_lastcmd)\]\
# \[$tdarkgrey\]:\
# \[$treset\]\[\$(_jobs)\]\
# \[$tdarkgrey\]:\
# \[$treset\]\w\
# \[$tyellow\]\\$ \[$treset\]"
# Shorter ps1
PS1="\
\[$user_colour\]\u\
\[$tdarkgrey\]@\
\[$tgreen\]\h\
\[$tdarkgrey\]:\
\[$treset\]\w\
\[$tyellow\]\\$ \[$treset\]"
#
# PS1="\
# $(_fg $user_colour)\u\
# $(_fg $darkgrey)@\
# $(_fg $green)\h\
# $(_fg $darkgrey):\
# $(_clr)\$(_lastcmd)\
# $(_fg $darkgrey):\
# $(_clr)\$(_jobs)\
# $(_fg $darkgrey):\
# $(_clr)\w\
# $(_fg $yellow)\\$ $(_clr)"


# $(_clr)\`if [ \$? = 0 ]; 
# then 
#    echo \"\\[\\033[38;5;\"$green\"m\\]•\"; 
# else
#   echo \"\\[\\033[38;5;\"$red\"m\\]•\"; fi\`\

 # https://github.com/adamveld12/laughing-hipster/blob/master/.shell_colors
 # https://github.com/lepistone/dotfiles/blob/master/profile.d/prompt.sh

    # PS1='${debian_chroot:+($debian_chroot)}\[\033[36m\]\u\[\033[01;00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;00m\]\w\[\033[00m\]\[\033[01;33m\]\$\[\033[00m\] '
    # PS1="${debian_chroot:+($debian_chroot)}`XCLR 33`\u`XCLR 248`@`XCLR 46`\h`XCLR 248`:`XCLR 254`\j`XCLR 248`:`XCLR 254`\`if [ \$? = 0 ]; then echo 0; else echo 1; fi\``XCLR 248`:`XCLR 254`\w`XCLR 226`\$`RST` "
    # PS1="${debian_chroot:+($debian_chroot)}`XCLR 33`\u`XCLR 248`@`XCLR 46 236`\h`XCLR 248 0`:`XCLR 254`\j`XCLR 248 0`:`XCLR 254`\`if [ \$? = 0 ]; then XCLR 46 0; echo •; else XCLR 160 0; echo •; fi\``XCLR 248 0`:`XCLR 254 0`\w\[\033[00m\]`XCLR 226`\$\[\033[00m\] "
    # PS1="$(XCLR 33)\u$(XCLR 248)@$(XCLR 46 236)\h$(XCLR 248 0):$(XCLR 254)\j$(XCLR 248 0):$(XCLR 254)\`if [ \$? = 0 ]; then XCLR 46 0; echo •; else XCLR 160 0; echo •; fi\`$(XCLR 248 0):$(XCLR 254 0)\w\[\033[00m\]$(XCLR 226)\$\[\033[00m\] "
    # PS1="\$(XCLR $blue)\u\
# \$(XCLR $darkgrey)@\
# \$(XCLR $green)\h\
# \$(XCLR $darkgrey 0):\
# \w\
# \$(XCLR $yellow)\$ \$(XCLR r)"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac
# 
# if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
#         export TERM=gnome-256color
# elif infocmp xterm-256color >/dev/null 2>&1; then
#         export TERM=xterm-256color
# fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
export PROMPT_COMMAND='history -a'
export EDITOR=vim
