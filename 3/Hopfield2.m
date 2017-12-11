function OUT = Hopfield2(netEv, T, N, J)
    diff = true;
    %OUTS = [];
    while diff == true
        
        netEv = sign(J'*netEv);
        
        diff = false;
        if netEv ~= sign(J'*netEv)
            diff = true;
        end
        
        %OUTS = [OUTS, reshape(netEv, [N,N])];
    end
    %sprintf('Executed with %d steps.',steps)
    OUT = netEv;
    %imshow(OUTS);
end