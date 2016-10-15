#!/bin/bash

MSG="message=Login from user $PAM_USER"

if [ "$PAM_TYPE" != "close_session" ]; then
curl -s \
        --form-string "token=APPTOKEN" \
        --form-string "user=USERTOKEN" \
        --form-string "$MSG" \
        https://api.pushover.net/1/messages.json
fi
exit 0
