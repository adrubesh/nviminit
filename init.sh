#!/usr/bin/env bash

# NVIM_LISTEN_PORT: Port for Neovim server to listen on
# USER_ID: New userid for user
# ZSH_CONFIG_URL: Url to download a ZSH config from

function __nvim_listen() {
	if [ -z "$NVIM_LISTEN_PORT" ]; then
		printf "Please set %s to valid port." "NVIM_LISTEN_PORT" 
		return 1
	fi

	nvim --listen "0.0.0.0:$NVIM_LISTEN_PORT" --headless
}

function __check_uid() {
	CURRENT_UID=`id -u`
	CURRENT_USER=`whoami`
	if [ "$CURRENT_UID" -ne "$USER_ID"]; then
		printf "Changing user id."
		sudo usermod -u "$USER_ID" "$CURRENT_USER"
	fi
}

function __check_zsh() {
	if [ -v ZSH_CONFIG_URL && ! -f ~/.zshrc ]; then
		curl -o ~/.zshrc -L "$ZSH_CONFIG_URL"
	fi
}

function __check_nvim() {
	if [ -v NVIM_CONFIG_URL && ! -f ~/.config/nvim/init.vim ]; then
		curl -o ~/.config/nvim/init.vim --create-dirs -L "$NVIM_CONFIG_URL"
	fi
}

__check_zsh
__check_nvim
__check_uid
__nvim_listen
