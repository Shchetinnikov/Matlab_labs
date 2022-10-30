% Восстановление изображений Прокудина-Горского С.М.

% Из Библиотеки Конгресса США скачено изображение, содержащее три кадра с
% фильтров Blue, Green, Red

% Обрезка кадров и сохранение каждого в монохроме
crop();


% Чтение кадров
R = imread('./imgs/red.tif');
G = imread('./imgs/green.tif');
B = imread('./imgs/blue.tif');

% Вывод
figure1 = figure('Position', [200 50 750 500]);
subplot(1, 3, 1);
imshow(R);
title('Red channel');

subplot(1, 3, 2);
imshow(G);
title('Green channel');

subplot(1, 3, 3);
imshow(B);
title('Blue channel');


% Применение алгоритма совмещенеия фотографий
L = cat(3, R, G, B);
L_aligned = merge_imgs( R, G, B );

figure2 = figure('Position', [200 50 750 500]);
subplot(1, 2, 1);
imshow(L);
title('Merged image');

subplot(1, 2, 2);
imshow(L_aligned);
title('Aligned and merged image');