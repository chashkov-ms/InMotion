TagsCoordinates_figure = figure ('Name', 'Tags Coordinates', 'NumberTitle','off');

subplot (1,2,1); 
hold on
title('Coordinates Before Filtering');
xlabel('X coordinate, m');
ylabel('Y coordinate, m');
grid on;
axis auto;  
% xlim([-1,30]);
% ylim([-1,15]);

plot(tag_1(:,1),tag_1(:,2),'.b');
plot(tag_2(:,1),tag_2(:,2),'.c');
plot(tag_3(:,1),tag_3(:,2),'.y');
plot(tag_4(:,1),tag_4(:,2),'.r');
plot(tag_5(:,1),tag_5(:,2),'.g');
plot(tag_6(:,1),tag_6(:,2),'.k');   
lgd1 = legend('tag 219','tag 212','tag 215','tag 213','tag 217','tag 203');
hold off


subplot (1,2,2); 
hold on
title('Coordinates After Filtering');
xlabel('X coordinate, m');
ylabel('Y coordinate, m');
grid on;
axis auto;  
xlim([-10,35]);
ylim([-10,20]);

plot(tag_1_out(:,1),tag_1_out(:,2),'.b');
plot(tag_2_out(:,1),tag_2_out(:,2),'.c');
plot(tag_3_out(:,1),tag_3_out(:,2),'.y');
plot(tag_4_out(:,1),tag_4_out(:,2),'.r');
plot(tag_5_out(:,1),tag_5_out(:,2),'.g');
plot(tag_6_out(:,1),tag_6_out(:,2),'.k');   
lgd1 = legend('tag 219','tag 212','tag 215','tag 213','tag 217','tag 203');

hold off
