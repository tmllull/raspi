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
        } | mail -s "$subject" mail@domain.com || exit 1;
fi
exit 0
