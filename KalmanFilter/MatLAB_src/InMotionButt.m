clear all;
close all;

ReadData();
ParseToTag();
clear i text x y time tag_id seq_num fid;

tag_1_out = ClearRejection(tag_1);
tag_2_out = ClearRejection(tag_2);
tag_3_out = ClearRejection(tag_3);
tag_4_out = ClearRejection(tag_4);
tag_5_out = ClearRejection(tag_5);
tag_6_out = ClearRejection(tag_6);

tag_1_out = Restore_10_Hz(tag_1_out);
tag_2_out = Restore_10_Hz(tag_2_out);
tag_3_out = Restore_10_Hz(tag_3_out);
tag_4_out = Restore_10_Hz(tag_4_out);
tag_5_out = Restore_10_Hz(tag_5_out);
tag_6_out = Restore_10_Hz(tag_6_out);

tag_1_adapt = Adaptation(tag_1_out);
tag_2_adapt = Adaptation(tag_2_out);
tag_3_adapt = Adaptation(tag_3_out);
tag_4_adapt = Adaptation(tag_4_out);
tag_5_adapt = Adaptation(tag_5_out);
tag_6_adapt = Adaptation(tag_6_out);

DrawAdaptationResult(tag_1_out, tag_1_adapt, 'tag 219');
DrawAdaptationResult(tag_2_out, tag_2_adapt, 'tag 212');
DrawAdaptationResult(tag_3_out, tag_3_adapt, 'tag 215');
DrawAdaptationResult(tag_4_out, tag_4_adapt, 'tag 213');
DrawAdaptationResult(tag_5_out, tag_5_adapt, 'tag 217');
DrawAdaptationResult(tag_6_out, tag_6_adapt, 'tag 203');


tag_1_out = ButtFilter(tag_1_out);
tag_2_out = ButtFilter(tag_2_out);
tag_3_out = ButtFilter(tag_3_out);
tag_4_out = ButtFilter(tag_4_out);
tag_5_out = ButtFilter(tag_5_out);
tag_6_out = ButtFilter(tag_6_out);

Draw_TagsPosition();
Draw_TagsPositionAdapt();
