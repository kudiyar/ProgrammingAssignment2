%{
ECE 592 hw5

n casale
ncasale@ncsu.edu

kudiyar orazymbetov
korazym@ncsu.edu

Golden Section Search
17/11/26
%}

function minimum = golden(a, b, tol, num_iters)

   % golden ratio
   GR = (1 + sqrt(5))/2;

   c = b - (b - a)/GR;
   d = a + (b - a)/GR;

   for iter=1:num_iters

      if (abs(c - d) < tol)
         break;
      end
      
      if (eval_fun(c) < eval_fun(d))
         b = d;
      else
         a = c;
      end
      
      % recompute c and d to avoid loss of precision
      c = b - (b - a)/GR;
      d = a + (b - a)/GR;
      
   end

   minimum = (b + a)/2;
   
end

function y = eval_fun(x)

   y = 3*x - log(x);

end