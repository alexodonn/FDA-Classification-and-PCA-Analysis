%%

load('blah'); % Eigen values are important
a = dir('generated_faces/generated_faces/*.png');
clear error_reconstruct;
clear errs_sorted;
tic

featvecmat2 = zeros(size(a,1),12288);
for i = 1 : size(a,1)       
   I = imread(['generated_faces/generated_faces/',a(i).name]);
   featvecmat2(i,:) = I(:);       % Transform generated images into feature matrix
end

toc
%%
featvecmat2 = double(featvecmat2);
error_threshold = 2.33*10^6;        %99.9% of images of faces were classified correctly (This was to take outlyers into account)

newfeatvec = zeros(size(a,1),num_components);              %New feature vector array of generated images 
for O = 1:size(a,1)
    
    % For the Oth image
    mean_sunset = double(mean(featvecmat2));
    imvecO = featvecmat2(O,:)'- double(mean_sunset');
    proj_vecO = coeff(:,1:num_components)'*imvecO;            % Project the i first principle components
    newfeatvec2(i,:) = proj_vecO;                              % Project features into new feature space
    
    imavec_reconstructed = double(mean_sunset');
    for mmm = 1:num_components
        imavec_reconstructed = imavec_reconstructed + proj_vecO(mmm)*coeff(:,mmm);
    end
    
    
    error_reconstruct(O) = sum((featvecmat2(O,:)'-imavec_reconstructed).^2);
    
    

%
    if error_reconstruct(O)< error_threshold
        face(O) = 1; % Image is face if it was reconstructed with low error from the n principle components
    else
        face(O) = 0;
    end
    
    if(mod(O,50)==0)
       disp(O) 
    end
end

%%
errs_sorted = sort(error_reconstruct)
errmax = max(error_reconstruct)
a2 = find(error_reconstruct==errs_sorted(500))
acc = sum(face)/size(a,1)
% err_new_im = error_reconstruct(2)


% LDA classifier



% KNN Classifier



% SVM
