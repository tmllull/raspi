# OwnCloud config

http://www.electroensaimada.com/owncloud.html

Aparentment, s'ha de substituir la comanda "sudo cp -r owncloud /var/www" per "sudo cp -r owncloud /var/www/html".

Una vegada es pot accedir, i estem registrats, fer el següent per poder accedir des de fora:

https://github.com/greyltc/docker-owncloud/wiki/Access-your-ownCloud-server-from-a-URL-other-than-localhost

Modificar el final de la url per  "/index.php/settings/admin?trustDomain=elnostredomini.com"
