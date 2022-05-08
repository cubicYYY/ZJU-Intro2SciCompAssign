clear;clc;
% (a)Generate a vector d of 20 random integers in the range 1 to 6.
d = floor(6*rand(1,20)+1); 
% generate a vector d filled with random integers in range of [1,6]
disp('The vector d is:');
disp(d); % display the content of vector d

% (b)Count the number of “sixes” thrown by summing
% the elements of the logical vector d ==6.
a = (d == 6); % Convert d to a logical vector ("sixes" replaced by 1, otherwise 0)
fprintf('The ''six(es)'' count of d: %d\n', sum(a)); 
% Using function sum() to sum the whole logical vector
% Because every "1" in logical vector a represents a "6" in d, 
% by summing vector a we can yield the count of 6 in vector d.
