# int2fp16.py
from ast import For
import struct
import numpy as np
import math

dec_float = -38
#计算tanh
tanh_dec = math.tanh(dec_float)
print(tanh_dec)

# 十进制单精度浮点转16位16进制
hexa = struct.unpack('H',struct.pack('e',dec_float))[0]
hexa = hex(hexa)
hexa = hexa[2:]
print(hexa)

# 十六进制转16位二进制
bina = bin(int(hexa,16))
print(bina)

# 16位16进制转十进制单精度浮点
y = struct.pack("H",int(hexa,16))
float = np.frombuffer(y, dtype =np.float16)[0]
print(float) 

"""
#计算exp

dec_float = math.exp(-0.96)
# 十进制单精度浮点转16位16进制
hexa = struct.unpack('H',struct.pack('e',dec_float))[0]
hexa = hex(hexa)
hexa = hexa[2:]
print(hexa) # 45e6

# 16位16进制转十进制单精度浮点
y = struct.pack("H",int(hexa,16))
float = np.frombuffer(y, dtype =np.float16)[0]
print(float) # 5.9
"""


"""
for i in [1,2,3,4,5,6]:
    dec_float = 1/i
    # 十进制单精度浮点转16位16进制
    hexa = struct.unpack('H',struct.pack('e',dec_float))[0]
    hexa = hex(hexa)
    hexa = hexa[2:]
    print(hexa) # 45e6

    # 16位16进制转十进制单精度浮点
    y = struct.pack("H",int(hexa,16))
    float = np.frombuffer(y, dtype =np.float16)[0]
    print(float) # 5.9
"""
