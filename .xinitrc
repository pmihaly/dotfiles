setxkbmap -layout hu &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
# wal -n -i ~/.config/wallpaper.jpg &
wal -R &
xwallpaper --zoom ~/.config/wallpaper.jpg &
xset r rate 300 50 &
picom -b &

slstatus &
sxhkd &
shopt -u -o history &
eval "$(ssh-agent -s)" &
unclutter 3 &
keepassxc &
redshift -l 47.29:19.2 &
[[ `pgrep syncthing` ]] || syncthing -no-browser &

(sleep 1 && xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape') &

# This line autostarts an instance of Pulseaudio that does not exit on idle.
# This is "necessary" on Artix due to a current bug between PA and
# Chromium-based browsers where they fail to start PA and use dummy output.
# pidof -s runit &&
# 	! pidof -s pulseaudio >/dev/null 2>&1 &&
# 	setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1

# sync emails periodically
while true; do
   # mbsync -a
   sleep 5m
done &

exec dwm
