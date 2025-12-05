clc;
clear all;
close all;
a=5;
x=[0.245];
x_unique=[0.245];
n=1;
while(n<65536)
x(n+1)=mod(a*x(n),1); %Bernoulli equation
n=n+1;
end
[B,I]=sort(x); %obtain index, I - position, B-value
writematrix(I','confusion_1.xlsx');


