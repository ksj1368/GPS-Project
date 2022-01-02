import numpy as np
import math
import sys
def LLHtoENV(phone, ublox, title):
    sys.stdout = open(title, 'w')   # 출력 결과 텍스트 파일로 저장
## GRS80타원체 정의
    a = 6378137.0               # 장반경
    f = 1/298.257223563         # 편평률
    b = a*(1. - f)              # 단반경
    aSQ = a*a 
    bSQ = b*b
    
    ## 반복횟수 지정
    mp = len(phone)   # 핸드폰 텍스트 파일의 행 갯수
    mu = len(ublox)   # ublox 텍스트 파일의 행 갯수
    if mp>mu:             # 행의 갯수가 적은 텍스트 파일로 반복 횟수 정의          
        m = mu
    else:
        m = mp
 
## 핸드폰의 위도, 경도, 고도 지정
    for i in range(0, m):
        p = phone[i].split(',')
        phone_lat = float(p[2])                                          # 핸드폰의 위도(도, 분)
        phone_lat_int = math.trunc(phone_lat*0.01)                       # 도 추출
        phone_lat_p = phone_lat%phone_lat_int                            # 분 추출
        phone_lat_rad = math.radians(phone_lat_int + phone_lat_p/60)     # 도(degree) = (도 + 분/60) -> 라디안으로 변환

        phone_lon = float(p[4])                                          # 핸드폰의 경도(도, 분)
        phone_lon_int = math.trunc(phone_lon*0.01)                       # 도 추출
        phone_lon_p = phone_lon%phone_lon_int                            # 분 추출
        phone_lon_rad =math.radians(phone_lon_int + phone_lon_p/60)      # 도(degree) = (도 + 분/60) -> 라디안으로 변환

        phone_h = float(p[9])                                            # 핸드폰의 고도(m)

        ## phone_XYZ
        phone_clat = math.cos(phone_lat_rad)                                  # 변수 선언
        phone_clon = math.cos(phone_lon_rad)                                  # 변수 선언
        phone_slat = math.sin(phone_lat_rad)                                  # 변수 선언       
        phone_slon = math.sin(phone_lon_rad)                                  # 변수 선언

        phone_N0 = aSQ/math.sqrt(aSQ*(phone_clat)**2 + bSQ*(phone_slat)**2)   # 핸드폰의 근사치
       
        phone_X = (phone_N0+phone_h)*phone_clat*phone_clon               # 핸드폰의 X좌표
        phone_Y = (phone_N0+phone_h)*phone_clat*phone_slon               # 핸드폰의 Y좌표
        phone_Z = (phone_N0*(aSQ**2/bSQ**2)+phone_h)*phone_slon          # 핸드폰의 Z좌표

        ## ublox(기준점)의 위도, 경도, 고도 지정
        u = ublox[i].split(',')
        ublox_lat = float(u[2])                                           # ublox의 위도(도, 분)
        ublox_lat_int = math.trunc(ublox_lat*0.01)                        # 도 추출
        ublox_lat_p = ublox_lat%ublox_lat_int                             # 분 추출
        ublox_lat_rad = math.radians(ublox_lat_int + ublox_lat_p/60)      # 도(degree) = (도 + 분/60) -> 라디안으로 변환

        ublox_lon = float(u[4])                                           # ublox의 경도(도, 분)
        ublox_lon_int = math.trunc(ublox_lon*0.01)                        # 도 추출
        ublox_lon_p = ublox_lon%ublox_lon_int                             # 분 추출
        ublox_lon_rad =math.radians(ublox_lon_int + ublox_lon_p/60)       # 도(degree) = (도 + 분/60) -> 라디안으로 변환

        ublox_h = float(u[9])                                             # ublox의 고도(m)

        ## ublox_XYZ
        ublox_clon = math.cos(ublox_lon_rad)                                  # 변수 선언
        ublox_clat = math.cos(ublox_lat_rad)                                  # 변수 선언
        ublox_slon = math.sin(ublox_lon_rad)                                  # 변수 선언
        ublox_slat = math.sin(ublox_lat_rad)                                  # 변수 선언

        ublox_N0 = aSQ/math.sqrt(aSQ*(ublox_clat)**2 + bSQ*(ublox_slat)**2)   # ublox의 근사치

        ublox_X = (ublox_N0+ublox_h)*ublox_clat*ublox_clon                    # ublox의 X좌표
        ublox_Y = (ublox_N0+ublox_h)*ublox_clat*ublox_slon                    # ublox의 Y좌표     
        ublox_Z = (ublox_N0*(aSQ**2/bSQ**2)+ublox_h)*ublox_slon               # ublox의 Z좌표

        ## ENV 변환 후 오차 구하기
        clon = math.cos(ublox_lon_rad)                        # 변수 선언
        clat = math.cos(ublox_lat_rad)                        # 변수 선언
        slon = math.sin(ublox_lon_rad)                        # 변수 선언
        slat = math.sin(ublox_lat_rad)                        # 변수 선언

        XYZtoENV = np.array([[-slon, clon, 0], [-slat*clon, -slat*slon, clat], [clat*clon, clat*slon, slat]]) 

        dx = phone_X - ublox_X                                           # 변수 선언
        dy = phone_Y - ublox_Y                                           # 변수 선언
        dz = phone_Z - ublox_Z                                           # 변수 선언

        XYZ = np.array([[dx], [dy], [dz]]) 

        ENV = np.dot(XYZtoENV,XYZ)
        
        print(i+1, format(*ENV[0], ".7f"), format(*ENV[1], ".7f"), format(*ENV[2], ".7f"), sep = ' ') # 오차값(E, N, V)
    sys.stdout.close() # 출력 결과를 저장한 텍스트 파일 닫기
      

## data가져오기(개활지)
iphone = open('C:/Users/JSJ/Desktop/GPS data/test4_iphone.txt', 'rt').readlines()           # iphone
s10= open('C:/Users/JSJ/Desktop/GPS data/test4_s10.txt', 'rt').readlines()                  # galaxy10
s9 = open('C:/Users/JSJ/Desktop/GPS data/test4_s9.txt', 'rt').readlines()                   # galaxy9
ublox = open('C:/Users/JSJ/Desktop/GPS data/test4_ublox.txt', 'rt').readlines()             # ublox

## data 가져오기(난수신환경)
ns_iphone= open('C:/Users/JSJ/Desktop/GPS data/ns3_iphone.txt', 'rt').readlines()               # iphone
ns_s10 = open('C:/Users/JSJ/Desktop/GPS data/ns3_s10.txt', 'rt').readlines()                    # galaxy10
ns_s9 = open('C:/Users/JSJ/Desktop/GPS data/ns3_s9.txt', 'rt').readlines()                      # galaxy9
ns_ublox = open('C:/Users/JSJ/Desktop/GPS data/ns3_ublox.txt', 'rt').readlines()                # ublox

## 오차값 저장(개활지)
LLHtoENV(iphone, ublox, 'OpenSpaceError_iphone.txt')
LLHtoENV(s10, ublox, 'OpenSpaceError_s10.txt')
LLHtoENV(s9, ublox, 'OpenSpaceError_s9.txt')

## 오차값 저장(난수신 환경)
LLHtoENV(ns_iphone, ns_ublox, 'NsSpaceError_iphone.txt')
LLHtoENV(ns_s10, ns_ublox, 'NsSpaceError_s10.txt')
LLHtoENV(ns_s9, ns_ublox, 'NsSpaceError_s9.txt')
