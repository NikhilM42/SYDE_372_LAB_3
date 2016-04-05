clc;
clear;
clf;

load feat.mat;

%% K-Means

zp = zeros(2,10);

%%%Step 1%%%%
repeat = 1;
zploc = zeros(10);
znew = zeros(2,10);
while repeat == 1
    zploc = round(160*rand(1,10));
    repeat = 0;
    for a = 1:10
        if sum(zploc==zploc(a)) > 1 || zploc(a) == 0
            repeat = 1;
        end
    end
end
for b = 1:10
   znew(:,b) = f32(1:2,zploc(b)); 
end

converge = 0;
while converge == 0
    
    zp = znew;
    
    %%%Step 2%%%%
    c = zeros(10,1);
    class = zeros(1,160);
    for a = 1:160
        for b = 1:10
            c(b) = norm(f32(1:2,a)-zp(:,b));
        end
        %%%%Step 3%%%%%%
        [constant,location] = min(c);
        class(a) = location;
    end
    
    %%%%Step 4%%%%
    clustertotal = zeros(2,10);
    clustercounter = zeros(10);
    for a = 1:160
        clustertotal(:,class(a)) = clustertotal(:,class(a)) + f32(1:2,a);
        clustercounter(class(a)) = clustercounter(class(a))+1;
    end
    
    %%%%Step 5%%%%
    converge = 1;
    for b=1:10
        znew(:,b)=clustertotal(:,b)/clustercounter(b);
        if  norm(znew(:,b)-zp(:,b)) > 0
            converge = 0;
        end
    end
    
end

figure(1);
hold on;
aplot(f32);
scatter(zp(1,:),zp(2,:),100,'x','r','LineWidth',3);
title('K-Means Plot');
hold off;

%% Fuzzy K-Means

zp2 = zeros(2,10);

%%%Step 1%%%%
repeat = 1;
zploc = zeros(10);
znew = zeros(2,10);
while repeat == 1
    zploc = round(160*rand(1,10));
    repeat = 0;
    for a = 1:10
        if sum(zploc==zploc(a)) > 1 || zploc(a) == 0
            repeat = 1;
        end
    end
end
for b = 1:10
   znew(:,b) = f32(1:2,zploc(b)); 
end

converge = 0;
while converge == 0
    
    zp2 = znew;
    
    %%%Step 2%%%%
    c = zeros(160,1);
    class = zeros(1,160);
    for a = 1:160
        for b = 1:10
            c(a) = norm(f32(1:2,a)-zp2(:,b));
        end
    end
    
    %%%%Step 4%%%%
    converge = 1;
    numerator = zeros(2,10);
    denominator = zeros(1,10);
    for b = 1:10
        for a=1:160
            numerator(:,b) = numerator(:,b) + f32(1:2,a)*c(a)^2;
            denominator(b) = denominator(b) + c(a)^2;
        end
        znew(:,b) = numerator(:,b)/denominator(b);
        if  norm(znew(:,b)-zp2(:,b)) > 0.1
            converge = 0;
        end
    end
    
end

hold on;
scatter(zp2(1,:),zp2(2,:),100,'x','b','LineWidth',3);
hold off;

