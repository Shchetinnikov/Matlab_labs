function [ L ] = merge_imgs( R, G, B )
% Совмещение и слияние кадров

    [movingPoints, fixedPoints] = cpselect(G, R, 'Wait', true);
    T1 = cp2tform(movingPoints, fixedPoints, 'similarity');
    
    [movingPoints, fixedPoints] = cpselect(B, R, 'Wait', true);
    T2 = cp2tform(movingPoints, fixedPoints, 'similarity');

    G = imtransform(G, T1, 'XData', [1 size(R, 2)], 'YData', [1 size(R, 1)]);
    B = imtransform(B, T2, 'XData', [1 size(R, 2)], 'YData', [1 size(R, 1)]);

    L = cat(3, R, G, B);
end

