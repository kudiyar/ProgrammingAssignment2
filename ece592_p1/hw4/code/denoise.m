%{
ECE 592 hw4 problem 2

n casale
ncasale@ncsu.edu

Kudiyar Orazymbetov
korazym@ncsu.edu

AMP simulation
Denoising function
utilized Dr. Baron's code from the course webpage
17/11/9
%}

function [xhat, d] = denoise(v, var_x, var_z, epsilon)
   
   term1 = (1 - 2*epsilon)*normpdf(v, 0, sqrt(var_z));
   term2 = epsilon*normpdf(v, 1, sqrt(var_x + var_z));
   term3 = epsilon*normpdf(v, -1, sqrt(var_x + var_z));
   xhat = (term2 - term3)./(term1 + term2 + term3); % denoised version, x(t+1)
   
   % empirical derivative
   Delta = 1e-10; % perturbation
   term1_d = (1 - 2*epsilon)*normpdf(v + Delta, 0, sqrt(var_z));
   term2_d = epsilon*normpdf(v + Delta, 1, sqrt(var_x + var_z));
   term3_d = epsilon*normpdf(v + Delta, -1,sqrt(var_x + var_z));
   xhat2 = (term2_d - term3_d)./(term1_d + term2_d + term3_d);
   d = (xhat2 - xhat)/Delta;
   
end