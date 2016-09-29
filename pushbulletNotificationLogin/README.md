## How to use
This is a simple script for send a notification using Pushbullet servcie when someone login into Raspi.

First of all, we need to create an "Access token" from [Pushbullet website](http://www.pushbullet.com), in your account settings.

Create a file pushLogin.sh with the following code, changing *YOURTOKEN* for the token generated from Pushbullet. Depending the way you use for execute (explained at the end), you must comment one or other MSG line:

	#!/bin/bash

	API="YOURKEY"

	#Using PAM
	MSG="Login from user $PAM_USER"

	#Using profile
	#MSG="Login from user $USER"

	#Only execute on login, not on logout
	if [ "$PAM_TYPE" != "close_session" ]; then

	curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Raspi Alert" -d body="$MSG"
	fi

	exit 0

Save and close the file.

Now, copy that file to yout scripts folder (or where you want) and change permissions on it to allow execution:

	sudo cp pushLogin.sh /home/pi/scripts
	sudo chmod 755 /home/pi/scripts/pushLogin.sh

Finally, we've 2 way to execute:

1. Edit /etc/pam.d/sshd and add a call to the script like follow. **Take care to add the line just next to "pam_selinux.so close"**:

		SOME CODE
		.............
		# SELinux needs to be the first session rule.  This ensures that any
		# lingering context has been cleared.  Without this it is possible that a
		# module could execute code in the wrong domain.
		session [success=ok ignore=ignore module_unknown=ignore default=bad]        pam_selinux.so close

		# My script
		session required pam_exec.so seteuid /home/pi/scripts/pushLogin.sh

		# Set the loginuid process attribute.
		session    required     pam_loginuid.so

		# Create a new session keyring.
		session    optional     pam_keyinit.so force revoke
		............
		MORE CODE

2. Edit /etc/profile and add a call to the script at the end
	
		# /etc/profile: system-wide .profile file for the Bourne shell (sh(1)) and...
 		...
 		SOME CODE (NOT CHANGE)
 		...
 		# My scripts
 		/home/pi/scripts/pushLogin.sh >/dev/null 2>/dev/null
 
*The command >/dev/null 2>/dev/null is for redirect the output messages to this directory, and not print on prompt*