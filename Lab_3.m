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
eight = ones(4,16,10);
thirtytwo = ones(4,16,10);
for a = 1:10
    two(:,:,a) = f2(:,(1+16*(a-1)):(16+16*(a-1)));
    eight(:,:,a) = f8(:,(1+16*(a-1)):(16+16*(a-1)));
    thirtytwo(:,:,a) = f32(:,(1+16*(a-1)):(16+16*(a-1)));
end

alpha = 'ABCDEFGHIJ';
start = 6;
for b = (start+1):10
    figure(b-start);
    hold on
    aplot(thirtytwo(:,:,start:(b-start):b));
    title(strcat({'Feature Data '},alpha(start),{' vs. '},alpha(b)));
    hold off
end

