# Configure NO-IP

Download no-ip

    wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz

Extract

    tar -zxvf noip-duc-linux.tar.gz

Access to the new folder no-ip, and install it

    sudo make
    sudo make install

During the installation, we need to introduce our user and pass for no-ip, and select what domain we want to use. If only have one, take this default. Then, choose an update interval (I use 5 minutes), and choose no (N) for the next question.

For open automatically no-ip when turn on the Raspi, create a new file

    sudo nano /etc/init.d/noip2

And copy this into

    #! /bin/bash
    ### BEGIN INIT INFO
    # Provides: somethings
    # Required-Start: $syslog
    # Required-Stop: $syslog
    # Default-Start: 2 3 4 5
    # Default-Stop: 0 1 6
    # Short-Description: moresomethings
    # Description:
    #
    ### END INIT INFO
    sudo /usr/local/bin/noip2

Add execution permissions

    sudo chmod +x /etc/init.d/noip2

And update this file

    sudo update-rc.d noip2 defaults

Start no-ip

    sudo /usr/local/bin/noip2

Finally, open the ports you want to use from Internet from your router:

- 80 for http
- 22 for ssh
- 9091 for transmission
- etc
