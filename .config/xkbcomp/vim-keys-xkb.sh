#! /bin/sh

xkbcomp ~/.config/xkbcomp/vim-keys.xkb $DISPLAY
xcape -e 'Mode_switch=Escape'
