workers 20
preload_app!
bind 'unix:///tmp/isubata.sock'
pidfile '/tmp/puma.pid'
