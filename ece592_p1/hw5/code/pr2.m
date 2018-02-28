%{
ECE 592 hw5

n casale
ncasale@ncsu.edu

kudiyar orazymbetov
korazym@ncsu.edu

Comparison of line search and golden section search
adapted from course code
17/11/26
%}

clear; close all;

addpath('utility');

f = instantiateFig(1);
x = 0.01:1e-4:10; % grid for visualizing signal
y = 3*x-log(x); % signal values
plot(x, y);
prettyPictureFig(f);
xlabel('x');
ylabel('y');
title('Function to be Searched Over');

print('../images/function', '-dpng');

REPS = 500;
num_iters = 10;
% run linesearch with speed measurement
tMinls = inf;
tic;
for rep = 1:REPS
   fprintf('ls rep = %d\n', rep);
 
   tSt = tic;  
   minimumls = line_search(min(x), max(x), num_iters);
   tElapsed = toc(tSt);
   
   tMinls = min(tElapsed, tMinls);
   
end
tAvgls = toc/REPS;

% run golden section search with speed measurement
tMing = inf;
tic;
tol = 1e-10;
num_iters = 20;
for rep = 1:REPS
   fprintf('g rep = %d\n', rep);
 
   tSt = tic;  
   minimumg = golden(min(x), max(x), tol, num_iters);
   tElapsed = toc(tSt);
   
   tMing = min(tElapsed, tMing);
   
end
tAvgg = toc/REPS;


% print results
fprintf('\nlinesearch:\n min = %2.5f,\n avg = %2.5f,\n fmin = %2.4f\n', ...
   tMinls, tAvgls, minimumls);
fprintf('\ngolden:\n min = %2.5f,\n avg = %2.5f,\n fmin = %2.4f\n', ...
   tMing, tAvgg, minimumg);
fprintf('\ncompare:\n min = %2.5f times faster,\n avg = %2.5f times faster,\n fmin = %2.4f abs diff in accuracy\n', ...
   tMinls/tMing, tAvgls/tAvgg, abs(minimumls-minimumg));