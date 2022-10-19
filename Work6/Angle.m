function [ alpha ] = Angle(m, g, V0, k, L0, T, tau)
% Alpha determination by current distance

alpha = -1;
eps   = 0.01;

% Проверка L0 и первый выстрел (максимальный)
[x_vec, y_vec] = ode_sol( m, g, V0, k, pi/4, T, tau );
x_max = x_vec(size(x_vec, 1), 1);

if L0 > x_max
    disp('Максимальное расстояние полета снаряда: ');
    x_max
    return;
else
    if L0 == 0
        disp('Целевая точка находится в точке старта');
        return;
    end
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
        
        [x_vec, y_vec] = ode_sol( m, g, V0, k, alpha, T, tau );
        x_r = x_vec(size(x_vec, 1), 1);
        
        if x_r > L0
            alpha_r = alpha;
        else
            alpha_2 = alpha;
        end
    end
    
    if abs(x_l - L0) > eps
        alpha = (alpha_l + alpha_1) / 2;
        
        [x_vec, y_vec] = ode_sol( m, g, V0, k, alpha, T, tau );
        x_l = x_vec(size(x_vec, 1), 1);
        
        if x_l > L0
            alpha_l = alpha;
        else
            alpha_1 = alpha;
        end
    end
end

alpha = [alpha_1, alpha_r];

end

