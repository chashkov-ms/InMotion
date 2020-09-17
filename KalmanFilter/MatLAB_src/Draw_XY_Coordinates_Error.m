X_error_figure = figure ('Name', 'X error', 'NumberTitle','off');

hold on
title('X error');
xlabel('Seq Num');
ylabel('X error, m');
grid on;
axis auto;  

%plot(tag_1(:,3),tag_1(:,4),'ob');
plot(tag_1_out(:,3),kalm_err(:,1));
%lgd1 = legend('before filter', 'after filter');
hold off

Y_error_figure = figure ('Name', 'Y error', 'NumberTitle','off');

hold on
title('Y error');
xlabel('Seq Num');
ylabel('Y error, m');
grid on;
axis auto;  

%plot(tag_1(:,3),tag_1(:,4),'ob');
plot(tag_1_out(:,3),kalm_err(:,2));
%lgd1 = legend('before filter', 'after filter');
hold off