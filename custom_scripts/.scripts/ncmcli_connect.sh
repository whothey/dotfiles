nmcli_connect() {
    echo -n "SSID: ";
    read ssid;
    echo -n "Password: ";
    read ssid_pw;
    nmcli dev wifi connect $ssid wep-key-type phrase password $ssid_pw;
}
