from numpy import linalg as la
import numpy as np

def MeanNstd(device, title):
## mean, std, RMSE
    E = []
    N = [] 
    V = []
    for i in range(len(device)):
        d = device[i].split(' ')                                               
        E.append(abs(float(d[1])))                     # E 방향 오차
        N.append(abs(float(d[2])))                     # N 방향 오차
        V.append(abs(float(d[3])))                    # V 방향 오차

    meanE = np.mean(E)
    meanN = np.mean(N)
    meanV = np.mean(V)
    stdE = np.std(E)
    stdN = np.std(N)
    stdV = np.std(V)
    device_ENV = [meanE, meanN, meanV]
    device_3D = la.norm(device_ENV)                    # 3차원 오차

    print(title)
    print("device_3D :", format(device_3D, ".5f"))
    print("mean :", format(meanE,".5f"),format(meanN,".5f"),format(meanV,".5f"))
    print("std :",format(stdE,".5f"),format(stdN,".5f"),format(stdV,".5f"),'\n')
    

## data가져오기(개활지)
iphone = open('C:/Users/JSJ/Desktop/output/OpenSpaceError_iphone.txt', 'rt').readlines()           # iphone
s10= open('C:/Users/JSJ/Desktop/output/OpenSpaceError_s10.txt', 'rt').readlines()                  # galaxy10
s9 = open('C:/Users/JSJ/Desktop/output/OpenSpaceError_s9.txt', 'rt').readlines()                   # galaxy9

## data 가져오기(난수신환경)
ns_iphone= open('C:/Users/JSJ/Desktop/output/NsSpaceError_iphone.txt', 'rt').readlines()               # iphone
ns_s10 = open('C:/Users/JSJ/Desktop/output/NsSpaceError_s10.txt', 'rt').readlines()                    # galaxy10
ns_s9 = open('C:/Users/JSJ/Desktop/output/NsSpaceError_s9.txt', 'rt').readlines()                      # galaxy9

MeanNstd(iphone, "개활지 iphone")
MeanNstd(s10,"개활지 s10")
MeanNstd(s9,"개활지 s9")
MeanNstd(ns_iphone,"난수신 환경 iphone")
MeanNstd(ns_s10,"난수신 환경 s10")
MeanNstd(ns_s9, "난수신 환경 s9")
