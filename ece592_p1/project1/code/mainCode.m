%{
ECE 592 Project 1

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

Nico Casale
ncasale@ncsu.edu
%}

%% PART 1
clear; close all;
addpath('utility', 'kmeans');
setup();
global imagesFolder
overwriteImage = 0;

fprintf('ECE 592 Project 1\n');
fprintf(strcat(datestr(now),'\n'));
% read image
I = double(imread('image3.gif'));
[M, N] = size(I);

%% PART 2
P = 2; % square patch dimension
R = 0.25:0.25:1; % various values for Rate
K = round(2 .^(R*P^2));
for j = 1:length(K)
   % partition into patches
   Ipartitioned = im2col(I, [P P], 'distinct');
   
   % apply k-means
   [idx, Cn] = kmeans(Ipartitioned', K(j));
   
   % reconstruct image
   indexrepresentations = zeros(length(idx), P^2);
   for i = 1:length(idx)
      indexrepresentations(i, :) = Cn(idx(i), :);
   end
   Iquantized = col2im(indexrepresentations', [P P], size(I), 'distinct');
   
   subplot(1, 2, 1);
   imshow(I, []);
   f2 = subplot(1,2,2);
   imshow(Iquantized, []);
   
   % Calculate distortion D
   D(j) = sum(sum((I - Iquantized) .^2)/(M*N));
end

%% PART 3 Rate & Distortion Plot
R = 0.25:0.25:1;
plot(R,D)

%% PART 4 
P = 4;
R = 0.25:0.25:0.75;
K = round(2 .^(R*P^2));
for j = 1:length(K)
   % partition into patches
   Ipartitioned = im2col(I, [P P], 'distinct');
   
   % apply k-means
   [idx, Cn] = kmeans(Ipartitioned', K(j));
   
   % reconstruct image
   indexrepresentations = zeros(length(idx), P^2);
   for i = 1:length(idx)
      indexrepresentations(i, :) = Cn(idx(i), :);
   end
   Iquantized = col2im(indexrepresentations', [P P], size(I), 'distinct');
   
   % compute distortion D
   D1(j) = sum(sum((I - Iquantized) .^2)/(M*N));
end

% Plot RD trade-off for P =2 and P =4;
figure
R = 0.25:0.25:0.75;
plot(R(1:3),D(1:3))
title('RD trade-off for P=2 and P=4')
xlabel('Rate')
ylabel('Error distortion')
hold on
plot(R,D1)
hold off
legend('P = 2', 'P = 4')

%% PART 5
% First run Part 2, then run this part

P = 2; % square patch dimension
R = 0.25:0.25:1;
K = round(2 .^(R*P^2));

for j = 1:length(K)
   % partition into patches
   Ipartitioned = im2col(I, [P P], 'distinct');

   % apply k-means
   [idx, Cn] = kmeans(Ipartitioned', K(j));
   
   % recontstruct image
   indexrepresentations = zeros(length(idx), P^2);
   for i = 1:length(idx)
      indexrepresentations(i, :) = Cn(idx(i), :);
   end
   Iquantized = col2im(indexrepresentations', [P P], size(I), 'distinct');
   
   % plot results
   subplot(1, 2, 1);
   imshow(I, []);
   f2 = subplot(1,2,2);
   imshow(Iquantized, []);
   
   % compute distortion
   D(j) = sum(sum((I - Iquantized) .^2)/(M*N));
   
   for k = 1:K(j)
      Np(k) = sum(idx == k);
   end
   
   H = 0;
   for m = 1:K(j)
      H = H -(Np(m)*P^2/(M*N)*log2(Np(m)*P^2/(M*N)));
   end
   
   r(j) = H/P^2; % look at r array to see rates
end

