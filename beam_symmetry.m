clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

% input parameters
slabExponent = 0; % low
wedgeExponent = 1; % high

beam = manyFeatures01;
beam.featureSizes = [ 5, 3 ]; % low feature size (a), high feature size (b)
beam.featureTypes = ['b','d']; % bright, dark
beam.stateChoices = [ 1, 1 ]; % these are non-zero so that the symmetry xforms will be non-trivial
beam.calcPatternAndGensFromParams;
beamZeroState = beam.pattern
beamXformed = beam.transformPattern(beamZeroState, ['s','w'], [1 2],... 
    [ slabExponent, wedgeExponent ] )

% beam drawing
drawBeam = spatialDiagram08;
drawBeam.figPos = [100 100 800 200];
drawBeam.initialize;
drawBeam.drawPattern(beamXformed, 0);
drawBeam.clearBorder; 


