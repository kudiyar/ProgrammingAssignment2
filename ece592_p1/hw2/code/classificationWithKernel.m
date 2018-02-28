%-------
% classificationWithSimpleKernel.m
% This script goes through examples in Hastie et al.'s book.
% Binary classification is performed in two ways: linear regression
% and nearest neighbors
% Chekad Sarami
%%
clear % often useful to clean up thework space from old variables
close all

%% parameters
num_clusters=2; % number of components (clusters) in mixture model
N=6*1000; % total number of samples of training data
grid=-3:0.1:3; % test data grid for each dimension
num_neighbors=15; % number of neighbors used in K-nearest neighbors
%  
%% mixture models
Gmean=randn(2,num_clusters); % locations of centers of clusters for green class
Rmean=randn(2,num_clusters); % -"- red class

%% training data
samples=zeros(2,N); % locations of samples in 2 dimensions
class_samples=zeros(N,1); % class of each one (green or red)
cluster_variance=0.1; % variance of each cluster around its mean
for n=1:N/2
    Gcluster=ceil(rand(1)*num_clusters); % select green cluster
    Rcluster=ceil(rand(1)*num_clusters); % -"- red
    samples(:,n)=Gmean(:,Gcluster)+sqrt(cluster_variance)*randn(2,1); % generate green sample
    samples(:,n+N/2)=Rmean(:,Rcluster)+sqrt(cluster_variance)*randn(2,1); % -"- red
    class_samples(n)=1; % green
    class_samples(n+N/2)=0; % red
end

% permuting the column whithin each cluster

%X1= samples(: ,1:N/2);
%X2= samples(: ,  1+ N/2:N);
%X1=X1(:, randperm(length(X1)));
%X2=X2(:, randperm(length(X2)));
%samples = [X1 X2];
X = cat(2,ones(1,N/2),zeros(1,N/2));
samples3 = cat(1,samples,X);


%% test data - is the thired 1/6 and last 1/6 of the samples
train = cat(2,samples3(:,1:N/3),samples3(:,N/2+1:5*N/6));
test =  cat(2,samples3(:,N/3+1:N/2),samples3(:,5*N/6+1:N));

%% run classifiers on test grid
%% nearest neighbors
test_NN=zeros(size(test,2),1); % classification results on test data
for n1=1:size(test,2)
        distances=(test(1,n1)-train(1,:)).^2+(test(2,n1)-train(2,:)).^2; % distances to training samples
        [distances_sort,distances_index] = sort(distances);
        neighbors=distances_index(1:num_neighbors);
        class_predicted=(sum(class_samples(neighbors))/num_neighbors>0.5); % NN classifier
        test_NN(n1)=class_predicted; % store classification
end

%[test_NN'  ;test(3,:)]
err0=sum((test_NN' ~= test(3,:)))/length(test_NN)

%% nearest neighbors

err1=knnWithKernel(num_neighbors, train, test)
    
