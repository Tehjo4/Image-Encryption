% COUPLED 2d HENON LOGISTIC MAP
clc
clear all
close all
%control parameters
r=3.99 ;
a=1.999;
b=0.99999;

x = zeros(1, 65536);
y = zeros(1, 65536); 

x(1)=0.452;
x(2)=0.326;
y(1)=0.628;
y(2)=0.854;
tic;
for n=1:65534
x(n+2)=mod(r*(3*(b*x(n))+1)*(1-a*(x(n)^2)+y(n))*(1-(1-a*x(n)^2+y(n))),1);
y(n+2)=mod(r*(3*(1-a*(x(n+1)^2+y(n+1))+1))*b*x(n)*(1-b*x(n)),1);

end
toc;
x=mod(x*10^7,256);%whole number conversion, positive values
y=mod(y*10^7,256);

x2=uint8(x);%unsigned (+ve) 0-255
y2=uint8(y);
y2=y2';
x2=x2';


%writematrix(x2,'clheon_x_uint8.xlsx');
%writematrix(y2,'clheon_y_uint8.xlsx');
