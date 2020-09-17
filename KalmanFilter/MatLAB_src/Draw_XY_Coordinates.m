X_coordinate_figure = figure ('Name', 'X Coordinates', 'NumberTitle','off');

hold on
title('X Coordinates');
xlabel('Seq Num');
ylabel('X coordinate, m');
grid on;
axis auto;  
ylim([10,25]);

plot(tag_1(:,3),tag_1(:,1),'ob');
plot(tag_1_out(:,3),tag_1_out(:,1));
lgd1 = legend('before filter', 'after filter');
hold off

Y_coordinate_figure = figure ('Name', 'Y Coordinates', 'NumberTitle','off');

hold on
title('Y Coordinates');
xlabel('Seq Num');
ylabel('Y coordinate, m');
grid on;
axis auto;  
ylim([-1,15]);

plot(tag_1(:,3),tag_1(:,2),'ob');
plot(tag_1_out(:,3),tag_1_out(:,2));
lgd1 = legend('before filter', 'after filter');
hold off