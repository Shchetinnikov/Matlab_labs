function [ ] = Mandelbrot(R, iter)
% Mandelbrot set

n = 600;
x_plot = linspace(-2, 2, n);
y_plot = linspace(-2, 2, n);

K = zeros(n);

for i = 1 : n
    for j = 1 : n
        c = x_plot(i) + 1i * y_plot(j);
        
        z = 0;
        
        for k = 1 : iter
            z = z^2 + c;
            
            if abs(z) > R
                K(j,i) = 1;
                break;
            end
        end
    end
end
        
fig1 = figure;
imagesc(K);
colormap('gray');
% axis square;

end

