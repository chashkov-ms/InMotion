function out = ClearRejection(x)

    POROG_V = 0.006;          % Experiment - limit V = 10 m/sec = 0.08 m/msec 

    while (IsFirstReject(x(1,:), x(2,:), x(3,:)))
        x = x(2:end,:);
    end
    
    out = x(1,:);
    dim = size(x);
    numLastPoint = 1;
    for (i=2:dim(1))  
        deltaC = (x(i,1)-x(numLastPoint,1))^2 + (x(i,2)-x(numLastPoint,2))^2;
        porogC = deltaC/((POROG_V*(x(i,3)-x(numLastPoint,3)))^2);
        if porogC < 1
            out = [out; x(i,:)];
            numLastPoint = i;
        end
    end
end