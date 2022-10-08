% ЧИСЛЕННОЕ РЕШЕНИЕ ЗАДАЧИ ТЕПЛОПРОВОДНОСТИ ПО СХЕМЕ СКВОЗНОГО СЧЕТА

% Решение уравнения теплопроводности: u1_t = a1^2*u1_xx, [0, L_cu] 
%                                     u2_t = a2^2*u2_xx, [L_cu, L]
% Граничные условия: u1(0, t) = 393 
%                    u2(L, t) = 308
% Начальное условие: u1(x, 0) = u2(x, 0) = 293
% Условия сшивки: u1(L_cu, t) = u2(L_cu, t)
%                 k1 * u1'(L_cu, t) = k2 * u2'(L_cu, t)


% Исходные данные
U0  = 293;
U10 = 393;
U20 = 308;

k1  = 400;
k2  = 237;
c1  = 385;
c2  = 920;
ro1 = 8940;
ro2 = 2700;

% Сетка
L_cu = 0.1;
L_a  = 0.1;
L    = L_cu + L_a;
h = 0.01;

T = 200;
t = Kurant_condition( h, k1, k2, c1, c2, ro1, ro2 );

x1_plot = linspace(0, L_cu, L_cu / h);
x2_plot = linspace(L_cu, L, (L - L_cu) / h);
x_plot  = [x1_plot x2_plot(1, 2 : size(x2_plot, 2))];

t_plot = linspace(0, T, T / t);

% Истинное решение
u1 = @(x) (k2/k1 * (U20 - U10) / (L_cu * k2/k1 - L_cu + L)) .* x + U10;
u2 = @(x) ((U20 - U10) / (L_cu * k2/k1 - L_cu + L)) .* x + U20 - L * (U20 - U10) / (L_cu * k2/k1 - L_cu + L);

u1_plot = u1(x1_plot);
u2_plot = u2(x2_plot);

u_plot_real = [u1_plot u2_plot(1, 2 : size(x2_plot, 2))];

% Численное решение
u_plot = apprx_solution(x_plot, t_plot, size(x1_plot, 2), U0, U10, U20, k1, k2, c1, c2, ro1, ro2);


% Ошибка
flag = 0;
error_plot = zeros(1, size(t_plot, 2));
for n = 1 : size(t_plot, 2)
    
    [error, index] = max(abs(u_plot(n, :) - u_plot_real));
    error_plot(1, n) = error;
    
    if flag == 0 && u_plot(n, index) * 0.01 >= error
        t_error = t_plot(n);
        flag = 1;
    end
end
   

% Визуализация
fig2 = figure;
ax1 = subplot(1, 2, 1);
ax2 = subplot(1, 2, 2);
hold(ax1, 'on');
hold(ax2, 'on');
fontsize  = 11;
linewidth = 1;

plot(log(t_plot), log(error_plot), 'LineWidth',linewidth);
y = ylim;
plot([log(t_error) log(t_error)],[y(1) y(2)], 'LineWidth',linewidth);

xlabel('log(t)',    'FontSize', fontsize);
ylabel('log(error)','FontSize', fontsize);
title('Error');
annotation(fig2,'textbox',...
    [0.84609375 0.396825396825397 0.05078125 0.0453514739229025],...
    'String',{'error <= 1%'},...
    'FontSize', 7,...
    'FitBoxToText','off',...
    'EdgeColor','none');

axes(ax1);
for n = 1 : 10 :size(t_plot, 2)
    cla(ax1);    
    
    plot(x_plot, u_plot(n, : ), 'LineWidth',linewidth);
    plot(x1_plot, u1_plot, 'Color',[0.850980401039124 0.325490206480026 0.0980392172932625], 'LineWidth',linewidth);
    plot(x2_plot, u2_plot, 'Color',[0.850980401039124 0.325490206480026 0.0980392172932625], 'LineWidth',linewidth);
    
    xlabel('x','FontSize', fontsize);
    ylabel('u','FontSize', fontsize);
    title(['time t=', num2str(t_plot(n)), ' from 0 to ', num2str(T)]);
    
    legend1 = legend('Numerical solution', 'Analytical stationary solution');
    set(legend1,...
        'Position',[0.306292870488137 0.786848072562358 0.152183148013558 0.120773831453494],...
        'FontSize', 9);
    drawnow;
end