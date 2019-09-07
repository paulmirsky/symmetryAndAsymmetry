clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Symmetries of the observables')

calc.angleOb
angleConj = inv(calc.slab) * calc.angleOb * calc.slab

calc.positionOb
positionConj = inv(calc.wedge) * calc.positionOb * calc.wedge



