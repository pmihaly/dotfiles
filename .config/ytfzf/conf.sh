## when using devour, ytfzf hides, but mpv isnt loaded yet
# video_player="devour mpv"
# video_player_format="devour mpv --ytdl-format="
# audio_player="devour mpv --no-video"

enable_hist=0

thumbnail_video_info_text () {
         printf "\n${c_cyan}%s" "$title"
         printf "\n${c_blue}Channel      ${c_green}%s" "$channel"
         printf "\n${c_blue}Duration     ${c_yellow}%s" "$duration"
         printf "\n${c_blue}Views        ${c_magenta}%s" "$views"
         printf "\n${c_blue}Date         ${c_cyan}%s" "$date"
         printf "\n${c_blue}URL          ${c_reset}%s" "https://youtube.com/watch?v=$shorturl"
}
