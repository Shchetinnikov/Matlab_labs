function [ alpha ] = Angle(m, g, V0, k, L0, T, tau)
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

% Проверка L0
alpha = -1;
x_max = x_r;

if L0 > x_max
    disp('Максимальное расстояние полета снаряда: ');
    disp(x_max);
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

