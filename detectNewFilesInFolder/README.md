# Detect new files on folder

A usefull feature to use with a Raspi is detect new files on folders, for example when you use it for Torrent server. This is a little script using inotify-tools to make something when detect a new file.

Firts, install inotify-tools

    sudo apt-get install inotify-tools
    
Create a new file:

    nano detect_files.sh

And add this code:

    #!/bin/sh
    MONITORDIR="/path/to/the/dir/to/monitor/"
    inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" | while read NEWFILE
    do
        Make that you want, like send an email, push notification, etc.
    done

If you want to monitor diferents folder, use this:

    #!/bin/sh
    MONITORDIR1="/path/to/the/dir/to/monitor1/"
    MONITORDIR2="/path/to/the/dir/to/monitor2/"
    MONITORDIRX="/path/to/the/dir/to/monitorx/"    

    monitor() {
    inotifywait -m -r -e create --format "%f" "$1" | while read NEWFILE
    do
        Make that you want, like send an email, push notification, etc.
    done
    }
    monitor "$MONITORDIR1" &
    monitor "$MONITORDIR2" &
    monitor "$MONITORDIRX" &

Add execution persmissions:

    sudo chmod +x yourscript.sh
    
And execute it using nohup command, for allow the script running when you logout from your session:

    nohup yourscript.sh &

sources:

https://github.com/rvoicilas/inotify-tools/wiki

http://superuser.com/questions/956311/continuously-detect-new-files-with-inotify-tools-within-multiple-directories-r

https://techarena51.com/index.php/inotify-tools-example/

http://stackoverflow.com/questions/18692134/continuously-monitor-a-directory-in-linux-and-notify-when-a-new-file-is-availabl
