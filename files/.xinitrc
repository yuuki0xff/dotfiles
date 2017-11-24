
. ~/.xinputrc
setxkbmap -option ctrl:nocaps
xrdb -merge $HOME/.Xdefault
xset -b

# モニタの設定
case `hostname` in
	desktop1)
		xrandr --output HDMI-1 --right-of HDMI-2 --output HDMI-1 --primary
		;;
	laptop2)
		xrandr --output eDP-1 --primary
		;;
esac

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
pasystray &

# よく利用するプログラムの起動
firefox &
thunderbird &
xterm &

exec i3

# vim:filetype=sh
