function out = Restore_10_Hz(x)
    out = x(1,:);
    startInputPosition = 3;
    nextPosition = x(1,4)+1; 
    if (x(2,4) ~= nextPosition)
        out = [out; x(1,:)];
        out(2,3) = out(2,3)+100;
        out(2,4) = nextPosition;
        startInputPosition = startInputPosition - 1;
    else
        out = [out; x(2,:)];
    end
    nextPosition = nextPosition+1;
    
    dim = size(x);
    i=startInputPosition;
    cntDataAdd = 0;
    flagDataAdd = false;
    while (i<=dim(1))
        if (x(i,4) < nextPosition)
            i = i+1;
            continue;
        end
        if (x(i,4) ~= nextPosition)
            flagDataAdd = true;
            cntDataAdd = cntDataAdd+1;
        else
            if (flagDataAdd)
                flagDataAdd = false;
                new_data = FindNewData(out, x(i,:), cntDataAdd);
                out = [out; new_data];
                cntDataAdd = 0;
            else
                out = [out; x(i,:)];
            end
            i = i+1;
        end
        nextPosition = nextPosition + 1;
end