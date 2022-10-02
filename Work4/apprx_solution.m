function [ u_plot ] = apprx_solution(x_plot, t_plot, mid_index, U0, U10, U20, k1, k2, c1, c2, ro1, ro2)
% Численное решение

x_shape = size(x_plot, 2);
t_shape = size(t_plot, 2);

t = t_plot(2) - t_plot(1);
h = x_plot(2) - x_plot(1);


% Матричное решение
u_plot = zeros(t_shape, x_shape);

c1_ro1 = ones(1, mid_index - 1) * (c1 * ro1);
c2_ro2 = ones(1, x_shape - mid_index) * (c2 * ro2);
c_ro   = [c1_ro1 (c1*ro1+c2*ro2)/2 c2_ro2];

k1_plot_next = ones(1, mid_index - 1) * k1;
k2_plot_next = ones(1, x_shape - mid_index + 1) * k2;

k1_plot_prev = ones(1, mid_index) * k1;
k2_plot_prev = ones(1, x_shape - mid_index) * k2;

k_next = [k1_plot_next k2_plot_next];
k_prev = [k1_plot_prev k2_plot_prev];


% Начальное условие
u_plot(1, :) = U0;

% Вычисление по временной сетке
for n = 2 : t_shape
    u_plot_i = u_plot(n - 1, : );
    u_E_plot = [u_plot(n - 1, 2 : x_shape) 0];
    u_W_plot = [0 u_plot(n - 1, 1 : x_shape - 1)];

    u_plot(n, : ) = t * ( k_next .* (u_E_plot - u_plot_i) / h^2 - k_prev .* (u_plot_i - u_W_plot) / h^2 ) ./ c_ro + u_plot_i;
    
    % Граничные условия
    u_plot(n, 1)       = U10;
    u_plot(n, x_shape) = U20;
end