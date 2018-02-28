%{
ECE592
Hw4 Problem 1
 Nico Casale
 Kudiyar Orazymbetov
%}

%% 
%clear; close all;
addpath('utility', '../images');
setup();
global imagesFolder
overwriteImage = 0;

fprintf('ECE 592 HW 4\n');
fprintf(strcat(datestr(now),'\n'));
% read image
I = double(imread('image3.gif'));
[M, N] = size(I);
%%
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
%%
%methods = {'ezw', 'spiht'; 'stw'; 'wdr'; 'aswdr'; 'spiht_3d'; 'lvl_mmc'; 'gbl_mmc_f'; 'gbl_mmc_h'};
methods = {'ezw', 'spiht', 'stw', 'wdr', 'aswdr', 'spiht_3d', 'lvl_mmc', 'gbl_mmc_f', 'gbl_mmc_h'};
%methods = ['ezw', 'spiht', 'stw', 'wdr', 'aswdr', 'spiht_3d', 'lvl_mmc', 'gbl_mmc_f', 'gbl_mmc_h'];

%methods = cellstr(methods);
mse = zeros(9,1);
for i=1:9
    if i<7
        [cr,bpp] = wcompress('c',I,'I.wtc',methods{i},'maxloop',12);
    elseif i == 7
        [cr,bpp] = wcompress('c',I,'I.wtc',methods{i},'maxloop',12);
    elseif i > 7
        [cr,bpp] = wcompress('c',I,'I.wtc',methods{i},'maxloop',12);
    end
    Xc = wcompress('u','I.wtc');
    delete('I.wtc')
    D1 = abs(I-Xc).^2;
    mse(i) = sum(D1(:))/numel(I);
end
%%
T = array2table(mse, 'RowNames', methods)