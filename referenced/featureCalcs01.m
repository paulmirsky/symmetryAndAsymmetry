classdef featureCalcs01  < handle
    
    properties
        nPatches % input  
        wedge
        slab
        phase
        ft
        darkStates
        brightStates
        realEVals % real eigenvalues of the positionOb and angleOb matrices
        complexEVals % complex eigenvalues of the positionOb and angleOb matrices
        baseReal
        basePhase
        positionOb
        angleOb
        zeroOffset
        
    end
    properties (Access = 'private')
    end

    
    methods
        
        % constructor
        function this = featureCalcs01()
            % constructor only            
        end 

        
        
        
        % do this to start it up
        function initializeCalc(this)
            
            % validate inputs
            if isempty(this.nPatches)
                error('feature size is required as input!');
            end
            if ~allEntriesAreIntegers(this.nPatches,1e-9)
                error(['feature size is not an integer, ', num2str(this.nPatches)]);
            end            

            % calculate all feature data
            this.ft = normalize(fftshift(fft(eye(this.nPatches))));
            this.darkStates = eye(this.nPatches);
            this.brightStates = this.ft;            
            this.baseReal = 1 /this.nPatches;
            this.basePhase = exp(1i*this.baseReal*2*pi);            
            this.realEVals = hwIndexRange01(this.nPatches,'right') * this.baseReal;
            this.zeroOffset = ceil((this.nPatches+1)/2);
            this.complexEVals = this.basePhase.^this.realEVals;
            this.angleOb = hamiltonian002(this.brightStates, this.realEVals);
            this.positionOb = hamiltonian002(this.darkStates, this.realEVals);
            this.slab = expm( 2i*pi*this.angleOb );
            this.wedge = expm( 2i*pi*this.positionOb );
            this.phase = this.basePhase * eye(this.nPatches);
            
        % function end
        end            
        
        
    % end of methods           
    end

% end of class       
end

