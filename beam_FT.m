clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

% input parameters
% stateChoices = [0, 0]; % low, high state indices
% stateChoices = [0, 1]; % low, high state indices
stateChoices = [-1, 0]; % low, high state indices

beam = manyFeatures01;
beam.featureSizes = [ 3, 5 ]; % low feature size (a), high feature size (b)
beam.featureTypes = ['b','d']; % bright, dark
beam.stateChoices = stateChoices;
beam.calcPatternAndGensFromParams;
patternIn = beam.pattern
patternOut = beam.ftPattern(patternIn, [1 2])

% beam drawing
drawBeam = spatialDiagram08;
drawBeam.figPos = [100 100 700 500];
drawBeam.initialize;
drawBeam.zOrientation = 'h';
drawBeam.drawPattern(patternIn, 0);
drawBeam.drawPattern(patternOut, 10);
drawBeam.clearBorder; 


