#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web Development
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
    export PS1="\u@\h [\w]# "
    export PS1='\[\033[01;32m\]\u\[\033[01;34m\]@\[\033[01;31m\]\h\[\033[00;34m\]{\[\033[01;34m\]\w\[\033[00;34m\]}\[\033[01;32m\]:\[\033[00m\] '
    PS1='\[\033[01;32m\]\u\[\033[01;34m\]@\[\033[01;31m\]\h\[\033[00;34m\]{\[\033[01;34m\]\w\[\033[00;34m\]}\[\033[01;32m\]:\[\033[00m\] '

#   Set Paths
#   ------------------------------------------------------------
    export PATH="$PATH:/usr/local/bin"

#   Set Default Editor
#   ------------------------------------------------------------
     export EDITOR="vim"
     export SVN_EDITOR="vim"
     export VISUAL="vim"

#   Set Colors
#   ------------------------------------------------------------
    black='\e[0;30m'
    blue='\e[0;34m'
    green='\e[0;32m'
    cyan='\e[0;36m'
    red='\e[0;31m'
    purple='\e[0;35m'
    brown='\e[0;33m'
    lightgray='\e[0;37m'
    darkgray='\e[1;30m'
    lightblue='\e[1;34m'
    lightgreen='\e[1;32m'
    lightcyan='\e[1;36m'
    lightred='\e[1;31m'
    lightpurple='\e[1;35m'
    yellow='\e[1;33m'
    white='\e[1;37m'
    nc='\e[0m'

#   Set Helpers
#   ------------------------------------------------------------
    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # If not running interactively, don't do anything
    [ -z "$PS1" ] && return

    # don't put duplicate lines in the history. See bash(1) for more options
    # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
    # ... or force ignoredups and ignorespace
    export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
    export HISTCONTROL=ignoreboth

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # if the command-not-found package is installed, use it
    if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
        function command_not_found_handle {
                # check because c-n-f could've been removed in the meantime
                    if [ -x /usr/lib/command-not-found ]; then
               /usr/lib/command-not-found -- "$1"
                       return $?
                    elif [ -x /usr/share/command-not-found/command-not-found ]; then
               /usr/share/command-not-found/command-not-found -- "$1"
                       return $?
            else
               printf "%s: command not found\n" "$1" >&2
               return 127
            fi
        }
    fi

#------------------------------------------////
# Aliases:
#------------------------------------------////

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

    alias wtf="watch -n 1 w -hs"
    alias wth="ps -uxa | more"
    alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
    alias ports='netstat -nape --inet'
    alias ping='ping -c 4'
    alias ns='netstat -alnp --protocol=inet'
    alias ls='ls -AF --color=always'
    alias la='ls -Al'
    alias lx='ls -lXB'
    alias lk='ls -lSr'
    alias lc='ls -lcr'
    alias lu='ls -lur'
    alias lr='ls -lR'
    alias lt='ls -ltr'
    alias lm='ls -al |more'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    alias cp='cp -iv'                           # Preferred 'cp' implementation
    alias mv='mv -iv'                           # Preferred 'mv' implementation
    alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
    alias ll='ls -FlAhp'                        # Preferred 'ls' implementation
    alias less='less -FSRXc'                    # Preferred 'less' implementation
    cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
    alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias .3='cd ../../../'                     # Go back 3 directory levels
    alias .4='cd ../../../../'                  # Go back 4 directory levels
    alias .5='cd ../../../../../'               # Go back 5 directory levels
    alias .6='cd ../../../../../../'            # Go back 6 directory levels
    alias edit='subl'                           # edit:         Opens any file in sublime editor
    alias ~="cd ~"                              # ~:            Go Home
    alias c='clear'                             # c:            Clear terminal display
    alias which='type -all'                     # which:        Find executables
    alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias show_options='shopt'                  # Show_options: display bash options settings
    alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
    alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
    mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
    alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

    zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
    alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
    alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
    alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
    alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

#   encrypt:  Encrypt given file/directory
#   ---------------------------------------------------------
    encrypt ()
    {
    gpg -ac --no-options "$1"
    }

#   decrypt:  Decrypt give file/directory
#   ---------------------------------------------------------
    decrypt ()
    {
    gpg --no-options "$1"
    }

#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

    alias qfind="find . -name "                 # qfind:    Quickly search for file
    ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
    ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
    ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

    alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
    alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
    alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
    alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
    alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
    alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
    alias showBlocked='sudo iptables --list'            # showBlocked:  All ipfw rules inc/ blocked IPs

    localnet () {
        /sbin/ifconfig | awk /'inet addr/ {print $2}'
        echo ""
        /sbin/ifconfig | awk /'Bcast/ {print $3}'
        echo ""
    }

    whatismyip () {
        lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org/ | grep "Current IP Address" | cut -d":" -f2 | cut -d" " -f2
    }

    upinfo () {
        echo -ne "${green}$HOSTNAME ${red}uptime is ${cyan} \t ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
    }

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        echo
    }

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

    # Set Who Am I Variable
    whoami=`whoami`

    case "$-" in
    *i*)

    if [[ "$whoami" == "root" || "$whoami" == "jacob" || "$whoami" == "deploy" || "$whoami" == "vagrant"]]; then
        clear
    else
        clear
        cat /usr/share/motd/legal

        echo -n "Do you agree to the above terms? (YES or NO? [ENTER]) "
        read -e confirmation

        # Ensuring confirmation is all lower case!
        confirmation="$(echo ${confirmation} | tr 'A-Z' 'a-z')"

        if [[ $confirmation =~ ^([yY][eE][sS]|[yY])$ ]]

        then
            clear
        else
            pkill -KILL -u $whoami
        fi
    fi

    echo -e "${LIGHTGRAY}";figlet "Welcome  $USER";
    echo -ne "${red}Today is:\t\t${cyan}" `date`; echo ""
    echo -e "${red}Kernel Information: \t${cyan}" `uname -smr`
    echo -ne "${cyan}";upinfo;echo ""
    echo -e "${cyan}"; cal -3
    ;;
    esac

    alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

    # Nginx Rules
    alias xcd='cd /etc/nginx/'
    alias xsites='cd /etc/nginx/sites-available'
    alias xconf='cd /etc/nginx/includes'
    alias xedit='sudo subl /etc/nginx/nginx.conf'
    alias xrr='sudo service nginx reload; sudo service nginx restart'
    alias xrestart='sudo service nginx restart'
    alias xreload='sudo service nginx reload'
    alias xstop='sudo service nginx stop'
    alias xstart='sudo service nginx start'
    alias rphp='sudo service php5-fpm restart'
    alias pstop='sudo service php5-fpm stop'
    alias pstart='sudo service php5-fpm start'
    alias xlogs='cd /var/log/nginx/'

    # Apache Rules
    alias acd='cd /etc/apache2/'
    alias asites='cd /etc/apache2/sites-available'
    alias aconf='cd /etc/apache2/includes'
    alias aedit='vim /etc/apache2/apache2.conf'
    alias arr='sudo service apache2 reload; sudo service apache2 restart'
    alias arestart='sudo service apache2 restart'
    alias areload='sudo service apache2 reload'
    alias astop='sudo service apache2 stop'
    alias astart='sudo service apache2 start'
    alias alogs='cd /var/log/apache2/'
    alias felogs='tail -f /var/log/apache2/error.log'
    alias falogs='tail -f /var/log/apache2/access.log'

    # General Rules
    alias server='cd /server'
    alias xhosts='sudo vim /etc/hosts'
    alias myrestart='sudo service mysql restart'
    alias mystop='sudo service mysql stop'
    alias mystart='sudo service mysql start'

    # SSL Certificate Rules
    certinfo () { openssl x509 -in "$1" -noout -text; }
    csr () { openssl req -new -newkey rsa:2048 -nodes -keyout "$1".key -out "$1".csr; }

    httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }
