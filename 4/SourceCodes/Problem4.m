% O(n^3) for special constructed map.
% BFS can reach O(n^2) in worst cases.
clc;clear;
%% Generate test data
map = randi(10, 11); % Random maps for test
map = map>2; % 1s:0s=8:2
map(5, 5) = 1;
disp(grassfire(map, 5, 5));
%% Grassfire function
function distance = grassfire (occupancy, dest_row, dest_col)
[rows, cols] = size(occupancy);
distance = inf(rows+2, cols+2); % border padding
distance(dest_row+1, dest_col+1) = 0;
updated = 1; %flag
while updated
    updated = 0;
    for i=2:rows+1
        for j=2:cols+1
            if ~occupancy(i-1, j-1) % Keep dis. of obstacles be inf.
                continue;
            end
            new_dis = 1 + min([distance(i-1, j), distance(i+1, j), ...
                distance(i, j-1), distance(i, j+1)]);
            %NOTE: this kind of query(crossing row/column) is very common
            %in scientific computation needs, like particle physics. But it
            %breaks "space locality" and leads to high performance loss,
            %since cache misses will occur high frequently, and
            %pre-fetching no longer make a difference.
            %The way to solve it is by dividing the full matrix into small
            %blocks in special orders.
            %
            %See also: morton code
            if new_dis<distance(i, j)
                distance(i, j) = new_dis;
                updated = 1;
            end
        end
    end
    if ~updated
        break;
    end
end
distance = distance(2:rows+1, 2:cols+1); % de-padding
end