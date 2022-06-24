function cloud = cloud(ax,x,y,r)
cloud = rectangle('Position',[x-r y-r r*4 r],'Curvature',[1,1],'parent',ax);
set(cloud,'facecolor',[0 0 1 0.3]);
set(cloud,'edgecolor',[0 0 1 0.3]);
end