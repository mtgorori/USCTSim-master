%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2018/08/10
%牛の腓腹筋断面写真を使う．
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('H:\codes'))
cd('H:\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
t_size = 19.8*2.e-3;
t_facing_distance = 40e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_facing_distance/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_facing_distance/2;
figure;
param.t_end = 1.000000000000000e-04 * 3000/5200;
max_num_pict = 5;
max_num_pict2 = 10;
max_num_pict3 = 10;
rate_EMCLs = zeros(1,max_num_pict+max_num_pict2+max_num_pict3);

for i = 1:max_num_pict
    [medium,rateEMCL] = makeRealisticMedium(param,0,i,1,max_num_pict,1);
    hold on
    imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
    scatter(t_pos(2,:)*1000,t_pos(1,:)*1000,'rs','filled');
    axis equal
    axis tight
    xlabel('x-axis[mm]')
    ylabel('y-axis[mm]')
    myfilename = sprintf('case%d: EMCL%0.2f',i,rateEMCL);
    myfilename2 = sprintf('case%d',i);
    title(myfilename);
    colorbar;
    caxis([1450 1580]);
    c = colorbar;
    c.Label.String = '[m/s]';
    hold off
    cd('H:\data\kwave\medium\2018_08_10_realisticScatter\corrected\')
    exportfig(myfilename2,'png',[300,300]);
    save(myfilename2, 'medium','kgrid','param');
    rate_EMCLs(1,i) = rateEMCL;
end

for i = 1:max_num_pict2
    [medium,rateEMCL] = makeRealisticMedium(param,0,i,2,max_num_pict2,1);
    hold on
    imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
    scatter(t_pos(2,:)*1000,t_pos(1,:)*1000,'rs','filled');
    axis equal
    axis tight
    xlabel('x-axis[mm]')
    ylabel('y-axis[mm]')
    myfilename = sprintf('case%d: EMCL%0.2f',i+max_num_pict,rateEMCL);
    myfilename2 = sprintf('case%d',i+max_num_pict);
    title(myfilename);
    colorbar;
    caxis([1450 1580]);
    c = colorbar;
    c.Label.String = '[m/s]';
    hold off
    cd('H:\data\kwave\medium\2018_08_10_realisticScatter\corrected\')
    exportfig(myfilename2,'png',[300,300]);
    save(myfilename2, 'medium','kgrid','param');
    rate_EMCLs(1,i+max_num_pict) = rateEMCL;
end

for i = 1:max_num_pict3
    [medium,rateEMCL] = makeRealisticMedium(param,0,i,3,max_num_pict3,1);
    hold on
    imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
    scatter(t_pos(2,:)*1000,t_pos(1,:)*1000,'rs','filled');
    axis equal
    axis tight
    xlabel('x-axis[mm]')
    ylabel('y-axis[mm]')
    myfilename = sprintf('case%d: EMCL%0.2f',i+max_num_pict+max_num_pict2,rateEMCL);
    myfilename2 = sprintf('case%d',i+max_num_pict+max_num_pict2);
    title(myfilename);
    colorbar;
    caxis([1450 1580]);
    c = colorbar;
    c.Label.String = '[m/s]';
    hold off
    cd('H:\data\kwave\medium\2018_08_10_realisticScatter\corrected\')
    exportfig(myfilename2,'png',[300,300]);
    save(myfilename2, 'medium','kgrid','param');
    rate_EMCLs(1,i+max_num_pict+max_num_pict2) = rateEMCL;
end
 cd('H:\data\kwave\medium\2018_08_10_realisticScatter\corrected\')
 save('corrected_rate_EMCLs.mat','rate_EMCLs');