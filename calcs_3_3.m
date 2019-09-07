clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Conjugating wedge by FT')
conjugtedWedge = calc.ft * calc.wedge * inv(calc.ft)
slab = calc.slab

disp('Conjugating slab by FT')
conjugatedSlab = inv(calc.ft) * calc.slab * calc.ft
wedge = calc.wedge


