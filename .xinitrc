setxkbmap -layout hu &
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
# wal -n -i ~/.config/wallpaper.jpg &
wal -R &
xwallpaper --zoom ~/.config/wallpaper.jpg &
xset r rate 300 50 &

slstatus &
sxhkd &
shopt -u -o history & # bash ne vezessen történetet
eval "$(ssh-agent -s)" &
unclutter 3 &
keepassxc &
redshift -l 47.29:19.2 &


(sleep 1 && xdotool key super+F5) & # téma érvényesítése
(sleep 1 && xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape') &


while true; do

   # BATCAP="$(cat /sys/class/power_supply/BAT0/capacity)"
   # BATSTAT="$(cat /sys/class/power_supply/BAT0/status)"
   # DATE="$(date +"%F %R")"
   # xsetroot -name " $BATCAP% ($BATSTAT) | $DATE "

   mbsync -a
   sleep 1m    # Update time every minute
done &

exec dwm
