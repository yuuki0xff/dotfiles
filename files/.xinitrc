
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

# モニタの設定
# 外部ディスプレイ接続時は、外部ディスプレイをプライマリにする
if xrandr|grep -w connected|grep -vq LVDS1; then
	xrandr|grep -w connected|grep -v LVDS1|awk '{print $1}'|(
		read INP
		xrandr --output "$INP" --primary
	)
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
