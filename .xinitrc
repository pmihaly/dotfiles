setxkbmap -layout hu &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
# wal -n -i ~/.config/wallpaper.jpg &
wal -R -n &
xwallpaper --zoom ~/.config/wallpaper.jpg &
xset r rate 300 50 &
picom -b &

slstatus &
dunst &
sxhkd &
shopt -u -o history &
eval "$(ssh-agent -s)" &
unclutter 3 &
keepassxc &
redshift -P -t 5700:2500 -l 47.29:19.2 -b 0.7:0.5 &
[[ `pgrep syncthing` ]] || syncthing -no-browser &

(sleep 1 && xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape') &

# This line autostarts an instance of Pulseaudio that does not exit on idle.
# This is "necessary" on Artix due to a current bug between PA and
# Chromium-based browsers where they fail to start PA and use dummy output.
# pidof -s runit &&
# 	! pidof -s pulseaudio >/dev/null 2>&1 &&
# 	setsid -f pulseaudio --start --exit-idle-time=-1 >/dev/null 2>&1

exec dwm
