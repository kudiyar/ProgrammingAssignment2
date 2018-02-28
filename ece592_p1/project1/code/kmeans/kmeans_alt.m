%{
ECE 592 Project 1

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

Nico Casale
ncasale@ncsu.edu

This is our own implementation of K-means
https://en.wikipedia.org/wiki/K-means_clustering#Standard_algorithm
%}

function [idx, Cn] = kmeans_alt(patches, K)
   
   %{
   Generate initial centroids by choosing 
   K random samples of patches
   %}
   inds = randi(length(patches), [K, 1]);
   Cn = patches(inds,:); 

   % Group and update centroids
   iter = 0;
   max_iter = 100; % maximum iterations
   
   change = inf;
   idx = zeros(length(patches),1);
   
   while (change && iter < max_iter)
      [Cnew, count, idx] = assignmentStep(Cn, idx, patches);
      Cnew = updateStep(Cnew, count);
      change = max(max(abs(Cnew - Cn)));
      Cn = Cnew;
      iter = iter + 1;
   end
   
end
