function c_new = FindNewData(oldData, lastData, numAddData)
deltaX = lastData(1) - oldData(end,1);
deltaY = lastData(2) - oldData(end,2);

stepY = deltaY/(numAddData+1);
newY = [oldData(end,2)+stepY];
stepX = deltaX/(numAddData+1);
newX = [oldData(end,1)+stepX];
newtime = [oldData(end,3)+100];
newSeqNum = [oldData(end,4)+1];

for (i=2:numAddData)
    newY = [newY, oldData(end,2)+stepY*i];
    newX = [newX, oldData(end,1)+stepX*i];
    newtime = [newtime; oldData(end,3)+100*i];
    newSeqNum = [newSeqNum; oldData(end,4)+i];
end    


if (abs(deltaX) < abs(deltaY))
    stateX = [oldData(end-1,1), oldData(end,1), lastData(1)];       %y(x)
    stateY = [oldData(end-1,2), oldData(end,2), lastData(2)];
    
    a0 = stateY(1)*stateX(2)*stateX(3)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3)))+ ...   %y(x) = a0 + a1*x +a2*x^2
        stateY(2)*stateX(1)*stateX(3)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3)))+ ...
        stateY(3)*stateX(1)*stateX(2)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2)));
    a1 = -stateY(1)*stateX(2)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3))) ...
        -stateY(1)*stateX(3)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3))) ...
        -stateY(2)*stateX(1)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3))) ...
        -stateY(2)*stateX(3)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3))) ...
        -stateY(3)*stateX(1)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2))) ...
        -stateY(3)*stateX(2)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2)));
        
    a2 = stateY(1)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3)))+ ...
        stateY(2)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3)))+ ...
        stateY(3)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2))); 
    
    if ((~isinf(a0)) | (~isinf(a1)) | (~isinf(a2))) 
        for (i=1:numAddData)
            newY(i) = a0+a1*newX(i)+a2*newX(i)^2;
        end       
    end
        
else
    stateY = [oldData(end-1,1), oldData(end,1), lastData(1)];       %x(y)
    stateX = [oldData(end-1,2), oldData(end,2), lastData(2)];

    a0 = stateY(1)*stateX(2)*stateX(3)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3)))+ ...    %x(y) = a0 + a1*y +a2*y^2
        stateY(2)*stateX(1)*stateX(3)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3)))+ ...
        stateY(3)*stateX(1)*stateX(2)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2))); 
    a1 = -stateY(1)*stateX(2)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3))) ...
        -stateY(1)*stateX(3)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3))) ...
        -stateY(2)*stateX(1)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3))) ...
        -stateY(2)*stateX(3)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3))) ...
        -stateY(3)*stateX(1)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2))) ...
        -stateY(3)*stateX(2)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2)));
        
    a2 = stateY(1)/((stateX(1)-stateX(2))*(stateX(1)-stateX(3)))+ ...
        stateY(2)/((stateX(2)-stateX(1))*(stateX(2)-stateX(3)))+ ...
        stateY(3)/((stateX(3)-stateX(1))*(stateX(3)-stateX(2)));
    
    if ((~isinf(a0)) | (~isinf(a1)) | (~isinf(a2))) 
        for (i=1:numAddData)
            newX(i) = a0+a1*newY(i)+a2*newY(i)^2;
        end       
    end
end

c_new = [newX', newY', newtime, newSeqNum];
c_new = [c_new; lastData];
end