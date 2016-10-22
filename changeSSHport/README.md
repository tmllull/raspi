# Change SSH port number

If you want to use more than one Raspi on your net, and access both from other location ([using no-ip, for example](https://github.com/tmllull/raspi/tree/master/no-ip)), you need to change ssh port for one of them, because you can't open 22 port from your router to redirect to two diferent local IP's.

Edit the next file

    sudo nano /etc/ssh/sshd_config

And change or comment the line *port 22* to other port number:

    #port 22
    port 2214

Normally, I add the IP number of my Raspi. For example, if my Raspi IP is 192.168.1.14, I use the port 2214 

After this, restart the ssh service or reboot your Raspi

    sudo service ssh restart

or 

    sudo reboot now

To access your Raspi with this new ssh port inside your local network:

    ssh -p 2214 pi@192.168.1.14
    
And to access from other network:

    ssh -p 2214 pi@yourdomain.com

*Remember to open the new port from your router to redirect to the Raspi local IP.


source: http://codrspace.com/audiojava/changing-ssh-port-number/
