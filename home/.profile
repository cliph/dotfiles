# Aliases
# if [ -d ~/Development/transmission-remote-cli/ ]; then
if [ -d ~/Development/tremc/ ]; then
   alias btcli="~/Development/tremc/tremc"
   # alias btcli="~/Development/transmission-remote-cli/transmission-remote-cli"
   # alias bt="btcli"
   alias bt="mvt & btcli && tsq"
fi

if [ -d ~/Development/scripts/teksavvy/ ]; then
   # alias tsq="~/Development/scripts/teksavvy/quota.py"
   tsqcache=~/.teksavvy-quota
   function tsq {
      if [ -f $tsqcache ]
      then
         cat $tsqcache
      else
         # ~/Development/scripts/teksavvy/quota.py -dup > $tsqcache && tsq
         ~/Development/scripts/teksavvy/nightly-tsq.sh && tsq
      fi
   }
   alias tsb=~/Development/scripts/teksavvy/tsq-bar.sh
fi

if [ -d ~/Development/scripts/gmail-check/ ]; then
   alias gm="~/Development/scripts/gmail-check/gmcheck.py"
fi

if [ -d ~/bin/toggleres.app/ ]; then
   alias toggleres="open ~/bin/toggleres.app"
fi



if [ -d ~/Development/weather/ ]; then
   # alias weather="pushd `pwd` > /dev/null && cd ~/Development/weather/ && ./weather -m cytz; popd > /dev/null"
   wd="~/Development/weather/"
   alias weather="$wd/weather --setpath=$wd -m cytz"
   unset wd
fi

if [ -x ~/Development/scripts/rustplayers ]; then
   alias wr="watch -c -d -n300 'rustplayers'"
fi


# alias vl='vim $(!!)'

# hash mosh &> /dev/null
# which mosh &> /dev/null
# if [ $? -eq 0 ]; then
alias mu="mosh unixadmin"
alias mc="mosh cli.ph"
alias ma="mosh ascii"
alias mcdn="mosh unixadmin mosh ec2-52-192-238-158.ap-northeast-1.compute.amazonaws.com"
# alias mcam="mosh cam"
# alias hammer="ssh hammer"

# alias agent="eval `ssh-agent`\
#  sleep 5 && ssh-add"

alias whatismyip="wget http://ipinfo.io/ip -qO -"
alias root="sudo -Es bash -l"


if [ -d "$HOME/Development/"turtlecoin-v0.7.0 ] ; then
   alias wallet="./Development/turtlecoin-v0.7.0/zedwallet --remote-daemon mini:11898 --wallet-file ~/iCloud/Documents/Finance/Crypto/TRTL01.wallet"
fi

if [[ "$(hostname)" = *home.cli.ph* ]]; then
   homehosts=(mini tertimi dubh pi)
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

for host in `grep "Host " ~/.ssh/config | egrep -v '\*|\#|\?' | cut -f2 -d' '`
   do
      alias $host="ssh $host"
      alias m$host="mosh $host"
   done

hash pwgen &> /dev/null
if [ $? -eq 1 ]; then
   alias genpw="pwgen -cnyB1 10"
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh
alias hs="homeshick"
alias cddot="hs cd dotfiles"
homeshick --quiet refresh 30

alias grep='grep --color=always'
alias more='less'
alias less='less -R --RAW-CONTROL-CHARS'
alias ll="ls -lathr"
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias +='pushd'
alias -- -='popd'
alias ?='dirs -v'

alias reload='hs pull; clear; sleep 2; source ~/.bash_profile'

# if [ -n "$BASH_VERSION" ]; then
#     if [ -f "$HOME/.bashrc" ]; then
#         . "$HOME/.bashrc"
#     fi
# fi
 
if [ -d "$HOME/Development/scripts" ] ; then
    PATH="$HOME/Development/scripts:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

platform=`uname`

if [ $platform == "Darwin" ]; then
   mvt ()
      {
         # Move files from a given extension from a given location to another given location
         base=~/
         srcs=(Downloads Desktop)
         src2=/Volumes/${srcs[0]}
         dst=.t????n?s
         ext=t*n*t
         IFS=$(echo -en "\n\b")
         shopt -s nullglob
         # for src in ${srcs[@]}; do
         #    if [ ! -z "`echo $base${src}/*.$ext`" ];
         #    then
         #       for file in $base${src}/*.$ext
         #      do
         #          echo "Moving `basename "$file"` ..."
         #          mv "$file" $base$dst/
         #       done
         #       echo "Done."
         #    else
         #       echo "No ${ext}s in $base${src}."
         #       # return 1
         #   fi
         #i done
         # if [ -e ${src2}/*.$ext ];
         # then
             mv -v ${src2}/*.$ext $base$dst/ 2> /dev/null
             mv -v ~/${srcs[0]}/*.$ext $base$dst/ 2> /dev/null
         # fi
         # echo $src2
         # echo ${src2}
         # return 1
      }

   stopsocks () 
   {
   pkill -f "ssh -D"
   sudo networksetup -setsocksfirewallproxystate Wi-Fi off
   sudo networksetup -setsocksfirewallproxystate Ethernet off
   }

   # if [ -d /opt/local/bin/nmap ]; then
      scanlocal () {
         if [ $# -eq 0 ]
         then
            if=en0
         else
            if=$1
         fi
         localip=`ipconfig getifaddr $if`
         localnet=$(echo ${localip}|cut -d. -f1,2,3)

         # echo $localip
         # echo $localnet

         # echo nmap -sn -sV $localnet.0/24
         echo "Scanning $localnet.0/24 ... "
         nmap -sn $localnet.0/24
         # --version-light 
      } 
   # fi

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
            sudo networksetup -setsocksfirewallproxy Wi-Fi localhost $port
            sudo networksetup -setsocksfirewallproxy Ethernet localhost $port
            sudo networksetup -setsocksfirewallproxystate Wi-Fi on
            sudo networksetup -setsocksfirewallproxystate Ethernet on
            ;;
            esac
   }

   alias bat="pmset -g batt | grep Internal | cut -f2 | cut -d' ' -f1,2,3,4| sed s/\;\ 0\:00.*//g"
   alias batt="bat"
   alias free="echo -n 'Memory free: ' && memory_pressure |tail -1|cut -d' ' -f5"
   alias con="tail -40 -f /var/log/system.log"
   alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport"
   alias socku="startsocks l.unixadmin.ca"
   alias sockc="startsocks www.cli.ph"
   alias o="open ."
   alias vlc="open -a vlc"

   dict () {
      open dict://$1
   }
   
   ql () {
      /usr/bin/env qlmanage -p "$@" &>/dev/null
   }

   bnchost=l.unixadmin.ca

   tunnel ()
   {
      if [ $# -ne 2 ];
      then
         echo "Usage ${FUNCNAME[0]} <host> <rport> <thost>"
         return 1
      fi
      host=$1
      rport=$2
      if [ $3 ];
      then
         thost=$3
      else
         thost=$bnchost
      fi

      if [ ${#rport} -eq 3 ];
      then
         lport=8$rport
      else
         lport=$rport
      fi
         
      echo -n "Create tunnel to $host:$rport via $thost? [Y/n] "
      read answer
      case "$answer" in
         n|N)
            return 1
            ;;
         y|Y|*)
            # echo ssh -v -f -N -L $lport:$host:$rport $thost
            ssh -f -N -L $lport:$host:$rport $thost
            if [ $? -ne 0 ];
            then
               echo "SSH error"
               return 1 
            fi
            sshpid=$!
            echo
            ;;
            esac
      nc -z localhost $lport
      if [ $? -ne 0 ];
      then
         echo "Port $lport doesn't seem to be open"
         kill $sshpid
         return 1
      fi
      echo -n "Would you like to open https://localhost:$lport/ [Y/n] "
      read answer
      case "$answer" in
         n|N)
            ;;
         y|Y|*)
            open https://localhost:$lport/
            echo
            ;;
            esac
   }

   teardown () {
   for pid in `ps x|egrep  '[s]sh | -[L] '|cut -f1 -d' '`
   do
      echo -n "Killing $pid ... "
      kill $pid
      echo "Done."
   done
   }

   tunnels () {
      tnnels=`ps x | egrep '[s]sh | -[L] '`
      if [ $? -eq 1 ];
      then
         echo "No tunnels."
      else
         numtuns=`echo $tnnels|wc -l`
         echo "$numtuns tunnel(s)."
      fi
   }

   vpn () {
      numargs=$#
      IFS=$'\n'
   
      usage () {
      echo "vpn <VPN keyword|stop> <action: start|stop>"
      echo "Without any arguments \`vpn\` will display the status of all configured VPNs"
      echo "With only the action \"stop\", the currently active VPN will be stopped"
      echo "With a VPN identifying keyword supplied the status of that VPN will be \
         displayed or the action will be performed on that VPN"
      }

      vpn_status() {
         if [ $#  -eq 0 ]; then 
            for vpn in  `networksetup -listallnetworkservices|grep -v \*|grep VPN`;
               do
                  echo -n "${vpn}: "
                  networksetup -showpppoestatus ${vpn}
               done
         else
            echo -n "$vpn_name: "
            result=`networksetup -showpppoestatus $vpn_name`
            echo $result
            if `echo $result | grep -qv "disconnected"`; then
               return 0
            else
               return 1
            fi
         fi 
      }
     
      poll () {
         loops=0
         maxloops=200

         echo "Polling ..."

         while vpn_status; do
            sleep 0.1
            let loops=$loops+1
            echo $loops
            [ $loops -lt $maxloops ] && break
         done

         [ $loops -le $maxloops ]
      }

      vpn_start () {
         if vpn_status $arg >/dev/null; then
            echo "VPN is already up"
         else
            echo -n "Starting $vpn_name ... "
            # networksetup -connectpppoeservice \"$vpn_name\"
            # echo networksetup -connectpppoeservice \"$vpn_name\"
            # vpn_status | grep connected
            # if poll; then
            #    echo "Connected"
            # else
            #    echo "Did not connect"
            #    vpn_stop
            # fi
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "$vpn_name"
                if exists VPN then connect VPN
                repeat while (current configuration of VPN is not connected)
                    delay 1
                end repeat
        end tell
end tell
EOF
            vpn_status $vpn_name
         fi
      }

      vpn_stop () {
         if [ $# -eq 1 ]; then
            vpn_name=$1
         fi

            echo -n "Stopping $vpn_name ... "
            # echo networksetup -disconnectpppoeservice \"$vpn_name\"
            # networksetup -disconnectpppoeservice \"$vpn_name\"
            # echo scutil --nc stop $vpn_name
            # scutil --nc stop $vpn_name
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "$vpn_name"
                if exists VPN then disconnect VPN
        end tell
end tell
return
EOF
            vpn_status $vpn_name
      }

      if [ $# -eq 1 ]; then
         arg=$1
         if [ $arg = "stop" ]; then
            # vpn_status 
            # vpn_status | grep " connected" | cut -f1 -d\:
            running_vpn=`vpn_status | grep " connected" | cut -f1 -d\:`
            # echo $running_vpn
            if [ -z "$running_vpn" ]; then
               echo "No active VPN"
               # echo $running_vpn
            else
               vpn_stop $running_vpn
            fi
   
         elif [ $arg = "help" ]; then
           usage
            
         else
            vpn_name=`networksetup -listallnetworkservices|grep -v \*|grep VPN|grep -i $arg`
            vpn_status $vpn_name
         fi
      elif [ $# -eq 2 ]; then
         arg=$1
         action=$2
         vpn_name=`networksetup -listallnetworkservices|grep -v \*|grep VPN|grep -i $arg`
         case "$action" in
               start)
                  vpn_start
                  ;;
               stop)
                  vpn_stop
                  ;;
            esac
      else
         vpn_status
      fi

      # echo $arg
      # echo $vpn_name
   }

   export PATH=/opt/local/bin:/opt/local/sbin:$PATH
   
   if [ -d "$HOME/Development/arm-cs-tools/bin" ];
   then
      export PATH=$HOME/Development/arm-cs-tools/bin:$PATH
   fi

   alias ls='ls -GF'
   alias l='ls -lGF'
   alias la='ls -laGF'

   alias update="reload_motd; sudo port selfupdate && sudo port upgrade outdated && sudo port uninstall inactive"
   alias upgrade="update"
   if [ -x "/opt/local/bin/aws-2.7" ];
   then
      alias aws='/opt/local/bin/aws-2.7'
   fi

   if [ -e ~/Synervoz/AWS/source_creds ];
   then
      alias syner='aws_creds Synervoz'
   fi

   if [ -e ~/Mobiroo/AWS/source_creds ];
   then
      alias mobi='aws_creds Mobiroo'
   fi

   alias syn='cd ~/Synervoz && syner'
   alias mob='cd ~/Mobiroo && mobi'

   aws_creds() {
      if [ $# -lt 1 ];
      then
         echo "$FUNCNAME requires an argument"
         return 1
      else
         client=$1
         if [ -d ~/$client/AWS/ ];
         then
            echo -n "Exporting $client AWS credentials ... "
            source ~/$client/AWS/source_creds
            echo "Done."
         else
            echo "AWS directory not found in ~/$client/"
            return 1
         fi 
      fi
   }


   if [ -x "$HOME/Library/Python/2.7/bin" ];
   then
      export PATH=$HOME/Library/Python/2.7/bin:$PATH
   fi

#	SSH_ENV="$HOME/.ssh/environment"
#
#	function start_agent {
#		  echo "Initialising new SSH agent..."
#		  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#		  echo succeeded
#		  chmod 600 "${SSH_ENV}"
#		  . "${SSH_ENV}" > /dev/null
#		  /usr/bin/ssh-add;
#	}
#
#	# Source SSH settings, if applicable
#
#	if [ -f "${SSH_ENV}" ]; then
#		  . "${SSH_ENV}" > /dev/null
#		  #ps ${SSH_AGENT_PID} doesn't work under cywgin
#		  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#				start_agent;
#		  }
#	else
#		  start_agent;
#	fi

elif [ $platform == 'Linux' ]; then
   alias ls='ls -GF --color=auto'
   distro=`head -1 /etc/issue | cut -f1 -d' '`
   case "$distro" in
      Debian|Ubuntu)
         alias apt-get="sudo apt-get"
         alias upgrade="sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get clean"
         ;;
      CentOS|Redhat)
         alias upgrade="sudo yum update"
         ;;
   esac
fi

reload_motd () {
   platform=`uname`
   case "$platform" in
      Linux)
         unamecmd=$(uname -srv)
         ;;
      Darwin)
         unamecmd=$(build=`sw_vers -buildVersion`; uname=`uname -vm | sed -E 's/Kernel\ Version\ //g;s/\/RELEASE.{7}//g;s/\:\ /\ /g;s/\;//g'`; echo $uname $build)
         ;;
         esac
         
   sudo cp /etc/motd{,.prev}
   sudo echo $unamecmd > /tmp/motd.new
   if [ -f /etc/motd.art ];
      then
         sudo cat /etc/motd.art >> /tmp/motd.new;
   fi
   sudo mv /tmp/motd.new /etc/motd
   cat /etc/motd
}

# echo $run_client_scripts
# 
# if [ -d "$HOME/bin/scripts/clients" ] && [ "$run_client_scripts" = "0" ];
# then
#     echo "Loading client scripts ..."
#     for file in `find $HOME/bin/scripts/clients -maxdepth 2 -type f -name *.sh`
#     do
#        source $file
#     done
#  fi
