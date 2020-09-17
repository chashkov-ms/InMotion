TagsCoordinates_figure = figure ('Name', 'Tags Coordinates', 'NumberTitle','off');

subplot (1,2,1); 
hold on
title('Coordinates Before Adaptation');
xlabel('X coordinate, m');
ylabel('Y coordinate, m');
grid on;
axis auto;  
xlim([-1,35]);
ylim([-5,20]);

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
title('Coordinates After Adaptation');
xlabel('X coordinate, m');
ylabel('Y coordinate, m');
grid on;
axis auto;  
xlim([-1,35]);
ylim([-5,20]);

plot(tag_1_adapt(:,1),tag_1_adapt(:,2),'.b');
plot(tag_2_adapt(:,1),tag_2_adapt(:,2),'.c');
plot(tag_3_adapt(:,1),tag_3_adapt(:,2),'.y');
plot(tag_4_adapt(:,1),tag_4_adapt(:,2),'.r');
plot(tag_5_adapt(:,1),tag_5_adapt(:,2),'.g');
plot(tag_6_adapt(:,1),tag_6_adapt(:,2),'.k');   
lgd1 = legend('tag 219','tag 212','tag 215','tag 213','tag 217','tag 203');

hold off
