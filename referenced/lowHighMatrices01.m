classdef lowHighMatrices01  < handle
    
    properties
        highMatType       
        highFeatSize    
        highExponent
        lowMatType
        lowFeatSize
        lowExponent
        basePhase
        showIt = false
    end
    
    
    methods
        
        % constructor
        function this = lowHighMatrices01()
        % constructor end
        end 
        
        
        
        
        % 
        function calcAll(this)
            
            % low feature
            lowFeature = featureCalcs01;
            lowFeature.nPatches = this.lowFeatSize;
            lowFeature.initializeCalc;
            if (this.lowMatType=='s')
                gen = lowFeature.slab;
            elseif (this.lowMatType=='w')
                gen = lowFeature.wedge;
            else
                error('invalid low matrix type!');
            end
            lowMatrix = gen^this.lowExponent; % this is the effect of the low
            formatter = reformatMatrixFromR02;
            formatter.basePhase = lowFeature.basePhase;
            if this.showIt
                lowMatrix = lowMatrix
                lowExponents = formatter.doReformat( lowMatrix )
                lowBasePhase = lowFeature.basePhase            
            end
            
            % high feature
            highFeature = featureCalcs01;
            highFeature.nPatches = this.highFeatSize;
            highFeature.initializeCalc;
            if (this.highMatType=='s')
                gen = highFeature.slab;
            elseif (this.highMatType=='w')
                gen = highFeature.wedge;
            else
                error('invalid high matrix type!');
            end
            highMatrix = gen^this.highExponent; % this is the effect of the high
            formatter = reformatMatrixFromR02;
            formatter.basePhase = highFeature.basePhase;
            if this.showIt
                highMatrix = highMatrix;
                highExponents = formatter.doReformat( highMatrix )
                highBasePhase = highFeature.basePhase            
            end
            
            % start a many features
            this.basePhase = exp( 2i*pi / (this.lowFeatSize * this.highFeatSize) );
            sys = manyFeatures01;
            sys.featureSizes = [ this.lowFeatSize, this.highFeatSize ]; % the first is the lowest-ranking / lowmost
            sys.featureTypes = 'bb'; % doesn't matter
            sys.stateChoices = [ 0 0 ];
            sys.calcPatternAndGensFromParams;
            genLabels = [ this.lowMatType, this.highMatType ];
            genExponents = [ this.lowExponent, this.highExponent ];
            [~, productMatrix] = sys.transformPattern( sys.pattern, genLabels, [1 2], genExponents );
            formatter = reformatMatrixFromR02;
            formatter.basePhase = this.basePhase;            
            if this.showIt
                productMatrix = productMatrix
                productExponents = formatter.doReformat( productMatrix )            
                productBasePhase = this.basePhase
            end

            
            
        % function end
        end
       
               
    % end of methods           
    end

% end of class       
end

