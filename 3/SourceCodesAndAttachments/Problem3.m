clear;clc;
disp(Scores_ranking(2));

function rank=Scores_ranking(n)

%% Initialize for File Operation
filename = input('Please input the file name:', 's');
% Must include suffix, like 'score.txt'
% Note: the file MUST under the current working directory.
fid = fopen(filename, 'rt');% Read as a text(ASCII) file

%% Local(in Room) Stuffs
students = fscanf(fid, '%d %d', [2, inf])';% Store all data in a 5n*2 array
rank = zeros(5*n, 5);
for i=1:n
    room = zeros(5, 4);
    room(:,1:2) = sortrows(students(5*i-4:5*i,:), 2, 'descend');
    % Sort by scores, high-to-low order
    % No need to consider the ID column, since all the room will be mixed
    % and re-calculate later.

    for j=1:5 % Dispatch local rankings
        if (j==1 || room(j,2)~=room(j-1,2))
            room(j,4) = j;
        else
            room(j,4) = room(j-1,4);
            % Same score, same ranking.
        end
    end
    room(:,3) = repelem(i, 5)'; % Add the column of room number
    rank(5*i-4:5*i,1:4) = room;
end

%% Generate Global and Final Result
rank = sortrows(rank, [2, 1], {'descend', 'ascend'});
% Sort the result table by both score and ID column.
% If the score is the same, then sort by ID column in non-decreasing order.

for j=1:5*n % Calculate the final/global ranking for every student
    if (j==1 || rank(j,2)~=rank(j-1,2))
        rank(j,5) = j;
    else
        rank(j,5) = rank(j-1,5);
    end
end

end