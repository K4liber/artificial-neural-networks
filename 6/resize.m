function OUT = resize( IN, OUTSize )
    
    OUT = [];
    
    for i = 1:1:OUTSize
        steps = int64(length(IN)/OUTSize);
        stop = i*steps-1;
        start = (i-1)*steps+1;
        mean = 0.0;
        
        for j = start:1:stop
            index = uint64(j);
            if length(IN) > index
                mean = mean + (1.0/double(stop-start))*IN(index);
            end
        end
        
        %index = uint8(start);
        OUT = [OUT, mean];
    end
    OUT = OUT;
end

