%{
ECE 592 HW 2

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

Nico Casale
ncasale@ncsu.edu

Chekad Sarami
csarami@ncsu.edu

%}
%%
clear;

global imagesFolder
imagesFolder = '../images/';
addpath(imagesFolder);

fprintf('ECE 592 Homework 2\n');
fprintf(strcat(datestr(now),'\n'));
numClusters=1; % number of components (clusters) in mixture model
N=200; % total number of samples of training data
grid=-3:0.05:3; % test data grid for each dimension

%%
Gmean=randn(2,numClusters); % locations of centers of clusters for green class
Rmean=randn(2,numClusters); % red class
cov1 = rand(1);
clusterVariance1 = [1 cov1; cov1 1];
cov2 = rand(1);
clusterVariance2 = [1 cov2; cov2 1];
[X1, X2] = meshgrid(grid, grid);
posProb = zeros(size(X1));

for i = 1:length(grid)
   for j = 1:length(grid)
      G(i,j) = mvnpdf([grid(i) grid(j)],Gmean(:,1)',clusterVariance1);
      R(i,j) = mvnpdf([grid(i) grid(j)],Rmean(:,1)',clusterVariance2);
      posProb(i,j) = max(G(i,j), R(i,j));
   end
end

surf(grid,grid,posProb, (G>R)/2);

caxis([min(posProb(:))-.5*range(posProb(:)),max(posProb(:))]);

axis([-3 3 -3 3 0 .3])
title('QDA Bayes'' classifier');
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

%% save images
file = sprintf('qda_bayes');
file = strcat(imagesFolder, file);
print(file, '-dpng');