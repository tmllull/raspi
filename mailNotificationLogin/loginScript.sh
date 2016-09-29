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
        } | mail -s "$subject" mail@domain.com || exit 1;
else
        $PUSHBULLETOUT 2>/dev/null 1>/dev/null
fi
