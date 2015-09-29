
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

# モニタの設定
# 外部ディスプレイ接続時は、外部ディスプレイをプライマリにする
if xrandr|grep -w connected|grep -q HDMI1; then
	xrandr --output HDMI1 --left-of LVDS1
	xrandr --output HDMI1 --primary
fi

# ログイン時にボリュームを下げておく
if which pulseaudio >/dev/null; then
	pulseaudio --start
	while sleep 1; pulseaudio --check; [ $? -ne 0 ]; do :; done
	pulseaudio-ctl set 0
	pulseaudio-ctl mute on
fi

# よく利用するプログラムの起動
#nvpy &
#firefox &
#thunderbird &
xterm &
VBoxClient-all &

exec i3

# vim:filetype=sh
