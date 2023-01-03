#!/usr/bin/env bash
message="Reconnected after $1 seconds"
notify-send -u critical "${message}"
espeak-ng "${message}"
