function out = mydot(t, y, N, I, C) 
    out = y;
    a = 1.0;
    b = 3.0;
    c = 1.0;
    d = 5.0;
    r = 0.006;
    s = 4.0;
    Chi = -1.6;
    
    for i=1:N
        
        xPrim = y(i*3-2);
        yPrim = y(i*3-1);
        zPrim = y(i*3);
        conn = 0.0;
        
        for j=1:N
            conn = conn + C*(y(j*3-2)-xPrim);
        end
        
        % OUT(i) x
        out(i*3-2) = yPrim - a*xPrim^3 + b*xPrim^2 - zPrim + I(i) + conn;
        % OUT(i) x
        out(i*3-1) = c - d*xPrim^2 - yPrim;
        % OUT(i) x
        out(i*3) = r*(s*(xPrim-Chi) - zPrim);
    end
    
    out = out(:);
end