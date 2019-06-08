vnc4server :1 -geometry 1280x1340 -geometry 2560x1340 -geometry 1600x1340 -geometry 1440x800

### EXPERIMENTAL: disable scrolling (buttons 4 & 5), and unused buttons ###

DISPLAY=:1 xmodmap -e "pointer = 1 2 3 0 0 0 0 0 0"
DISPLAY=:1 vncconfig &
