function OUT = Cover(net1, net2, N)
    OUT = 0.0;
    for i =  1 : N
        OUT = OUT + (net1(i)*net2(i))/N;
    end
end