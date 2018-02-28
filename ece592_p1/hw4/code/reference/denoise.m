function [xhat,d]=denoise(v,var_x,var_z,epsilon);
%---------
% denoise.m
% Denoise a Bernoulli Gaussian random variable.
% Inputs: r pseudo data, var_x signal variance, var_z noise variance,
% epsilon sparsity rate.
% Outputs: xhat estimated signal, d derivative of denoiser.
% Dror Baron, 11.2.2016
%---------

term1 = (1-epsilon)*normpdf(v,0,sqrt(var_z));
term2 = epsilon*normpdf(v,0,sqrt(var_x+var_z));
xW=var_x/(var_x+var_z)*v; % Wiener filter
xhat=term2./(term1+term2).*xW; % denoised version, x(t+1)

% empirical derivative
Delta=1e-10; % perturbation
term1_d = (1-epsilon)*normpdf(v+Delta,0,sqrt(var_z));
term2_d = epsilon*normpdf(v+Delta,0,sqrt(var_x+var_z));
xW2=var_x/(var_x+var_z)*(v+Delta);% Wiener filter
xhat2=xW2.*term2_d./(term1_d+term2_d);
d=(xhat2-xhat)/Delta;
