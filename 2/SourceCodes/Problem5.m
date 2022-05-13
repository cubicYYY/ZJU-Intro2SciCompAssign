clear;clc;
disp(lengthOnes('1101001111'));
function y = lengthOnes(x)
y = 0;
current = 0;
for i=1:length(x)
    if x(i)=='1'
        current = current + 1; % Current consecutive times
    else
        y = max(y, current); % Update the answer
        current = 0; % Reset counter
    end
end
y = max(y, current); % Update the remained value in counter "current"
end