function [ ] = Distances(m, g, V0, T)
% Distance by initial angle

tau = 0.01;
angle_plot = linspace(0, pi/2, 25);
k_plot = linspace(0, 10, 11);

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
        [x_vec, y_vec] = ode_sol( m, g, V0, k, angle_i, T, tau );
        x_plot = [x_plot x_vec(size(x_vec, 1), 1) ; ];
    end
    
    plot1 = plot(angle_plot, x_plot, 'LineStyle','--', 'Parent',axes1); 
    set(plot1, 'DisplayName', ['k = ', num2str(k)]);
end

legend1 = legend(axes1,'show');
set(legend1,'FontSize',7);

drawnow;
end