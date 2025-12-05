%% r parameter

clc
clear all
close all

a=1.4;
b=0.3;



N=1000; %iterations
T = 500;   % Points to plot after transient removal
r_values = linspace(0, 4, 1000); % Varying r


for idx = 1:length(r_values)
    r = r_values(idx);
    x=[1.452 0.326];
    y=[0.628 0.854];
for n=1:N
x(n+2)=mod(r*(3*(b*x(n))+1)*(1-a*(x(n)^2)+y(n))*(1-(1-a*x(n)^2+y(n))),1);
y(n+2)=mod(r*(3*(1-a*(x(n+1)^2+y(n+1))+1))*b*x(n)*(1-b*x(n)),1);

end

 % Store last T points for plotting
    x_final(idx, :) = x(N-T+1:N);
    y_final(idx, :) = y(N-T+1:N);
end

% Plot bifurcation diagram for x(n)
figure;
plot(r_values, x_final, 'b.', 'MarkerSize', 1);
xlabel('r');
ylabel('x');
title('Bifurcation Diagram for x(n)');
grid on;
xticks(0:0.2:4);

% Plot bifurcation diagram for y(n)
figure;
plot(r_values, y_final, 'b.', 'MarkerSize', 1);
xlabel('r');
ylabel('y');
title('Bifurcation Diagram for y(n)');
grid on;
xticks(0:0.2:4);



%% a parameter

clc
clear all
close all

r=1.19;
b=0.3;



N=1000; %iterations
T = 500;   % Points to plot after transient removal
a_values = linspace(0, 2, 1000); % Varying r


for idx = 1:length(a_values)
    a = a_values(idx);
    x=[1.452 0.326];
    y=[0.628 0.854];
for n=1:N
x(n+2)=mod(r*(3*(b*x(n))+1)*(1-a*(x(n)^2)+y(n))*(1-(1-a*x(n)^2+y(n))),1);
y(n+2)=mod(r*(3*(1-a*(x(n+1)^2+y(n+1))+1))*b*x(n)*(1-b*x(n)),1);

end

 % Store last T points for plotting
    x_final(idx, :) = x(N-T+1:N);
    y_final(idx, :) = y(N-T+1:N);
end

% Plot bifurcation diagram for x(n)
figure;
plot(a_values, x_final, 'b.', 'MarkerSize', 1);
xlabel('a');
ylabel('x');
title('Bifurcation Diagram for x(n)');
grid on;
xticks(0:0.2:4);

% Plot bifurcation diagram for y(n)
figure;
plot(a_values, y_final, 'b.', 'MarkerSize', 1);
xlabel('a');
ylabel('y');
title('Bifurcation Diagram for y(n)');
grid on;
xticks(0:0.2:4);

%% b parameter

clc
clear all
close all

r=1.19;
a=1.4;



N=1000; %iterations
T = 500;   % Points to plot after transient removal
b_values = linspace(0, 1, 1000); % Varying r


for idx = 1:length(b_values)
    b = b_values(idx);
    x=[1.452 0.326];
    y=[0.628 0.854];
for n=1:N
x(n+2)=mod(r*(3*(b*x(n))+1)*(1-a*(x(n)^2)+y(n))*(1-(1-a*x(n)^2+y(n))),1);
y(n+2)=mod(r*(3*(1-a*(x(n+1)^2+y(n+1))+1))*b*x(n)*(1-b*x(n)),1);

end

 % Store last T points for plotting
    x_final(idx, :) = x(N-T+1:N);
    y_final(idx, :) = y(N-T+1:N);
end

% Plot bifurcation diagram for x(n)
figure;
plot(b_values, x_final, 'b.', 'MarkerSize', 1);
xlabel('b');
ylabel('x');
title('Bifurcation Diagram for x(n)');
grid on;
xticks(0:0.2:4);

% Plot bifurcation diagram for y(n)
figure;
plot(b_values, y_final, 'b.', 'MarkerSize', 1);
xlabel('b');
ylabel('y');
title('Bifurcation Diagram for y(n)');
grid on;
xticks(0:0.2:4);