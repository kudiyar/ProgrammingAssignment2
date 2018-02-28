%{
ECE 592 Project 1

Kudiyar (Cody) Orazymbetov
korazym@ncsu.edu

Nico Casale
ncasale@ncsu.edu

Helper function for kmeans_alt

Updates each cluster as the centroid of the patches 
assigned to the cluster at hand
%}

function Cnew = updateStep(Cnew, count)
   
   % average
   for i = 1:length(Cnew)
      % don't modify the cluster if no one belongs to it
      if count(i) == 0
         continue;
      end
      Cnew(i,:) = Cnew(i,:)/count(i);
   end
end