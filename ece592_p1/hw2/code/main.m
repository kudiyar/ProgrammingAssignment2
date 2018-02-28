%-------
% This is used to compare kNN and the kerneled one
%% creating dataset and spliting it into training and testing sets
clear % often useful to clean up thework space from old variables
close all

num_clusters=5; % number of components (clusters) in mixture model
N=6*800; % total number of samples of training data


%% Trying different cluster variances and number of neighbors

cvs = .2:.2:1; % different cluster varations
nns = 3:2:9; % differnt number of neighbors to consider in kNN and kNN with kernel.
avgErrors = zeros(length(cvs), length(nns),2);
repeat = 10;
for i=1:length(cvs)
    for j=1:length(nns)
        err0tot =0;
        err1tot=0;
        for it =1:repeat
            [train, test] = dataSetCreator(num_clusters, N,cvs(i));
            err0tot= err0tot +           knn(nns(j), train, test);
            err1tot= err1tot+  knnWithKernel(nns(j), train, test)
        end
        avgErrors(i,j,1) = err0tot/repeat;
        avgErrors(i,j,2) = err1tot/repeat;
    end
end
        
avgErrors
sum(sum(avgErrors))
avgErrors(:,:,2)-avgErrors(:,:,1)

