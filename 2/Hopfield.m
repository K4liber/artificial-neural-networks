function OUT = Hopfield(netEv, T, N, J)
    diff = true;
    steps = 0;
    OUTS = [];
    while diff == true
        steps = steps + 1;
        h = zeros(N*N, 'double');
        for i = 1 : N*N
            for j=1: N*N
                h(i) = h(i) + J(i,j)*netEv(j);
            end
        end
        diff = false;
        for i = 1 : N*N
            if ~diff && netEv(i) ~= sign(h(i) - T)
                diff = true;
            end
            netEv(i) = sign(h(i) - T);
        end
        OUTS = [OUTS, reshape(netEv, [N,N])];
    end
    sprintf('Executed with %d steps.',steps)
    OUT = netEv;
    imshow(OUTS);
end