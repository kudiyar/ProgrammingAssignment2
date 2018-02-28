%{
ECE 592 hw4 problem 2

n casale
ncasale@ncsu.edu

Kudiyar Orazymbetov
korazym@ncsu.edu

linear programming ell1 solver
used Dr. Baron's example code from the course webpage
17/11/9
%}

function [xell1, mse] = sim_linprog(N, A, x, y)

   %---------
   % linear programming
   %---------
   % xhat = argmin ||x||_1 s.t. y=A*x
   % take x=xpos-xneg
   % xpos>=0, xneg>=0
   % xhat=argmin xpos+xneg s.t. y=A*(xpos-xneg)
   fprintf('solving ell1\n')
   f=ones(2*N,1);
   Aeq=[A -A];
   beq=y;
   lb=zeros(2*N,1); % lower bound zero
   ub=ones(2*N,1)*inf; % upper bound is infinity
   xsolve=linprog(f,[],[],Aeq,beq,lb,ub);
   xp=xsolve(1:N);
   xn=xsolve(N+1:2*N);
   xell1=xp-xn;
   mse = mean((xell1-x).^2);
   fprintf('ell1 error = %10.6f\n', mse);
   
end