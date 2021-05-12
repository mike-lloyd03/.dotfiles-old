#! /bin/sh

xkbcomp ~/.config/xkbcomp/vim-keys-mod.xkb $DISPLAY
xcape -e 'Mode_switch=Escape'
