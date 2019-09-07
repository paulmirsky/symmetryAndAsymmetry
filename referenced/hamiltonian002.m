function hamOut = hamiltonian002(basis, energies)

% local values
dimension = size(basis,1);
eVecCount = size(basis,2);

% make the operator
accumulator = zeros(dimension);
for n = 1:eVecCount
    accumulator = accumulator + energies(n)*makeProjector(basis(:,n));
end
hamOut = accumulator;

end




function out = makeProjector(vectorIn)

    % check that they form a basis
    if false == true % FIX THIS LATER
        error = MException('Rainbow:vecsNotABasis','Vectors passed to ''projectorList'' don''t form a basis');
        throw(error);
    end
    
    % loop over vecs
    normedVec = vectorIn/norm(vectorIn); % normalizes the vector to 1, even though it should come in that way
    out = normedVec*normedVec'; % outer product with conjugate
        
end