function [ epsilon ] = Epsilon()
% EPSILON
% This function calculates ìachine epsilon 
    epsilon = 1;
    while 1 + epsilon ~= 1
        epsilon = epsilon / 2;
    end
end

