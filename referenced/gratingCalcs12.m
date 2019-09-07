classdef gratingCalcs12  < handle
    
    properties

        % system params, for input grating
        form
        texture
        period % give it an approx val, code changes it to exact
        formAngle = 0
        texAngle = 0
        formShift = 0
        texShift = 0
        lensFL % give it an approx val, code changes it to exact
        wavelength
        
        % data
        xVals
        inputWF
        outputWF
        plotXMax
        formIn
        textureIn
        formOut
        textureOut
        
        % display params
        visible = 'on'
        lensAxSize = [500 35]
        showPhaseCutoff = .001
        scaleFormCutoff = .001
        peakHeightRatio = 0.95
        showXLims = false
        formColor = 0.7*[1 1 1]
        magColor = [1 0 0]
        phaseColor = [45 135 240]/255
        lensColor = [91 155 213]/255
        figPosXY = [50 50] % in px
        axesWidth = 1400
        axesHeight = 170
        axesStandoff = 15
        planeStandoff = 120
        axesBorder = 60
        formLineWidth = 2
        phaseLineWidth = 2
        shiftLineWidth = 1
        suppressLabels = false
        lensEdge = 0.85 % at 1, it covers none of the lens        
        labelXFactor = 0.96
        labelYFactor = 0.82
        labelFontSize = 24
        labelColor = 0.6*[1 1 1]
        
        % objects
        plotFig
        magInAx
        magOutAx
        phaseInAx
        phaseOutAx
        
        % misc params
        nSigmaForForm = 3
        sizeToSigma = sqrt(2)/4
        bmpFolder
        bmpName

    end

    
    methods
        
        % constructor
        function this = gratingCalcs12()
            
            % just a constructor.  gives user the opportunity to set values
            % that are different from default
            
        % constructor end
        end 
        
        
        
        
        % calculates the inputWF from the parameters that were already set
        function calcInputWF(this)
            
            % get exact vals, integral nPatches
            nPatchesPerPeriod = round( this.period/this.wavelength );
            this.period = nPatchesPerPeriod * this.wavelength;
            nPatchesTotal = round( this.lensFL/this.wavelength );
            this.lensFL = nPatchesTotal * this.wavelength;
            
            % create form
            this.xVals = this.wavelength * ( (1:nPatchesTotal).' - floor(nPatchesTotal/2) );                   
            formSigma = this.form * this.sizeToSigma;
            this.formIn = exp( -1*( (this.xVals-this.formShift).^2) / (2*(formSigma^2)) ) / sqrt(2*pi*formSigma^2);
            
            % create tex
            nSmallsPerSide = ceil( this.nSigmaForForm * formSigma / this.period );
            texSigma = this.texture * this.sizeToSigma;
            texFunction = zeros([nPatchesTotal,1]);
            for ii = (-1*nSmallsPerSide):nSmallsPerSide                
                thisCenter = ii * this.period;                
                theseXVals = this.xVals - thisCenter - this.texShift;    
                texAmp =  exp( -1*(theseXVals.^2)/(2*(texSigma^2)) ) / sqrt(2*pi*texSigma^2);                
                texPhase = exp( this.texAngle * 1i * theseXVals  / this.wavelength  );
                thisTerm = texAmp .* texPhase;
                if ii==0
                    this.textureIn = thisTerm;
                end
                % add contribution from form
                discreteFormPhase = exp( this.formAngle * 1i * (thisCenter-this.formShift) / this.wavelength );
                thisTerm = thisTerm * discreteFormPhase;
                texFunction = texFunction + thisTerm;
            end

            % combine tex and form
            this.inputWF = this.formIn .* texFunction; 
            
        % function end
        end        
      
        


        % 
        function calcOutputWF(this)

            % get the FT
            wfOut = ifftshift( this.inputWF );
            wfOut = fft(wfOut);
            this.outputWF = flipud(fftshift(wfOut));     
            
            % FT for tex and form
            textureOut = ifftshift(this.formIn);
            textureOut = fft(textureOut);
            this.textureOut = flipud(fftshift(textureOut));     
                        
            formOut = ifftshift(this.textureIn);
            formOut = fft(formOut);
            this.formOut = flipud(fftshift(formOut));     
            
        % function end
        end        

           
        
                
        % 
        function draw(this, lightWF, planeTag)
        
            % create the axes etc.
            if isempty(this.plotFig) || ~isvalid(this.plotFig)
                figWidth = 2*this.axesBorder + this.axesWidth;
                figHeight = 2*this.axesBorder + 4*this.axesHeight + 2*this.axesStandoff + this.planeStandoff;
                this.plotFig = figure('Position',[ this.figPosXY, figWidth, figHeight ],...
                    'Color','white','visible',this.visible);  
                yThisAx = this.axesBorder;
                this.magInAx = axes('parent',this.plotFig,'units','pixels','position',...
                    [this.axesBorder, yThisAx, this.axesWidth, this.axesHeight]);                
                yThisAx = yThisAx + this.axesHeight + this.axesStandoff;
                this.phaseInAx = axes('parent',this.plotFig,'units','pixels','position',...
                    [this.axesBorder, yThisAx, this.axesWidth, this.axesHeight]);                
                yLens = yThisAx + this.axesHeight + 0.5*this.planeStandoff;
                yThisAx = yThisAx + this.axesHeight + this.planeStandoff;
                this.magOutAx = axes('parent',this.plotFig,'units','pixels','position',...
                    [this.axesBorder, yThisAx, this.axesWidth, this.axesHeight]);                
                yThisAx = yThisAx + this.axesHeight + this.axesStandoff;
                this.phaseOutAx = axes('parent',this.plotFig,'units','pixels','position',...
                    [this.axesBorder, yThisAx, this.axesWidth, this.axesHeight]);
                % draw the lens
                lensAxCenter = [figWidth/2 yLens];
                lensAx = axes('parent',this.plotFig,'units','pixels','position',...
                    [ lensAxCenter-0.5*this.lensAxSize, this.lensAxSize ]);
                rectangle('position',[-1 -1 2 2],'parent',lensAx,'FaceColor',this.lensColor,'Curvature',[1 1],...
                    'EdgeColor','none');
                rectangle('position',[-1 -1 (1-this.lensEdge) 2],'parent',lensAx,'FaceColor',[1 1 1],'EdgeColor','none');
                rectangle('position',[this.lensEdge -1 (1-this.lensEdge) 2],'parent',lensAx,'FaceColor',[1 1 1],'EdgeColor','none');
                set(lensAx,'XLim',[-1 1],'YLim',[-1 1],'XColor',[1 1 1],'YColor',[1 1 1]);
                
            end
            
            
            % handle which plane it is
            if strcmp(planeTag,'input')
                magAx = this.magInAx;
                phaseAx = this.phaseInAx;
                xLims = this.plotXMax * [-1 1];
                form = this.formIn;
            elseif strcmp(planeTag,'output')
                magAx = this.magOutAx;
                phaseAx = this.phaseOutAx;
                xLims = this.plotXMax * [-1 1];
                form = this.formOut;
            end            

            % get mag and form
            signal = abs(lightWF).^2;
            form = abs(form).^2;
            % scale it
            badOnes = form < max(form)*this.scaleFormCutoff; % find the invalid points
            theRatio = signal./form;
            theRatio(badOnes) = 0;
            scaleFac = max(theRatio);
            form = form * scaleFac;
            
            % find good phases
            phases = angle(lightWF);
            signalCutoff = max(signal) * this.showPhaseCutoff;
            phaseValid = signal >= signalCutoff;
            validPhaseXs = this.xVals;
            validPhaseXs(~phaseValid) = nan;
            validPhases = phases;
            validPhases(~phaseValid) = nan;
            phaseJumps = (diff(validPhases) > 6) | (diff(validPhases) < -6);
            phaseJumps = [false; phaseJumps];
            validPhases(phaseJumps) = nan;
            
            % plot the mag and form
            plot( this.xVals, form, 'parent', magAx, 'Color', this.formColor,... 
                'LineWidth', this.formLineWidth );
            hold(magAx,'on')
            area(magAx,this.xVals,signal,'FaceColor', this.magColor,'EdgeColor','none')
            
            % scale etc.
            if isempty(xLims)
                xLims = magAx.XLim;
            end
            set(magAx,'XLim',xLims,'YTick',[] );
            if this.showXLims
                set(magAx,'XTick',[ xLims(1), 0, xLims(2)]);
            else
                set(magAx,'XTick',[]);
            end
            plotPeak = max(form) / this.peakHeightRatio;
            line( [0 0], [0 plotPeak], 'parent', magAx, 'Color', 'black',... 
                'LineWidth', this.shiftLineWidth );
            magAx.YLim(2) = plotPeak;
            this.addLabel(magAx,'magnitude');
            hold(magAx,'off')
            
            % plot the phase
            plot( validPhaseXs, validPhases, 'parent', phaseAx, 'Color', this.phaseColor,... 
                'LineWidth', this.phaseLineWidth );
            set(phaseAx,'YLim',pi*[-1 1],'XTick',[],'YTick',[-1 0 1]*pi,'YTickLabel',...
                {'-\pi','0','\pi'},'XLim',xLims,'FontSize',24);
            this.addLabel(phaseAx,'phase');
            
        % function end
        end
        
        
        
        function addLabel( this, anAxis, aString )
            
            if ~this.suppressLabels
                xVal = this.labelXFactor * anAxis.XLim(1);
                yVal = anAxis.YLim(1) + this.labelYFactor*( anAxis.YLim(2)-anAxis.YLim(1) );
                text( xVal, yVal, aString, 'parent', anAxis,'FontSize', this.labelFontSize,...
                    'Color', this.labelColor);                
            end
            
        % function end
        end

        
               
    % end of methods           
    end

    
% end of class       
end

