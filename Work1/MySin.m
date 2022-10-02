function [ result, iterations ] = MySin( x )
% MYSINUS 
% This is realization of sinus function
    
    x = mod(x, 2*pi) - 2*pi;
    
    result      = x;
    prev_result = 0;
    
    n = 0;
    while ~isequaln(result, prev_result)
        n = n + 1;
        prev_result = result;
        result = result + (-1)^n .* x.^(2*n + 1) ./ factorial(2*n + 1);
    end
    
    iterations = n;
end