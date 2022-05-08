clear;clc;
gcd(44,28);
gcd(14,24);
function gcd(M, N)
% Calculate GCD(M,N)
% If M/N is not designated then got it from user input
switch nargin
        case 0
            M = round(input('Input value of M:'));
            N = round(input('Input value of N:'));
end
while M ~= N % 更相减损法/Euclidean algorithm to calculate GCD
    while M > N
        M = M - N;
    end
%     fprintf("M=%d N=%d\n", M, N); 
% deprecated due to typographical problems
    while M < N
        N = N - M;
    end
    fprintf("M=%d N=%d\n", M, N); % Sketch M and N in loop
end
disp(['Ultimately, value of M is:']);disp(M);
end