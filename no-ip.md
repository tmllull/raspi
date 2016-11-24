# Configure NO-IP

Download no-ip

    wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz

Extract

    tar -zxvf noip-duc-linux.tar.gz

Access to the new folder no-ip, and install it

    cd noip-2.1.9-1
    sudo make
    sudo make install

During the installation, introduce our user and pass for no-ip, and select what domain we want to use. If you only have one, it's taked by default. Then, choose an update interval (I use 5 minutes), and choose "NO" (N) for the next question.

To open automatically no-ip when turn on the Raspi, create a new file

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

And modify update-rc.d

    sudo update-rc.d noip2 defaults

Start no-ip with

    sudo /usr/local/bin/noip2

Finally, open the ports you want to use from Internet from your router:

- 80 for http
- 22 for ssh
- 9091 for transmission
- etc

# Commands

Show noip2 configuration
    
    sudo noip2 -S

Update refresh interval

    sudo noip2 -U time_in_minutes

Kill process

    sudo killall noip2

