clear;clc;
fprintf("%d ", The_date_difference(20210101,20210105));
fprintf("%d ", The_date_difference(20210105,20210101));
fprintf("%d ", The_date_difference(20210105,20210106)); % Consecutive days
fprintf("%d ", The_date_difference(20120228,20120301)); % Leap year
fprintf("%d ", The_date_difference(20110228,20110301)); % Not leap year
fprintf("%d ", The_date_difference(20000228,20000301)); % Leap year
fprintf("%d ", The_date_difference(19000228,19000301)); % Not leap year
fprintf("%d ", The_date_difference(18000128,19050630));
function difference=The_date_difference(time1,time2)
% Manually extract the Y/M/D from integers in the form of YYYYMMDD
m2d = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
if time1>time2 % inplace swap
    time1=bitxor(time1, time2);
    time2=bitxor(time2, time1);
    time1=bitxor(time1, time2);
end
year1 = fix(time1/10000);year2 = fix(time2/10000);
month1 = rem(fix(time1/100), 100);month2 = rem(fix(time2/100), 100);
day1 = rem(time1, 100);day2 = rem(time2, 100);
isLeapYear = @(n)((rem(n,4)==0&rem(n,100))|(rem(n,400)==0));
difference = 365*(year2-year1) + sum(isLeapYear(year1:year2-1));
% Whole years between dates
m2d(2) = 28 + isLeapYear(year1);
for i=1:month1-1 % Delete remain days in year1
    difference = difference - m2d(i);
end
difference = difference - day1;
m2d(2) = 28 + isLeapYear(year2);
for i=1:month2-1 % Add remain days in year2
    difference = difference + m2d(i);
end
difference = difference + day2 + 1;
end
