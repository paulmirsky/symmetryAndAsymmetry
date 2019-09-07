classdef manyFeatures01  < handle
    
    properties        
        featureSizes        
        featureTypes    
        stateChoices
        stateChoiceZeroOffset = true
        nFeatures
        arrayPattern
        wedgeGens
        slabGens
        pattern
        
    end
    properties (Access = 'private')
    
    end

    
    methods
        
        % constructor
        function this = manyFeatures01()            
            % constructor only
        % constructor end
        end 
        
        
        
        
        % 
        function calcPatternAndGensFromParams(this)
            
            % validate inputs
            if any( [ isempty(this.featureSizes), isempty(this.featureTypes), isempty(this.stateChoices)] )
                error('not all parameters have been set!');
            end            
            if ~isequal( numel(this.featureSizes), numel(this.featureTypes), numel(this.stateChoices) )
                error('all parameter vectors must be the same size!');
            end
            
            % for each feature...
            this.nFeatures = numel(this.featureSizes);
            for ii = 1:this.nFeatures
                
                % calculate the feature
                nPatches = this.featureSizes(ii);  
                thisFeature = featureCalcs01;
                thisFeature.nPatches = nPatches;
                thisFeature.initializeCalc;
                
                % collect the generators
                this.wedgeGens{ii,1} = thisFeature.wedge;
                this.slabGens{ii,1} = thisFeature.slab;                

                % get the state vector choices
                if (this.featureTypes(ii)=='d') % dark
                    allStates = thisFeature.darkStates;
                elseif (this.featureTypes(ii)=='b') % bright
                    allStates = thisFeature.brightStates;
                else
                    error('invalid feature type!')
                end                
                
                % choose a state vector
                thisStateIndex = this.stateChoices(ii);
                if this.stateChoiceZeroOffset % offset it from zero, if you want
                    zeroPoint = ceil((nPatches+1)/2);
                    thisStateIndex = thisStateIndex + zeroPoint;
                end
                thisStateIndex = mod( (thisStateIndex-1), nPatches ) + 1;
                factorStateVecs{ii,1} = allStates(:,thisStateIndex);

            end

            % form the direct product of factor features
            this.pattern = vectorDirProd02( flipud(factorStateVecs) );
            this.arrayPattern = reshape(this.pattern,this.featureSizes);
                               
        % function end
        end
        
        
        
        
        % 
        function [patternOut, totalXform] = transformPattern(this, patternIn, genTypes, genIndices, genExponents )
            
            % validate inputs
            if ~isequal( this.nFeatures, numel(genExponents), numel(genIndices), numel(genTypes) )
                error('all parameter vectors must match the number of features!');
            end            
        
            % gather the appropriate transform from each feature
            for ii = 1:this.nFeatures
                if genTypes(ii)=='s'
                    thisFactor = this.slabGens{ genIndices(ii) }^genExponents(ii);
                elseif genTypes(ii)=='w'
                    thisFactor = this.wedgeGens{ genIndices(ii) }^genExponents(ii);
                else
                    error('invalid tag for generator! use s or w (slab or wedge) only');
                end
                factorTransforms{ii,1} = thisFactor;                
            end

            % create the combined transform by forming outer product of the
            % individual features' transforms
            totalXform = matrixDirProd02( flipud(factorTransforms) );
            
            % apply it to the state
            patternOut = totalXform * patternIn;
            
        % function end
        end
                
        
        
        
        %
        function patternOut = ftPattern(this, patternIn, featureIndices)
        
            % first we split the pattern vector up into a multidim array, 
            % one dimension for each feature. then we do the FT.  then, we 
            % switch the multidim array back to one vector     
            arrayPatt = reshape(patternIn,this.featureSizes(featureIndices));
            arrayPatt = ifftshift(arrayPatt);
            arrayPatt = fftn(arrayPatt); % the FFT is naturally done on an array
            arrayPatt = fftshift(arrayPatt);
            arrayPatt = permute( arrayPatt, flipud(featureIndices(:)) );                        
            patternOut = reshape(arrayPatt,[prod(this.featureSizes),1]);
        
        % function end
        end

        
        
        
        % local function
        function returnVal = FUNCTIONNAME(this, inputArguments)
        
            % 
                        
            returnVal = 0;
        
        % function end
        end
        
               
    % end of methods           
    end

% end of class       
end

