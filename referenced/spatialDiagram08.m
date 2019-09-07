classdef spatialDiagram08  < handle
    
    properties
        figObj
        axObj % if you pass it an axObj before initialization, it uses it.  Otherwise, it creates its own
        figPos = [100 100 1500 400]
        nothingQty = 1e-9
        patchSize = 0.9
        phaseWidth = 1 % in patches, both sizes together
        tickWidth = 1 % in patches, both sizes together
        brightColor = [255 0 0]/255
        darkColor
        iDarkColor = 2
        zOrientation = 'v' % 'v' or 'h'
        allDarkColors = [
            [160 195 230]/255;
            [195 217 239]/255;
            [215 230 245]/255 ]
        smallTickColor = 0.7 * [1 1 1]
        largeTickColor = 0.4 * [1 1 1]
        suppressDarkPatches = false
        ellipticity = 0.35
        phaseOffset = .00 * 2*pi % used to stop the annoying 'wrap-around' in the plots
        plottingOffset = [0 0] % x and y offsets in where it plots
        minX % these find the regions with bright patches
        maxX
        centralX 
        halfSpread        
        
    end


    
    methods
        
        % constructor
        function this = spatialDiagram08()
            % 
        % constructor end
        end 
        
        
        
        
        % creates all the variables etc 
        function initialize(this)
            
            if isempty(this.axObj) % if you already gave it one, then it uses that
                this.figObj = figure('position',this.figPos);
                this.axObj = axes('parent',this.figObj);
            end
            daspect(this.axObj,[1 1 1]);
            % pbaspect(this.axObj,[this.plotAspectRatio 1 1]);
            hold(this.axObj,'on');                
            
            this.darkColor = this.allDarkColors(this.iDarkColor,:);
            
        % function end
        end

        
        
        
        %
        function drawPattern(this, pattern, zVal)
            
            % check sizes
            absPattern = abs(pattern);
            allNonZeroMags = absPattern( absPattern > this.nothingQty  );
            variation = ( max(allNonZeroMags) - max(allNonZeroMags) ) / mean(allNonZeroMags);
            if (variation > 1e-3)
                error('magnitudes of pattern are not uniform -- something is wrong!');
            end
                        
            for ii = 1:numel( pattern )
                
                % choose params
                if ( abs(pattern(ii)) < this.nothingQty ) % dark patches
                    if this.suppressDarkPatches
                        continue;
                    end
                    thisZ = zVal;
                    thisColor = this.darkColor;                    
                else % bright patches
                    pattern(ii) = pattern(ii) * exp(1i*this.phaseOffset);                    
                    phaseVal = mod(angle(pattern(ii)) + pi, 2*pi) - pi;                    
                    phaseX = -1 * this.phaseWidth *  phaseVal / (2*pi); 
                    thisZ = zVal+phaseX;
                    thisColor = this.brightColor;
                end
                
                % plot, according to orientation
                if (this.zOrientation=='v')
                    this.markPoint(ii, thisZ, thisColor);
                elseif (this.zOrientation=='h')
                    this.markPoint(thisZ, -ii, thisColor);
                else
                    error('invalid orientation tag!');
                end
                
            end
           
            % get important points for plotting
            this.minX = find( (abs(pattern) > this.nothingQty), 1, 'first' );
            this.maxX = find( (abs(pattern) > this.nothingQty), 1, 'last' );
            this.centralX = ceil( ( this.minX + this.maxX )/2 );
            this.halfSpread = ceil( (this.maxX - this.minX)/2 );
            
        % function end
        end
        
        
        
        
        % draws a point
        function markPoint(this, xVal, yVal, thisColor)
        
            if (this.zOrientation=='v')
                markerDims = [ this.patchSize, this.ellipticity*this.patchSize ];
            elseif (this.zOrientation=='h')
                markerDims = [ this.ellipticity*this.patchSize, this.patchSize ];
            else
                error('invalid orientation tag!');
            end            
            
            posVec = [ [xVal yVal] + this.plottingOffset - 0.5*markerDims, abs(markerDims) ];
            rectangle('position',posVec,'curvature',[1 1],'FaceColor',thisColor,...
                'EdgeColor', 'none');
            
        % function end
        end

        

                    
        % 
        function clearBorder(this)
        
            this.axObj.Parent.Color = [1 1 1];
            this.axObj.XColor = 'none';
            this.axObj.YColor = 'none';
        
        % function end
        end

        
        
                    
        % 
        function addTicks(this, propAxisVal, transAxisVals, thickness, tickColor)
            
            for ii = 1:numel(transAxisVals)
                if (this.zOrientation=='v')
                    xVals = [transAxisVals(ii),transAxisVals(ii)]+0.5;
                    yVals = propAxisVal+this.tickWidth*[-0.5,0.5];
                elseif (this.zOrientation=='h')                    
                    xVals = propAxisVal+this.tickWidth*[-0.5,0.5];                    
                    yVals = -1*[transAxisVals(ii),transAxisVals(ii)]-0.5;
                else
                    error('invalid orientation tag!');
                end
                xVals = xVals + this.plottingOffset(1);
                yVals = yVals + this.plottingOffset(2);
                line( xVals, yVals, 'parent', this.axObj,'LineWidth',thickness,'Color',tickColor)
            end
        
        % function end
        end

               
    % end of methods           
    end

% end of class       
end

