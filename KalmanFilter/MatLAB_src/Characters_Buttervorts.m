close all
clear all
T = 0.1;
F_c = 2.1;
N = 1000;
n= 0:N;
F_isp = 1;
signal_in = 10*sin(2*pi()*F_isp.*n*T);
dim = size(signal_in);
signal_out = [signal_in(1)];

for (i=2:dim(2))
    signal_out(i) = signal_out(i-1)+(signal_in(i)-signal_out(i-1))/F_c;
end

TagsCoordinates_figure = figure ('Name', 'Characteristics', 'NumberTitle','off');
L = 20;

subplot (1,2,1); 
hold on
title('Signal IN');
xlabel('n');
ylabel('signal IN');
grid on;
axis auto;  
plot(n(1:L),signal_in(1:L));

subplot (1,2,2); 
hold on
title('Signal OUT');
xlabel('n');
ylabel('signal IN');
grid on;
axis auto;  
plot(n(1:L),signal_out(1:L));
