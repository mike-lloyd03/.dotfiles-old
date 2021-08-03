#!/bin/bash

SCRIPT_LOCATION=$(dirname $(readlink -f $0))

xmodmap $SCRIPT_LOCATION/xmodmap-vim
xcape -e 'Mode_switch=Escape'
