%{
ECE 592 Project 1

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

Nico Casale
ncasale@ncsu.edu

Helper function for kmeans_alt

Assigns each patch to a cluster, 
Sums continuously the new centroid, to be averaged later
Counts the number of patches in each cluster
%}

function [Cnew, count, idx] = assignmentStep(Cn, idx, patches)

   %{
   assign each patch to one of the K centroids in Cn
   based on minimum distance to a given centroid
   %}

   % todo: repmat on Cn to make more parallel?
   
   % initialize new clusters
   Cnew = zeros(size(Cn));
   count = zeros(size(Cn,1),1);
   
   for i = 1:length(patches)
      % broken up step by step to find bottleneck
      a1 = (patches(i) - Cn).^2; % least expensive
      a2 = sum(a1,2); % mid-expensive
      [~,newId] = min(a2); % most expensive
      
      idx(i) = newId;
      Cnew(newId,:) = Cnew(newId,:) + patches(i,:);
      count(newId) = count(newId) + 1;
   end

end