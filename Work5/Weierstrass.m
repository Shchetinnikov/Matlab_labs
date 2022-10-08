function [  ] = Weierstrass( n )
% The Weierstrass function 
    function build_plot(x_plot, n, a, b)
        w_plot = 0;
        for i = 0 : n
            w_plot = w_plot + b^n * cos(a^n * pi .* x_plot);
        end

        plot(x_plot, w_plot); 
    end


x_plot = linspace(-20, 20, 500);
a = 1;
b = 1;


fig1 = figure;
fig1.Position = [150 90 1000 540];
axe1 = axes('Parent',fig1,...
            'Position',[0.13 0.203960396039604 0.775 0.721039603960396]);
% box(axes1,'on');
% hold(axes1,'on');

% Create textbox
annotation(fig1,'textbox',...
    [0.18 0.03 0.07 0.04],...
    'String','b',...
    'HorizontalAlignment','center',...
    'FitBoxToText','off');

% Create textbox
annotation(fig1,'textbox',...
    [0.18 0.09 0.07 0.04],...
    'String','a',...
    'HorizontalAlignment','center',...
    'FitBoxToText','off');

% Create textbox
annotation(fig1,'textbox',...
           [0.26 0.02 0.07 0.05],...
           'String','0',...
           'LineStyle','none');

% Create textbox
annotation(fig1,'textbox',...
           [0.26 0.08 0.07 0.05],...
           'String','1',...
           'LineStyle','none');

% Create textbox
annotation(fig1,'textbox',...
           [0.7 0.02 0.07 0.05],...
           'String','10',...
           'LineStyle','none');

% Create textbox
annotation(fig1,'textbox',...
           [0.7 0.08 0.07 0.05],...
           'String','10',...
           'LineStyle','none');
       
       


c1 = uicontrol(fig1,'Style','slider', 'Min', 1, 'Max',10,'SliderStep',[0.01 0.10], 'Position', [290 50 405 20]);
c1.Value = a;
c1.Callback = @update;

c2 = uicontrol(fig1,'Style','slider', 'Min',0, 'Max',10,'SliderStep',[0.01 0.10], 'Position', [290 20 405 20]);
c2.Value = b;
c2.Callback = @update;

    function update(src,event)
        cla(axe1);
        build_plot(x_plot, n, c1.Value, c2.Value);
    end


build_plot(x_plot, n, a, b);

end

