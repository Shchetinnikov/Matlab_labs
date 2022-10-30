L = imread('./imgs/origin.tif');

height = size(L, 1);

Blue  = L(1 : height / 3, :, 1);
Green = L(height / 3 + 1 : 2 * height / 3, :, 2);
Red   = L(2 * height / 3 + 1 : height, :, 3);

imwrite(Red,   './imgs/red.tif');
imwrite(Green, './imgs/green.tif');
imwrite(Blue,  './imgs/blue.tif');