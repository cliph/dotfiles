# Aliases
alias btcli="~/Development/transmission-remote-cli/transmission-remote-cli"
alias mu="mosh unixadmin"
alias mc="mosh cli.ph"
alias ma="mosh ascii"
alias mcam="mosh cam"

# alias machine_list="cat ~/.ssh/config | egrep '^Host' | grep -v '\*' | cut -d ' ' -f 2"
# 
# for machine in `machine_list`
# do
#    alias $machine="ssh $machine"
#    alias m$machine="mosh $machine"
# done
   
alias homeshick="source $HOME/.homesick/repos/homeshick/bin/homeshick.sh"
alias hs="homeshick"
homeshick --quiet refresh

# Variables
export EDITOR=vim

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
  
# set PATH so it includes user's private bin if it exists
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

   # MacPorts Installer addition on 2012-11-23_at_23:17:09: adding an appropriate PATH variable for use with MacPorts.
   export PATH=/opt/local/bin:/opt/local/sbin:$PATH
   # Finished adapting your PATH environment variable for use with MacPorts.

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

   alias ls='ls -GF'

elif [ $platform == 'Linux' ]; then
   alias ls='ls -GF --color=auto'
fi

