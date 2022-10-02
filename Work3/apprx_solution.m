function [ u_plot ] = apprx_solution(x_plot, t_plot)
% Numerical solution
    f = @(x , t) 1/4 * (2 * x .* (1 + x + x * t) + (1 + t)^2) ./ (1 + x + x * t).^(3/2);

    [ q, t_shape] = size(t_plot);
    [ q, x_shape] = size(x_plot);
    
    t = t_plot(2) - t_plot(1);
    h = x_plot(2) - x_plot(1);
    
    u_plot = zeros(t_shape, x_shape);
    
%   Начальное условие
    u_plot(1, : ) = sqrt(1 + x_plot);
    
    
%   Вычисление по временной сетке
    for n = 2 : t_shape
        t_i = t_plot(n);
                
        u_plot_i = u_plot(n - 1, : );
        u_E_plot = [u_plot(n - 1, 2 : x_shape) 0     ; ];
        u_W_plot = [0 u_plot(n - 1, 1 : x_shape - 1) ; ];
        
        u_plot(n , : ) = u_plot_i + (u_E_plot + u_W_plot - 2 * u_plot_i) * t / h^2 + f(x_plot, t_i) * t;
        
        %   Граничные условия
        u_plot(n, 1)       = h * (2 + t_i - 2 * u_plot(n, 2) / h) / (h - 2);
        u_plot(n, x_shape) = h * ((3 + 2 * t_i) / sqrt(2 + t_i) + 2 * u_plot(n, x_shape - 1) / h) / (h + 2);
    end
end