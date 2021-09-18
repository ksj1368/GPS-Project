%% ������ �������� �ּ� ����, diary �̸� ���� �� ���� %%

%% data��������(��Ȱ��)
%phone = readtable('test4_iphone');              % iphone
%phone = readtable('test4_s10');                 % galaxy10
%phone = readtable('test4_s9');                  % galaxy9
%ublox = readtable('test4_ublox.txt');           % ublox

%% data ��������(������ȯ��)
%phone = readtable('ns3_iphone');                % iphone
%phone = readtable('ns3_s10');                   % galaxy10
phone = readtable('ns3_s9');                     % galaxy9
ublox = readtable('ns3_ublox.txt');              % ublox

diary ns_galaxy9ENVs.txt;                             % ���â�� ���� ����� �ؽ�Ʈ ���Ϸ� ���� ����

%% GRS80Ÿ��ü ����
a = 6378137.0;              % ��ݰ�
f = 1/298.257223563;        % �����
b = a*(1. - f);             % �ܹݰ�
aSQ = a^2;
bSQ = b^2;
 
%% �ݺ�Ƚ�� ����
mp = height(phone);  % ublox �ؽ�Ʈ ������ �� ����
mu = height(ublox);  % �ڵ��� �ؽ�Ʈ ������ �� ����
if mp>mu             % ���� ������ ���� �ؽ�Ʈ ���Ϸ� �ݺ� Ƚ�� ����          
   m = mu;
else
   m = mp;
end
 
%% �ڵ����� ����, �浵, �� ����
for i = 1:m
phone_lat = phone{i,3};                                          % �ڵ����� ����(��, ��)
phone_lat_int = fix(phone_lat*0.01);                             % �� ����
phone_lat_p = mod(phone_lat,phone_lat_int);                      % �� ����
phone_lat_rad = deg2rad(phone_lat_int + phone_lat_p/60);         % ��(degree) = (�� + ��/60) -> �������� ��ȯ

phone_lon = phone{i,5};                                          % �ڵ����� �浵(��, ��)
phone_lon_int = fix(phone_lon*0.01);                             % �� ����
phone_lon_p = mod(phone_lon,phone_lon_int);                      % �� ����
phone_lon_rad =deg2rad(phone_lon_int + phone_lon_p/60);          % ��(degree) = (�� + ��/60) -> �������� ��ȯ

phone_h = phone{i,10};                                           % �ڵ����� ��(m)

%% phone_XYZ
phone_clat = cos(phone_lat_rad);                                 % ���� ����
phone_clon = cos(phone_lon_rad);                                 % ���� ����
phone_slat = sin(phone_lat_rad);                                 % ���� ����       
phone_slon = sin(phone_lon_rad);                                 % ���� ����

phone_N0 = aSQ/sqrt(aSQ*(phone_clat)^2 + bSQ*(phone_slat)^2);    % �ڵ����� �ٻ�ġ

phone_X = (phone_N0+phone_h)*phone_clat*phone_clon;              % �ڵ����� X��ǥ
phone_Y = (phone_N0+phone_h)*phone_clat*phone_slon;              % �ڵ����� Y��ǥ
phone_Z = (phone_N0*(aSQ^2/bSQ^2)+phone_h)*phone_slon;           % �ڵ����� Z��ǥ

%% ublox(������)�� ����, �浵, �� ����
ublox_lat = ublox{i,3};                                          % ublox�� ����(��, ��)
ublox_lat_int = fix(ublox_lat*0.01);                             % �� ����
ublox_lat_p = mod(ublox_lat,ublox_lat_int);                      % �� ����
ublox_lat_rad = deg2rad(ublox_lat_int + ublox_lat_p/60);         % ��(degree) = (�� + ��/60) -> �������� ��ȯ

ublox_lon = ublox{i,5};                                          % ublox�� �浵(��, ��)
ublox_lon_int = fix(ublox_lon*0.01);                             % �� ����
ublox_lon_p = mod(ublox_lon,ublox_lon_int);                      % �� ����
ublox_lon_rad =deg2rad(ublox_lon_int + ublox_lon_p/60);          % ��(degree) = (�� + ��/60) -> �������� ��ȯ

ublox_h = ublox{i,12};                                           % ublox�� ��(m)

%% ublox_XYZ
ublox_clon = cos(ublox_lon_rad);                                 % ���� ����
ublox_clat = cos(ublox_lat_rad);                                 % ���� ����
ublox_slon = sin(ublox_lon_rad);                                 % ���� ����
ublox_slat = sin(ublox_lat_rad);                                 % ���� ����

ublox_N0 = aSQ/sqrt(aSQ*(ublox_clat)^2 + bSQ*(ublox_slat)^2);    % ublox�� �ٻ�ġ

ublox_X = (ublox_N0+ublox_h)*ublox_clat*ublox_clon;              % ublox�� X��ǥ
ublox_Y = (ublox_N0+ublox_h)*ublox_clat*ublox_slon;              % ublox�� Y��ǥ     
ublox_Z = (ublox_N0*(aSQ^2/bSQ^2)+ublox_h)*ublox_slon;           % ublox�� Z��ǥ

%% ENV ��ȯ �� ���� ���ϱ�
clon = cos(ublox_lon_rad);                       % ���� ����
clat = cos(ublox_lat_rad);                       % ���� ����
slon = sin(ublox_lon_rad);                       % ���� ����
slat = sin(ublox_lat_rad);                       % ���� ����

XYZtoENV = [-slon clon 0; 
            -slat*clon -slat*slon clat;
            clat*clon clat*slon slat];

dx = phone_X - ublox_X;                                          % ���� ����
dy = phone_Y - ublox_Y;                                          % ���� ����
dz = phone_Z - ublox_Z;                                          % ���� ����

XYZ = [dx; dy; dz];

ENV = XYZtoENV*XYZ;

fprintf('%d E : %10.8f N : %10.8f V : %10.8f\n', i,ENV(1),ENV(2),ENV(3)); % ������(E, N, V)
end

diary off % ���â�� ���� ����� �ؽ�Ʈ ���Ϸ� ���� ����