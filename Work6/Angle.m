function [ alpha, iter ] = Angle(m, g, V0, k, L0, T, tau)
% Alpha determination by current distance

eps   = 0.01;

% Поиск максимального расстояния
alpha_l = 0;
alpha_r = pi/2;

x_l = 0;
x_r = 0;
while 1
    alpha = (alpha_l + alpha_r) / 2;

    [x_vec, y_vec] = ode_sol( m, g, V0, k, alpha, T, tau );
    x_i = x_vec(size(x_vec, 1), 1);

    if (x_l + x_r) == 0 || (x_i > x_l && x_i > x_r)
        x_r = x_i;
        alpha_r = alpha;
        continue;
    end
        
    if x_i > x_l && x_i < x_r
        x_l = x_i;
        alpha_l = alpha;
    else
        if x_i < x_l && x_i > x_r
            x_r = x_i;
            alpha_r = alpha;
        end
    end
   
    if abs(x_l - x_r) <= eps
        break;
    end
end

x_max = x_r;

% Проверка L0
if L0 > x_max
    disp('Максимальное расстояние полета снаряда: ');
    disp(x_max);
    alpha = -1;
    return;
else
    if L0 == 0
        disp('Целевая точка находится в точке старта');
        alpha = -1;
        return;
    end
end

% Метод стрельбы
% % % % % % % % % % % % % % % % % % % % % % % % 
% Настройки визуализации
fontsize = 10;

figure1 = figure('Position', [200 50 750 500]);
axes1 = axes('Parent',figure1,'LineStyleOrderIndex',2);
hold(axes1,'on');

ylabel('y', 'FontSize', fontsize);
xlabel('x', 'FontSize', fontsize);
title('Flight path','FontSize',12);
% % % % % % % % % % % % % % % % % % % % % % % % 

iter = 0;

alpha_1 = 0;
alpha_l = alpha;
alpha_r = alpha;
alpha_2 = pi/2;

x_r = x_max;
x_l = x_max;
while abs(x_r - L0) > eps || abs(x_l - L0) > eps
    if abs(x_r - L0) > eps
        iter = iter + 1;
        alpha = (alpha_r + alpha_2) / 2;
        
        [x_vec, y_vec] = ode_sol( m, g, V0, k, alpha, T, tau );
        x_r = x_vec(size(x_vec, 1), 1);
        
        if x_r > L0
            alpha_r = alpha;
        else
            alpha_2 = alpha;
        end
        
        plot1 = plot(x_vec(1:size(x_vec, 1), 1), y_vec(1:size(y_vec, 1), 1), ...
                         'LineStyle',':', 'Color', 'k', 'LineWidth', 0.1, 'Parent',axes1);
%         set(plot1, 'DisplayName', ['alpha = ', num2str(angle_i)]);
    end
    
    if abs(x_l - L0) > eps
        iter = iter + 1;
        alpha = (alpha_l + alpha_1) / 2;
        
        [x_vec, y_vec] = ode_sol( m, g, V0, k, alpha, T, tau );
        x_l = x_vec(size(x_vec, 1), 1);
        
        if x_l > L0
            alpha_l = alpha;
        else
            alpha_1 = alpha;
        end
        plot1 = plot(x_vec(1:size(x_vec, 1), 1), y_vec(1:size(y_vec, 1), 1), ...
                         'LineStyle',':', 'Color', 'k', 'LineWidth', 0.1, 'Parent',axes1);
%         set(plot1, 'DisplayName', ['alpha = ', num2str(angle_i)]);
    end
end

alpha = [alpha_1, alpha_r];
disp('Количество итераций, выполненных для расчета угла полета снаряда в заданную точку: ');
disp(iter);

% Визуализация траектории полета снаряда в заданную точку
plot1 = plot(L0, 0, 'ro');
set(plot1, 'DisplayName', 'aim');

for angle_i = alpha
    if angle_i == 0
       continue
    end

    [x_vec, y_vec] = ode_sol( m, g, V0, k, angle_i, T, tau );

    plot1 = plot(x_vec(1:size(x_vec, 1), 1), y_vec(1:size(y_vec, 1), 1), ...
                 'LineStyle','-', 'LineWidth', 1.5, 'Parent',axes1); 
    set(plot1, 'DisplayName', ['alpha = ', num2str(angle_i)]);
end

legend1 = legend(axes1,'show');
set(legend1,'FontSize',7);

end

