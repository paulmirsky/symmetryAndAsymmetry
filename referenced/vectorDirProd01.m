function productVec = vectorDirProd01(vector1, vector2)

productVec = reshape(vector2 * vector1.', length(vector1)*length(vector2), 1);

end

