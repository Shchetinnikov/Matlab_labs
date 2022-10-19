% ЧИСЛЕННОЕ РЕШЕНИЕ ЗАДАЧИ ПОЛЕТА СНАРЯДА
% 
% Уравнение движения: m*r_tt = m*g - k*r_t
% Начальные условия: r(0) = 0
%                    r_t(0) = V0
% 
% Уравнения для каждой компоненты:
%   m*x_tt = - k*x_t
%   x(0) = 0
%   x_t(0) = V0 * cos(alpha)

%   m*y_tt = - m*g - k*y_t
%   y(0) = 0
%   y_t(0) = V0 * sin(alpha)
% 
% 
% После приведения уравнений к нормальному виду:
%   x_t = x1
%   x1_t = - k/m * x1
% 
%   y_t = y1
%   y1_t = -g - k/m * y1


% Исходные данные
V0 = 10;     % начальная скорость
m  = 10;     % масса снаряда
g  = 9.81;   % ускорение свободного падения

k   = 0.6;   % коэффициент сопротивления
L0 = 6;      % целевая точка

% Временная сетка
tau = 0.001;  % шаг
T   = 5;      % временной промежуток



% Задача 1: зависимость дальности полета от начального угла
Distances(m, g, V0, T);

% Задача 2: определение начального угла полета в целевую точку
alpha = Angle(m, g, V0, k, L0, T, tau);

% Визуализация траектории полета снаряда в заданную точку
if alpha ~= -1
    fontsize = 10;

    figure1 = figure('Position', [200 50 750 500]);
    axes1 = axes('Parent',figure1,'LineStyleOrderIndex',2);
    hold(axes1,'on');

    ylabel('y', 'FontSize', fontsize);
    xlabel('x', 'FontSize', fontsize);
    title('Flight path','FontSize',12);

    plot1 = plot(L0, 0, 'ro');
    set(plot1, 'DisplayName', 'aim');

    for angle_i = alpha
        if angle_i == 0
           continue
        end

        [x_vec, y_vec] = ode_sol( m, g, V0, k, angle_i, T, tau );

        plot1 = plot(x_vec(1:size(x_vec, 1), 1), y_vec(1:size(y_vec, 1), 1), ...
                     'LineStyle','--', 'Parent',axes1); 
        set(plot1, 'DisplayName', ['alpha = ', num2str(angle_i)]);
    end

    legend1 = legend(axes1,'show');
    set(legend1,'FontSize',7);
end