clear;clc;
A = [
    1,3,2;
    8,4,6;
    7,9,5]; % Matrix that is given

B = A(1:2:3 , 1:2); % Generate a new matrix from specific row/column
C = reshape(A(1:4), [2,2])';% Unwounded index, then be resized and transposed
D = A(1:2, :); % Specific row, : stands for all column
E = max(A, [], 2);
% The third arg stands for dimension=2, which means row
% Note: MATLAB is NOT row-major
F(1:2:5, 1:2:5) = A'; % Special indexing can be used in assignment
% Note: if not specified, the default value for an element is 0
disp(B);disp(C);disp(D);disp(E);disp(F);