


# ALIASES
alias d="cd ~/Desktop"
alias dev="cd /Users/adamisom/Desktop/dev"

alias python2="/usr/bin/python"
alias grep="grep --color=auto"
alias ll="ls -alF" # -a show hidden; -l show long desc; -F show / or *

alias ss="stopwatch_start"
alias st="stopwatch_stop"

alias n="nano"
alias subl="open -a 'Sublime Text'"
alias chrome="open -a '/Applications/Google Chrome.app'"
alias et="emacs -nw" # run emacs in terminal; note that the function 'e' runs emacs in the background

alias screenshots_to='defaults write com.apple.screencapture location'

alias ff_off="defaults write com.apple.Terminal FocusFollowsMouse -boolean NO"
alias focusfollowsmouse_in_terminal="defaults write com.apple.Terminal FocusFollowsMouse -boolean YES"
alias ff="focusfollowsmouse_in_terminal"

alias showhidden="defaults write com.apple.finder AppleShowAllFiles YES"
alias turnoffshowhidden="defaults write com.apple.finder AppleShowAllFiles NO"

alias nb="nbash"
alias rb="rbash"
alias rbash="exec bash -l" # replace w/new bash instance (-l is login shell)
alias nbash="nano ~/.bash_profile"

alias gs="git status"
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

alias rs="rails server"
alias rc="rails console"

alias rce-em='rubocop --except Style/EmptyMethod' # accommodate method wishlists in Rubocop
alias rco="rubocop --format offenses"
alias rcfixit='rubocop -a' # let Rubocop auto-fix files

alias pep8-align="pep8 --format=pylint"
alias pa="pep8-align"


# FUNCTIONS
stopwatch_start () {  # aliased as ss
  export STOPWATCH_START_TIME=$(date +%s)
}

stopwatch_stop () {  # aliased as st
  if [ $STOPWATCH_START_TIME ]; then
    echo $(($(date +%s ) -$STOPWATCH_START_TIME))
    unset STOPWATCH_START_TIME
  fi
}

e() {
  emacs "$1" & # run emacs in background
}

grep. ()
{
  grep -r $1 .
}

hist () {
  history | tail -$1
}

mkcd ()
{
  mkdir $1 && cd $1
}

cdls ()
{
  cd $1 ; ls ;
}

to ()
{
  touch $1 && open $1
}

subdir_lines () {  # function I made to help myself learn shell commands
  if [ $1 ]; then path=$1  
  else path='.'  # if no path passed in, uses current dir
  fi

 	# I honestly don't recall what the sed below does. I think it's two sed expressions? (;) What's $?
  echo "Total lines:" $(find $path -type f | sed "s/^/'/;s/$/'/" | xargs cat | wc -l)

  # count the number of lines in each subdirectory by recursively finding files
  # and then--to get a single number instead of one per file--concatenating them
  # wrap each file in quotation marks so cat can handle filenames having spaces
  for d in $(ls -d $path/*/); do
    if [ $1 ]; then subdir=$d
    else subdir=$(echo $d | colrm 1 2)
    fi
    
    echo $subdir $(find $d -type f | sed "s/^/'/;s/$/'/" | xargs cat | wc -l)
  done
}


# EXPORTS
export PS1=dir:"\W cmd:\$ "
export PGDATABASE=template1 # so psql stops complaining that 'database adamisom does not exist'
PATH=~/bin:"$PATH" # bin is a good place to put shell scripts I write
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # this allows gnu-sed (newer version/not 2005 built-in) to run as sed (vs gsed)
PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH" # this allows me to run ftp and other inetutils without prefacing with g
PATH="/usr/local/Cellar/ruby/2.6.4_2/bin:${PATH}" # brew installs gems here
PATH="/Users/adamisom/anaconda3/bin:$PATH" # added by Anaconda3 installer
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}" # so the "python" cmd resolves to 3.8
export PATH
