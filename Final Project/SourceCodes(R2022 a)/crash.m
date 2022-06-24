function bool=crash(rocket,met,ter)
%rocket:object Rocket
%met=[x,y,vx,vy];
%ter=[x,y,width,height];
bool=true;
shape_rocket=[rocket.Size(:,1)';rocket.Size(:,2)'];
shape_rocket=[cos(rocket.Position(3)),sin(rocket.Position(3));
    -sin(rocket.Position(3)),cos(rocket.Position(3))]*shape_rocket;
shape_rocket=[shape_rocket(1,:)+rocket.Position(1);shape_rocket(2,:)+rocket.Position(2)];
%tell whether the rocket crash with the meteorite
xmet=zeros(1,10*size(met,1));ymet=zeros(1,10*size(met,1));
for n=1:size(met,1)
    xmet(10*n-9:10*n)=cos(linspace(0,2*pi,10))+met(n,1);%points of met
    ymet(10*n-9:10*n)=sin(linspace(0,2*pi,10))+met(n,2);
end
[in,on]=inpolygon(xmet,ymet,shape_rocket(1,:),shape_rocket(2,:));
in=floor(in);
on=floor(on);
if sum(in,"all")>0||sum(on,"all")>0
    disp(1);
    return
end
%tell whether the rocket crash with the terain
xter=zeros(1,10*size(ter,1));yter=zeros(1,10*size(ter,1));
for n=1:size(ter,1)
    xter(10*n-9:10*n)=linspace(ter(n,1),ter(n,1)+ter(n,3),10);%points of ter
    yter(10*n-9:10*n)=linspace(ter(n,2),ter(n,2)+ter(n,4),10);
end
[in,on]=inpolygon(xter,yter,shape_rocket(1,:),shape_rocket(2,:));
in=floor(in);
on=floor(on);
if sum(in,"all")>0||sum(on,"all")>0
    disp(2);
    return
end
bool=false;
end