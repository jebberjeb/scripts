if [ -z "$XRANDR_SIZE" ]; then
    export XRANDR_SIZE=0
else
    let "XRANDR_SIZE++"
fi

echo "changing display size using xrandr to $XRANDR_SIZE"
xrandr -s "$XRANDR_SIZE"

