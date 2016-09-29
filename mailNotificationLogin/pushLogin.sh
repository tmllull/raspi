#!/bin/bash

API="YOURKEY"
MSG="Login from user $PAM_USER"
#MSG="Login from user $USER"

curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Raspi Alert" -d body="$MSG"

exit 0
