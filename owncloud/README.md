# Configure OwnCloud on your Raspi

To use OwnCloud, is recommended have an external HDD or USB with mínimum 16/32GB and [mount this device] (https://github.com/tmllull/raspi/tree/master/mountDevices) and have an [Static IP for the Raspi] (https://github.com/tmllull/raspi/tree/master/staticIP)

Once we have our HDD/USB mounted, we need to update and upgrade our Raspi

    sudo apt-get update && sudo apt-get upgrade

To use OwnCloud, web need to install Apache server

    sudo apt-get install apache2 php5 php5-json php5-gd php5-sqlite curl libcurl3 libcurl3-dev php5-curl php5-common php-xml-parser

Then, install SQLite

    sudo apt-get install sqlite

Now, download OwnCloud. I use the 9.1.1 version

    wget https://download.owncloud.org/community/owncloud-9.1.1.tar.bz2

And extract

    tar -xjf owncloud-9.1.1.tar.bz2

At this point, copy the folder owncloud in /var/www

    sudo cp -r owncloud /var/www

And change owner/group to the www folder and your HDD or USB mounted folder

    sudo chown -R www-data:www-data /var/www
    sudo chown -R www-data:www-data /media/hdd

*NOTE: If when you finish all the steps, you can't acces to the OwnCloud, try to copy the folder owncloud to /var/www/html, and change the permissions to this folder too.

The last steps are create a few folder on our HDD/USB to use with OwnCloud and change owner

    sudo mkdir /media/hdd/owncloud
    sudo mkdir /media/hdd/owncloud/data
    sudo chown -R www-data:www-data /media/hdd/owncloud/data 

Now, restart apache

    sudo service apache2 restart

To try it, you can access to your IP address with /owncloud port, like this:

http://192.168.1.13/owncloud

*Change 192.168.1.13 with your local IP address

The first time, we need to create a new user and pass for the admin, and change the route for data on the advance settings, typing our route (/media/hdd/owncloud/data).

## Change maximun file size

The default settings for files size is limited to 2MB. To edit this, open the config file

    sudo nano /etc/php5/apache2/php.ini

Change the _post_max_size_ and _upload_max_filesize_. I put 10000M, but you can change for any other value.

And restart Apache

    sudo service apache2 restart


## Access to OwnCloud from any device (not only on local net)

If you want to acces to your OwnCloud from other devices that not are in the same local net, you need to [configure no-ip](https://github.com/tmllull/raspi/tree/master/no-ip)

Then, just loggin to your OwnCloud from your local IP address as admin, and change the final address on your browser for this

    .../index.php/settings/admin?trustDomain=yourdomain.com

*Change "yourdomain.com" for your domain to access to the Raspi.

You'll get an alert box to add this domain to the trust domains.

*NOTE: If you can access to your OwnCloud from other net, try to open de 80 port from your router.
