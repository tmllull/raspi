# Install Arduino IDE

Commands:

    sudo apt-get update
    sudo apt-get install arduino


# Developing Arduino in Raspi (Not IDE)

Commands:

    sudo apt-get update 
    sudo apt-get install arduino
    sudo apt-get install python-dev&&python-setuptools
    git clone git://github.com/amperka/ino.git
    cd ino
    sudo python setup.py install

### For init files

    ino init              # initiates blank project
    ino init -t blink      # initiates a project using "blink" as a template, copy libraries into 
    ino build               # compiles the sketch, creating .hex file (default Arduino uno -m atmega328 for duemilanove)
    ino upload             # uploads the .hex file

### Links python libs...

http://rdiaz.es/blog/comunicacion-entre-raspberry-pi-y-arduino-por-usb/?lang=en

    sudo apt-get install python-dev&&python-setuptools
    sudo apt-get install python-serial

### Disable AutoReset

For disable autoreset when open new serial connection, connect a 100uf from GND to Reset pins.

link: http://playground.arduino.cc/Main/DisablingAutoResetOnSerialConnection
