Connect one time to you'r wifi net if you want to save the password (recomended)

Copy /etc/network/interfaces to a new file ifacesbk (backup)

Edit the file interfaces and change eth0, wlan0, wlan1... for this:

auto wlan0
iface wlan0 inet static
address 192.168.1.X
netmask 255.255.255.0
gateway 192.168.1.1
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf

