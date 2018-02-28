function [r, value] = price1(n, p)
    value = zeros(n+1,1);
    r = zeros(n+1,1);
    value(1) = 0;
    
    for j=1:n
       q = -inf;
       for i = 1:j
         if q < p(i) + r(j+1-i)
            value(j+1) = i;
            q = p(i) + r(j+1-i);
         end
       end
       r(j+1) = q; 
    end
    
end