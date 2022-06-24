%%
% billiardScript : Sets up and runs a billiard simulation
%
% initialState:
%      the initial state of the ball (position and velocity) expressed as a row vector [x y vx vy]

%      (x and y in meters, vx and vy in meters/second)
% walls :
%      The walls in the simulation this is provided as an array with
%      one row for every wall - each row encodes the endpoints of the wall in the following format [x1 y1 x2 y2]
%      so the array [1 3 1 5; 7 5 10 5] would represent two walls one with end
%      points (1,3) and (1,5) and the other with endpoints (7,5) and (10,5).
%      Note that the walls will either be purely horizontal or purely vertical
%      and you can tell which by checking whether the x or y coordinates of
%      the endpoints are constant
% timestep :
%      the simulation timestep in seconds
% iterations :
%      number of timesteps to run the simulation
% coefficient_of_restitution :
%      after the ball collides with a wall it's speed after the collision is related to its speed
%      before the collision the coefficient of restitution. This is a
%      unitless quantity between 0 and 1.

%% !Modifiable Arguments
% Initial State of ball
%                 x    y   vx vy
initialState = [1.2 0.88 10.1 12.313];

%  x1  y1  x2  y2
walls = [  
    0   0  10   0; ...
    0  10  10  10; ...
    0   0   0  10; ...
    10   0  10  10; ...
    0   5   4   5; ...
    4   0   4   3; ...
    7   6   7   9;
    3   2   3   8;
    5   6   9   6];

coefficient_of_restitution = 1;
timestep = 0.005;
iterations = 10000;
%%

% Run the simulation
%

ballState = initialState;

% Initialize the display

% Draw the ball
h = plot (ballState(1), ballState(2), 'bo', 'MarkerSize', 10);

% Set the axis to correspond to a 10 meter by 10 meter field
axis ([0 10 0 10]);

% Draw the walls using the line function
line (walls(:,[1 3])',walls(:,[2 4])')

% For each timestep
for i = 1:iterations

    % Update the ball state
    ballState = updateBallState (ballState, timestep, walls, coefficient_of_restitution);
    % Redraw the ball
    set (h, 'XData', ballState(1));
    set (h, 'YData', ballState(2));

    % pause so that we can see the drawing
    pause (0.01);

end


%% My work
function [t, collisionState] = findCollision (ballState, wall, coefficient_of_restitution)
x = ballState(1);
y = ballState(2);
vx = ballState(3);
vy = ballState(4);
if wall(1)==wall(3) % Wall is vertical
    if vx*(wall(1)-x)<=0 % No speed or wrong direction
        t = inf;
        collisionState = [];
        return ;
    end
    if wall(2)>wall(4) % swap if start>end
        tmp = wall(2);
        wall(2)=wall(4);
        wall(4)=tmp;
    end
    xt = wall(1); % target X
    new_y = vy*(xt-x)/vx+y; % Y of collision position.
    if new_y>=wall(2)&&new_y<=wall(4) % Fall inside the range of wall
        t = (xt-x)/vx; % How many time left before collison
        collisionState = [xt, new_y, ...
            -vx*coefficient_of_restitution, vy*coefficient_of_restitution];
        return ;
    else
        t = inf;
        collisionState = [];
        return ;
    end
else % Wall is horizontal, the same
    if vy*(wall(2)-y)<=0
        t = inf;
        collisionState = [];
        return ;
    end
    if wall(1)>wall(3)
        tmp = wall(1);
        wall(1)=wall(3);
        wall(3)=tmp;
    end
    yt = wall(2);
    new_x = vx*(yt-y)/vy+x; % x of collision position.
    if new_x>=wall(1)&&new_x<=wall(3)
        t = (yt-y)/vy;
        collisionState = [new_x, yt, ...
            vx*coefficient_of_restitution, -vy*coefficient_of_restitution];
        return ;
    else
        t = inf;
        collisionState = [];
        return ;
    end
end
end

function newBallState = updateBallState (ballState, dt, walls, coefficient_of_restitution)
[wallcnt, ~] = size(walls);
minT_id = 1;
t = inf;

for i=1:wallcnt % Find the next wall to hit (minimum time before collision)
    wall = walls(i,:);
    [tmpt, ~] = findCollision(ballState, wall, coefficient_of_restitution);
    if tmpt<t % Log the wall with the minimum time to hit
        minT_id = i;
        t = tmpt;
    end
end
[t, collisionState] = findCollision(ballState, walls(minT_id,:), coefficient_of_restitution);
if t<=dt % Collision is coming
    newBallState = updateBallState(collisionState, dt-t, walls, coefficient_of_restitution);
    % Recursively update the state
else
    newBallState = UpdateBallStateNoCollisions(ballState, dt);
end
    function next_state = UpdateBallStateNoCollisions (current_state, dt)
        % Nested function, for normal movement without collisions
        next_state = current_state;
        x = current_state(1);
        y = current_state(2);
        vx = current_state(3);
        vy = current_state(4);
        next_state(1) = (x + vx*dt);
        next_state(2) = (y + vy*dt);

    end
end