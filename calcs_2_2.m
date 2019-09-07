clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Base phase')
r = calc.basePhase

disp('Bright states')
B_neg1 = calc.brightStates(:, (calc.zeroOffset - 1) )
B_0 = calc.brightStates(:, (calc.zeroOffset + 0) )
B_1 = calc.brightStates(:, (calc.zeroOffset + 1) )

disp('Factors from shifting')
calc9 = featureCalcs01;
calc9.nPatches = 9;
calc9.initializeCalc;
iStartState = 2; % this determines the start state, and by extension the basePhasesInShift
stateBefore = calc9.brightStates(:,calc9.zeroOffset + iStartState)
stateAfter = circshift(stateBefore,[1 0])
shiftFactor = stateAfter ./ stateBefore
basePhasesInShift = angle(shiftFactor) / angle( calc9.basePhase )




