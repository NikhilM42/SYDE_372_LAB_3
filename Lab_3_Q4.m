clc;
clear;

load feat.mat;

eight = ones(4,16,10);
meight = ones(2,16,10);
seight = ones(2,2,10);
teight  = ones(4,16,10);

for a = 1:10
    eight(:,:,a) = f32(:,(1+16*(a-1)):(16+16*(a-1)));
    meight(:,a) = mean(eight(1:2,:,a)')';
    seight(:,:,a) = cov(eight(1:2,:,a)');
    teight(:,:,a) = f8t(:,(1+16*(a-1)):(16+16*(a-1)));
end

ceight = ones(256,10,256);
cimage = zeros(256,256);

for a = 1:256
    for b = 1:256
        for c = 1:10
            ceight(a,c,b) = ([multf8(a,b,1);multf8(a,b,2)]-meight(:,c))'*inv(seight(:,:,c))*([multf8(a,b,1);multf8(a,b,2)]-meight(:,c));
        end
        [temp,cimage(a,b)] = min(ceight(a,:,b));
    end
end

figure(1);
imagesc(multim);
figure(2);
imagesc(cimage);