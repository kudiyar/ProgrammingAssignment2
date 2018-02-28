function [train, test] = dataSetCreator(num_clusters, N,cluster_variance) 
% dataSetCreator.m: this creates mixture data set with multivariate Gausisan distribution, given, number of clusters,
% N ( size of complete dataset), grid ( x and y limits), and cluster_variations
% splits the dataset into test and data set


    %% mixture models
    Gmean=randn(2,num_clusters); % locations of centers of clusters for green class
    Rmean=randn(2,num_clusters); % -"- red class

    %% training data
    samples=zeros(2,N); % locations of samples in 2 dimensions
    class_samples=zeros(N,1); % class of each one (green or red)
    for n=1:N/2
        Gcluster=ceil(rand(1)*num_clusters); % select green cluster
        Rcluster=ceil(rand(1)*num_clusters); % -"- red
        samples(:,n)=Gmean(:,Gcluster)+sqrt(cluster_variance)*randn(2,1); % generate green sample
        samples(:,n+N/2)=Rmean(:,Rcluster)+sqrt(cluster_variance)*randn(2,1); % -"- red
        class_samples(n)=1; % green
        class_samples(n+N/2)=0; % red
    end

    X = cat(2,ones(1,N/2),zeros(1,N/2));
    samples3 = cat(1,samples,X);


    %% test data - is the thired 1/6 and last 1/6 of the samples
    train = cat(2,samples3(:,1:N/3),samples3(:,N/2+1:5*N/6));
    test =  cat(2,samples3(:,N/3+1:N/2),samples3(:,5*N/6+1:N));
end