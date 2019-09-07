clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

calc = featureCalcs01;
calc.nPatches = 3;
calc.initializeCalc;

disp('Calculating observables from projectors')

projD_neg1 = calc.darkStates(:,1) * calc.darkStates(:,1)';
projD_0 = calc.darkStates(:,2) * calc.darkStates(:,2)';
projD_1 = calc.darkStates(:,3) * calc.darkStates(:,3)';
positionObFromProjectors = (-1/3)*projD_neg1 + (0/3)*projD_0 + (1/3)*projD_1

projB_neg1 = calc.brightStates(:,1) * calc.brightStates(:,1)';
projB_0 = calc.brightStates(:,2) * calc.brightStates(:,2)';
projB_1 = calc.brightStates(:,3) * calc.brightStates(:,3)';
angleObFromProjectors = (-1/3)*projB_neg1 + (0/3)*projB_0 + (1/3)*projB_1

disp('Observables')
positionOb = calc.positionOb
angleOb = calc.angleOb

disp('Time-evolution operators')
h = 6.63e-34;
delta_t = -1*h;
positionTEO = expm(-2i*pi*delta_t * positionOb / h )
wedge = calc.wedge
angleTEO = expm(-2i*pi*delta_t * angleOb / h )
slab = calc.slab



