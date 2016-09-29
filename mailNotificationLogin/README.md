## How to use
This is a simple script for send an email and notification using Pushbullet servcie when someone login into Raspi.

First of all, we need to configure a mail client, and we follow [this steps](). 

Then, we need to create an "Access token" from [Pushbullet website](http://www.pushbullet.com), in your account settings.

Create file pushLogin.sh with the following code, changing *YOURTOKEN* for the token generated from Pushbullet.

    #!/bin/bash

    API="YOURTOKEN"
    MSG="Login from user $PAM_USER"
    
    curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Raspi Alert" -d body="$MSG"

    exit 0

Create a new file named pushLogout.sh and copy the same code changing the MSG for "Logout..."

Copy files to yout scripts folder (or where you want) and change permissions on it to allow execution:

    sudo cp pushLogin.sh /home/pi/scripts
    sudo chmod 755 /home/pi/scripts/pushLogin.sh
    sudo chmod 755 /home/pi/scripts/pushLogout.sh
  
Create a new file login_script.sh:

    #!/bin/bash

    PUSHBULLETIN="/home/pi/scripts/pushLogin.sh"
    PUSHBULLETOUT="/home/pi/scripts/pushLogout.sh"

    if [ "$PAM_TYPE" != "close_session" ]; then
        $PUSHBULLETIN >/dev/null 2>/dev/null
        subject="Raspi Login"
        {
                date
                echo "SSH:$PAM_TYPE: $PAM_USER from $PAM_RHOST on $host." 
                env
                echo ""
                w
                echo ""
                #last
                echo ""
                #ps -eFly --forest
                echo ""
                echo ""
        } | mail -s "$subject" name@domain.com || exit 1;
    else
        $PUSHBULLETOUT 2>/dev/null 1>/dev/null
    fi

This script send a Pushbullet notification when someone is login and logout, and an email with some information like where are connected, User, last connections, process... The lines *last* and *ps* are commented for minimize information, but just discomment for recieve all.

Edit /etc/pam.d/sshd and add a call to the script like follow. **Take care to add the line just next to "pam_selinux.so close"**:

		SOME CODE
		.............
		# SELinux needs to be the first session rule.  This ensures that any
		# lingering context has been cleared.  Without this it is possible that a
		# module could execute code in the wrong domain.
		session [success=ok ignore=ignore module_unknown=ignore default=bad]        pam_selinux.so close

		# My script
		session required pam_exec.so seteuid /home/pi/scripts/login_script.sh

		# Set the loginuid process attribute.
		session    required     pam_loginuid.so

		# Create a new session keyring.
		session    optional     pam_keyinit.so force revoke
		............
		MORE CODE
