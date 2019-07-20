
is_vnc() {
	xrandr 2>/dev/null |fgrep -q VNC-0
}


. ~/.xinputrc
setxkbmap -option ctrl:nocaps
xrdb -merge $HOME/.Xdefault
xset -b

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

# モニタの設定
case `hostname` in
	desktop1)
		xrandr --output HDMI-1 --right-of HDMI-2 --output HDMI-1 --primary
		;;
	laptop2)
		xrandr --output eDP1 --primary
		# VNC clientしか使ってない。
		# SSH接続のためにターミナル起動する以外、何もしない。
		xterm &
		exec i3
		;;
	tagoken-desktop1)
		if is_vnc; then
			xrandr --output VNC-0 --primary
		else
			# 物理コンソールにログインしたときは、モニターの設定変更をする。
			# 3画面
			# 一番左のモニター(VGA-1)は縦置き
			# それ以外のモニター(HDMI-1, HDMI-2)は、VGA-1と下側を揃えて配置
			xrandr \
				--output VGA-1 --auto --rotate left --pos 0x0 \
				--output HDMI-1 --auto --pos 1080x840 \
				--output HDMI-2 --auto --primary --pos 3000x840
			# VNCへのログイン画面を表示
			vncviewer &
			# 常駐アプリは、VNCセッション起動時に立ち上げ済み。
			# 物理コンソールへのログイン時は、VNCのログイン画面だけを表示させたい。
			# そのため、これ以降の処理を全てスキップし、i3wmに制御を渡す。
			exec i3
		fi
		;;
esac

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
