# float2fp16.py
import struct
import numpy as np

def loadtxtmethod(filename):
    data = np.loadtxt(filename,dtype=np.str,delimiter=',')
    return data

fp16_float = loadtxtmethod('C:/Users/Super_Liao/Desktop/A  LeNet专用加速器设计/验证文档-LXH/5 LeNet/debug/out_file_F7.txt')

for i in range(len(fp16_float)):

    hexa = int(fp16_float[i],16)
    print('0x%s'%hexa)
    hexa = hex(hexa)
    hexa = hexa[2:]

    # 十六进制转16位二进制
    bina = bin(int(hexa,16))
    print(bina)

    # 16位16进制转十进制单精度浮点
    y = struct.pack("H",int(hexa,16))
    float = np.frombuffer(y, dtype =np.float16)[0]
    print(float) 

    # 写入txt：
    result2txt=str(float)          # 先将其转为字符串才能写入
    with open('C:/Users/Super_Liao/Desktop/A  LeNet专用加速器设计/验证文档-LXH/5 LeNet/debug/out_file_F7_dec.txt','a') as file_handle:   # .txt可以不自己新建,代码会自动新建
        file_handle.write(result2txt)     # 写入
        file_handle.write('\n')         # 自动转行

    # 16位16进制转十进制单精度浮点
    y = struct.pack("H",int(hexa,16))
    float = np.frombuffer(y, dtype =np.float16)[0]
    print(float) # 5.9
