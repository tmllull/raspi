# Static IP

First, I recommend to connect one time to your wifi for save the password.

Then, edit the file dhcpcd.conf
  
    sudo nano /etc/dhcpcd.conf
    
And add at final the next lines, depend if you want to use static IP on your eth or wlan connection:

    interface eth0

    static ip_address=192.168.1.XX/24
    static routers=192.168.1.1
    static domain_name_servers=192.168.1.1

    interface wlan0

    static ip_address=192.168.1.XX/24
    static routers=192.168.1.1
    static domain_name_servers=192.168.1.1

Take care to change the IP address accord with your router. In generally, the routers have 192.168.1.1 IP address.

For your Raspi IP is recommended use low numbers, between 10-30 for example, because DHCP address start at 33 (in generally), and it's easier to remember for you.

Save the file and reboot

    sudo reboot now

And use ifconfig to check if your IP address are assigned correctly

    ifconfig
