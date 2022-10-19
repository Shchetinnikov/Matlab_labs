function [ x_vec, y_vec ] = ode_sol( m, g, V0, k, alpha, T, tau )
% Numerical solution of ODE

tspan = linspace(0, T, round(T/tau) + 1);

x0 = [0 V0 * cos(alpha)];
y0 = [0 V0 * sin(alpha)];
[t, x_vec] = ode45(@(t, x_vec) odefun(t, x_vec, 0, m, k), tspan, x0);
[t, y_vec] = ode45(@(t, y_vec) odefun(t, y_vec, g, m, k), tspan, y0);

indexes  = find(y_vec(:,1) >= 0);
ind_size = size(indexes, 1);

x_vec = x_vec(1:indexes(ind_size), 1:2);
y_vec = y_vec(1:indexes(ind_size), 1:2);

end

