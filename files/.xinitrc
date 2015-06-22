
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

# よく利用するプログラムの起動
nvpy &
firefox &
thunderbird &
xterm &

exec i3

# vim:filetype=sh
