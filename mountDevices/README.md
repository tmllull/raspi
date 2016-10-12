#Mount USB or HDD on Raspi

Without connect your USB or HDD, use fdisk -l to see the devices

    sudo fdisk -l

Then, connect USB or HDD and use the same command to find your device. Usually is /dev/sda1, but depends that number of devices connected.

Now, make a new folder named usb, hdd, pendrive or what you want

    sudo mkdir /media/hdd

Edit fstab file

    sudo nano /etc/fstab

And add this line follow the other similars lines

    /dev/sda1   /media/hdd  ext4    defaults    0   0

*Note that the spacing are tabs, and ext4 is the filesystem that your device use

Update with

    sudo mount -a

Now, when you turn on your Raspi, this device are mounted automatically
