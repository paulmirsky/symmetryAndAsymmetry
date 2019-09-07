function productMatrix = matrixDirProd01(matrix1, matrix2)

productMatrix = zeros(size(matrix1, 1)*size(matrix2, 1), size(matrix1, 2)*size(matrix2, 2)); % initialize

for m = 1:size(matrix1, 1) % loop thru rows of matrix1
    zeroM = (m - 1) * size(matrix2, 1);
    for n = 1:size(matrix1, 2) % loop thru columns of matrix1
        zeroN = (n - 1) * size(matrix2, 2);
        productMatrix((zeroM + 1):(zeroM + size(matrix2, 1)), (zeroN + 1):(zeroN + size(matrix2, 2))) = matrix1(m, n) * matrix2;
    end
end

end

