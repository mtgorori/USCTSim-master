function simulate_usct(param, medium, dst_path)
% cd('../result') % comment on 2018/1/25
% revise on 2018/1/25
% dst_path = ['\\Azlab-fs01\東研究室\個人work\竹内(ひ)\data\kwave\result\2018_08_05_patternScatter2\', dst_path];
%
if ~exist(dst_path, 'dir')
    mkdir(dst_path);
end
save([dst_path, '\param'], 'param');
save([dst_path, '\medium'], 'medium', '-v7.3');
if exist('jsonencode', 'builtin')
    fid = fopen([dst_path, '\param.json'], 'w');
    fprintf(fid, jsonencode(param));
    fclose(fid);
end

% Create grid with time array
kgrid = makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
dt1=1/param.sensor.freq;
[ta2,dt2] = makeTime(kgrid, medium.sound_speed, [], param.t_end);
if dt2<dt1         % select higher sampling rate
    kgrid.dt = dt2;
    kgrid.t_array=ta2;
else
    kgrid.dt = dt1;
    kgrid.t_array=0:dt1:param.t_end;
end
save([dst_path,'\kgrid.mat'],'kgrid');
% Define source wave form
source_wave = create_waveform( param.source.waveform, kgrid.t_array, kgrid.dt);
save([dst_path,'\sourse_wave.mat'],'source_wave');

% Define sensors
% ring_cx = 0; ring_cy = 0;% 中心位置
% ring_radius = 50.e-3;% 半径
% rr =  ring_radius;
% t_num = 256;%トランスデューサ数
% t = linspace(0, ((t_num-1)/t_num)*2*pi, t_num);%センサ位置角
% t_pos = zeros(2, t_num);%センサ位置
% t_pos(1,:) = rr*cos(t)+ring_cx;
% t_pos(2,:) = rr*sin(t)+ring_cy;
%センサ設置
% t_size = 100.e-3;
% t_num = 128;%トランスデューサ数
% t_pos = zeros(2, t_num);%センサ位置
% t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
% t_pos(2,1:t_num/2) = t_size/2;
% t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
% t_pos(2,t_num/2+1:t_num) = -t_size/2;
% Define sensors
t_size = 19.8*2.e-3;
t_facing_distance = 40e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_facing_distance/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_facing_distance/2;
sensor.mask=t_pos;
sensor.record = {'p'}; % define the acoustic parameters to record
save([dst_path,'\sensor.mat'],'sensor');

% cart -> grid conversion (from xy coodinate to pixel index)
[mask_points, ringpos2scanpos, ~]=cart2grid(kgrid, t_pos);
save([dst_path,'\mask_points.mat'],'mask_points');

% Source loop
[~,num_step] = size(param.source.point_map);
% rfdata=zeros(length(kgrid.t_array), param.ringarray.num_points, num_step);
rfdata=zeros(length(kgrid.t_array), t_num, num_step);
for step=1:num_step
    
    disp(['Step ',num2str(step),'/',num2str(num_step)])
    
    save_path = [dst_path, '\step', num2str(step, '%03d')];
    if ~exist(save_path, 'dir')
        mkdir(save_path);
    end
    
    % Define source wave
    points = param.source.point_map(:,step);
    source.p_mask = mask_points;
    %     source.p = zeros(param.ringarray.num_points, length(kgrid.t_array));
    source.p = zeros(t_num, length(kgrid.t_array));
    for i=1:length(points)
        if points(i) > 0
            source.p( ringpos2scanpos( points(i,1) ), : ) = source_wave;
        end
    end
    save([save_path,'\source.mat'],'source');
    
    % Run the simulation
    input_args = {
%                     'RecordMovie', param.io.save_movie==1, ...
%                     'MovieType', 'image', ...
%                     'MovieName', [save_path, '\out'], ...
                    'DataCast','gpuArray-single'...
                    'PlotScale',[-0.1 0.1]
        };
    sensor_data = (kspaceFirstOrder2D(...
        kgrid, medium, source, sensor,...
        input_args{:}...
        )).';
    % % interp ...
    % target_smpl_freq = 10e6; % [Hz]
    % curr_smpl_freq = 1/kgrid.dt; % [Hz]
    % sensor_data = interp(sensor_data, target_smpl_freq/curr_smpl_freq);
    rfdata(:,:,step)=gather(sensor_data.p).';
    
    % Plot the simulated sensor data
%     figure;
%     imagesc(sensor_data.p.',[-0.1 0.1]);
%     xlabel('Sensor Position');
%     ylabel('Time Step');
%     colorbar;
%     saveas(gcf, [save_path, '\rf'], 'png')
%     close all
    
end

save([dst_path,'\rfdata.mat'],'rfdata', '-v7.3');

end