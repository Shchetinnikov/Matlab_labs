function [ p, s ] = Polygon_ps( X, Y )
% Perimeter and square of figure

pgon = alphaShape(X, Y);

% plot(pgon);
fill(X, Y, 'b');

p = perimeter(pgon);
s = area(pgon);

end

