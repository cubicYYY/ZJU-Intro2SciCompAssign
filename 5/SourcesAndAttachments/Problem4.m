clear;clc;
%% Initial conditions
g=9.8;
c=0.2;
x0=0;
y0=0;
low_x=0;
high_x=100;
vy=2.0;
time_step=0.01;
dis=10;
tol=0.01;
%% Calculation
disp(goldCornhole(g,c,x0,y0,low_x,high_x,vy,time_step,dis,tol));

function vxOpt = goldCornhole(g,c,x0,y0,vxa,vxb,vy,tstep,dis,tol)
%% Golden section search
vxOpt = inf;
vx1=vxb-0.618*(vxb-vxa); % Test point 1
vx2=0.618*(vxb-vxa)+vxa; % Test point 2
dis1 = abs(projectileSim(g,c,x0,y0,vx1,vy,tstep));
dis2 = abs(projectileSim(g,c,x0,y0,vx2,vy,tstep));
while abs(dis1-dis)>tol || abs(dis2-dis)>tol % Totally in the range
    if abs(dis1-dis) < abs(dis2-dis)
        % Choose the better, eliminate the worse
        vxOpt=vx1;
        vxb=vx2;
        vx2=vx1;dis2=dis1;
        vx1=vxb-0.618*(vxb-vxa);
        dis1 = abs(projectileSim(g,c,x0,y0,vx1,vy,tstep));
    else
        vxOpt=vx2;
        vxa=vx1;
        vx1=vx2;dis1=dis2;
        vx2=0.618*(vxb-vxa)+vxa;
        dis2 = abs(projectileSim(g,c,x0,y0,vx2,vy,tstep));
    end
end
end
function disX = projectileSim(g,c,x0,y0,vx0,vy0,tstep)
% Calculate landing point of the beanbag, where air drag considered.
EPS=1e-6;
disX = x0;
while y0>-EPS || vy0>0
    x0 = vx0*tstep + x0;
    y0 = vy0*tstep + y0;
    vy0 = vy0 - g*tstep - tstep*sign(vy0)*c*vy0^2; 
    % NOTE: not following the given formula
    % (See also: relatedProblemMentioned.png)
    % it was because a delay in material distribution occured when
    % assigning homework. You need to correct it by yourself!
    % Be careful about the force direction.
    vx0 = vx0 - tstep*sign(vx0)*c*vx0^2;
end
disX = x0 - disX;
end