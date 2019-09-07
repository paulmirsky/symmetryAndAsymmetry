clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

% input parameters
lowSlabExponent = 0;
lowWedgeExponent = 0;
highSlabExponent = 0;
highWedgeExponent = 1;

grating = manyFeatures01;
grating.featureSizes = [ 5, 2, 4, 3 ]; % lowest to highest, a-b-c-d
grating.featureTypes = ['b','d','b','d']; % bright, dark, bright, dark
grating.stateChoices = [ 1, 1, 1, 1 ]; % these are non-zero so that the symmetry xforms will be non-trivial
grating.calcPatternAndGensFromParams;
gratingZeroState = grating.pattern
gratingXformed = grating.transformPattern(gratingZeroState, ['s','w','s','w'], [1 2 3 4],... 
    [ lowSlabExponent, lowWedgeExponent, highSlabExponent, highWedgeExponent ] )

% grating drawing
drawGrating = spatialDiagram08;
drawGrating.figPos = [100 100 1200 200];
drawGrating.initialize;
drawGrating.ellipticity = 1;
drawGrating.phaseWidth = 4;
drawGrating.drawPattern(gratingXformed, 0);
drawGrating.clearBorder; 


