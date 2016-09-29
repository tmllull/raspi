# Configure Raspi for send emails with ssmtp

Install ssmtp & mailutils:

    sudo apt-get install ssmtp
    sudo apt-get install mailutils

Edit ssmtp.conf file

    sudo nano /etc/ssmtp/ssmtp.conf

And add this:

    root=postmaster
    mailhub=smtp.gmail.com:587
    hostname=raspberrypi
    AuthUser=user@gmail.com
    AuthPass=gmailPassword
    FromLineOverride=YES
    UseSTARTTLS=YES

# VERY IMPORTANT!!!

    ####If other people have access to this computer
    # Your GMAIL Password is left unencrypted in this file
    # so make sure you have a strong root password, and make sure
    # you change the permissions of this file to be 640:
    # chown root:mail /etc/ssmtp/ssmtp.conf
    # chmod 640 /etc/ssmtp/ssmtp.conf
    # 
    # add your user to the group mail
    # usermod -a -G mail <yourUserName>
    # quit all your sessions
    # login again

When you're loged in again, just try to send an email:

    echo "Body message" | mail -s "Subject" name@domain.com

### Troubles

If you receive the follow error when you try to send an email...

    mail: cannot send message: Process exited with a non-zero status

You need to change your app settings from yout [Google account] (https://www.google.com/settings/security/lesssecureapps), and activate acces for less secure apps.

## Sources

[Debian Wiki](https://wiki.debian.org/sSMTP)

[Raspberry projects](http://www.raspberry-projects.com/pi/software_utilities/email/ssmtp-to-send-emails)
