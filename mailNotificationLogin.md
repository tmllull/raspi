## How to use
This is a simple script for [send an email](https://github.com/tmllull/raspi/tree/master/configureMail) when someone login into Raspi.
  
Create a new file loginScript.sh:

    #!/bin/bash

    if [ "$PAM_TYPE" != "close_session" ]; then
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
    fi
    
    exit 0

This script send an email with some information like where are connected, User, last connections, process... The lines *last* and *ps* are commented for minimize information, but just discomment for recieve all.

Edit /etc/pam.d/sshd and add a call to the script like follow. **Take care to add the line just next to "pam_selinux.so close"**:

		SOME CODE
		.............
		# SELinux needs to be the first session rule.  This ensures that any
		# lingering context has been cleared.  Without this it is possible that a
		# module could execute code in the wrong domain.
		session [success=ok ignore=ignore module_unknown=ignore default=bad]        pam_selinux.so close

		# My script
		session required pam_exec.so seteuid /home/pi/scripts/loginScript.sh

		# Set the loginuid process attribute.
		session    required     pam_loginuid.so

		# Create a new session keyring.
		session    optional     pam_keyinit.so force revoke
		............
		MORE CODE
