setxkbmap -layout hu &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
# wal -n -i ~/.config/wallpaper.jpg &
wal -R &
xwallpaper --zoom ~/.config/wallpaper.jpg &
xset r rate 300 50 &

slstatus &
sxhkd &
shopt -u -o history &
eval "$(ssh-agent -s)" &
unclutter 3 &
keepassxc &
redshift -l 47.29:19.2 &


(sleep 1 && xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape') &


# sync emails periodically
while true; do
   mbsync -a
   sleep 1m
done &

exec dwm
