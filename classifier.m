function mineightloc = classifier(dim, f8t)
    % clc;
    % clear;

    load('feat.mat', 'f8');
    class_num = length(f8)/dim;
    sample_num = length(f8t)/dim;


    eight = ones(2,dim,class_num);
    meight = ones(2,dim,class_num);
    seight = ones(2,2,class_num);
    teight = ones(2,dim,sample_num);


    for a = 1:class_num
        eight(:,:,a) = f8(1:2,(1+16*(a-1)):(16+16*(a-1)));
        meight(:,a) = mean(eight(1:2,:,a)')';
        seight(:,:,a) = cov(eight(1:2,:,a)');
    end
    for a = 1:sample_num
        teight(:,:,a) = f8t(1:2,(1+16*(a-1)):(16+16*(a-1)));
    end

    ceight = ones(sample_num,dim,class_num);

    for c = 1:class_num
        for b = 1:dim
            for a = 1:sample_num
                ceight(a,b,c) = (teight(1:2,b,a)-meight(:,c))'*inv(seight(:,:,c))*(teight(1:2,b,a)-meight(:,c));
            end
        end
    end

    mineight = ones(dim,sample_num);
    mineightloc = ones(dim,sample_num);

    for c = 1:sample_num
        [mineight(:,c),mineightloc(:,c)] = min(ceight(c,:,:),[],3);
    end
end



