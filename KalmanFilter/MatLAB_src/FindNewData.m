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

a0 = oldData(end,2)-oldData(end,1)/deltaX*deltaY;
a1 = deltaY/deltaX;
for (i=1:numAddData)
    newY(i) = a0 + newX(i)*a1;
end       
        
c_new = [newX', newY', newtime, newSeqNum];
c_new = [c_new; lastData];
end