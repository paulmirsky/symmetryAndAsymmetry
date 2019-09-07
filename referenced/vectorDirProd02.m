function productVec = vectorDirProd02(vecCellArray)

productVec = [1];
for m = 1:length(vecCellArray)
    productVec = vectorDirProd01(productVec, vecCellArray{m});
end
    
end

