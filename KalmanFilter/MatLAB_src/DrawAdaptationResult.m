function y = DrawAdaptationResult(dataIn, dataOut, tag)


TagsCoordinates_figure = figure ('Name', 'Tags Coordinates', 'NumberTitle','off');

hold on
title('Coordinates');
xlabel('X coordinate, m');
ylabel('Y coordinate, m');
grid on;
axis auto;  

plot(dataIn(:,1),dataIn(:,2), '-r');
p2 = plot(dataOut(:,1),dataOut(:,2),'*-b');
lgd1 = legend([tag, ' data'], [tag, ' adaptation']);


p2.MarkerSize = 4;
p2.LineWidth = 0.8;
hold off

y = 1;

end