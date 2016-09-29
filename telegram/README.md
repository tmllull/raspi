# Telegram

## How to install Telegram on Raspi

Here explain how I install Telegram on my Raspi, following some posts (referals at bottom), because I've a few problems during the installation, so I "combine" them and with this steps, it works.

First, we need to update and upgrade our Raspi:

    sudo apt-get update
    sudo apt-get upgrade

May take a lot of time, so be patient ;)

Install some libs:

    sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make

Now, we need to clone a Github project:

    git clone --recursive https://github.com/vysheng/tg.git && cd tg

Configure:

    ./configure

And make:

    make

For start client, just type:

    bin/telegram-cli -k tg-server.pub -W

At this point, I had a problem:

    pi@raspberrypi:~/tg $ bin/telegram-cli -k tg-server.pub -W
    Telegram-cli version 1.4.1, Copyright (C) 2013-2015 Vitaly Valtman
    Telegram-cli comes with ABSOLUTELY NO WARRANTY; for details type `show_license'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show_license' for details.
    Telegram-cli uses libtgl version 2.1.0
    Telegram-cli includes software developed by the OpenSSL Project
    for use in the OpenSSL Toolkit. (http://www.openssl.org/)
    I: config dir=[/home/pi/.telegram-cli]
    > telegram-cli: tgl/mtproto-utils.c:101: BN2ull: Assertion `0' failed.
    SIGNAL received

If you've this message when launch the client the first time, try to comment lines 101 and 115 on tgl/mtproto-utils.c and recompiling.

The first time that you launch Telegram client, you must enter your phone number with land code (+34 for Spain) and you receive a code on your phone. Enter this code and that's all.

For send a message, just type:

    msg Name_Lastname message
        
*Use underscore (_) for separate name and lastname*

## Quick message

We can make a little script for create a command for send a message easier. Create a new file .sh on your home, or in the forlder for your scripts (if you'va one):

    sudo nano /home/pi/scripts tg.sh

In this file, copy the follow code:

    #!/bin/bash
    to=$1
    msg=$2
    tgpath=/home/pi/tg
    cd ${tgpath}
    cmd="bin/telegram-cli -W -k server.pub -e \"msg $to $msg\""
    eval $cmd

*Note that tgpath must be the exact route to the main folder tg*

Remember to give it execution permissions:

    sudo chmod 0655 /home/pi/scripts/tg.sh

To use this script, just type:

    /home/pi/scripts/tg.sh Name_Lastname Message

## Autoresponse

We can use Telegram in Raspi like a "bot", that response with a predefined message (or make an specific thing) depending on the message recevied. We use Lua in this case.

Create a new file named action.lua, for example, in the tg folder:

    sudo nano /home/pi/tg/action.lua

And copy this:

    function on_msg_receive (msg)
      if msg.out then
          return
      end
      if (msg.text=='ping') then
         send_msg (msg.from.print_name, 'pong', ok_cb, false)
      end
    end
   
    function on_our_id (id)
    end
   
    function on_secret_chat_created (peer)
    end
   
    function on_user_update (user)
    end
   
    function on_chat_update (user)
    end
   
    function on_get_difference_end ()
    end
   
    function on_binlog_replay_end ()
    end

With this code, when receive a message with "ping" (without quotes), automatically send a "pong" response. Just works with "ping", and not with "PING" or "Ping".

For launch, use:

    bin/telegram-cli -k tg-server.pub -W -s action.lua

You can change the trigger message or response.

I made a little script in bash for launch this easier:

    sudo nano /home/pi/scripts/tg_action.sh

With this code:

    #!/bin/bash
    tgpath=/home/pi/tg
    cd ${tgpath}
    bin/telegram-cli -k tg-server.pub -W -s action.lua

And give it execution permissions:

    sudo chmod 0655 /home/pi/scripts/tg_action.sh

## Original source

[vysheng/tg](https://github.com/vysheng/tg)

## Other referals

[Instructables](http://www.instructables.com/id/Telegram-on-Raspberry-Pi/)

[Instructables](http://www.instructables.com/id/Raspberry-remote-control-with-Telegram/)

[EmmeShop](http://www.blog.emmeshop.eu/?q=node/44)

[Raspberrypihelp](http://raspberrypihelp.net/raspberry-pi-telegram/)

