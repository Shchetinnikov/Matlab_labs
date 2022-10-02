% **** Spiral ****
% Working with matrix

mat_size = input('Input size of matrix: ');

min_value = 0;
max_value = 100;

A = round(rand(mat_size) * (max_value - min_value));

A = sort(A(:));
A = reshape(A, mat_size, mat_size);

subplot(1, 2, 1, 'align');
imagesc(A);
colorbar;
colormap(gray);


% Spiral clockwise
A = sort(A(:))';
res = ones(mat_size);

row = 1;
col = 1;
limit = 0;
dir = 0;

for a_i = A
    res(row, col) = a_i;
       
    if dir == 0       
        if col < mat_size - limit
            col = col + 1;
            continue;
        end;
        
        if (col == mat_size - limit) && (row + 1 == mat_size - limit)
            dir = 1;
        end

        if row < mat_size - limit
            row = row + 1;
            continue;
        end;
    else       
        if col > limit + 1
            col = col - 1;
            continue;        
        elseif col == limit + 1
            limit = limit + 1;
        end;
        
        if (col == limit) && (row - 1 == 1 + limit)
            dir = 0;
        end;
       
        if row > 1 + limit
            row = row - 1;
            continue;
        end;
    end;
end;

subplot(1, 2, 2);
imagesc(res);
colorbar;
colormap(gray);