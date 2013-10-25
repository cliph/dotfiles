# Aliases
alias btcli="~/Development/transmission-remote-cli/transmission-remote-cli"
alias mu="mosh unixadmin"
alias mc="mosh cli.ph"

# Variables
export EDITOR=vim

# Functions
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
      echo "No torrents in $src."
      return 1
   fi
}

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
  
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# MacPorts Installer addition on 2012-11-23_at_23:17:09: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
export PATH=~/Development/arm-cs-tools/bin:$PATH

