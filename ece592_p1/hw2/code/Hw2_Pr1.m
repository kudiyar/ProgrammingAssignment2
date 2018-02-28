%{ 
ECE 592 Homework 2
Chekad Sarami

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

Nico Casale
ncasale@ncsu.edu
%}
%%
clear;
%setup();
fprintf('ECE 592 hw 2\n');
fprintf(strcat(datestr(now),'\n'));
numClusters=5; % number of components (clusters) in mixture model
N=200; % total number of samples of training data
grid=-3:0.05:3; % test data grid for each dimension
%%
Gmean=randn(2,numClusters); % locations of centers of clusters for green class
Rmean=randn(2,numClusters); % red class
clusterVariance = [1 0; 0 1];
[X1, X2] = meshgrid(grid, grid);
posProb = zeros(size(X1));
%x = [];
%for k =1:5
    for i = 1:length(grid)
        for j = 1:length(grid)
            G(i,j) = mvnpdf([grid(i) grid(j)],Gmean(:,1)',clusterVariance);
            R(i,j) = mvnpdf([grid(i) grid(j)],Rmean(:,2)',clusterVariance);
            posProb(i,j) = max(G(i,j), R(i,j));
         end
    end
mean = 1/2*(Gmean(:,1) + Rmean(:,1));
f = @(i,j) (1/2*(Gmean(:,1) + Rmean(:,1)) ...
                 - log(G(i,j)/R(i,j))*(Gmean(:,1) - Rmean(:,1))/sum((Gmean(:,1) - Rmean(:,1)).^2));
surf(grid,grid,posProb, (G>R)/2);
%w = @(x,y) dot((Gmean(:,1) - Rmean(1,:))',[x; y] - 1/2*(Gmean(:,1) + Rmean(:,1)));
% x = mean(1);
% y = mean(2);
alpha = 0.5;
caxis([min(posProb(:))-.5*range(posProb(:)),max(posProb(:))]);
axis([-3 3 -3 3 0 .4])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
