%% 가져올 데이터의 주석 해제, diary 이름 변경 후 실행 %%

%% data가져오기(개활지)
%phone = readtable('test4_iphone');              % iphone
%phone = readtable('test4_s10');                 % galaxy10
%phone = readtable('test4_s9');                  % galaxy9
%ublox = readtable('test4_ublox.txt');           % ublox

%% data 가져오기(난수신환경)
%phone = readtable('ns3_iphone');                % iphone
%phone = readtable('ns3_s10');                   % galaxy10
phone = readtable('ns3_s9');                     % galaxy9
ublox = readtable('ns3_ublox.txt');              % ublox

diary ns_galaxy9ENVs.txt;                             % 명령창에 나온 결과를 텍스트 파일로 저장 시작

%% GRS80타원체 정의
a = 6378137.0;              % 장반경
f = 1/298.257223563;        % 편평률
b = a*(1. - f);             % 단반경
aSQ = a^2;
bSQ = b^2;
 
%% 반복횟수 지정
mp = height(phone);  % ublox 텍스트 파일의 행 갯수
mu = height(ublox);  % 핸드폰 텍스트 파일의 행 갯수
if mp>mu             % 행의 갯수가 적은 텍스트 파일로 반복 횟수 정의          
   m = mu;
else
   m = mp;
end
 
%% 핸드폰의 위도, 경도, 고도 지정
for i = 1:m
phone_lat = phone{i,3};                                          % 핸드폰의 위도(도, 분)
phone_lat_int = fix(phone_lat*0.01);                             % 도 추출
phone_lat_p = mod(phone_lat,phone_lat_int);                      % 분 추출
phone_lat_rad = deg2rad(phone_lat_int + phone_lat_p/60);         % 도(degree) = (도 + 분/60) -> 라디안으로 변환

phone_lon = phone{i,5};                                          % 핸드폰의 경도(도, 분)
phone_lon_int = fix(phone_lon*0.01);                             % 도 추출
phone_lon_p = mod(phone_lon,phone_lon_int);                      % 분 추출
phone_lon_rad =deg2rad(phone_lon_int + phone_lon_p/60);          % 도(degree) = (도 + 분/60) -> 라디안으로 변환

phone_h = phone{i,10};                                           % 핸드폰의 고도(m)

%% phone_XYZ
phone_clat = cos(phone_lat_rad);                                 % 변수 선언
phone_clon = cos(phone_lon_rad);                                 % 변수 선언
phone_slat = sin(phone_lat_rad);                                 % 변수 선언       
phone_slon = sin(phone_lon_rad);                                 % 변수 선언

phone_N0 = aSQ/sqrt(aSQ*(phone_clat)^2 + bSQ*(phone_slat)^2);    % 핸드폰의 근사치

phone_X = (phone_N0+phone_h)*phone_clat*phone_clon;              % 핸드폰의 X좌표
phone_Y = (phone_N0+phone_h)*phone_clat*phone_slon;              % 핸드폰의 Y좌표
phone_Z = (phone_N0*(aSQ^2/bSQ^2)+phone_h)*phone_slon;           % 핸드폰의 Z좌표

%% ublox(기준점)의 위도, 경도, 고도 지정
ublox_lat = ublox{i,3};                                          % ublox의 위도(도, 분)
ublox_lat_int = fix(ublox_lat*0.01);                             % 도 추출
ublox_lat_p = mod(ublox_lat,ublox_lat_int);                      % 분 추출
ublox_lat_rad = deg2rad(ublox_lat_int + ublox_lat_p/60);         % 도(degree) = (도 + 분/60) -> 라디안으로 변환

ublox_lon = ublox{i,5};                                          % ublox의 경도(도, 분)
ublox_lon_int = fix(ublox_lon*0.01);                             % 도 추출
ublox_lon_p = mod(ublox_lon,ublox_lon_int);                      % 분 추출
ublox_lon_rad =deg2rad(ublox_lon_int + ublox_lon_p/60);          % 도(degree) = (도 + 분/60) -> 라디안으로 변환

ublox_h = ublox{i,12};                                           % ublox의 고도(m)

%% ublox_XYZ
ublox_clon = cos(ublox_lon_rad);                                 % 변수 선언
ublox_clat = cos(ublox_lat_rad);                                 % 변수 선언
ublox_slon = sin(ublox_lon_rad);                                 % 변수 선언
ublox_slat = sin(ublox_lat_rad);                                 % 변수 선언

ublox_N0 = aSQ/sqrt(aSQ*(ublox_clat)^2 + bSQ*(ublox_slat)^2);    % ublox의 근사치

ublox_X = (ublox_N0+ublox_h)*ublox_clat*ublox_clon;              % ublox의 X좌표
ublox_Y = (ublox_N0+ublox_h)*ublox_clat*ublox_slon;              % ublox의 Y좌표     
ublox_Z = (ublox_N0*(aSQ^2/bSQ^2)+ublox_h)*ublox_slon;           % ublox의 Z좌표

%% ENV 변환 후 오차 구하기
clon = cos(ublox_lon_rad);                       % 변수 선언
clat = cos(ublox_lat_rad);                       % 변수 선언
slon = sin(ublox_lon_rad);                       % 변수 선언
slat = sin(ublox_lat_rad);                       % 변수 선언

XYZtoENV = [-slon clon 0; 
            -slat*clon -slat*slon clat;
            clat*clon clat*slon slat];

dx = phone_X - ublox_X;                                          % 변수 선언
dy = phone_Y - ublox_Y;                                          % 변수 선언
dz = phone_Z - ublox_Z;                                          % 변수 선언

XYZ = [dx; dy; dz];

ENV = XYZtoENV*XYZ;

fprintf('%d E : %10.8f N : %10.8f V : %10.8f\n', i,ENV(1),ENV(2),ENV(3)); % 오차값(E, N, V)
end

diary off % 명령창에 나온 결과를 텍스트 파일로 저장 종료