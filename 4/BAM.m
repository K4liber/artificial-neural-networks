function [x, y] = BAM(netEv, part, W)
    diff = true;
    %OUTS = [];
    steps = 1;
    
    if strcmp(part,'LEFT')
        x = netEv;
        y = sign(W'*x);
    elseif strcmp(part, 'RIGHT')
        y = netEv;
        x = sign(W*y);
    end
    
    while diff == true
        
        steps = steps + 1;
        y = sign(W'*x);
        W = W';
        x = sign(W'*y);
        W = W';
        diff = false;
        
        if strcmp(part,'LEFT')
            subplot(1,3,1), imshow(reshape(netEv,[7, 7]))
            subplot(1,3,2), imshow(reshape(x,[7, 7]))
            subplot(1,3,3), imshow(reshape(y,[2, 8]))
        elseif strcmp(part, 'RIGHT')
            subplot(1,3,1), imshow(reshape(netEv,[2, 8]))
            subplot(1,3,2), imshow(reshape(x,[7, 7]))
            subplot(1,3,3), imshow(reshape(y,[2, 8]))
        end
        
        if x ~= sign(W*y)
            diff = true;
        end
        
        if y ~= sign(W'*x)
            diff = true;
        end
        
    end
    sprintf('Executed with %d steps.',steps)
    {x, y};
end