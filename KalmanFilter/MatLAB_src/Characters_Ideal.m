close all
clear all

F_c = 5;
F = 0:0.01:200;
w_c = 2*pi()*F_c;
H = w_c./(w_c+2*1i*pi().*F);
H2 = H.*H;
fi = angle(H2);

TagsCoordinates_figure = figure ('Name', 'Characteristics', 'NumberTitle','off');

subplot (1,2,1); 
hold on
title('H(f)');
xlabel('F, Hz');
ylabel('H(f)log');
grid on;
axis auto;  
loglog(log10(F),20*log10(abs(H)));

subplot (1,2,2); 
hold on
title('Fi teoret(f)');
xlabel('F, Hz');
ylabel('Fi(f)log');
grid on;
axis auto;  
loglog(log10(F),fi);