clear;clc;
A = [
    -23,-18,2,-19,-15;
    -1,-16,10,1,3;
    -15,-23,1,8,7;
    -19,7,2,19,-4;
    -15,-11,-3,-11,-15];% Matrix (5 x 5) of coefficients
B = [22;-21;-20;-18;-17];% Vector (5 x 1) of constants
xSol1 = A\B;% Method1: using operator \
disp('Method1 x1~x5: ');disp(xSol1'); 
xSol2 = inv(A)*B;
disp('Method2 x1~x5: ');disp(xSol2'); 
% Method2: multiplied by the inverse matrix of A
% Note: Less efficient & less accurate than method1

xSol3 = linsolve(A, B);
disp('Method3 x1~x5: ');disp(xSol3'); 
% Method3: using built-in MATLAB function linsolve()
% which is designated for solving linear equations.

