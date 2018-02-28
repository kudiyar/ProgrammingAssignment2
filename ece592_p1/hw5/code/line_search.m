%{
ECE 592 hw5

n casale
ncasale@ncsu.edu

kudiyar orazymbetov
korazym@ncsu.edu

Line Search Modified from Dr. Baron's code
17/11/26
%-------
% line_search.m
% The following code defines a simple convex function, and 
% then finds the minimum using a crude line search.
% Dror Baron, 11.14.2016
%-------
%}

function minimum = line_search(a, b, num_iters)

   % a, b, are min and max of x respectively
   xmin = a;
   xmax = b;

   for iter=1:num_iters
       grid_here = xmin:(xmax-xmin)/10:xmax;
       fhere = 3*grid_here - log(grid_here);
       
       % index where f is minimal
       location_min = find(fhere == min(fhere));
       
       % compute indices for next iteration
       next_min = max(location_min - 2,1);
       next_max = min(location_min + 2, length(grid_here));
       
       % edges for next iteration
       xmin = grid_here(next_min);
       xmax = grid_here(next_max);
       
       fprintf('xmin = %10.7f, fmin = %10.7f, interval width = %10.7f\n',...
           (xmin+xmax)/2,fhere(location_min),xmax-xmin);
   end
   
   minimum = (xmin+xmax)/2;
   
end