%{
ECE 592 hw4 problem 2

n casale
ncasale@ncsu.edu

Kudiyar Orazymbetov
korazym@ncsu.edu

AMP simulation
17/11/9
%}

function [x, xhat, mse, A, y] = AMP(plot_bool, N, theta, delta, gamma, iterations, lambda)

   % generate signal
   var_x = 2*theta;
   mask = binornd(1,2*theta, [N,1]);
   x = (rand(N,1)<.5)*2 - 1;
   x = mask.*x;

   % plot a subset of the signal
   if plot_bool
      f = instantiateFig(1);
      samps = 300;
      stem(x(1:samps));
      prettyPictureFig(f);
      ylim([-1.2 1.2]);
      title(sprintf('%d samples of x\n$$2\\theta$$ = %0.1f', samps, 2*theta));
      xlabel('sample index');
      ylabel('amplitude');
   end

   % measurement matrix A in R^{M x N}
   M = round(N*delta);
   sigma = sqrt(1/M);
   A = sigma.*randn(M,N);
   AT = A';

   % noise
   z = sqrt(1/gamma).*randn(M,1);

   % noisy measurements
   y = A*x + z;

   % Dr. Baron's AMP implementation
   % initialization
   mse = zeros(iterations,1); % store mean square error
   xhat = zeros(N,1); % estimate of signal
   dt = zeros(N,1); % derivative of denoiser
   rt = zeros(M,1); % residual

   for iter = 1:iterations

       % update residual
       rt = y - A*xhat + 1/delta*mean(dt)*rt;
       % compute pseudo-data
       vt = xhat + AT*rt;
       % estimate scalar channel noise variance; estimator is due to Montanari
       var_t = mean(rt.^2);
       % denoising
       [xt1, dt] = denoise(vt, var_x, var_t, theta);
       % damping step
       xhat = lambda*xt1 + (1-lambda)*xhat;
       mse(iter) = mean((xhat-x).^2);

   end

   % plot estimated values over original
   if plot_bool
      f = instantiateFig(2); hold on;
      stem(x(1:samps));
      stem(xhat(1:samps));
      ylim([-1.2 1.2]);
      hold off;
      legend('original', 'estimated');
      title(sprintf('Original and Estimated Data\nN = %d, $$2\\theta$$ = %0.1f, $$\\delta$$ = %0.1f, $$\\gamma$$ = %d, Iterations = %d, $$\\lambda$$ = %0.1f', ...
         N, theta, delta, gamma, iterations, lambda));
      xlabel('sample index');
      ylabel('amplitude');
      prettyPictureFig(f);
   end
   
   % tanaka's fixed point equation
   n = linspace(0.01, 1, iterations);
   mmse = ((1./n) - 1).*(delta/gamma);   
   
   % plot mse
   if plot_bool
      f = instantiateFig(3); %hold on;
      plot(mse,'o-');
      %plot(mmse,'x-');
      %hold off;
      title(sprintf('MSE at each iteration\nN = %d, $$2\\theta$$ = %0.1f, $$\\delta$$ = %0.1f, $$\\gamma$$ = %d, Iterations = %d, $$\\lambda$$ = %0.1f', ...
         N, 2*theta, delta, gamma, iterations, lambda));
      xlabel('Iteration')
      ylabel('MSE')
      prettyPictureFig(f);
   end

   fprintf('AMP error = %10.6f\n', min(mse));

end