% %% script for running the function simulate_usct(...)
% clear; close all;
% for j = 3:10
%
%     for i = 2:5
%         myfilename = sprintf('Group%dERate5IRate02Num%d', j, i);
%         load(myfilename);
%         param = makeParam( 0.125,0.125,400,400,0 );
%         param.source.point_map = cast(linspace(1,100,100),'int8');
%         myfilename = sprintf('2018_04_26_Group%dERate5IRate02Num%d',j, i);
%         dst_path = myfilename;
%         simulate_usct(param, medium, dst_path);
%     end
%     for i = 1:4
%         myfilename = sprintf('Group%dERate%dIRate02Num3',j, i);
%         load(myfilename);
%         param = makeParam( 0.125,0.125,400,400,0 );
%         param.source.point_map = cast(linspace(1,100,100),'int8');
%         myfilename = sprintf('2018_04_26_Group%dERate%dIRate02Num3', j,i);
%         dst_path = myfilename;
%         simulate_usct(param, medium, dst_path);
%     end
%     for i = 4:2:8
%         myfilename = sprintf('Group%dERate5IRate0%dNum3', j, i);
%         load(myfilename);
%         param = makeParam( 0.125,0.125,400,400,0 );
%         param.source.point_map = cast(linspace(1,100,100),'int8');
%         myfilename = sprintf('2018_04_26_Group%dERate5IRate0%dNum3',j, i);
%         dst_path = myfilename;
%         simulate_usct(param, medium, dst_path);
%     end
%     myfilename = sprintf('Group%dERate5IRate10Num3',j);
%     load(myfilename);
%     param = makeParam( 0.125,0.125,400,400,0 );
%     param.source.point_map = cast(linspace(1,100,100),'int8');
%     myfilename = sprintf('2018_04_26_Group%dERate5IRate10Num3',j);
%     dst_path = myfilename;
%     simulate_usct(param, medium, dst_path);
% end
%
% %% TOFマップ作成 Group%d
% for j = 3:10
%     for i = 1:5
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
%         myfilename = sprintf('2018_04_26_Group%dERate5IRate02Num%d', j, i);
%         cd(myfilename);
%         load('kgrid.mat')
%         load('rfdata.mat')
%         tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate02Num%d', j,i);
%         save(myfilename,'tof_data');
%     end
%     for i = 1:4
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
%         myfilename = sprintf('2018_04_26_Group%dERate%dIRate02Num3', j,i);
%         cd(myfilename);
%         load('kgrid.mat')
%         load('rfdata.mat')
%         tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate%dIRate02Num3', j,i);
%         save(myfilename,'tof_data');
%     end
%     for i = 4:2:8
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
%         myfilename = sprintf('2018_04_26_Group%dERate5IRate0%dNum3', j,i);
%         cd(myfilename);
%         load('kgrid.mat')
%         load('rfdata.mat')
%         tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate0%dNum3', i);
%         save(myfilename,'tof_data');
%     end
%
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
%     myfilename = sprintf('2018_04_26_Group%dERate5IRate10Num3',j);
%     cd(myfilename);
%     load('kgrid.mat')
%     load('rfdata.mat')
%     tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate10Num3',j);
%     save(myfilename,'tof_data');
%     %% 平均音速算出(配列定義) Group%d
%     tof_cell  = zeros(200,100,5,5,5);%{Receiver, Transmitter, ERate, IRate, Num, }
%     aveSOS = zeros(5,5,5);%{ERate, IRate, Num}
%     for i = 1:5
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate02Num%d',j, i);
%         load(myfilename,'tof_data');
%         tof_cell(:,:,5,1,i) = tof_data;
%     end
%     for i = 1:4
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate%dIRate02Num3', j,i);
%         load(myfilename,'tof_data');
%         tof_cell(:,:,i,1,3) = tof_data;
%     end
%     for i = 4:2:8
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate0%dNum3', j,i);
%         load(myfilename,'tof_data');
%         tof_cell(:,:,5,i/2,3) = tof_data;
%     end
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate10Num3',j);
%     load(myfilename,'tof_data');
%     tof_cell(:,:,5,5,3) = tof_data;
%     myfilename = sprintf('2018_04_27_Group%dallTOFdata_matrix',j);
%     save(myfilename,'tof_cell');
%     %% 平均音速算出（メイン） Group%d
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_27_Group%dallTOFdata_matrix',j);
%     load(myfilename,'tof_cell');
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
%     myfilename = sprintf('2018_04_26_Group%dERate5IRate02Num3',j);
%     cd(myfilename);
%     load('kgrid.mat')
%     param = makeParam( 0.125,0.125,400,400,0 );
%     param.source.point_map = cast(linspace(1,100,100),'int8');
%     t_size = 40.e-3;
%     t_num = 200;%トランスデューサ数
%     t_pos = zeros(2, t_num);%センサ位置
%     t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
%     t_pos(2,1:t_num/2) = t_size/2;
%     t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
%     t_pos(2,t_num/2+1:t_num) = -t_size/2;
%     sensor.mask=t_pos;
%     leng = zeros(1,100);
%     for i = 1:5
%         [Min,ind]= min(tof_cell(101:end,:,i,1,3));
%         ind = ind+100;
%         for j = 1: t_num/2
%             leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
%         end
%         aveSOS(i,1,3) = mean(leng./Min);
%     end
%     for i = 1:5
%         if i == 3
%             continue
%         end
%         [Min,ind]= min(tof_cell(101:end,:,5,1,i));
%         ind = ind+100;
%         for j = 1: t_num/2
%             leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
%         end
%         aveSOS(5,1,i) = mean(leng./Min);
%     end
%     for i = 2:5
%         [Min,ind]= min(tof_cell(101:end,:,5,i,3));
%         ind = ind+100;
%         for j = 1: t_num/2
%             leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
%         end
%         aveSOS(5,i,3) = mean(leng./Min);
%     end
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_28_Group%daveSOS',j);
%     save(myfilename,'aveSOS');
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% script for running the function simulate_usct(...)Group1 Erate = 6:2:20
clear; close all;
for i = 1:5
    if i == 2
        continue;
    end
    if i == 3
        continue;
    end
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\data\kwave\medium\2018_04_26_randomScatter');
    myfilename = sprintf('Group1ERate5IRate02Num%d-2', i);
    load(myfilename);
    param = makeParam( 0.125,0.125,400,400,0 );
    param.source.point_map = cast(linspace(1,100,100),'int8');
    myfilename = sprintf('2018_04_26_Group1ERate5IRate02Num%d-2' ,i);
    dst_path = myfilename;
    simulate_usct(param, medium, dst_path);
end
for i = 1:4
    if i == 2
        continue;
    end
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\data\kwave\medium\2018_04_26_randomScatter');
    myfilename = sprintf('Group1ERate%dIRate02Num3-2', i);
    load(myfilename);
    param = makeParam( 0.125,0.125,400,400,0 );
    param.source.point_map = cast(linspace(1,100,100),'int8');
    myfilename = sprintf('2018_04_26_Group1ERate%dIRate02Num3-2' ,i);
    dst_path = myfilename;
    simulate_usct(param, medium, dst_path);
end
for i = 4:2:8
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\data\kwave\medium\2018_04_26_randomScatter');
    myfilename = sprintf('Group1ERate5IRate0%dNum3-2', i);
    load(myfilename);
    param = makeParam( 0.125,0.125,400,400,0 );
    param.source.point_map = cast(linspace(1,100,100),'int8');
    myfilename = sprintf('2018_04_26_Group1ERate5IRate0%dNum3-2' ,i);
    dst_path = myfilename;
    simulate_usct(param, medium, dst_path);
end
for i = 6:2:20
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\data\kwave\medium\2018_04_26_randomScatter');
    myfilename = sprintf('Group1ERate%dIRate02Num3-2', i);
    load(myfilename);
    param = makeParam( 0.125,0.125,400,400,0 );
    param.source.point_map = cast(linspace(1,100,100),'int8');
    myfilename = sprintf('2018_04_26_Group1ERate%dIRate02Num3-2' ,i);
    dst_path = myfilename;
    simulate_usct(param, medium, dst_path);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TOFマップ作成 Group1-2
for i = 1:5
    if i == 2
        continue;
    end
    if i ==3
        continue;
    end
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
    myfilename = sprintf('2018_04_26_Group1ERate5IRate02Num%d-2', i);
    cd(myfilename);
    load('kgrid.mat')
    load('rfdata.mat')
    tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate02Num%d-2',i);
    save(myfilename,'tof_data');
end
for i = 1:4
    if i == 2
        continue;
    end
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
    myfilename = sprintf('2018_04_26_Group1ERate%dIRate02Num3-2', i);
    cd(myfilename);
    load('kgrid.mat')
    load('rfdata.mat')
    tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate%dIRate02Num3-2',i);
    save(myfilename,'tof_data');
end
for i = 4:2:8
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
    myfilename = sprintf('2018_04_26_Group1ERate5IRate0%dNum3-2', i);
    cd(myfilename);
    load('kgrid.mat')
    load('rfdata.mat')
    tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate0%dNum3-2',i);
    figure;imagesc(tof_data);
    save(myfilename,'tof_data');
end
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
myfilename = sprintf('2018_04_26_Group1ERate5IRate10Num3-2');
cd(myfilename);
load('kgrid.mat')
load('rfdata.mat')
tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate10Num3-2');
save(myfilename,'tof_data');
for i = 6:2:20
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
    myfilename = sprintf('2018_04_26_Group1ERate%dIRate02Num3-2', i);
    cd(myfilename);
    load('kgrid.mat')
    load('rfdata.mat')
    tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate%dIRate02dNum3-2',i);
    save(myfilename,'tof_data');
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 平均音速算出(配列定義) Group1 Erate = 6:2:20
tof_cell  = zeros(200,100,20,5,5);%{Receiver, Transmitter, ERate, IRate, Num, }
aveSOS = zeros(20,5,5);%{ERate, IRate, Num}
steSOS = zeros(20,5,5);
for i = 1:5
    if i == 2
        continue;
    end
    if i == 3
        continue;
    end
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate02Num%d-2', i);
    load(myfilename,'tof_data');
    tof_cell(:,:,5,1,i) = tof_data;
end
for i = 2:3
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate02Num%d-2', i);
    load(myfilename,'tof_data');
    tof_cell(:,:,5,1,i) = tof_data;
end
for i = 1:4
    if i == 2
        continue;
    end
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate%dIRate02Num3-2', i);
    load(myfilename,'tof_data');
    tof_cell(:,:,i,1,3) = tof_data;
end
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
myfilename = sprintf('2018_04_27_TOFdata_Group1ERate2IRate02Num3-2');
load(myfilename,'tof_data');
tof_cell(:,:,2,1,3) = tof_data;
for i = 2:4
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate0%dNum3-2', i*2);
    load(myfilename,'tof_data');
    tof_cell(:,:,5,i,3) = tof_data;
end
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
myfilename = sprintf('2018_04_27_TOFdata_Group1ERate5IRate10Num3-2');
load(myfilename,'tof_data');
tof_cell(:,:,5,5,3) = tof_data;
for i = 6:2:20
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
    myfilename = sprintf('2018_04_27_TOFdata_Group1ERate%dIRate02Num3-2', i);
    load(myfilename,'tof_data');
    tof_cell(:,:,i,1,3) = tof_data;
end

myfilename = sprintf('2018_04_27_Group1dallTOFdata_matrix_temp-2');
save(myfilename,'tof_cell');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 平均音速算出（メイン） Group1 Erate = 6:2:20
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
myfilename = sprintf('2018_04_27_Group1dallTOFdata_matrix_temp-2');
load(myfilename,'tof_cell');
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
myfilename = sprintf('2018_04_26_Group1ERate5IRate02Num3-2');
cd(myfilename);
load('kgrid.mat')
param = makeParam( 0.125,0.125,400,400,0 );
param.source.point_map = cast(linspace(1,100,100),'int8');
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
sensor.mask=t_pos;
leng = zeros(1,100);

for i = 1:5
    [Min,ind]= min(tof_cell(101:end,:,i,1,3));
    ind = ind+100;
    for j = 1: t_num/2
        leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
    end
  
    aveSOS(i,1,3) = sum(leng./Min)/(t_num/2);
    steSOS(i,1,3) = std(leng./Min,0,2)/sqrt(t_num/2);
end
for i = 6:2:20
    [Min,ind]= min(tof_cell(101:end,:,i,1,3));
    ind = ind+100;
    for j = 1: t_num/2
        leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
    end
    aveSOS(i,1,3) =sum(leng./Min)/(t_num/2);
    steSOS(i,1,3) =std(leng./Min,0,2)/sqrt(t_num/2);
end
for i = 1:5
    [Min,ind]= min(tof_cell(101:end,:,5,1,i));
    ind = ind+100;
    for j = 1: t_num/2
        leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
    end
    aveSOS(5,1,i) = sum(leng./Min)/(t_num/2);
    steSOS(5,1,i) =std(leng./Min,0,2)/sqrt(t_num/2);
end
for i = 1:5
    [Min,ind]= min(tof_cell(101:end,:,5,i,3));
    ind = ind+100;
    for j = 1: t_num/2
        leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
    end
    aveSOS(5,i,3) = sum(leng./Min)/(t_num/2);
    steSOS(5,i,3) = std(leng./Min,0,2)/sqrt(t_num/2);
end
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
myfilename = sprintf('2018_04_28_Group1aveSOS_temp-2');
save(myfilename,'aveSOS');
myfilename = sprintf('2018_04_28_Group1steSOS_temp-2');
save(myfilename,'steSOS');

%% 上の振り方のまま別の平均音速算出法を試す．
%対向する受信素子において，その伝わるパワーの半分が伝わった時間を元に平均音速を算出する．
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
myfilename = sprintf('2018_04_26_Group1ERate5IRate02Num3-2');
cd(myfilename);
load('kgrid.mat')
param = makeParam( 0.125,0.125,400,400,0 );
param.source.point_map = cast(linspace(1,100,100),'int8');
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
sensor.mask=t_pos;
leng = 40 * 1e-3;
dt = kgrid.dt;
aveSOS = zeros(20,1);
steSOS = zeros(20,1);
for i = 2:2:20
    cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
    myfilename = sprintf('2018_04_26_Group1ERate%dIRate02Num3-2',i);
    cd(myfilename);
    load('rfdata')
    L = length(rfdata(:,1,1));
    store_rf = zeros(L,t_num/2);
    str_rf_abs = zeros(L,t_num/2);
    total_str_rf_abs = zeros(t_num/2);
    str_half_t = zeros(t_num/2,1);
    
    for j = 1: t_num/2
        check_tmp = 2;
        store_rf(:,j,i) = rfdata(:,100+j,j);
        str_rf_abs(:,j,i) = abs(store_rf(:,j,i));
        total_str_rf_abs(j,i) = sum(str_rf_abs(:,j,i));
        total_tmp = total_str_rf_abs(j,i);
        while sum(str_rf_abs(1:check_tmp,j,i)) < 0.5*total_tmp
            check_tmp = check_tmp+1;
        end
        str_half_t(j,i) = check_tmp * dt;
    end
    aveSOS(i,1) = sum(leng./str_half_t(:,i))/(t_num/2);
    steSOS(i,1) = std(leng./str_half_t(:,i))/sqrt(t_num/2);
end
cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
myfilename = sprintf('2018_04_28_Group1aveSOS2_temp-2');
save(myfilename,'aveSOS');
myfilename = sprintf('2018_04_28_Group1steSOS2_temp-2');
save(myfilename,'steSOS');
%
% %% script for running the function simulate_usct(...)
% clear; close all;
%
% for i = 2:5
%     myfilename = sprintf('Group%dERate5IRate02Num%d', j, i);
%     load(myfilename);
%     param = makeParam( 0.125,0.125,400,400,0 );
%     param.source.point_map = cast(linspace(1,100,100),'int8');
%     myfilename = sprintf('2018_04_26_Group%dERate5IRate02Num%d',j, i);
%     dst_path = myfilename;
%     simulate_usct(param, medium, dst_path);
% end
% for i = 1:4
%     myfilename = sprintf('Group%dERate%dIRate02Num3',j, i);
%     load(myfilename);
%     param = makeParam( 0.125,0.125,400,400,0 );
%     param.source.point_map = cast(linspace(1,100,100),'int8');
%     myfilename = sprintf('2018_04_26_Group%dERate%dIRate02Num3', j,i);
%     dst_path = myfilename;
%     simulate_usct(param, medium, dst_path);
% end
% for i = 4:2:8
%     myfilename = sprintf('Group%dERate5IRate0%dNum3', j, i);
%     load(myfilename);
%     param = makeParam( 0.125,0.125,400,400,0 );
%     param.source.point_map = cast(linspace(1,100,100),'int8');
%     myfilename = sprintf('2018_04_26_Group%dERate5IRate0%dNum3',j, i);
%     dst_path = myfilename;
%     simulate_usct(param, medium, dst_path);
% end
% myfilename = sprintf('Group%dERate5IRate10Num3',j);
% load(myfilename);
% param = makeParam( 0.125,0.125,400,400,0 );
% param.source.point_map = cast(linspace(1,100,100),'int8');
% myfilename = sprintf('2018_04_26_Group%dERate5IRate10Num3',j);
% dst_path = myfilename;
% simulate_usct(param, medium, dst_path);
% end
%
%
%     %% 平均音速算出(配列定義) Group%d
%     tof_cell  = zeros(200,100,5,5,5);%{Receiver, Transmitter, ERate, IRate, Num, }
%     aveSOS = zeros(5,5,5);%{ERate, IRate, Num}
%     for i = 1:5
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate02Num%d',j, i);
%         load(myfilename,'tof_data');
%         tof_cell(:,:,5,1,i) = tof_data;
%     end
%     for i = 1:4
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate%dIRate02Num3', j,i);
%         load(myfilename,'tof_data');
%         tof_cell(:,:,i,1,3) = tof_data;
%     end
%     for i = 4:2:8
%         cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%         myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate0%dNum3', j,i);
%         load(myfilename,'tof_data');
%         tof_cell(:,:,5,i/2,3) = tof_data;
%     end
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_27_TOFdata_Group%dERate5IRate10Num3',j);
%     load(myfilename,'tof_data');
%     tof_cell(:,:,5,5,3) = tof_data;
%     myfilename = sprintf('2018_04_27_Group%dallTOFdata_matrix',j);
%     save(myfilename,'tof_cell');
%     %% 平均音速算出（メイン） Group%d
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_27_Group%dallTOFdata_matrix',j);
%     load(myfilename,'tof_cell');
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_02_28_-kwave');
%     myfilename = sprintf('2018_04_26_Group%dERate5IRate02Num3',j);
%     cd(myfilename);
%     load('kgrid.mat')
%     param = makeParam( 0.125,0.125,400,400,0 );
%     param.source.point_map = cast(linspace(1,100,100),'int8');
%     t_size = 40.e-3;
%     t_num = 200;%トランスデューサ数
%     t_pos = zeros(2, t_num);%センサ位置
%     t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
%     t_pos(2,1:t_num/2) = t_size/2;
%     t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
%     t_pos(2,t_num/2+1:t_num) = -t_size/2;
%     sensor.mask=t_pos;
%     leng = zeros(1,100);
%     for i = 1:5
%         [Min,ind]= min(tof_cell(101:end,:,i,1,3));
%         ind = ind+100;
%         for j = 1: t_num/2
%             leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
%         end
%         aveSOS(i,1,3) = mean(leng./Min);
%     end
%     for i = 1:5
%         if i == 3
%             continue
%         end
%         [Min,ind]= min(tof_cell(101:end,:,5,1,i));
%         ind = ind+100;
%         for j = 1: t_num/2
%             leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
%         end
%         aveSOS(5,1,i) = mean(leng./Min);
%     end
%     for i = 2:5
%         [Min,ind]= min(tof_cell(101:end,:,5,i,3));
%         ind = ind+100;
%         for j = 1: t_num/2
%             leng(1,j) = norm(t_pos(:,j)-t_pos(:,ind(1,j)));
%         end
%         aveSOS(5,i,3) = mean(leng./Min);
%     end
%     cd('\\Azlab-fs01\東研究室\個人work\竹内(ひ)\result\2018_04_27_analyzeLipidModel')
%     myfilename = sprintf('2018_04_28_Group%daveSOS',j);
%     save(myfilename,'aveSOS');
