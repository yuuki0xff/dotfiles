
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

# よく利用するプログラムの起動
xterm &
VBoxClient-all &

exec i3

# vim:filetype=sh
