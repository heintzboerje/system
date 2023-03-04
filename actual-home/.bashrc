# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi
alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias qutebrowser="qutebrowser --qt-flag disable-seccomp-filter-sandbox"

export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export NODE_PATH="/home/snake/.guix-profile/lib/node_modules${NODE_PATH:+:}$NODE_PATH"
export NIX_REMOTE=daemon
export C_INCLUDE_PATH="/home/snake/.guix-profile/include${C_INCLUDE_PATH:+:}$C_INCLUDE_PATH"
export CPLUS_INCLUDE_PATH="/home/snake/.guix-profile/include${CPLUS_INCLUDE_PATH:+:}$CPLUS_INCLUDE_PATH"
export LIBRARY_PATH="/home/snake/.guix-profile/include${LIBRARY_PATH:+:}$LIBRARY_PATH"
export NIX_PROFILES="/nix/var/nix/profiles/default $HOME/.nix-profile"

for i in $NIX_PROFILES; do
	export PATH="${PATH}:${i}/bin"
done

export PATH="/home/snake/.config/guix/current/bin${PATH:+:}${PATH}"

if [ ! -e $HOME/.nix-defexpr -o -L $HOME/.nix-defexpr ]; then
	echo "creating $HOME/.nix-defexpr" >&2
	rm -f $HOME/.nix-defexpr
	mkdir $HOME/.nix-defexpr
	if [ "$USER" != root]; then
		ln -s /nix/var/nix/profiles/per-user/root/channels \
		$HOME/.nix-defexpr/channels_root
	fi
fi

if test "$USER" != root; then
	export NIX_REMOTE=daemon
else
	export NIX_REMOTE=
fi

export EDITOR="hx"
export PATH="/home/snake/.cargo/bin:/home/snake/.local/bin:$PATH"
export BSD_GAMES_DIR=/var/multiplayer
export BSD_GAMES_DIR=~/.local/share/bsd-games

eval "$(starship init bash)"