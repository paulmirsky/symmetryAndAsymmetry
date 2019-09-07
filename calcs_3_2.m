clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Slab phases a bright state.  Phase ratio is uniform, i.e. scalar')
iBrightState = 1;
slab = calc.slab
startState = calc.brightStates( :, calc.zeroOffset + iBrightState )
endState =  slab * startState
toMatch = calc.basePhase^iBrightState * startState

disp('Wedge phases a dark state.  Phase ratio is uniform, i.e. scalar')
iDarkState = 1;
wedge = calc.wedge
startState = calc.darkStates( :, calc.zeroOffset + iDarkState )
endState =  wedge * startState
toMatch = calc.basePhase^iDarkState * startState






