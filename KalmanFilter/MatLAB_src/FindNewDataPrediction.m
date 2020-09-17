function c_new = FindNewData(old_data)
t2 = old_data(end-1,3);
t3 = old_data(end,3);
A = [t2, (t2^2)/2; t3, (t3^2)/2];
B_X =[old_data(end-1,1)-old_data(end-2,1); old_data(end,1)-old_data(end-1,1)]; 
B_Y =[old_data(end-1,2)-old_data(end-2,2); old_data(end,2)-old_data(end-1,2)]; 

V_A_X = inv(A)*B_X;
V_A_Y = inv(A)*B_Y;

seqNumNew = old_data(end,4)+1;
t_new = old_data(end,3)+100;
x_new = old_data(end,1) + V_A_X(1)*t_new + V_A_X(2)/2*t_new^2;
y_new = old_data(end,2) + V_A_Y(1)*t_new + V_A_Y(2)/2*t_new^2;

c_new = [x_new, y_new, t_new, seqNumNew];

POROG_V = 0.010;          % Experiment - limit V = 15 m/sec = 0.015 m/msec 

deltaC = (x_new - old_data(end,1))^2 + (y_new - old_data(end,2))^2;
porogC = deltaC/((POROG_V*100)^2);
if (porogC < 1)
    c_new = [x_new, y_new, t_new, seqNumNew];
else
    c_new = [old_data(end,1), old_data(end,2), t_new, seqNumNew];
end
end