# float2fp16.py
import struct
import numpy as np

def loadtxtmethod(filename):
    data = np.loadtxt(filename,dtype=np.float32,delimiter=',')
    return data

dec_float = loadtxtmethod('C:/Users/Super_Liao/Desktop/A  LeNet专用加速器设计/验证文档-LXH/0 Input Files/Data_In&Out/output6.txt')

for i in range(len(dec_float)):

    # 十进制单精度浮点转16位16进制
    hexa = struct.unpack('H',struct.pack('e',dec_float[i]))[0]
    hexa = hex(hexa)
    hexa = hexa[2:]
    print(hexa) # 45e6

    # 写入txt：
    result2txt=str(hexa)          # 先将其转为字符串才能写入
    with open('C:/Users/Super_Liao/Desktop/A  LeNet专用加速器设计/验证文档-LXH/0 Input Files/Data_In&Out_fp16/output6.txt','a') as file_handle:   # .txt可以不自己新建,代码会自动新建
        file_handle.write(result2txt)     # 写入
        file_handle.write('\n')         # 自动转行

    # 16位16进制转十进制单精度浮点
    y = struct.pack("H",int(hexa,16))
    float = np.frombuffer(y, dtype =np.float16)[0]
    print(float) # 5.9
