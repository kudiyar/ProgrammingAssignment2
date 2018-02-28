function pr = price(n, p)
    %final_value = zeros(n+1,1);
        %value(0) = 0;
    final_value(1) = 0;
    for i=1:n
        value = -inf;
        for j = 0:(i-1)
            value = max(value, p(j+1)+ final_value(1+i-j));
        end
        final_value(i) = value;
    end
    pr = final_value(n)
end