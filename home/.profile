# Aliases
if [ -d ~/Development/transmission-remote-cli/ ]; then
   alias btcli="~/Development/transmission-remote-cli/transmission-remote-cli"
   alias bt="btcli"
fi

# alias vl='vim $(!!)'

hash mosh &> /dev/null
if [ $? -eq 1 ]; then
   alias mu="mosh unixadmin"
   alias mc="mosh cli.ph"
   alias ma="mosh ascii"
   alias mcam="mosh cam"
fi

if [[ "$(hostname)" = *home.cli.ph* ]]; then
   homehosts=(mini tertimi)
   for host in "${homehosts[@]}"
   do
      alias $host="ssh $host.local"
   done
else
   for host in "${homehosts[@]}"
   do
      alias $host="ssh $host"
   done
fi

# alias machine_list="cat ~/.ssh/config | egrep '^Host' | grep -v '\*' | cut -d ' ' -f 2"
# 
# for machine in `machine_list`
# do
#    alias $machine="ssh $machine"
#    alias m$machine="mosh $machine"
# done
  
source $HOME/.homesick/repos/homeshick/homeshick.sh
alias hs="homeshick"
alias cddot="hs cd dotfiles"
homeshick --quiet refresh

alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'

export EDITOR=vim

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
  
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

platform=`uname`

if [ $platform == "Darwin" ]; then
   mvtorrent ()
      {
         # Move files from a given extension from a given location to another given location
         src=~/Downloads
         dst=~/Dropbox/Downloads/torrents/
         ext=torrent
         IFS=$(echo -en "\n\b")
         shopt -s nullglob
         if [ ! -z "`echo $src/*.$ext`" ];
         then
            for file in $src/*.$ext
            do
               echo "Moving `basename "$file"` ..."
               mv "$file" $dst
            done
            echo "Done."
         else
            echo "No ${ext}s in $src."
            return 1
         fi
      }

   stopsocks () 
   {
   pkill -f "ssh -D"
   sudo networksetup -setsocksfirewallproxystate Ethernet off
   }

   startsocks ()
   {
      if [ $# -lt 1 ];
      then
         echo "Usage ${FUNCNAME[0]} <host>"
         return 1
      fi
      stopsocks
      host=$1
      if [ ! -z $2 ]
      then
         port=$2
      else
         port=8080
      fi
      ssh -D $port -f -N $host
      echo -n "Update proxy settings to use $host:$port [Y/n] "
      read answer
      case "$answer" in
         n|N)
            stopsocks
            return 1
            ;;
         y|Y|*)
            sudo networksetup -setsocksfirewallproxy Ethernet localhost $port
            sudo networksetup -setsocksfirewallproxystate Ethernet on
            ;;
            esac
   }

   alias socku="startsocks unixadmin.ca"
   alias sockc="startsocks www.cli.ph"


   export PATH=/opt/local/bin:/opt/local/sbin:$PATH
   
   if [ -d "$HOME/Development/arm-cs-tools/bin" ];
   then
      export PATH=$HOME/Development/arm-cs-tools/bin:$PATH
   fi

   alias ls='ls -GF'
   alias update="sudo port selfupdate && sudo port upgrade outdated"

elif [ $platform == 'Linux' ]; then
   alias ls='ls -GF --color=auto'
   alias upgrade="sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get clean"
fi

if [ -d "$HOME/bin/scripts/clients" ];
then
   for file in `find $HOME/bin/scripts/clients -type f | grep -v .swp`
   do
      source $file
   done
fi


