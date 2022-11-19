function [ L ] = merge_imgs( R, G, B )
% Совмещение и слияние кадров

    [movingPoints, fixedPoints] = cpselect(G, B, 'Wait', true);
    T1 = cp2tform(movingPoints, fixedPoints, 'projective');
    
    [movingPoints, fixedPoints] = cpselect(R, B, 'Wait', true);
    T2 = cp2tform(movingPoints, fixedPoints, 'projective');

    G = imtransform(G, T1, 'XData', [1 size(B, 2)], 'YData', [1 size(B, 1)]);
    R = imtransform(R, T2, 'XData', [1 size(B, 2)], 'YData', [1 size(B, 1)]);

    L = cat(3, R, G, B);
end

