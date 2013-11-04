# Aliases
if [ -d ~/Development/transmission-remote-cli/ ]; then
   alias btcli="~/Development/transmission-remote-cli/transmission-remote-cli"
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
  
source ~/.homesick/repos/homeshick/homeshick.sh
alias hs="homeshick"
alias cddot="hs cd dotfiles"
homeshick --quiet refresh

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

   export PATH=/opt/local/bin:/opt/local/sbin:$PATH

   alias ls='ls -GF'

elif [ $platform == 'Linux' ]; then
   alias ls='ls -GF --color=auto'
fi
