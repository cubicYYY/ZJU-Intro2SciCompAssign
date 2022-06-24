function rockets = drawRocket(ax,r)
pos=r.Position(1:2);
angle=r.Position(3);
thrust=logical(r.thrustOn);
x=pos(1);y=pos(2);% Central point coordinates
W = 16;
H = 36;
i=1;
%% Rocket Body
X = [-W/2 W/2 W/2 -W/2];
Y = [H/2 H/2 -H/2 -H/2];
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'r','Parent',ax);
set(rockets(i),'facealpha',.6);
i=i+1;
%% Rocket Head
X = [-W/2 0 W/2];
Y = [H/2 H/2+W*sqrt(3) H/2];
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'b','Parent',ax);
set(rockets(i),'facealpha',.5);
i=i+1;
%% Rocket Left Wing
X = [-W/2 -W/2 -W/2-W*0.2 -W/2-W*0.2];
Y = [H/4 -H/4 -H/4-H*0.2 H/4-H*0.2];
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'g','Parent',ax);
set(rockets(i),'facealpha',.3);
i=i+1;
%% Rocket Right Wing
X = [W/2 W/2 W/2+W*0.2 W/2+W*0.2];
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'g','Parent',ax);
set(rockets(i),'facealpha',.3);
i=i+1;
%% Rocket Thrusters
X = [-W/2 -W/2+W/5 -W/2+W/5+W*0.05 -W/2-W*0.05];
Y = [-H/2 -H/2 -H/2-H*0.1 -H/2-H*0.1];
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'r','Parent',ax);
set(rockets(i),'facealpha',.3);
i=i+1;

X = X+W*2/5;
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'r','Parent',ax);
set(rockets(i),'facealpha',.6);
i=i+1;

X = X+W*2/5;
rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,'r','Parent',ax);
set(rockets(i),'facealpha',.3);
i=i+1;
%% Flames(gradient color)
if r.fuel>0
    X = [-W/2 -W/2+W/5 -W/2+W/10];
    Y = [-H/2 -H/2 -H];
    if thrust(1)
        rockets(i) = patch(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,[0;0;8],'Parent',ax);
        set(rockets(i),'facealpha',.7);
    end
    X = X+W*2/5;
    i=i+1;
    if thrust(2)
        rockets(i) = patch(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,[0;0;8],'Parent',ax);
        set(rockets(i),'facealpha',.7);
    end
    X = X+W*2/5;
    i=i+1;
    if thrust(3)
        rockets(i) = fill(X.*cos(angle)+Y.*sin(angle)+x,-X.*sin(angle)+Y.*cos(angle)+y,[0;0;8],'Parent',ax);
        set(rockets(i),'facealpha',.7);
    end
else
    r.thrustOn=zeros(1,3);
end

end