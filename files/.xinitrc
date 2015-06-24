
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

# モニタの設定
xrandr --output HDMI1 --right-of HDMI2 --output HDMI2 --primary

# ログイン時にボリュームを下げておく
if which pulseaudio >/dev/null; then
	pulseaudio --start
	while sleep 1; pulseaudio --check; [ $? -ne 0 ]; do :; done
	pactl set-sink-volume 1 0%
	pactl set-sink-mute 1 1
	pactl set-sink-volume 2 0%
	pactl set-sink-mute 2 1
fi

# 常駐するプログラムの起動
dropbox start &
xscreensaver -no-splash &

# よく利用するプログラムの起動
nvpy &
firefox &
thunderbird &
xterm &

exec i3

# vim:filetype=sh
