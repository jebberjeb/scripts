vnc4server :1 -geometry 1280x1340 -geometry 2560x1340 -geometry 1600x1340 -geometry 1440x800

# Disable scrolling (buttons 4 & 5), and unused buttons
DISPLAY=:1 xmodmap -e "pointer = 1 2 3 0 0 0 0 0 0"
# For some reason, Super isn't setup as a modifier. Possibly because xkb
# support is currently fucked up. So use xmodmap to define it and add it
# as a valid modifier key. Note that this must be used w/ a VNC client
# which actually sends Super_L. So, _not_ the Mac sharing thing. There's no
# way to prevent it from translating Command (Meta) to Alt. But for some
# Reason, VNC turns Command_L into Alt_L, and Command_R into Super_R, and
# totally trashes the options keys, but whatever.
DISPLAY=:1 xmodmap -e "keycode 255 = Super_L"
DISPLAY=:1 xmodmap -e "add mod4 = Super_L"
DISPLAY=:1 vncconfig &
