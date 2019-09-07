clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;


disp('All possible basePhases of |D_0>')
D_0_p0 = calc.basePhase^0 * calc.darkStates( :, 2 )
D_0_p1 = calc.basePhase^1 * calc.darkStates( :, 2 )
D_0_p2 = calc.basePhase^2 * calc.darkStates( :, 2 )

disp('All possible basePhases of |B_0>')
B_0_p0 = calc.basePhase^0 * calc.brightStates( :, 2 )
B_0_p1 = calc.basePhase^1 * calc.brightStates( :, 2 )
B_0_p2 = calc.basePhase^2 * calc.brightStates( :, 2 )










