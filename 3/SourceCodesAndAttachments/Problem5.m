clear;clc;
%%
% Game of Life
% Based on the script teacher provided, the work is to implement 3 core
% functions(at the end of this file).
block = [1 1; 1 1];
boat = [1 1 0; 1 0 1; 0 1 0];
blinker = [1 1 1];
toad = [0 1 1 1; 1 1 1 0];
glider = [1 1 1; 1 0 0; 0 1 0];
LWSS = [0 1 0 0 1; 1 0 0 0 0; 1 0 0 0 1; 1 1 1 1 0];
gun_left = [
    0 0 1 1 0 0 0 0;
    0 1 0 0 0 1 0 0;
    1 0 0 0 0 0 1 0;
    1 0 0 0 1 0 1 1;
    1 0 0 0 0 0 1 0;
    0 1 0 0 0 1 0 0;
    0 0 1 1 0 0 0 0];% For glider gun
gun_right = [
    0 0 0 0 1;
    0 0 1 0 1;
    1 1 0 0 0;
    1 1 0 0 0;
    1 1 0 0 0;
    0 0 1 0 1;
    0 0 0 0 1];


%% Initialization of the basic patterns
% My shapes inserted here.
% Create a gosper glider gun
in = zeros(100);
in (6:7, 2:3) = block;
in (4:10, 12:19) = gun_left;
in (2:8, 22:26) = gun_right;
in (4:5, 36:37) = block;

%% Simulation
iterations = 1000;

for i = 1:iterations
    image(logical(in));
    colormap ([1 1 1; 0 0 0]);
    grid off; % Get rid of the grid, get it? A pun.
    in = updateCells(in);
    pause(0.001);
end
clear;clc;
%% Function implemented
function out = getCell(in, row, col)
%% Get an element from matrix, but with tolerance of array overrun
[maxrow, maxcol] = size(in);
if row<1 || row>maxrow || col<1 || col>maxcol
    % Special judge for illegal positions
    out = 0;
else
    out = (in(row, col)==1);
end
end

function out = countNeighbors(in)
[maxrow, maxcol] = size(in);
out = zeros(maxrow, maxcol);
for x=1:maxrow % Question about this methodology:
    % It takes O(n^4) for each period, but maybe it can reduced to O(n^2),
    % just by shifting and overlapping the matrix itself? Codes adhered
    % after this segment.
    for y=1:maxcol
        out(x, y) = getCell(in, x-1, y-1) + getCell(in, x-1, y) + ...
            getCell(in, x-1, y+1) + getCell(in, x, y-1) + ...
            getCell(in, x, y+1) + getCell(in, x+1, y-1) + ...
            getCell(in, x+1, y) + getCell(in, x+1, y+1);
        % 8 neighbors in 8 directions, not 4
    end
end
%% Alternative Method
% Maybe faster.
% out = zeros(maxrow+2, maxcol+2);
% out(1:maxrow,1:maxcol) = in;
% out(1:maxrow,2:maxcol+1) = out(1:maxrow,2:maxcol+1) + in;
% out(1:maxrow,3:maxcol+2) = out(1:maxrow,3:maxcol+2) + in;
% out(2:maxrow+1,1:maxcol) = out(2:maxrow+1,1:maxcol) + in;
% out(2:maxrow+1,3:maxcol+2) = out(2:maxrow+1,3:maxcol+2) + in;
% out(3:maxrow+2,1:maxcol) = out(3:maxrow+2,1:maxcol) + in;
% out(3:maxrow+2,2:maxcol+1) = out(3:maxrow+2,2:maxcol+1) + in;
% out(3:maxrow+2,3:maxcol+2) = out(3:maxrow+2,3:maxcol+2) + in;
% out = out(2:maxrow+1,2:maxcol+1);
end
function out = updateCells(in)
%% Calculate the next frame
neig = countNeighbors(in);
out = (neig==3) | (neig==2 & in);
% Simplified logic.
% Using logical matrix operation, short, easy to understand and fast.
end


