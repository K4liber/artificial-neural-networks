RGB = imread('index.png');
o=im2double(RGB);
%z=imshow(o)
p = 0.1
A = zeros(size(o,1), size(o,2), 'double');
filtr = [-1/12, -1/6, -1/12; -1/6, 1, -1/6; -1/12, -1/6, -1/12];
for n=2:size(o,1)-1
    for m=2:size(o,2)-1
        part = [o(n-1,m-1), o(n-1,m), o(n-1, m+1); o(n, m-1), o(n, m), o(n, m+1); o(n+1, m-1), o(n+1, m), o(n+1,m+1)];
        z = part*filtr;
        sum = 0;
        for i=1:size(z,1)
            for j=1:size(z,2)
                if (z(i,j) > p)
                    sum=sum+z(i,j);
                end
            end
        end
        if ( sum>p )
            A(n,m) = sum;
        end
    end
end

imshow(A)