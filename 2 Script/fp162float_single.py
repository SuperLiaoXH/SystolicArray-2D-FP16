# fp162float.py
from ast import For
import struct
import numpy as np
import math

hexa = 0x4198
print('0x%x'%hexa)
hexa = hex(hexa)
hexa = hexa[2:]

# 十六进制转16位二进制
bina = bin(int(hexa,16))
print(bina)

# 16位16进制转十进制单精度浮点
y = struct.pack("H",int(hexa,16))
float = np.frombuffer(y, dtype =np.float16)[0]
print(float) 
