function bool=land(rocket,terrain,permitNum)
%landGd=[x,y,width,height]
if rocket.Position(2)<20
    bool=true;
    return
end
line=zeros(2,20*size(permitNum,2));
for n=1:size(permitNum,2)
    line(1,20*n-19:20*n)=linspace(terrain(permitNum(n),1),terrain(permitNum(n),1)+terrain(permitNum(n),3),20);
    line(2,20*n-19:20*n)=ones(1,20)*(terrain(permitNum(n),2)+terrain(permitNum(n),4));
end
shape=[rocket.Size(:,1)';rocket.Size(:,2)'];
shape=[cos(rocket.Position(3)),sin(rocket.Position(3));-sin(rocket.Position(3)),cos(rocket.Position(3))]*shape;
shape=[shape(1,:)+rocket.Position(1);shape(2,:)+rocket.Position(2)];
[in,on]=inpolygon(line(1,:),line(2,:),shape(1,:),shape(2,:));
in=floor(in);on=floor(on);
if (sum(in,"all")>0||sum(on,"all")>0)&&(rocket.Position(3)>-pi/12)&&(rocket.Position(3)<pi/12)
    bool=true;
else
    bool=false;
end
end