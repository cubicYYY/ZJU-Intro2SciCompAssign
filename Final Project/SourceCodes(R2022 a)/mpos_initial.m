function mpos = mpos_initial(mode,axis_widt,axis_heit)
%陨石的产生与运动状态的初始化
if(mode==0)
    mpos=zeros(7,4);
elseif(mode==1)
    mpos=zeros(20,4);
end
mpos(:,2)=axis_heit-1;
for i=1:size(mpos,1)
    mpos(i,1)=randi([0 axis_widt],1);
    mpos(i,3)=randi([-20 20],1);
    mpos(i,4)=randi([-1 0],1);
end
end