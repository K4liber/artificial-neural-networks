N = 10;
tspan = [0 1000];
net = rand(1,3,10);
xPlot = [];
yPlot = [];
I = 3*rand(1,N,1)+1;
size = 101;
deltasGlob = zeros(size,size);

for C = 0.0:0.01:1;
    
    [t, y] = ode45(@(t, zmienne) mydot2(t, zmienne, N, I, C), tspan, net(:));
    deltas = [];
    for j = 1:length(t)
        delta = 0;
        for i = 1:N
            delta = delta + 1.0/(N-1) * abs((y(j,i*3-2)-y(j,1)));
        end
        deltas = [deltas, delta];
    end
    
    strcat(num2str(C*100), ' %')
    
    deltaGlob = resize(deltas, size);
    deltasGlob(:,uint8(C*(size-1))+1) = deltaGlob;
     
    %plot(C, resize(t, 11), deltas)
    
end

C = 0.0:0.01:1.0;
time = resize(0:1:1000, size);
deltas = resize(deltas, size);

surf(C, time, deltasGlob)
zlabel('Delta')
xlabel('C')
ylabel('time')
        
