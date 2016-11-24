#Create an SSH key

Use SSH keys to connect with your Raspi to have more recurity and quick connection.

First, we need to create a RSA key pair on your client machine (not on Raspi)

    ssh-keygen -t rsa
    
On the next questions, just press enter until you have a message similar to this:

    ssh-keygen -t rsa
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/user/.ssh/id_rsa): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/user/.ssh/id_rsa.
    Your public key has been saved in /home/user/.ssh/id_rsa.pub.
    The key fingerprint is:
    4a:dd:0a:c6:35:4e:3f:ed:27:38:8c:74:44:4d:93:67 user@a
    The key's randomart image is:
    +--[ RSA 2048]----+
    |          .oo.   |
    |         .  o.E  |
    |        + .  o   |
    |     . = = .     |
    |      = S = .    |
    |     o + = +     |
    |      . o + o .  |
    |           . o   |
    |                 |
    +-----------------+

The public key is saved on /home/user/.sshd/id_rsa.pub, and the private key on /home/user/.sshd/id_rsa. Note that user indicate your user name, and may be different.

The next step is copy your public key on Raspi

    ssh-copy-id user@123.45.56.78

*NOTE: If you're configured no-ip service, and you're not on your local network, change the last command for

    ssh-copy-id user@yourdomain.com
    
Answer "yes" when ask you, introduce your password for your Raspi login, and finally you'll reviced a message similar to:

    The authenticity of host '12.34.56.78 (12.34.56.78)' can't be established.
    RSA key fingerprint is b1:2d:33:67:ce:35:4d:5f:f3:a8:cd:c0:c4:48:86:12.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '12.34.56.78' (RSA) to the list of known hosts.
    user@12.34.56.78's password: 
    Now try logging into the machine, with "ssh 'user@12.34.56.78'", and check in:

      ~/.ssh/authorized_keys

    to make sure we haven't added extra keys that you weren't expecting.

Now, when you're loggin on your Raspi from your computer, doesn't ask for your password and loggin automatically.

#Delete stored SSH keys

If you want (or need) delete any stored SSH key, edit the file ~/.ssh/known_hosts and delete the line with the IP address/host name that you want to delete key and save.

    sudo nano ~/.ssh/known_hosts


sources:

https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2

https://www.raspberrypi.org/documentation/remote-access/ssh/passwordless.md

# Delete saved Key


