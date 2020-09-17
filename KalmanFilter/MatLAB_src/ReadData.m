fid = fopen('data_18_02_20.csv');
text = textscan(fid, '%s', 6, 'Delimiter', ',');
data = textscan(fid, '%d,%d,%f,%f,%f,%d');
fclose(fid);
tag_id = data{2};
x = data{3};
y = data{4};
time = data{5};
seq_num = data{6};