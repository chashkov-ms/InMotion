tag_1 = double([0.0, 0.0, 0.0, 0.0]);  %219 tag format [X, Y, Time, SeqNum]
tag_2 = [0.0, 0.0, 0.0, 0.0];  %212 
tag_3 = [0.0, 0.0, 0.0, 0.0];  %215 
tag_4 = [0.0, 0.0, 0.0, 0.0];  %213 
tag_5 = [0.0, 0.0, 0.0, 0.0];  %217 
tag_6 = [0.0, 0.0, 0.0, 0.0];  %203 

for (i=1:length(tag_id))
    switch (tag_id(i))
        case 219.0
            tag_1 = [tag_1; double(x(i)), double(y(i)), double(time(i)), double(seq_num(i))];
        case 212.0
            tag_2 = [tag_2; double(x(i)), double(y(i)), double(time(i)), double(seq_num(i))];
        case 215.0
            tag_3 = [tag_3; double(x(i)), double(y(i)), double(time(i)), double(seq_num(i))];
        case 213.0
            tag_4 = [tag_4; double(x(i)), double(y(i)), double(time(i)), double(seq_num(i))];
        case 217.0
            tag_5 = [tag_5; double(x(i)), double(y(i)), double(time(i)), double(seq_num(i))];
        case 203.0
            tag_6 = [tag_6; double(x(i)), double(y(i)), double(time(i)), double(seq_num(i))];
    end
end

tag_1 = tag_1(2:end,:);
tag_2 = tag_2(2:end,:);
tag_3 = tag_3(2:end,:);
tag_4 = tag_4(2:end,:);
tag_5 = tag_5(2:end,:);
tag_6 = tag_6(2:end,:);