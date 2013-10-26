# Aliases
alias btcli="~/Development/transmission-remote-cli/transmission-remote-cli"
alias mu="mosh unixadmin"
alias mc="mosh cli.ph"

if [[ "$(hostname)" = *home.cli.ph* ]]; then
   alias mini="ssh mini.local"
   alias tertimi="ssh tertimi.local"
else
   alias mini="ssh mini"
   alias tertimi="ssh tertimi"
fi

alias homeshick="source $HOME/.homesick/repos/homeshick/bin/homeshick.sh"
alias hs="homeshick"
homeshick --quiet refresh

# Variables
export EDITOR=vim

# Functions
if [ "$(uname)" == "Darwin" ]; then
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
   fi

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
  
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ "$(uname)" == "Darwin" ]; then
   # MacPorts Installer addition on 2012-11-23_at_23:17:09: adding an appropriate PATH variable for use with MacPorts.
   export PATH=/opt/local/bin:/opt/local/sbin:$PATH
   # Finished adapting your PATH environment variable for use with MacPorts.
fi
