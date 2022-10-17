function [ dydt ] = odefun(t, y, g, m, k)
% System of equations
dydt = zeros(2, 1);
dydt(1) = y(2);
dydt(2) = (-1)* k/m * y(2) - g;
end

