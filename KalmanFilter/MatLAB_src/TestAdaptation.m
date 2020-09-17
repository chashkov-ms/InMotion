clear all
close all

N = 314;
for (i=1:N)
    x(i) = rand*10-5+sin(i/50)*50;
    y (i)= rand*10-5+cos(i/50)*50;
end
% clear x y
% x = [-3.904582971, 0.792152101, -1.876365117, 8.573002154, 8.757893359, ...
%     10.22903268, 5.395628299, 8.613722339, 4.20509889, 14.27111153, ...
%     12.10974892, 13.943473,   8.629060114, 13.75503933, 18.0977284, ...
%     15.94733605, 16.12467059, 17.05988627, 22.36760311, 19.9570902, ...
%     20.55645945, 17.41742365, 26.25037083, 20.77587099, 21.07622518, ...
%     28.38769714, 28.60781454, 29.50577305, 31.80841738, 27.45377812];
% 
% y = [71.59802528, 68.5283097, 68.21618983, 71.01371607, 66.90295324, ...
%     66.74337225, 69.14860502, 68.91343644, 70.829489, 70.38298584, ...
%     66.51060562, 67.61407083, 65.28791167, 65.60902457, 65.19352221, ...
%     65.71428468, 64.88632604, 65.85610299, 63.31862337, 66.30892427, ...
%     62.97955076, 60.66987041, 61.97447755, 64.05091581, 61.23877158, ...
%     58.27562142, 59.13161533, 58.12815081, 57.18631782, 60.49239281];

Data = [x', y'];
AdaptData = Adaptation(Data);


TagsCoordinates_figure = figure ('Name', 'Tags Coordinates', 'NumberTitle','off');

hold on
title('Coordinates ');
xlabel('X coordinate, m');
ylabel('Y coordinate, m');
grid on;
axis auto;  
% xlim([-1,30]);
% ylim([-1,15]);
plot(x,y,'.b');
plot(AdaptData(:,1),AdaptData(:,2));