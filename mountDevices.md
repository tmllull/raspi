#Format and auto-mount USB or HDD on Raspi

First, we format our HDD or USB with our Raspi. This is recommended because sometimes we can have problems with permissions (using transmission, for example) if we mount a device formated with other machine.

Use fdisk -l to see the devices

    sudo fdisk -l

Usually if you connect only one HDD or USB, apears on /dev/sda1.

Now proceed to format:

    sudo fdisk /dev/sda

A new terminal menu apears, but the steps are:

- See the partition table with "p" (normally only have one)
- Delete this partition with "d"
- Create new partition with "n"

If ask you for a partition type, select primary (p). Then, just press Enter to leave default options.

Finally, press "p" for view partition table again to check the new partition.

With "w" save changes and exit.

In this point we have a new partition, but isn't format yet. For this, use:

    sudo mkfs.ext4 /dev/sda1

Select yes (y) for confirm.

Depends the size of the HDD, may take several time.

Now, make a new folder named usb, hdd, pendrive or what you want on /media

    sudo mkdir /media/hdd

Edit fstab file

    sudo nano /etc/fstab

And add this line follow the other similars lines

    /dev/sda1   /media/hdd  ext4    defaults    0   0

*Note that the spacing are tabs, and ext4 is the filesystem that your device use

Update with

    sudo mount -a

Now, when you turn on your Raspi, this device are mounted automatically
