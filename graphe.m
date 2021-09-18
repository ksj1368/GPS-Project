%% ������ �������� �ּ� ���� %%
%% ������ �ҷ�����(��Ȱ��)
gal10 = readtable('circle_galaxy10ENVs.txt');                    % galaxy10(��Ȱ��)
gal9 = readtable('circle_galaxy9ENVs.txt');                      % galaxy9(��Ȱ��)
iphone = readtable('circle_iphoneENVs.txt');                     % iphone(��Ȱ��)

%% ������ �ҷ�����(������ ȯ��)
%gal10 = readtable('ns_galaxy10ENVs.txt');                       % galaxy10(������ȯ��)
%gal9 = readtable('ns_galaxy9ENVs.txt');                         % galaxy9(������ȯ��)
%iphone = readtable('ns_iphoneENVs.txt');                        % iphone(������ȯ��)

%% E, N ���� �׷���
figure(1) 
grid on
hold;
gal10_EN = plot(gal10{1:height(gal10),4},gal10{1:height(gal10),7},'rx');        % galaxy10�� E, N ���� �׷���
gal9_EN = plot(gal9{1:height(gal9),4},gal9{1:height(gal9),7},'bx');             % galaxy9�� E, N ���� �׷���
iphone_EN = plot(iphone{1:height(iphone),4},iphone{1:height(iphone),7},'gx');   % iphone�� E, N ���� �׷���
xline(0);                                                                       % ublox ����(x)
yline(0);                                                                       % ublox ����(y)
 
legend([gal10_EN gal9_EN iphone_EN],{'galaxy10','galaxy9','iphone'},'Location','northwest'); 
    xlabel('West - East(m)');
    ylabel('North - South(m)');
    axis tight;

%% V ���� �׷���
figure(2)
grid on
hold;
gal10_V = plot(gal10{1:height(gal10),1},gal10{1:height(gal10),10},'rx');        % galaxy10�� V���� �׷���
gal9_V = plot(gal9{1:height(gal9),1},gal9{1:height(gal9),10},'bx');             % galaxy9�� V ���� �׷���
iphone_V = plot(iphone{1:height(iphone),1},iphone{1:height(iphone),10},'gx');   % iphone�� V ���� �׷���
yline(0);                                                                       % ublox ����(y)

legend([gal10_V gal9_V iphone_V],{'galaxy10','galaxy9','iphone'},'Location','northwest'); 
    xlabel('obs');
    ylabel('Vertical(m)');
    axis tight;