clear S_F;
dim = size(tag_1);
S_F (dim(1)) = 0;
for (i=1:dim(1))
    for (j = 1:dim(1))
        S_F(i) =S_F(i)+tag_1(j,1)*exp(-2*(j-1)*(i-1)/dim(1)*pi()*1i);
    end
end
S_F = S_F/dim(1);
SF_log = 20*log10(abs(S_F));

TagsCoordinates_figure = figure ('Name', 'Spektr', 'NumberTitle','off');
hold on;
title('Signal(f)');
xlabel('n');
ylabel('S(f)_log');
grid on;
axis auto;
xlim([0,51]);
n = 1:dim(1);
plot(n(1:50),SF_log(1:50));
plot(n(1:50),SF_log(1:50),'or');


