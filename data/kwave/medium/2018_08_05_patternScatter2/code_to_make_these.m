%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2018/08/05
%�w��̔}��������D1,2,3�w�ŁCEMCL������2~20%�܂�
%�ϓ�������D�c��-�������v�Z�̈捂��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('H:\codes'))
cd('H:\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
t_size = 40.e-3;
t_num = 200;%�g�����X�f���[�T��
t_pos = zeros(2, t_num);%�Z���T�ʒu
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%�f�q������������[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
figure;
param.t_end = 1.000000000000000e-04 * 3000/5200;
for i = 1:10
    for j = 2:2:20
        medium = makePatternMedium(2, param, j, i, 0);
        hold on
        imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
        scatter(t_pos(2,:)*1000,t_pos(1,:)*1000,'rs','filled');
        axis equal
        axis tight
        xlabel('x-axis[mm]')
        ylabel('y-axis[mm]')
        myfilename = sprintf('rEMCL%d & nEMCL%d',j,i);
        title(myfilename);
        colorbar;
        caxis([1450 1580]);
        c = colorbar;
        c.Label.String = '[m/s]';
        hold off
        cd('H:\data\kwave\medium\2018_08_05_patternScatter_2')
        exportfig(myfilename,'png',[300,300]);
        save(myfilename, 'medium','kgrid','param');
    end
end
