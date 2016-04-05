clc;
clear;

load feat.mat;
two = ones(4,16,10);
eight = two;
thirtytwo = two;

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

for c = 1:10
    [mintwo(:,c),mintwoloc(:,c)] = min(ctwo(:,:,c));
    [mineight(:,c),mineightloc(:,c)] = min(ceight(:,:,c));
    [minthirtytwo(:,c),minthirtytwoloc(:,c)] = min(cthirtytwo(:,:,c));
end

truthtabletwobytwo = zeros(10);
truthtableeightbyeight = zeros(10);
truthtablethirtytwobythirtytwo = zeros(10);

for a = 1:10
    for b = 1:10
        temptwo = sort(mintwoloc)';
        tempeight = sort(mineightloc)';
        tempthirtytwo = sort(minthirtytwoloc)';
        truthtabletwobytwo(a,b) = sum(temptwo(a,:)==b);
        truthtableeightbyeight(a,b) = sum(tempeight(a,:)==b);
        truthtablethirtytwobythirtytwo(a,b) = sum(tempthirtytwo(a,:)==b);
    end
end

errortwo = ones(10,1);
erroreight = errortwo;
errorthirtytwo = errortwo;

for a = 1:10
    errortwo(a) = 100*((sum(truthtabletwobytwo(a,:))-truthtabletwobytwo(a,a))/16);
    erroreight(a) = 100*((sum(truthtableeightbyeight(a,:))-truthtableeightbyeight(a,a))/16);
    errorthirtytwo(a) = 100*((sum(truthtablethirtytwobythirtytwo(a,:))-truthtablethirtytwobythirtytwo(a,a))/16);
end

avgerrortwo = mean(errortwo);
avgerroreight = mean(erroreight);
avgerrorthirtytwo = mean(errorthirtytwo);

finaltabletwo = [[truthtabletwobytwo,errortwo];[zeros(1,10),avgerrortwo]];
finaltableeight = [[truthtableeightbyeight,erroreight];[zeros(1,10),avgerroreight]];
finalttablethirtytwo = [[truthtablethirtytwobythirtytwo,errorthirtytwo];[zeros(1,10),avgerrorthirtytwo]];

fprintf('2x2 Final Table\n');
fprintf('%2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.2f\n',finaltabletwo');
fprintf('\n8x8 Final Table\n');
fprintf('%2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.2f\n',finaltableeight');
fprintf('\n32x32 Final Table\n');
fprintf('%2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.0f %2.2f\n',finalttablethirtytwo');



