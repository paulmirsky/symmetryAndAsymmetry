clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Slab changes a dark state into the next')
slab = calc.slab
startState = calc.darkStates( :, calc.zeroOffset )
endState = slab * startState

disp('Wedge changes a bright state into the next')
wedge = calc.wedge
startState = calc.brightStates( :, calc.zeroOffset )
endState = wedge * startState
matchTo = calc.brightStates( :, calc.zeroOffset - 1 )


