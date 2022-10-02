function [ t ] = Kurant_condition( h, k1, k2, c1, c2, ro1, ro2 )
% Kurant condition
% t < c * ro * h^2 / (2 * k)

t_1 = 0.999 * c1 * ro1 * h^2 / (2 * k1);
t_2 = 0.999 * c2 * ro2 * h^2 / (2 * k2);

if t_1 > t_2
    t = t_2;
else
    t = t_1;
end

end

