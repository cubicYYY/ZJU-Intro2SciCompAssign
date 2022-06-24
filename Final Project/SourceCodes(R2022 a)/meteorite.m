function newpos = meteorite(lastpos,tstep)
%更新陨石的位置
g=-0.2;
newpos=lastpos;
for i=1:size(lastpos,1)
    newpos(i,1)=lastpos(i,1)+lastpos(i,3)*tstep;
    newpos(i,2)=lastpos(i,2)+lastpos(i,4)*tstep;
    newpos(i,4)=lastpos(i,4)+g*tstep;
end
end