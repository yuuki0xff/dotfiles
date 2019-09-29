
is_vnc() {
	xrandr 2>/dev/null |fgrep -q VNC-0
}


. ~/.xprofile
. ~/.xinputrc

# GPG: Graphical pinentryが動作しない問題を修正
#
# gpg-agentがsystemdの配下で稼働しているとき、適切な環境変数が設定されていないので
# graphicalなpinentryが動作しない。
# この問題を修正するためのコード。
(
	export $(dbus-launch)
	systemctl --user set-environment DISPLAY=:0
	systemctl --user set-environment DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS
	systemctl --user restart gpg-agent
)

# ログイン時にボリュームを下げておく
if which pulseaudio >/dev/null; then
	# pulseaudioの起動は、systemdが勝手にやってくれるはず。
	# Firefoxはpulseaudioを先に起動する必要があるため、pulseaudioが起動完了するまで待機する。
	while sleep 1; pulseaudio --check; [ $? -ne 0 ]; do :; done
	pactl set-sink-volume 1 0%
	pactl set-sink-mute 1 1
	pactl set-sink-volume 2 0%
	pactl set-sink-mute 2 1
fi

# 常駐するプログラムの起動
pasystray &
dunst &

# よく利用するプログラムの起動
firefox &
thunderbird &
xterm &

exec i3

# vim:filetype=sh
