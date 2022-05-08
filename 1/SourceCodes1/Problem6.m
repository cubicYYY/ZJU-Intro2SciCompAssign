clear;clc;
% For test only
output_str=join(string(fib(20)),', '); % More pretty output
fprintf("The Fibonacci sequence for N = 20:\n%s\n", output_str);

function nums = fib(N)
% fib(N) returns a list of the first N Fibonacci Numbers.
% N must be an integer.

if N <= 0
    error('N must be positive.'); % Error reporting for illegal N;
end
if N <= 1 % Special judge
    nums = 0;
    return
end
if N == 2
    nums = [0, 1];
    return
end
nums = [0, 1]; % Initial value for the sequence
for now_index = 3:N+1 
% In MATLAB array index starts from 1, but the sequence index starts from 0
% So here is the reason why we offset 1
    nums(now_index) = nums(now_index-1) + nums(now_index-2);
end
end
% Of course we can use the built-in function fib()
% But that's too boring!
% Recursive function? Yes, but the time complexity will be Θ(n^2)
% When it comes to time complexity, the method that applies binary exponentiation
% to matrix can yield F_n in Θ(logn).
% However it’s not so effective when generating a whole sequence
% Just keep it simple.
