%% 가져올 데이터의 주석 해제 %%
%% 데이터 불러오기(개활지)
gal10 = readtable('circle_galaxy10ENVs.txt');                    % galaxy10(개활지)
gal9 = readtable('circle_galaxy9ENVs.txt');                      % galaxy9(개활지)
iphone = readtable('circle_iphoneENVs.txt');                     % iphone(개활지)

%% 데이터 불러오기(난수신 환경)
%gal10 = readtable('ns_galaxy10ENVs.txt');                       % galaxy10(난수신환경)
%gal9 = readtable('ns_galaxy9ENVs.txt');                         % galaxy9(난수신환경)
%iphone = readtable('ns_iphoneENVs.txt');                        % iphone(난수신환경)

%% E, N 오차 그래프
figure(1) 
grid on
hold;
gal10_EN = plot(gal10{1:height(gal10),4},gal10{1:height(gal10),7},'rx');        % galaxy10의 E, N 오차 그래프
gal9_EN = plot(gal9{1:height(gal9),4},gal9{1:height(gal9),7},'bx');             % galaxy9의 E, N 오차 그래프
iphone_EN = plot(iphone{1:height(iphone),4},iphone{1:height(iphone),7},'gx');   % iphone의 E, N 오차 그래프
xline(0);                                                                       % ublox 원점(x)
yline(0);                                                                       % ublox 원점(y)
 
legend([gal10_EN gal9_EN iphone_EN],{'galaxy10','galaxy9','iphone'},'Location','northwest'); 
    xlabel('West - East(m)');
    ylabel('North - South(m)');
    axis tight;

%% V 오차 그래프
figure(2)
grid on
hold;
gal10_V = plot(gal10{1:height(gal10),1},gal10{1:height(gal10),10},'rx');        % galaxy10의 V오차 그래프
gal9_V = plot(gal9{1:height(gal9),1},gal9{1:height(gal9),10},'bx');             % galaxy9의 V 오차 그래프
iphone_V = plot(iphone{1:height(iphone),1},iphone{1:height(iphone),10},'gx');   % iphone의 V 오차 그래프
yline(0);                                                                       % ublox 원점(y)

legend([gal10_V gal9_V iphone_V],{'galaxy10','galaxy9','iphone'},'Location','northwest'); 
    xlabel('obs');
    ylabel('Vertical(m)');
    axis tight;