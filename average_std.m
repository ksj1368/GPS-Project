%% 가져올 데이터의 주석 해제 %%
%% 데이터 불러오기(개활지)
gal10 = readtable('circle_galaxy10ENVs.txt');                    % galaxy10
gal9 = readtable('circle_galaxy9ENVs.txt');                      % galaxy9
iphone = readtable('circle_iphoneENVs.txt');                     % iphone

%% 데이터 불러오기(난수신 환경)
%gal10 = readtable('ns_galaxy10ENV.txt');                       % galaxy10
%gal9 = readtable('ns_galaxy9ENV.txt');                         % galaxy9
%iphone = readtable('ns_iphoneENV.txt');                        % iphone

%% 갤럭시10의 평균, 표준편차(E, N, V)
gal10_meanE = mean(abs(gal10{1:height(gal10),4}));                  % E의 평균
gal10_meanN = mean(abs(gal10{1:height(gal10),7}));                  % N의 평균
gal10_meanV = mean(abs(gal10{1:height(gal10),10}));                 % V의 평균

gal10_stdE = std(abs(gal10{1:height(gal10),4}));                    % E의 표준편차
gal10_stdN = std(abs(gal10{1:height(gal10),7}));                    % N의 표준편차
gal10_stdV = std(abs(gal10{1:height(gal10),10}));                   % V의 표준편차
gal10_ENV= [gal10_meanE gal10_meanN gal10_meanV];
gal10_3D = norm(gal10_ENV);                                         % 갤럭시10의 3차원 오차

%% 갤럭시9의 평균, 표준편차(E, N, V)
gal9_meanE = mean(abs(gal9{1:height(gal9),4}));                     % E의 평균
gal9_meanN = mean(abs(gal9{1:height(gal9),7}));                     % N의 평균
gal9_meanV = mean(abs(gal9{1:height(gal9),10}));                    % V의 평균

gal9_stdE = std(abs(gal9{1:height(gal9),4}));                       % E의 표준편차
gal9_stdN = std(abs(gal9{1:height(gal9),7}));                       % N의 표준편차
gal9_stdV = std(abs(gal9{1:height(gal9),10}));                      % V의 표준편차

gal9_ENV=[gal9_meanE gal9_meanN gal9_meanV];     
gal9_3D = norm(gal9_ENV);                                           % 갤럭시9의 3차원 오차

%% 아이폰의 평균, 표준편차(E, N, V)
iphone_meanE = mean(abs(iphone{1:height(iphone),4}));               % E의 평균
iphone_meanN = mean(abs(iphone{1:height(iphone),7}));               % N의 평균
iphone_meanV = mean(abs(iphone{1:height(iphone),10}));              % V의 평균

iphone_stdE = std(abs(iphone{1:height(iphone),4}));                 % E의 표준편차
iphone_stdN = std(abs(iphone{1:height(iphone),7}));                 % N의 표준편차
iphone_stdV = std(abs(iphone{1:height(iphone),10}));                % V의 표준편차
iphone_ENV=[iphone_meanE iphone_meanN iphone_meanV];     
iphone_3D = norm(iphone_ENV);                                       % 아이폰의 3차원 오차

fprintf('E 오차 평균 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_meanE,gal9_meanE, iphone_meanE);
fprintf('N 오차 평균 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_meanN,gal9_meanN, iphone_meanN);
fprintf('V 오차 평균 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_meanV,gal9_meanV, iphone_meanV);

fprintf('E 오차 표준편차 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_stdE,gal9_stdE, iphone_stdE);
fprintf('N 오차 표준편차 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_stdN,gal9_stdN, iphone_stdN);
fprintf('V 오차 표준편차 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f\n' ,gal10_stdV,gal9_stdV, iphone_stdV);

fprintf('3차원 오차 -> galaxy10 : %5.10f galaxy9 : %5.10f iphone : %5.10f' ,gal10_3D,gal9_3D, iphone_3D);
