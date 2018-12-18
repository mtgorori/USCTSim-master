%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2018/08/05
%均質媒質をつくる．
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('H:\codes'))
cd('H:\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
figure;
param.t_end = 1.000000000000000e-04 * 3000/5200;

medium = makePatternMedium(3, param, 0, 0, 0);
hold on
imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
scatter(t_pos(2,:)*1000,t_pos(1,:)*1000,'rs','filled');
axis equal
axis tight
xlabel('x-axis[mm]')
ylabel('y-axis[mm]')
myfilename = sprintf('No Object');
title(myfilename);
colorbar;
caxis([1450 1580]);
c = colorbar;
c.Label.String = '[m/s]';
hold off
cd('H:\data\kwave\medium\2018_08_05_no_object')
exportfig(myfilename,'png',[300,300]);
save(myfilename, 'medium','kgrid','param');

%%%%%%%%%%%%%%%%%%%
%2018/08/23
%2000 x 2000で作成
%%%%%%%%%%%%%%%%%%
addpath(genpath('H:\codes'))
cd('H:\data\kwave\param')
load('param_2board_plnwv.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
figure;
param.t_end = 1.000000000000000e-04 * 3000/5200;

medium = makePatternMedium(3, param, 0, 0, 0);
hold on
imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
scatter(t_pos(2,:)*1000,t_pos(1,:)*1000,'rs','filled');
axis equal
axis tight
xlabel('x-axis[mm]')
ylabel('y-axis[mm]')
myfilename = sprintf('NoObject');
title(myfilename);
colorbar;
caxis([1450 1580]);
c = colorbar;
c.Label.String = '[m/s]';
hold off
cd('H:\data\kwave\medium\2018_08_23_no_object_large')
exportfig(myfilename,'png',[300,300]);
save(myfilename, 'medium','kgrid','param');