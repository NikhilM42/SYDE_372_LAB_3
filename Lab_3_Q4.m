clear;
load('feat.mat', 'multim', 'multf8');

% multim = image with different textures
% multf8 = feature sets where n = 8
% ceight = classifier for n = 8

f8_size = size(multf8);
x_axis = 1;
y_axis = 2;
f_axis = 3;
dim = 4;
dim2 = dim^2;

count = 0;
f8t = zeros(2, f8_size(x_axis)*f8_size(y_axis));
for iter1 = 1:dim:f8_size(x_axis)
    for iter2 = 1:dim:f8_size(y_axis)
%         for iter3 = 1:dim2
%             f8t(:,iter3 + (iter1 - 1)*dim + (iter2 - 1)*dim) = ...
%                 multf8(iter1, iter2, :);
            count = count + 1;
            temp = multf8(iter1:iter1 + dim - 1, iter2:iter2 + dim - 1, 1);
            index = (iter1 - 1)*dim2^2 + (iter2 - 1)*dim2 + 1;
            f8t(1,index:index + dim2 - 1) = temp(1:dim2);
            temp = multf8(iter1:iter1 + dim - 1, iter2:iter2 + dim - 1, 2);
            f8t(2,index:index + dim2 - 1) = temp(1:dim2);
%         end
    end
end

results = classifier(dim2, f8t);
len = length(results);
selected = zeros(len - 189,1);
cimage_t = zeros(f8_size(x_axis));

for iter1 = 1:(len-189)
%     for iter2 = 
    selected(iter1) = mode(results(:,iter1));
%     cimage_t(floor((iter1 - 1)/f8_size(x_axis) + 1), ...
%         mod(iter1 - 1,f8_size(x_axis)) + 1) = selected;
end
cimage = reshape(selected,[64 64]);

figure(2);
imagesc(cimage);
test = 1;