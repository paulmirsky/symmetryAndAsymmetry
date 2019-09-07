clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Dark states')
D_neg1 = calc.darkStates(:, (calc.zeroOffset - 1) )
D_0 = calc.darkStates(:, (calc.zeroOffset + 0) )
D_1 = calc.darkStates(:, (calc.zeroOffset + 1) )




