function out = Restore_10_Hz(x)
    out = x(1,:);
    startInputPosition = 4;
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
    
    if (x(3,4) ~= nextPosition)
        out = [out; x(2,:)];
        out(3,3) = out(3,3)+100;
        out(3,4) = nextPosition;
        startInputPosition = startInputPosition - 1;
    else
        out = [out; x(3,:)];
    end
    nextPosition = nextPosition+1;
    
    dim = size(x);
    i=startInputPosition;
    while (i<=dim(1))
        if (x(i,4) < nextPosition)
            i = i+1;
            continue;
        end
        if (x(i,4) ~= nextPosition)
            new_data = FindNewDataPrediction(out);
            out = [out; new_data];
        else
            out = [out; x(i,:)];
            i = i+1;
        end
        nextPosition = nextPosition + 1;
end