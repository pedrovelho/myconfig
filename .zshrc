plugins=(
  git
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
)

export ZSH=$HOME/.oh-my-zsh

export ZSH_THEME="agnoster"
plugins=(git osx github macports textmate svn)

source $ZSH/oh-my-zsh.sh

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/
alias temacs="emacs -nw"

tmux-custom-split () {
    session=main
    window=${session}:0  
    
    # create a detached session and call it main
    tmux new-session -s main -d

    # split window
    tmux split-window -d -t 0 -h
    tmux split-window -d -t 0 -v
    tmux split-window -d -t 0 -h
    tmux split-window -d -t 3 -v

    # start htop on the small pane
    tmux send-keys -t "${window}.2" C-z 'htop' Enter
    tmux send-keys -t "${window}.0" C-z 'watch df -h' Enter

    # attach session back
    tmux attach-session -t ${session}
}

tmux-main() {
    # silent run tmux to inquire current session_name
    current_session=`tmux display-message -p '#S' 2> /dev/null`

    # test if an error ocurred is probably because no session is opened
    if [ $? -ne 0 ]; then
	echo "No current tmux session detected, initializing new"
	tmux-custom-split
    else
	if [ "x"$current_session = "xmain" ]; then
	    tmux attach-session -t main
	else
	    if [[ -z $TMUX ]]; then
		tmux-custom-split
	    else
		echo "Nested session, try detach the current tmux session first"
	    fi
	fi
    fi
}

alias tmux-list="tmux list-session"
alias tmux-kill="tmux kill-session -t"
alias tmux-atta="tmux attach-session -t"

exit() {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        tmux detach
    fi
}

# needed by dbus when tmux attach to session
# https://github.com/tmux/tmux/issues/616
export $(dbus-launch)

alias ls-connections=/home/pvelho/ls-connections.sh

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PATH=/usr/local/bin:$PATH
