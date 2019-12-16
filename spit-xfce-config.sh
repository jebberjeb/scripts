cp $SOURCE_PATH/scripts/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

cd ~/.config/xfce4
if [[ ! -e "terminal" ]]; then
    mkdir terminal
fi
cd terminal
cp $SOURCE_PATH/scripts/terminalrc .
