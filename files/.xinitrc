
. ~/.xinputrc
xrdb -merge $HOME/.Xdefault

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
