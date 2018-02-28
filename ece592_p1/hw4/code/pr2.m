%{
ECE 592 hw4 problem 2

n casale
ncasale@ncsu.edu

Kudiyar Orazymbetov
korazym@ncsu.edu

AMP simulation
17/11/9
%}

% initialize
clear; close all;
addpath('utility', '..');

global imagesFolder
imagesFolder = '../images/';
addpath(imagesFolder);
overwriteImages = 1;

set(0,'defaultTextInterpreter','latex');

fprintf(strcat('ECE 592 HW4 P2\n', datestr(now),'\n'));

% initial meta-parameters
% x
N = 2000;
theta = 0.05; % (1/2)*pr(non-zero)
% A
delta = 0.5; % measurement rate
% z
gamma = 10; % SNR, dB
% AMP
iterations = 20;
lambda = 0.7; % damping

%% AMP execution

[x, xhat, mse, ~, ~] = AMP(1, N, theta, delta, gamma, iterations, lambda);

figure(1);
if (0)
   file = sprintf('rademacher');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

figure(2);
if (0)
   file = sprintf('AMP');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

figure(3);
if (0)
   file = sprintf('AMP_mse');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

%% part f

% i varied SNR (gamma)
gammas = 1:50;
mses = zeros(1,length(gammas));

for gamma = gammas
   
   [x, xhat, mse, ~, ~] = AMP(0, N, theta, delta, gamma, iterations, lambda);
   mses(gamma) = min(mse);
   
end

% plot results
f = instantiateFig(4);
plot(gammas, mses, 'o-');
title(sprintf('Minimum MSE vs. SNR ($$\\gamma$$)\nN = %d, $$2\\theta$$ = %0.1f, $$\\delta$$ = %0.1f, Iterations = %d, $$\\lambda$$ = %0.1f', ...
   N, 2*theta, delta, iterations, lambda));
xlabel('SNR (\gamma)', 'Interpreter', 'tex')
ylabel('MSE')
prettyPictureFig(f);

if (0)
   file = sprintf('vary_gamma');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

%% ii varied measurement rate (delta)

gamma = 10; % SNR, dB, re-init from i
deltas = linspace(0.1, 1, 50);

for delta = deltas
   
   [x, xhat, mse, ~, ~] = AMP(0, N, theta, delta, gamma, iterations, lambda);
   mses(find(deltas == delta)) = min(mse);
   
end

% plot results
f = instantiateFig(5);
plot(deltas, mses, 'o-');
title(sprintf('Minimum MSE vs. Measurement Rate\nN = %d, $$2\\theta$$ = %0.1f, $$\\gamma$$ = %d, Iterations = %d, $$\\lambda$$ = %0.1f', ...
   N, 2*theta, gamma, iterations, lambda));
xlabel('Measurement Rate (\delta)', 'Interpreter', 'tex')
ylabel('MSE')
prettyPictureFig(f);

if (0)
   file = sprintf('vary_delta');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

%% iii varied N

delta = 0.5; % re-init from ii
Ns = 100:100:6000;
mses = zeros(1, length(Ns));
REPS = 5;

for N = Ns
   fprintf('     N = %d\n',N);
   for rep = 1:REPS
      [x, xhat, mse, ~, ~] = AMP(0, N, theta, delta, gamma, iterations, lambda);
      mses(find(Ns == N)) = mses(find(Ns == N)) + min(mse);      
   end   
end

mses = mses./REPS;

% plot results
f = instantiateFig(6);
plot(Ns, mses, 'o-');
title(sprintf('Minimum MSE vs. No. of Measurements\n$$2\\theta$$ = %0.1f, $$\\delta$$ = %0.1f, $$\\gamma$$ = %d, Iterations = %d, $$\\lambda$$ = %0.1f', ...
   2*theta, delta, gamma, iterations, lambda));
xlabel('Measurements (N)', 'Interpreter', 'tex')
ylabel('MSE')
prettyPictureFig(f);

if (0)
   file = sprintf('vary_n');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end

%% linear programming comparison with AMP

% initial meta-parameters
% x
theta = 0.05;
% A
delta = 0.5; % measurement rate
% z
gamma = 10; % SNR, dB
% AMP
iterations = 20;
lambda = 0.7; % damping

% compare speed and MSE
REPS = 5;
Ns = 100:100:700;
times = zeros(2, length(Ns));
mses = ones(2, length(Ns))*inf;

for N = Ns
   fprintf('     N = %d\n',N);
   for rep = 1:REPS
      tic;
      [x, xhat, mse, A, y] = AMP(0, N, theta, delta, gamma, iterations, lambda);
      times(1, find(Ns == N)) = times(1,find(Ns == N)) + toc;
      mses(1, find(Ns == N)) = min(min(mse), mses(1, find(Ns == N)));
      
      tic;
      [xhat, mse] = sim_linprog(N, A, x, y);
      times(2, find(Ns == N)) = times(2,find(Ns == N)) + toc;
      mses(2, find(Ns == N)) = min(min(mse), mses(2, find(Ns == N)));
   end
end

times = times./5; % get avg time

% then plot MSE vs. N
f = instantiateFig(7);
yyaxis left
plot(Ns, mses(1,:), 'o-', Ns, mses(2,:), 'x-', 'MarkerSize', 10);
ylabel('MSE')
title(sprintf('Minimum MSE and Time to Execute vs. No. of Measurements\n$$2\\theta$$ = %0.1f, $$\\delta$$ = %0.1f, $$\\gamma$$ = %d, Iterations = %d, $$\\lambda$$ = %0.1f', ...
   2*theta, delta, gamma, iterations, lambda));
yyaxis right
plot(Ns, times(1,:), 'o-', Ns, times(2,:), 'x-', 'MarkerSize', 10);
ylabel('Time to Execute')
xlabel('Measurements (N)', 'Interpreter', 'tex')
legend('AMP MSE', 'linprog MSE', 'AMP Time', 'linprog Time', 'Location', 'northwest');
prettyPictureFig(f);

if (0)
   file = sprintf('ell1');
   file = strcat(imagesFolder, file);
   print(file, '-dpng');
end