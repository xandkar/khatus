#! /bin/sh

set -e

dir_bin="$1"

ps -eo pid,state ww --no-headers | "$dir_bin"/khatus_parse_ps
