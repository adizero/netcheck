#!/usr/bin/env bash
message="Disconnected!"
notify-send -u critical "${message}"
espeak-ng "${message}"
