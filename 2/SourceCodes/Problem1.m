clear;clc;
P = @(r, A, n, k)(r.*A.*((1+r./n).^(n.*k))./(n.*((1+r./n).^(n.*k)-1)));
% Define a anonymous function as a short-cut

% Method1: nested 'for' loops
% MATLAB is column-major, hence the outer loop is for row, the inner loop
% is for column. This leads to potential performance boosts, like enabling
% cache prefetching or instruction-level parallelism.
col = 1;
table1 = zeros(11, 3);
for year=15:5:25
    row = 1;
    for rate=0.1:0.01:0.2
        table1(row, col) = P(rate, 1000, 12, year);
        row = row + 1;
    end
    col = col + 1;
end
disp(table1);

% Method2: vectorized outer loop(maybe method3 is expected answer)
table2 = zeros(11, 3);
row = 1;
for rate=0.1:0.01:0.2
    table2(row,:) = P(rate, 1000, 12, 15:5:25);
    row = row + 1;
end
disp(table2);

% Method3(Extra): fully vectorized
% !NOTE: actually I don't really know what "outer loop" refers to
% so I vectorized ALL loops(inner & outer), that will definitely meet every
% requirements, right?
table3 = P((0.1:0.01:0.2)', 1000, 12, 15:5:25);
disp(table3);
