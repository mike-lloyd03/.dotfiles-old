#! /bin/sh

# sleep 10
xkbcomp ~/.config/xkbcomp/vim-keys-mod.xkb $DISPLAY
if ! pgrep xcape; then
  xcape -e 'Mode_switch=Escape'
fi
