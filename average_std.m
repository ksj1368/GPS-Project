%% ������ �������� �ּ� ���� %%
%% ������ �ҷ�����(��Ȱ��)
gal10 = readtable('circle_galaxy10ENVs.txt');                    % galaxy10
gal9 = readtable('circle_galaxy9ENVs.txt');                      % galaxy9
iphone = readtable('circle_iphoneENVs.txt');                     % iphone

%% ������ �ҷ�����(������ ȯ��)
%gal10 = readtable('ns_galaxy10ENV.txt');                       % galaxy10
%gal9 = readtable('ns_galaxy9ENV.txt');                         % galaxy9
%iphone = readtable('ns_iphoneENV.txt');                        % iphone

%% ������10�� ���, ǥ������(E, N, V)
gal10_meanE = mean(abs(gal10{1:height(gal10),4}));                  % E�� ���
gal10_meanN = mean(abs(gal10{1:height(gal10),7}));                  % N�� ���
gal10_meanV = mean(abs(gal10{1:height(gal10),10}));                 % V�� ���

gal10_stdE = std(abs(gal10{1:height(gal10),4}));                    % E�� ǥ������
gal10_stdN = std(abs(gal10{1:height(gal10),7}));                    % N�� ǥ������
gal10_stdV = std(abs(gal10{1:height(gal10),10}));                   % V�� ǥ������
gal10_ENV= [gal10_meanE gal10_meanN gal10_meanV];
gal10_3D = norm(gal10_ENV);                                         % ������10�� 3���� ����

%% ������9�� ���, ǥ������(E, N, V)
gal9_meanE = mean(abs(gal9{1:height(gal9),4}));                     % E�� ���
gal9_meanN = mean(abs(gal9{1:height(gal9),7}));                     % N�� ���
gal9_meanV = mean(abs(gal9{1:height(gal9),10}));                    % V�� ���

gal9_stdE = std(abs(gal9{1:height(gal9),4}));                       % E�� ǥ������
gal9_stdN = std(abs(gal9{1:height(gal9),7}));                       % N�� ǥ������
gal9_stdV = std(abs(gal9{1:height(gal9),10}));                      % V�� ǥ������

gal9_ENV=[gal9_meanE gal9_meanN gal9_meanV];     
gal9_3D = norm(gal9_ENV);                                           % ������9�� 3���� ����

%% �������� ���, ǥ������(E, N, V)
iphone_meanE = mean(abs(iphone{1:height(iphone),4}));               % E�� ���
iphone_meanN = mean(abs(iphone{1:height(iphone),7}));               % N�� ���
iphone_meanV = mean(abs(iphone{1:height(iphone),10}));              % V�� ���

iphone_stdE = std(abs(iphone{1:height(iphone),4}));                 % E�� ǥ������
iphone_stdN = std(abs(iphone{1:height(iphone),7}));                 % N�� ǥ������
iphone_stdV = std(abs(iphone{1:height(iphone),10}));                % V�� ǥ������
iphone_ENV=[iphone_meanE iphone_meanN iphone_meanV];     
iphone_3D = norm(iphone_ENV);                                       % �������� 3���� ����

fprintf('E ���� ��� -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_meanE,gal9_meanE, iphone_meanE);
fprintf('N ���� ��� -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_meanN,gal9_meanN, iphone_meanN);
fprintf('V ���� ��� -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_meanV,gal9_meanV, iphone_meanV);

fprintf('E ���� ǥ������ -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_stdE,gal9_stdE, iphone_stdE);
fprintf('N ���� ǥ������ -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_stdN,gal9_stdN, iphone_stdN);
fprintf('V ���� ǥ������ -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_stdV,gal9_stdV, iphone_stdV);

fprintf('3���� ���� -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f' ,gal10_3D,gal9_3D, iphone_3D);
