clc;
clear;

load feat.mat;
% figure(1);
% aplot(f2);
% title('Features For 2x2 Block');
% figure(2);
% aplot(f8);
% title('Features For 8x8 Block');
% figure(3);
% aplot(f32);
% title('Features For 32x32 Block');

two = ones(4,16,10);
eight = two;
thirtytwo = two;

mtwo = ones(2,16,10);
meight = mtwo;
mthirtytwo = mtwo;

mtwo = ones(2,16,10);
meight = mtwo;
mthirtytwo = mtwo;

stwo = ones(2,2,10);
seight = stwo;
sthirtytwo = stwo;

ttwo = ones(4,16,10);
teight = ttwo;
tthirtytwo = ttwo;

for a = 1:10
    two(:,:,a) = f2(:,(1+16*(a-1)):(16+16*(a-1)));
    eight(:,:,a) = f8(:,(1+16*(a-1)):(16+16*(a-1)));
    thirtytwo(:,:,a) = f32(:,(1+16*(a-1)):(16+16*(a-1)));
    
    mtwo(:,a) = mean(two(1:2,:,a)')';
    meight(:,a) = mean(eight(1:2,:,a)')';
    mthirtytwo(:,a) = mean(thirtytwo(1:2,:,a)')';
    
    stwo(:,:,a) = cov(two(1:2,:,a)');
    seight(:,:,a) = cov(eight(1:2,:,a)');
    sthirtytwo(:,:,a) = cov(thirtytwo(1:2,:,a)');
    
    ttwo(:,:,a) = f2t(:,(1+16*(a-1)):(16+16*(a-1)));
    teight(:,:,a) = f8t(:,(1+16*(a-1)):(16+16*(a-1)));
    tthirtytwo(:,:,a) = f32t(:,(1+16*(a-1)):(16+16*(a-1)));
end

ctwo = ones(10,16,10);
ceight = ctwo;
cthirtytwo = ctwo;

for c = 1:10
    for b = 1:16
        for a = 1:10
            ctwo(a,b,c) = (ttwo(1:2,b,a)-mtwo(:,c))'*inv(stwo(:,:,c))*(ttwo(1:2,b,a)-mtwo(:,c));
            ceight(a,b,c) = (teight(1:2,b,a)-meight(:,c))'*inv(seight(:,:,c))*(teight(1:2,b,a)-meight(:,c));
            cthirtytwo(a,b,c) = (tthirtytwo(1:2,b,a)-mthirtytwo(:,c))'*inv(sthirtytwo(:,:,c))*(tthirtytwo(1:2,b,a)-mthirtytwo(:,c));
        end
    end
end

mintwo = ones(16,10);
mintwoloc = mintwo;
mineight = mintwo;
mineightloc = mintwo;
minthirtytwo = mintwo;
minthirtytwoloc = mintwo;

errortwo = ones(10,1);
erroreight = errortwo;
errorthirtytwo = errortwo;

for c = 1:10
    [mintwo(:,c),mintwoloc(:,c)] = min(ctwo(:,:,c));
    [mineight(:,c),mineightloc(:,c)] = min(ceight(:,:,c));
    [minthirtytwo(:,c),minthirtytwoloc(:,c)] = min(cthirtytwo(:,:,c));
    
    errortwo(c) = (10-(sum(mintwoloc(:,c) == c)/c))/16;
    erroreight(c) = (10-(sum(mineightloc(:,c) == c)/c))/16;
    errorthirtytwo(c) = (10-(sum(minthirtytwoloc(:,c) == c)/c))/16;
end


