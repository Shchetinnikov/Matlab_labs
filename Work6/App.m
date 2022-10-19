% ��������� ������� ������ ������ �������
% 
% ��������� ��������: m*r_tt = m*g - k*r_t
% ��������� �������: r(0) = 0
%                    r_t(0) = V0
% 
% ��������� ��� ������ ����������:
%   m*x_tt = - k*x_t
%   x(0) = 0
%   x_t(0) = V0 * cos(alpha)

%   m*y_tt = - m*g - k*y_t
%   y(0) = 0
%   y_t(0) = V0 * sin(alpha)
% 
% 
% ����� ���������� ��������� � ����������� ����:
%   x_t = x1
%   x1_t = - k/m * x1
% 
%   y_t = y1
%   y1_t = -g - k/m * y1


% �������� ������
V0 = 10;     % ��������� ��������
m  = 10;     % ����� �������
g  = 9.81;   % ��������� ���������� �������

k   = 0.6;   % ����������� �������������
L0 = 6;      % ������� �����

% ��������� �����
tau = 0.001;  % ���
T   = 5;      % ��������� ����������



% ������ 1: ����������� ��������� ������ �� ���������� ����
Distances(m, g, V0, T);

% ������ 2: ����������� ���������� ���� ������ � ������� �����
alpha = Angle(m, g, V0, k, L0, T, tau);

% ������������ ���������� ������ ������� � �������� �����
if alpha ~= -1
    fontsize = 10;

    figure1 = figure('Position', [200 50 750 500]);
    axes1 = axes('Parent',figure1,'LineStyleOrderIndex',2);
    hold(axes1,'on');

    ylabel('y', 'FontSize', fontsize);
    xlabel('x', 'FontSize', fontsize);
    title('Flight path','FontSize',12);

    plot1 = plot(L0, 0, 'ro');
    set(plot1, 'DisplayName', 'aim');

    for angle_i = alpha
        if angle_i == 0
           continue
        end

        [x_vec, y_vec] = ode_sol( m, g, V0, k, angle_i, T, tau );

        plot1 = plot(x_vec(1:size(x_vec, 1), 1), y_vec(1:size(y_vec, 1), 1), ...
                     'LineStyle','--', 'Parent',axes1); 
        set(plot1, 'DisplayName', ['alpha = ', num2str(angle_i)]);
    end

    legend1 = legend(axes1,'show');
    set(legend1,'FontSize',7);
end