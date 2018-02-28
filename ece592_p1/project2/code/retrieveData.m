%{
ECE 592 Project 2
Kudiyar (Cody) Orazymbetov (korazym@ncsu.edu)
Nico Casale (ncasale@ncsu.edu)
%}

function [distances, labels] = retrieveData()

   % distances greater than minDist will be truncated to inf
   minDist = 20;

   % (b) import into matlab
   [distances, labelsCell, ~] = xlsread('mileageChart.xlsx');

   % (c) zero diagonal entries of distances
   for i = 1:size(distances,1)
      distances(i,i) = 0;
   end

   % (d) replace distances above threshold with inf
   numinf = 0;
   for i = 1:size(distances,1)
      for j = 1:size(distances,2)
         if distances(i,j) >= minDist
            distances(i,j) = inf;
            numinf = numinf + 1;
         end
      end
   end

   % print number of real valued matrix entries
   fprintf('Number of real valued distances: %d\n', numel(distances) - numinf);
   
   % process labels into vector
   labelsarr = string(labelsCell);
   labels = labelsarr(1,2:end);

end