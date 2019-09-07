clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

% input parameters
wedgeExponent = 1; % low
slabExponent = 1; % high

beam = manyFeatures01;
beam.featureSizes = [ 5, 3 ]; % low feature size (a), high feature size (b)
beam.featureTypes = ['b','d']; % bright, dark
beam.stateChoices = [ 0, 0 ];
beam.calcPatternAndGensFromParams;
beamZeroState = beam.pattern
beamXformed = beam.transformPattern(beamZeroState, ['w','s'], [1 2],... 
    [ wedgeExponent, slabExponent ] )

% beam drawing
drawBeam = spatialDiagram08;
drawBeam.figPos = [100 100 800 200];
drawBeam.initialize;
drawBeam.drawPattern(beamXformed, 0);
drawBeam.clearBorder; 


