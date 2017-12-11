N = 20;
Count = 300;
mSr = [];
OUTS = zeros(Count, N*N);

% Generate 'Count' random patterns
Patterns = randi([0 1], Count, N, N)*2-1;

% Generate modified patterns
PatternsMod = Patterns;
for i = 1 : Count 
    Pattern = Patterns(i,:,:);
    PatternLin = Pattern(:);
    
    for j = 1 : size(PatternLin)
        
       if rand() <= 0.4
          PatternLin(j) = -PatternLin(j); 
       end
       
    end
    
    PatternsMod(i,:,:) = reshape(PatternLin, [N,N]);
end

% Main Loop
for i = 1 : Count
    sprintf('Loop number %d', i)
    % Count J matrix
    J = zeros(N*N, N*N);
    pattModI = PatternsMod(i,:,:);
    
    for j = 1 : i
        pattJ = Patterns(j,:,:);
        J = J + (pattJ(:)*pattJ(:)')/N;
    end
    
    OUTS(i,:) = Hopfield(pattModI(:), 0.1, N, J);
    mI = 0.0;
    
    for z = 1 : i
        pattZ = Patterns(z,:,:);
        mI = mI + Cover(pattZ(:)', OUTS(z,:), N*N);
    end
    
    mI = mI/i;
    mSr = [mSr, mI];
end

plot(1:1:Count, mSr)