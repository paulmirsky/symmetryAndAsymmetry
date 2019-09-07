clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

% input parameters
lowWedgeExponent = 1;
lowSlabExponent = 1;
highWedgeExponent = 1;
highSlabExponent = 1;

grating = manyFeatures01;
grating.featureSizes = [ 5, 2, 4, 3 ]; % lowest to highest, a-b-c-d
grating.featureTypes = ['b','d','b','d']; % bright, dark, bright, dark
grating.stateChoices = [ 0, 0, 0, 0 ];
grating.calcPatternAndGensFromParams;
gratingZeroState = grating.pattern
gratingXformed = grating.transformPattern(gratingZeroState, ['w','s','w','s'], [1 2 3 4],... 
    [ lowWedgeExponent, lowSlabExponent, highWedgeExponent, highSlabExponent ] )

% grating drawing
drawGrating = spatialDiagram08;
drawGrating.figPos = [100 100 1200 200];
drawGrating.initialize;
drawGrating.ellipticity = 1;
drawGrating.phaseWidth = 4;
drawGrating.drawPattern(gratingXformed, 0);
drawGrating.clearBorder; 


