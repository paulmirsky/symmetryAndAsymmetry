function productMat = matrixDirProd02(matCellArray)

productMat = [1];
for m = 1:length(matCellArray)
    productMat = matrixDirProd01(productMat, matCellArray{m});
end
    
end

