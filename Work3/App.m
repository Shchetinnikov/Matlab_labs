%Численный метод решения задачи теплопроводности.
% u_t = u_xx + 1/4 * (2x(1 + x + xt) + (1 + t)^2) / (1 + x + xt)^(3/2)
% u(0,t) + 2u_x(0,t) = 2 + t
% u(1,t) + 2u_x(1,t) = (3 + 2t) / sqrt(2 + t)
% u(x,0) = sqrt(1 + x)
%Решение: u0(x,t) = sqrt(1 + x + xt)

% Условие устойчивости:
% a^2 * t / h^2 >= 1/2

% Область значений и шаг по x
left  = 0;
right = 1;      
h     = 0.05;

% Область значений и шаг по t
t0 = 0;
T  = 1;
t  = h^2 / 3;   % из условия устойчивости

% Истинное решение
u0 = @(x, t) (1 + x + x * t).^(1/2);

% Сетка
x_plot = linspace(left, right, round((right - left) / h) + 1);
t_plot = linspace(t0, T, round((T - t0) / t) + 1);  

% Численное решение 
u_plot = apprx_solution(x_plot, t_plot);

% Аналитическое решение
[ q, t_shape] = size(t_plot);
[ q, x_shape] = size(x_plot);
u0_plot = zeros(t_shape, x_shape);

for n = 1 : t_shape
    u0_plot(n, :) = u0(x_plot, t_plot(n));
end


% График ошибки
error_plot = abs(u_plot - u0_plot);

figure;
mesh(x_plot, t_plot, error_plot);
xlabel('x');
ylabel('t');
zlabel('error(x,t)');
title('Error');

max_error = max(max(error_plot))

 
%Построение анимации
fig1 = figure;
for n = 1 : t_shape
    clf(fig1);
    hold on;
    
    figure(fig1);
    plot(x_plot, u0_plot(n, : ), 'Color',[1 0.200000002980232 0], 'LineWidth',1.5);
    plot(x_plot, u_plot(n, : ),  'Color',[0 0.600000023841858 1], 'LineWidth',1.5);
    xlabel('x','FontSize',14);
    ylabel('u','FontSize',15);
    title(['t = ',num2str(t_plot(n))]);
    
    legend1 = legend('Analytical solution', 'Numerical solution');
    set(legend1,...
    'Position',[0.616582524914859 0.211353533943262 0.243250044509908 0.108371193448692],...
    'FontSize',9);
    
    drawnow;
end