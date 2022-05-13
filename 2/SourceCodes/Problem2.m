% Hah, classic coding practice.
clear;clc;
disp(genNarcissistic());
function [ nars ] = genNarcissistic()
% Find all the 3-digits numbers which is "Narcissistic"

nars = [];
for i=100:999 % Enumerate all the 3-digits num
    if isNarcissistic(i)
        nars(end+1) = i;
        % The warning here indicates that a vector with variable length may lead
        % to performance loss. But since the size of this specific problem is
        % extremely small, we can just ignore it.
    end
end
end

function ret = isNarcissistic(num)
% Figure out whether the given num is a Narcissistic number or not

a = floor(num/100); % Extract the first digit
b = floor(rem(num, 100)/10); % Extract the second digit
c = rem(num, 10); % Extract the last digit
ret = (num == a^3 + b^3 + c^3); % Return in logical type
end