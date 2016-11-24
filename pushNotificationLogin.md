## How to use
This is a simple script for send a notification using Pushbullet or Pushover servcie when someone login into Raspi.

First of all, we need to create an "Access token" from [Pushbullet website](http://www.pushbullet.com), in your account settings, or create a new App from [Pushover website] (https://pushover.net/).

### Pushbullet

Create a file pushbulletLogin.sh with the following code, changing *YOURTOKEN* for the token generated from Pushbullet. Depending the way you use for execute (explained at the end), you must comment one or other MSG line:

	#!/bin/bash

	API="YOURTOKEN"

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

	sudo cp pushbulletLogin.sh /home/pi/scripts
	sudo chmod 755 /home/pi/scripts/pushbulletLogin.sh

### Pushover

Create a file pushoverLogin.sh with the following code, changing *APPTOKEN* and *USERTOKEN* for the tokens generated from Pushover. Depending the way you use for execute (explained at the end), you must comment one or other MSG line:

	#!/bin/bash

	#Using PAM
	MSG="message=Login from user $PAM_USER"

	#Using profile
	#MSG="message=Login from user $USER"

	if [ "$PAM_TYPE" != "close_session" ]; then
	curl -s \
        	--form-string "token=APPTOKEN" \
        	--form-string "user=USERTOKEN" \
        	--form-string "$MSG" \
        	https://api.pushover.net/1/messages.json
	fi
	exit 0

Save and close the file.

Now, copy that file to yout scripts folder (or where you want) and change permissions on it to allow execution:

	sudo cp pushoverLogin.sh /home/pi/scripts
	sudo chmod 755 /home/pi/scripts/pushoverLogin.sh

### Prepare for launch
Finally, we've 2 way to execute:

1. Edit /etc/pam.d/sshd and add a call to the script like follow. Use the script that you want (Pushbullet or Pushover). **Take care to add the line just next to "pam_selinux.so close"**:

		SOME CODE
		.............
		# SELinux needs to be the first session rule.  This ensures that any
		# lingering context has been cleared.  Without this it is possible that a
		# module could execute code in the wrong domain.
		session [success=ok ignore=ignore module_unknown=ignore default=bad]        pam_selinux.so close

		# My script
		#session required pam_exec.so seteuid /home/pi/scripts/pushbulletLogin.sh
		session required pam_exec.so seteuid /home/pi/scripts/pushoverLogin.sh

		# Set the loginuid process attribute.
		session    required     pam_loginuid.so

		# Create a new session keyring.
		session    optional     pam_keyinit.so force revoke
		............
		MORE CODE

2. Edit /etc/profile and add a call to the script at the end (same before, use your prefer script)
	
		# /etc/profile: system-wide .profile file for the Bourne shell (sh(1)) and...
 		...
 		SOME CODE (NOT CHANGE)
 		...
 		# My scripts
 		#/home/pi/scripts/pushbulletLogin.sh >/dev/null 2>/dev/null
		/home/pi/scripts/pushoverLogin.sh >/dev/null 2>/dev/null
 
*The command >/dev/null 2>/dev/null is for redirect the output messages to this directory, and not print on prompt*
