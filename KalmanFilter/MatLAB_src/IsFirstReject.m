function flag = IsFirstReject(c1, c2, c3)
    POROG_V = 0.0100;          % Experiment - limit V = 15 m/sec = 0.015 m/msec 
    
    delta1_2 = (c2(1)-c1(1))^2 + (c2(2)-c1(2))^2;
    porog1_2 = delta1_2/((POROG_V*(c2(3)-c1(3)))^2);
    delta1_3 = (c3(1)-c1(1))^2 + (c3(2)-c1(2))^2;
    porog1_3 = delta1_3/((POROG_V*(c3(3)-c1(3)))^2);
    
    if porog1_2 > 1
        if porog1_3 > 1
            flag = true;
            return;
        end
    end
    flag = false;
    return;
end