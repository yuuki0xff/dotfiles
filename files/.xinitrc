
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

# モニタの設定
# 外部ディスプレイ接続時は、外部ディスプレイをプライマリにする
if xrandr|grep -w connected|grep -q HDMI1; then
	xrandr --output HDMI1 --left-of LVDS1
	xrandr --output HDMI1 --primary
fi

# 回転スクロールを有効化
synclient CircularScrolling=1 CircScrollTrigger=1

# ログイン時にボリュームを下げておく
if which pulseaudio >/dev/null; then
	pulseaudio --start
	while sleep 1; pulseaudio --check; [ $? -ne 0 ]; do :; done
	pulseaudio-ctl set 0
	pulseaudio-ctl mute on
fi

# 常駐するプログラムの起動
dropbox start &

# よく利用するプログラムの起動
nvpy &
firefox &
thunderbird &
xterm &

exec i3

# vim:filetype=sh
