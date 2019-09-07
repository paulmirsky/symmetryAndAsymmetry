classdef reformatMatrixFromR02  < handle
    
    properties
        basePhase
        nothingQty = 1e-9
    end

    
    methods
        
        % constructor
        function this = reformatMatrixFromR02()
        % constructor end
        end 
        
        
        
        
        
        % 
        function exponentMat = doReformat(this, inputMatrix)
            
            % make sure magnitudes are uniform
            iNonZero = abs(inputMatrix) > this.nothingQty;
            nonZeros =  inputMatrix(iNonZero);
            magError = std(abs(nonZeros)) / mean(abs(nonZeros));
            if ( magError > this.nothingQty )
                error('not all nonzero entries have uniform magnitude!');
            end            
            
            if isempty(this.basePhase)
                error('user must supply base phase!');
            end
            
            exponentMat = nan( size( inputMatrix ) ); % initialize
            for ii = 1:size( inputMatrix, 1 ) % for each row of the inputMatrix, create a long string
                for jj = 1:size( inputMatrix, 2 ) % for each column along the row, produce 1 block
                    if ( abs(inputMatrix(ii,jj)) < this.nothingQty )
                        thisEntry = nan;
                    else % divide by the base phase
                        thisEntry = ( angle(inputMatrix(ii,jj)) ./ angle(this.basePhase) );
                        thisEntry = round( thisEntry,3);
                        if ~allEntriesAreIntegers(thisEntry,this.nothingQty)
                            error(['non-integer index! ', num2str(thisEntry) ])
                        end                        
                    end                    
                    exponentMat(ii,jj) = thisEntry;
                end
            end            
        
        % function end
        end
        
        
        % 
        function textBlockOut = makeOneBlock(this, inputPhaseFactor)
            letter = 'r';
            powerSymbol = '^';
            zeroSignSymbol = '+';       
            positiveSignSymbol = '+';
            negativeSignSymbol = '-';
            nPaddingPlaces = 5; 
            blankCharacter = ' ';
            nDecimals = 0;
            
            
            coefficient = abs(inputPhaseFactor);
%             
%             coefficient = 1/3
%             
%             num2str(coefficient)
%             
            formattingSpec = [ '%0.', num2str(nDecimals), 'f' ];
            coefficient = sprintf(formattingSpec , coefficient);
            
            % 
            
            if ( abs(inputPhaseFactor) > this.nothingQty )
                index = ( angle(inputPhaseFactor) ./ this.basePhase );
                index = round( index,3);
                if ~allEntriesAreIntegers(index,this.nothingQty)
                    error(['non-integer index! ', num2str(index) ])
                end
            else
                index = 0;
            end
            
            % calculate the correct angle
            
                        
            % signSymbol
            if ( index == 0 )
                signSymbol = zeroSignSymbol;
            elseif ( index > 0 )
                signSymbol = positiveSignSymbol;
            elseif ( index < 0 )
                signSymbol = negativeSignSymbol;
            end
            
            
            padding = repmat( blankCharacter, [1 nPaddingPlaces] );
            
            if ( abs(inputPhaseFactor) > this.nothingQty )
                textBlockOut = [ coefficient, letter, powerSymbol, signSymbol, num2str(abs(index)), padding ];
            else
                nSpaces = numel( [ letter, powerSymbol, signSymbol, num2str(abs(index)) ] );
                textBlockOut = [ coefficient, repmat(' ',[1 nSpaces]), padding ];
            end
            
        % function end
        end
        
                    
        
        
        % 
        function returnVal = FUNCTIONNAME(this, inputArguments)
        
            % 
                        
            returnVal = 0;
        
        % function end
        end
        
               
    % end of methods           
    end

% end of class       
end

