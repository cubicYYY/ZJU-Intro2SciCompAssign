function [terrain,m_pos,land_pos] = initial_terrain(ax,mode,axis_heit,axis_widt)
N_ter=40;   %矩形个数
step_w = axis_widt/N_ter;
if(mode==0)
    land_pos=randperm(N_ter,10);
elseif(mode==1)
    land_pos=randperm(N_ter,3);
end

terrain=zeros(N_ter,4);
terrain(:,1)=0:step_w:step_w*(N_ter-1);
terrain(:,2)=0;
terrain(:,3)=step_w;
min_h = floor(axis_heit*0.05);
max_h = floor(axis_heit*0.2);

terrain(:,4)=[randi([min_h max_h],1,N_ter/4) randi([min_h max_h],1,N_ter/4) randi([min_h max_h],1,N_ter/4) randi([min_h max_h],1,N_ter/4)];

for j = 1:N_ter
    if(ismember(j,land_pos))
        rectangle('Position',terrain(j,:), ...
            'LineWidth',2,'facecolor','r','parent',ax);
    else
        rectangle('Position',terrain(j,:), ...
            'LineWidth',2,'facecolor','k','parent',ax);
    end
end
% axis([0 N_ter 0 axis_heit]);  %调整轴的比例

%陨石位置初始化
m_pos=mpos_initial(mode,N_ter,axis_heit);
end