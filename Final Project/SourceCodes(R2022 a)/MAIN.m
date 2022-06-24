clear;clc;close all;
f = uifigure('position',[0 0 1080*0.9 720*0.9]);
movegui(f,'center');
set(f,'color','white');
%------------------------
global I WW WH STB;
%------------------------
WW = 1080;
WH = 720;
%mode = 1;

I = start(f);
%----------------------------
STB = start_Button(f);
%------------------------
function Image = start(uif)
global WW WH;
Image = uiimage(uif);
%Image.ImageClickedFcn = @(~,~)startGame(uif);
Image.Position = [0,0,WW*0.9,WH*0.9];
Image.ImageSource = 'rocket.png';
end
%-------------------------------------------
function stb = start_Button(uif)
stb(1) = uibutton('push','Text','Easy Mode','Position',[100 200 200 80],...
    'ButtonPushedFcn',@(~,~)startGame(uif,0),'Parent',uif,...
    'FontSize',30,'FontColor',[0 0 1],'BackgroundColor',[0 0.8 1]);
stb(2) = uibutton('push','Text','Hard Mode','Position',[100 100 200 80],...
    'ButtonPushedFcn',@(~,~)startGame(uif,1),'Parent',uif,...
    'FontSize',30,'FontColor',[0 0 1],'BackgroundColor',[0 0.8 1]);
end


function startGame(f,mode)
global I WW WH STB;
delete(I);
delete(I);
delete(STB);
%-----------------------------------------


ax = axInit(f);
[terrain,~,land_pos] = initial_terrain(ax,mode,WH,WW);
r = Rocket(randi(WW),randi([floor(WH/2) floor(WH*0.8)]),rand()*2*pi,0,0,0,1000);
set(f,'WindowKeyPressFcn',@(src,event)r.KeyP(event,r));
set(f,'WindowKeyReleaseFcn',@(src,event)r.KeyR(event,r));
m_pos=mpos_initial(0,WW,WH);
clouds(1)=cloud(ax,randi(WW),randi([floor(WH*0.6) floor(WH*0.8)]),80);
clouds(2)=cloud(ax,randi(WW),randi([floor(WH*0.6) floor(WH*0.8)]),80);
clouds(3)=cloud(ax,randi(WW),randi([floor(WH*0.6) floor(WH*0.8)]),80);
time=clock;
while 1
    dr = drawRocket(ax,r);
    N_ter  =40;
    %% Draw meteorite
    for k=1:size(m_pos,1)
        met_x=ceil(m_pos(k,1));
        if(met_x>=N_ter)
            met_x=N_ter;
        elseif(met_x<=0)
            met_x=1;
        end
        
        if(terrain(met_x,4)<=m_pos(k,2) || m_pos(k,1)>0 || m_pos(k,1)<N_ter)
            p1(k,:)=shootingStar(ax,m_pos(k,1),m_pos(k,2),8,m_pos(k,3),m_pos(k,4));
        end
    end
    %%
    m_pos=meteorite(m_pos,1);  %更新陨石位置
    if(sum(m_pos(:,2)<=0)>0)
        m_pos=mpos_initial(0,WW,WH);
    end
    r.Update(0.014);
    g = fuelbar(f,floor(WW*0.75),floor(WH*0.75),150,r.fuel/10);
    pause(0.1);
    delete(g);
    delete(dr);
    delete(p1);
    if land(r,terrain,land_pos)
        time=etime(clock,time);
        endGame(f,time,r.fuel,true);
    elseif crash(r,m_pos,terrain)
        delete(clouds);
        %delete(r);
        explx=30*cos((1/48:1/24:1)'*2*pi);
        explx(2:2:end)=explx(2:2:end)*0.5;
        exply=30*sin((1/48:1/24:1)'*2*pi);
        exply(2:2:end)=exply(2:2:end)*0.5;
        for n=1:43
            fill(explx+r.Position(1),exply+r.Position(2),[0.85,0.45,0.1],'Parent',ax);
            explx=explx*1.1;
            exply=exply*1.1;
            alpha(ax,1-n/51);
            pause(0.03);
        end
        endGame(f,0,r.fuel,false);
        break;
    end
end
end

function endGame(uif,time,fu,result)
global WW WH;
Image = uiimage(uif);
Image.Position = [0 0 WW*0.9 WH*0.9];
Image.ScaleMethod='fill';
if result
    Image.ImageSource = 'success.png';
    uilabel(uif,'Text',['Your used time:',num2str(time)],...
        'Position',[WW*0.15,WH*0.4,WW*0.4,WH*0.2],'FontSize',30);
    uilabel(uif,'Text',['Remaining fuel:',num2str(fu)],...
        'Position',[WW*0.15,WH*0.3,WW*0.4,WH*0.2],'FontSize',30);
else
    Image.ImageSource = 'failed.png';
end
pause(3);
uibutton(uif,'Text','New Game','Position',[WW*0.2,WH*0.1,WW*0.2,WH*0.1],...
    'ButtonPushedFcn',@(btn,event)newButtonPushed(uif));
uibutton(uif,'Text','Quit Game','Position',[WW*0.5,WH*0.1,WW*0.2,WH*0.1], ...
    'ButtonPushedFcn',@(btn,event)quitButtonPushed(uif));
end

function ax = axInit(uif)
ax = uiaxes(uif,'unit','normalized','position',[0 0 1 1]);
set(ax,'XLim',[0 1080]);
set(ax,'YLim',[0 720]);
axis(ax,'off');
hold(ax,'on');
set(ax,'xtick',[],'xticklabel',[]);
set(ax,'ytick',[],'yticklabel',[]);
end
function newButtonPushed(f)
delete(f);
clear;close all;
f = uifigure('position',[0 0 1080*0.9 720*0.9]);
movegui(f,'center');
set(f,'color','white');
global I WW WH mode STB;
WW = 1080;
WH = 720;
mode = 1;
I = start(f);
STB = start_Button(f);
end

function quitButtonPushed(f)
uialert(f,'You will quit the game.',...
    'Quit Button','Icon','info','CloseFcn','uiresume(f)');
uiwait(f);
delete(f);
close all;
end
