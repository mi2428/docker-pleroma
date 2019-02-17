#!/bin/ash
cd /pleroma
set -e

if [ -z $@ ]; then
    mix phx.server
else
    exec $@
fi
