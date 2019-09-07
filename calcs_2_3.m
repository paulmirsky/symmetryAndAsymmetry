clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Fourier transforming dark states')

ft_D_neg1 = calc.ft * calc.darkStates(:, (calc.zeroOffset - 1) )
toMatch = calc.brightStates(:, (calc.zeroOffset - 1) )

ft_D_0 = calc.ft * calc.darkStates(:, (calc.zeroOffset + 0) )
toMatch = calc.brightStates(:, (calc.zeroOffset + 0) )

ft_D_1 = calc.ft * calc.darkStates(:, (calc.zeroOffset + 1) )
toMatch = calc.brightStates(:, (calc.zeroOffset + 1) )

disp('Fourier transforming bright states')

ft_B_1 = calc.ft * calc.brightStates(:, (calc.zeroOffset + 1) )
toMatch = calc.darkStates(:, (calc.zeroOffset - 1) )

ft_B_0 = calc.ft * calc.brightStates(:, (calc.zeroOffset + 0) )
toMatch = calc.darkStates(:, (calc.zeroOffset + 0) )

ft_B_neg1 = calc.ft * calc.brightStates(:, (calc.zeroOffset - 1) )
toMatch = calc.darkStates(:, (calc.zeroOffset + 1) )







