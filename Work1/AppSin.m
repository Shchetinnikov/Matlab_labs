% *** Sinus ***
% Researching of iteration function
clear
n = 1;
N = 10;

for k = 0:0.01:N*pi
    [S(n), K(n)] = MySinus(k);
    n = n+1;
end

x = 0:0.01:N*pi;

figure
plot(x, S,'r--')
hold on
plot(x, sin(x), 'b-.')

figure
plot(x, K);