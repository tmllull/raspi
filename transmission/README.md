# Transmission on Raspi

Is recommended use a [static IP](https://github.com/tmllull/raspi/tree/master/staticIP) for your Raspi, and [congifure no-ip](https://github.com/tmllull/raspi/tree/master/no-ip).

Update and Upgrade your Raspi

    sudo apt-get update
    sudo apt-get upgrade

Install transmission-daemon

    sudo apt-get install transmission-daemon

At this point, we need to have a [mounted device](https://github.com/tmllull/raspi/tree/master/mountDevices) like external HDD or USB. For example, I use a 2TB HDD mounted on /media/hdd.

Create some folders to use with your HDD and Transmission.

    sudo mkdir /media/hdd/transmission
    sudo mkdir /media/hdd/transmission/progress
    sudo mkdir /media/hdd/transmission/completed

Add some permissions and add your user to the group debian-transmission

    sudo usermod -a -G debian-transmission pi
    chgrp debian-transmission /media/hdd/transmission/progress
    chgrp debian-transmission /media/hdd/transmission/completed
    chmod 770 /media/hdd/transmission/progress
    chmod 770 /media/hdd/transmission/completed

And stop the service

    sudo /etc/init.d/transmission-daemon stop

Now, make a copy from the settings file. Create a backups folder if you haven't one

    mkdir /home/pi/backups
    sudo cp /etc/transmission-daemon/settings.json /home/pi/backups transmission-settings-backup.json

Edit settings file

    sudo nano /etc/transmission-daemon/settings.json
    
Make some changes:

    ...
    "download-dir": "/media/hdd/transmission/completed",
    ...
    "incomplete-dir": "/media/hdd/transmission/progress", 
    "incomplete-dir-enabled": true,
    ...
    "rpc-authentication-required": true,
    ...
    "rpc-password": "your password",
    ...
    "rpc-username": "your user",
    ...
    "rpc-whitelist-enabled": false,
    
And restart the service

    sudo /etc/init.d/transmission-daemon restart
    

## Access from your local network

For access to your transmission list, type the Raspi IP address on your browser using port 9091

    192.168.1.XX:9091

## Access from external network

You need to open ports on your browser, redirect it to the Raspi IP and configure no-ip service.

Then just type your domain on browser using the same port 9091

    yourdomain.com:9091

## Using Android APP

You can use transmission from your mobile using an App like [Remote Transmission] (https://play.google.com/store/apps/details?id=com.neogb.rtac)


sources:

http://www.robertsetiadi.com/installing-transmission-in-raspberry-pi/

https://raspberryparatorpes.net/proyectos/instalar-y-configurar-un-descargador-de-torrents/
