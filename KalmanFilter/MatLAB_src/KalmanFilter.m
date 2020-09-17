clear all;
close all;

ReadData();
ParseToTag();

[tag_1_out, kalm_err] = KalmFilter(tag_1);
% [tag_1_out, kalm_err] = KalmFilter_withoutV(tag_1);
Draw_TagsPosition();
Draw_XY_Coordinates();
%Draw_XY_Velocity();
Draw_XY_Coordinates_Error();

%SavePicture();