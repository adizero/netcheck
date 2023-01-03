#!/usr/bin/env bash
# message="Checked now"
# notify-send -u low -t 1000 "${message}"
# espeak-ng "${message}"
logfile="$HOME/netcheck_Arris_SB6183_status.log"
last_status_file="/tmp/last_arris_status"
last_status="$(cat "${last_status_file}")"
timestamp="$(date "+%a %d %b %Y %H:%M:%S %Z")"
message="=== Checked at ${timestamp} ==="

echo "${message}" >> "${logfile}"
status=$(w3m -dump 192.168.100.1 | vim -E -c "1,/Startup Procedure/-1d" -c "/Current System Time/,\$d" -c%p -cq! /dev/stdin)
if [ "${last_status}" == "${status}" ]; then
    echo "No change" >> "${logfile}"
else
    echo "${status}" > "${last_status_file}"

    echo "--- diff to previous ---" >> "${logfile}"
    diff <(echo "${last_status}") <(echo "${status}") >> "${logfile}"
    # cannot use pipes as inputs for git diff
    # git --no-pager diff --word-diff <(echo "${last_status}") <(echo "${status}") > /tmp/status_diff
    echo "--- diff to previous end ---" >> "${logfile}"
    echo "${status}" >> "${logfile}"
fi
