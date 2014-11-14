function set_os() {
    if [[ $(uname --all | grep -c Ubuntu) == 1 ]]; then
        os="ubuntu"
        installer="apt-get -y"
    elif [[ $(uname --all | grep -c fc) == 1 ]]; then
        os="fedora"
        installer="yum -y"
    else
        echo "OS not recognized!"
        exit 1
    fi
}

