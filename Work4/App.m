% ЧИСЛЕННОЕ РЕШЕНИЕ ЗАДАЧИ ТЕПЛОПРОВОДНОСТИ ПО СХЕМЕ СКВОЗНОГО СЧЕТА

% Решение уравнения теплопроводности: u1_t = a1^2*u1_xx, [0, L] 
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

T = 100;
t = Kurant_condition( h, k1, k2, c1, c2, ro1, ro2 );

x1_plot = linspace(0, L_cu, L_cu / h);
x2_plot = linspace(L_cu, L, (L - L_cu) / h);
x_plot  = [x1_plot x2_plot(1, 2 : size(x2_plot, 2))];

t_plot = linspace(0, T, T / t);

% Численное решение
u_plot = apprx_solution(x_plot, t_plot, size(x1_plot, 2), U0, U10, U20, k1, k2, c1, c2, ro1, ro2);

% % Визуализация
% fig1 = figure;
% for n = 1 : size(t_plot, 2)
%     hold on;
%     
%     plot(x_plot, u_plot(n, : ));
%     xlabel('x','FontSize',14);
%     ylabel('u','FontSize',15);
%     title(['Numerical solution: step t=', num2str(t), ' from 0 to ', num2str(T)]);
% end

fig2 = figure;
for n = 1 : 5 :size(t_plot, 2)
    clf(fig2);
    
    figure(fig2)
    plot(x_plot, u_plot(n, : ));
    xlabel('x','FontSize',14);
    ylabel('u','FontSize',15);
    title(['Numerical solution: time t=', num2str(t_plot(n)), ' from 0 to ', num2str(T)]);
    
    drawnow;
end