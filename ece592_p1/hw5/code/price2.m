function pr = price2(n, p)
    final_value = zeros(1,n+1);
        %value(0) = 0;
    final_value(1) = 0;
    for i=1:n
        value = -inf;
        for j = 2:min(i+1,length(p)+1)
            value = max(value, p(j-1)+ final_value(i+2-j)); % j-1
        end
        final_value(i+1) = value;
    end
    pr = final_value(n+1);
end