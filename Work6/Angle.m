function [ alpha ] = Angle(m, g, V0, k, L0, T, tau)
% Alpha determination by current distance

eps   = 0.01;
tspan = linspace(0, T, round(T/tau) + 1);

% Проверка L0 и первый выстрел (максимальный)
x0 = [0 V0 * cos(pi/4)];
y0 = [0 V0 * sin(pi/4)];
[t, x_vec] = ode45(@(t, x_vec) odefun(t, x_vec, 0, m, k), tspan, x0);
[t, y_vec] = ode45(@(t, y_vec) odefun(t, y_vec, g, m, k), tspan, y0);

indexes  = find(y_vec(:,1) >= 0);
ind_size = size(indexes, 1);
x_max    = x_vec(indexes(ind_size), 1);

if L0 > x_max
    disp('Целевая точка находится дальше максимально возможной');
end

% Метод стрельбы
alpha_1 = 0;
alpha_l = pi/4;
alpha_r = pi/4;
alpha_2 = pi/2;

x_r = x_max;
x_l = x_max;
while abs(x_r - L0) > eps || abs(x_l - L0) > eps
    if abs(x_r - L0) > eps
        alpha = (alpha_r + alpha_2) / 2;
        
        x0 = [0 V0 * cos(alpha)];
        y0 = [0 V0 * sin(alpha)];
        [t, x_vec] = ode45(@(t, x_vec) odefun(t, x_vec, 0, m, k), tspan, x0);
        [t, y_vec] = ode45(@(t, y_vec) odefun(t, y_vec, g, m, k), tspan, y0);

        indexes  = find(y_vec(:,1) >= 0);
        ind_size = size(indexes, 1);
        x_r = x_vec(indexes(ind_size), 1);
        
        if x_r > L0
            alpha_r = alpha;
        else
            alpha_2 = alpha;
        end
    end
    
    if abs(x_l - L0) > eps
        alpha = (alpha_l + alpha_1) / 2;
        
        x0 = [0 V0 * cos(alpha)];
        y0 = [0 V0 * sin(alpha)];
        [t, x_vec] = ode45(@(t, x_vec) odefun(t, x_vec, 0, m, k), tspan, x0);
        [t, y_vec] = ode45(@(t, y_vec) odefun(t, y_vec, g, m, k), tspan, y0);

        indexes  = find(y_vec(:,1) >= 0);
        ind_size = size(indexes, 1);
        x_l = x_vec(indexes(ind_size), 1);
        
        if x_l > L0
            alpha_l = alpha;
        else
            alpha_1 = alpha;
        end
    end
    alphas_l = [alpha_1, alpha_l]
    alphas_r = [alpha_r, alpha_2]
    xs =    [x_r, x_l]
    errors = [abs(x_l - L0), abs(x_r - L0)]
end

alpha = [alpha_1, alpha_r];

end

