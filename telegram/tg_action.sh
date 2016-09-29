#!/bin/bash
tgpath=/home/pi/tg
cd ${tgpath}
bin/telegram-cli -k tg-server.pub -W -s action.lua
