#!/bin/env bash

function __nvim_listen() {
	if [ -z "$NVIM_LISTEN_PORT" ]; then
		printf "Please set %s to valid port." "$NVIM_LISTEN_PORT" 
	fi

	nvim --listen "0.0.0.0:$NVIM_LISTEN_PORT" --headless
}

__nvim_listen
