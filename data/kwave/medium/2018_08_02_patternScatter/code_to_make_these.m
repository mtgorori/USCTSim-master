%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2018/08/02
%層状の媒質をつくる．1,2,3層で，EMCL割合は2~20%まで
%変動させる．（実はミスが有った．rEMCLが不適切だったのを直した
%                アレイサイズに限定されていたことを考慮していなかった）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('H:\codes'))
cd('H:\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
figure;
param.t_end = 1.000000000000000e-04 * 3000/5200;
for i = 1:3
    for j = 2:2:20
        medium = makePatternMedium(1, param, j, i, 0);
        imagesc(kgrid.x_vec*1000,kgrid.y_vec*1000,medium.sound_speed);
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
        cd('H:\data\kwave\medium\2018_08_02_patternScatter')
        exportfig(myfilename,'png',[300,300]);
        save(myfilename, 'medium','kgrid','param');
    end
end
