clc;
clear;

load feat.mat;
figure(1);
aplot(f2);
title('Features For 2x2 Block');
figure(2);
aplot(f8);
title('Features For 8x8 Block');
figure(3);
aplot(f32);
title('Features For 32x32 Block');

two = ones(4,16,10);
eight = two;
thirtytwo = two;

mtwo = ones(2,16,10);
meight = mtwo;
mthirtytwo = mtwo;

mtwo = ones(2,16,10);
meight = mtwo;
mthirtytwo = mtwo;

stwo = ones(2,16,10);
seight = mtwo;
sthirtytwo = mtwo;
for a = 1:10
    two(:,:,a) = f2(:,(1+16*(a-1)):(16+16*(a-1)));
    eight(:,:,a) = f8(:,(1+16*(a-1)):(16+16*(a-1)));
    thirtytwo(:,:,a) = f32(:,(1+16*(a-1)):(16+16*(a-1)));
    
    mtwo(:,:,a) = mean(two(1:2,:,a)')';
    meight(:,:,a) = mean(eight(1:2,:,a)')';
    mthirtytwo(:,:,a) = mean(thirtytwo(1:2,:,a)')';
    
    stwo(:,:,a) = cov(two(1:2,:,a)');
    seight(:,:,a) = cov(eight(1:2,:,a)');
    sthirtytwo(:,:,a) = cov(thirtytwo(1:2,:,a)');
end

% alpha = 'ABCDEFGHIJ';
% start = 1;
% for b = (start+1):10
%     figure(b-start+3);
%     hold on
%     aplot(thirtytwo(:,:,start:(b-start):b));
%     title(strcat({'Feature Data '},alpha(start),{' vs. '},alpha(b)));
%     hold off
% end

