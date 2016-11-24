import serial
import time
a = serial.Serial('/dev/ttyACM0', 9600, serial.EIGHTBITS, serial.PARITY_NONE, serial.STOPBITS_ONE, None, False, False, None, False)
time.sleep(1)
#while True:
b = raw_input()
c = a.write(b)
print(b,c)
