X_velocity_figure = figure ('Name', 'X Velovity', 'NumberTitle','off');

hold on
title('X Velocity');
xlabel('Seq Num');
ylabel('X Velocity, m');
grid on;
axis auto; 
ylim([-0.1,0.1]);

%plot(tag_1(:,3),tag_1(:,4),'ob');
plot(tag_1_out(:,3),tag_1_out(:,4));
%lgd1 = legend('before filter', 'after filter');
hold off

Y_velocity_figure = figure ('Name', 'Y Velovity', 'NumberTitle','off');

hold on
title('Y Velocity');
xlabel('Seq Num');
ylabel('Y Velocity, m');
grid on;
axis auto;  
ylim([-0.1,0.1]);

%plot(tag_1(:,3),tag_1(:,5),'ob');
plot(tag_1_out(:,3),tag_1_out(:,5));
%lgd1 = legend('before filter', 'after filter');
hold off