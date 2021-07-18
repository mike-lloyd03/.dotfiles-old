#! /bin/sh

sleep 10
xkbcomp ~/.config/xkbcomp/vim-keys-mod.xkb $DISPLAY
xcape -e 'Mode_switch=Escape'
