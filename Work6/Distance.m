function [ ] = Distance(m, g, V0, T, tau)
% Distance by initial angle

angle_plot = linspace(0, pi/2, 25);
k_plot = linspace(0, 10, 11);
tspan  = linspace(0, T, round(T/tau) + 1);

% Визуализация
fontsize = 10;

figure1 = figure('Position', [200 50 750 500]);
axes1 = axes('Parent',figure1,'LineStyleOrderIndex',2);
hold(axes1,'on');

ylabel('L',     'FontSize', fontsize);
xlabel('alpha', 'FontSize', fontsize);
title('Distance by alpha','FontSize',12);

for k = k_plot
    x_plot = [];
    for angle_i = angle_plot
        x0 = [0 V0 * cos(angle_i)];
        y0 = [0 V0 * sin(angle_i)];
        [t, x_vec] = ode45(@(t, x_vec) odefun(t, x_vec, 0, m, k), tspan, x0);
        [t, y_vec] = ode45(@(t, y_vec) odefun(t, y_vec, g, m, k), tspan, y0);

        indexes  = find(y_vec(:,1) >= 0);
        ind_size = size(indexes, 1);
        
        x_plot = [x_plot x_vec(indexes(ind_size), 1) ; ];
    end
    
    plot1 = plot(angle_plot, x_plot, 'LineStyle','--', 'Parent',axes1); 
    set(plot1, 'DisplayName', ['k = ', num2str(k)]);
end

legend1 = legend(axes1,'show');
set(legend1,'FontSize',7);

drawnow;
end