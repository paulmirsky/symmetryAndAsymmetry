clear all
close all
dbstop on error
global suppressSound
suppressSound = true;
clc

calc = gratingCalcs12();
calc.wavelength = 500e-9;
calc.form = 3e-3;
calc.lensFL = .15;
calc.texture = 7e-5;
calc.period = 5e-4;
calc.plotXMax = .002;

% input parameters

% calc.formShift = 6e-4;
% calc.texShift = 1e-4;
calc.formAngle = 2e-3;
calc.texAngle = 2e-3;


calc.calcInputWF;
calc.calcOutputWF;
calc.draw(calc.inputWF,'input');
calc.draw(calc.outputWF,'output');