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
