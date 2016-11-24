# Configure FTP server

scp is a usefull command to copy some files from our server to our computer, but if we want to copy a lot of files from diferents folder, this task it's a little more complicated. To solve it, we can use FTP client.

Install vsftpd

    sudo apt-get install vsftpd
    
And made some changes on config file

    sudo nano /etc/vsftpd.conf
    
Modify the next lines:

    anonymous_enable=NO
    ....
    local_enable=YES
    ...
    write_enable=YES
    ...

If your FTP is used for differents users, and you want to restric access just to their personal folder, unccoment the line:

    chroot_local_user=YES
    
## Add SSL

If you want to add SSL certificate, use this command:

    sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
    
Then, edit again the config file:

    sudo nano /etc/vsftpd.conf
    
And at the bottom, made some changes about file and key certificate, and uncomment ssl_enable=YES:

    rsa_cert_file=/etc/ssl/private/vsftpd.pem
    rsa_private_key_file=/etc/ssl/private/vsftpd.pem
    ssl_enable=YES

Finally, add the follow lines:

    allow_anon_ssl=NO
    force_local_data_ssl=YES
    force_local_logins_ssl=YES
    
    ssl_tlsv1=YES
    ssl_sslv2=NO
    ssl_sslv3=NO
    
    require_ssl_reuse=NO
    ssl_ciphers=HIGH

Finally, restart the service:

    sudo service vsftpd restart
    
# Change FTP port

If you want to change the FTP port, edit the config file:

    sudo nano /etc/vsftpd.conf
    
And change/add the next lines, adding the new port you want to use (2121, 2122,2123...):

    #connect_from_port_20=YES
    ftp_data_port=2121
    listen_port=2121

Finally,restart the service:

    sudo service vsftpd restart


sources:

http://twincreations.co.uk/change-default-ftp-port-for-vsftp/

https://geekytheory.com/tutorial-raspberry-pi-9-servidor-ftp/

https://www.digitalocean.com/community/tutorials/how-to-configure-vsftpd-to-use-ssl-tls-on-an-ubuntu-vps

