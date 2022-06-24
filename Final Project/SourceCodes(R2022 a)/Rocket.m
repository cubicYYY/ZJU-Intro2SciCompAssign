classdef Rocket < handle
    properties
        %main state parameter
        Position=[0,1000,0];%x,y,angle
        Velocity=[0,0,0];%vx,vy,angular_v
        fuel=10000;
        %exchanging parameter for contol
        thrustOn=[0,0,0]%thrustOn=[left middle right],times of keys
        %const parameter for computation
        g=9.8/3;
        agt=[-pi/3,0,pi/3];%angle of 3 thrust (left,middle,right)
        acl=[45,80,45];%accelarate of each thrust angle
        ag_acl=[0.15,0,-0.15];%angular accelerate of each thrust angle
        flcsm=[2,3,2];%fuel consume of each thrust angle
        Size=[0,sqrt(3)*16+18;-8,18;-8,-18;8,-18;8,18];%size form the center[point(5)];point(i)=[theta(i),r(i)];
        %    ^
        %    |
        %----.---->
        %   /|\
        %  / | \
        % l  m  r
        %<-  -  ->>
        %left/right: thrust angle=-120/-60d, fuel consume=2, 
        %       total accelerate=35m/s, angular accelerate=-0.2/0.2
        %middle: thrust angle=-90d, fuel consume=3, total accelerate=45m/s
    end
    methods
        function obj=Rocket(x,y,angle,vx,vy,agv,fu)
            disp('create');
            %creat the object
            obj.thrustOn=zeros(1,3);
            if nargin==0
                obj.Position=[0,1000,0];
                obj.Velocity=[0,0,0];
                obj.fuel=1000;
            else
                obj.Position=[x,y,angle];
                obj.Velocity=[vx,vy,agv];
                obj.fuel=fu;
            end
        end
        function obj=Update(obj,dt)
            %update rocket state
            dt=dt*10;
            obj.Velocity=obj.Velocity.*exp(-0.1*dt);
            ac = zeros(1,3);
            for n=1:3
                if obj.thrustOn(n)
                    ac = ac + dt.*obj.acl(n).*[-sin(obj.agt(n)),cos(obj.agt(n)),obj.ag_acl(n)];
                    obj.fuel=obj.fuel-obj.thrustOn(n).*obj.flcsm(n);
                end
            end
            new_acx = ac(1).*cos(obj.Position(3))+ac(2).*sin(obj.Position(3));
            new_acy = -ac(1).*sin(obj.Position(3))+ac(2).*cos(obj.Position(3));
            obj.Velocity(1)=obj.Velocity(1)+dt*new_acx;
            obj.Velocity(2)=obj.Velocity(2)-dt.*obj.g+dt*new_acy;
            obj.Velocity(3)=obj.Velocity(3)+dt*ac(3);
            obj.Position=obj.Position+dt.*obj.Velocity;
        end
        function obj=KeyP(~,event,obj)
            %calling by set(gcf,'KeyPressFcn',@(src,event)r.KeyPress(event));
            %using global parameter tmp
            if obj.fuel>0
                if strcmp(event.Key,'a')
                    obj.thrustOn(1)=1;
                elseif strcmp(event.Key,'s') || strcmp(event.Key,'w')
                    obj.thrustOn(2)=1;
                elseif strcmp(event.Key,'d')
                    obj.thrustOn(3)=1;
                end
            end

        end
        function obj=KeyR(~,event,obj)
            %calling by set(gcf,'KeyPressFcn',@(src,event)r.KeyPress(event));
            %using global parameter tmp
            if strcmp(event.Key,'a')
                obj.thrustOn(1)=0;
            elseif strcmp(event.Key,'s') || strcmp(event.Key,'w')
                obj.thrustOn(2)=0;
            elseif strcmp(event.Key,'d')
                obj.thrustOn(3)=0;
            end
        end
    end
end