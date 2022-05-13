clear;clc;
% Some test cases:
fprintf("%d %d %d %d %d %d", my_gcd(0, 2), my_gcd(2, 0), my_gcd(0, 0), ...
    my_gcd(205, 25), my_lcm(12, 44), my_lcm(16, 404));

function out=my_gcd(a,b)
% Note: Here, my_gcd() behaves NOT the SAME as gcd()
if (a==0 || b==0)
    % Special judge for the case that a=0 or b=0
    % Return "Not A Number" instead of brutally throw an error
    out = nan;
    return
end
while b>0 % Continually calculates the reminder
    % If a>b the first loop will just swap them so it doesn't matter
    c = rem(a, b); % The Euclid's way
    a = b;
    b = c;
end
out = a;
end

function out=my_lcm(a,b)
if round(a) ~= a || round(b) ~= b || a < 1 || b < 1
    error('Input arguments should be postive integers.');
end
% Error handling, to eliminate illegal arguments(not an postive integer)
% Implicitly handled the case of insufficient parameters
out = a/my_gcd(a, b)*b; % Divided by common factor generated by my_gcd() 
end