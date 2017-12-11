function out = mydot(t, y, I) 
    a = 1.0;
    b = 3.0;
    c = 1.0;
    d = 5.0;
    r = 0.006;
    s = 4.0;
    Chi = -1.6;
    out = [
        y(2) - a*y(1)^3 + b*y(1)^2 - y(3) + I; 
        c - d*y(1)^2 - y(2); 
        r*(s*(y(1)-Chi) - y(3))
    ];
end