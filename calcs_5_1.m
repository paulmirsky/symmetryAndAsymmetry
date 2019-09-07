clear all
close all
dbstop on error
clc
addpath([ fileparts(mfilename('fullpath')), '\referenced' ]);

disp('Identity matrix');
calc = lowHighMatrices01;
calc.highMatType = 's';
calc.highFeatSize = 3;
calc.highExponent = 0;
calc.lowMatType = 'w';
calc.lowFeatSize = 2;
calc.lowExponent = 0;
calc.showIt = true;
calc.calcAll;

disp('High wedge');
calc = lowHighMatrices01;
calc.highMatType = 'w';
calc.highFeatSize = 3;
calc.highExponent = 1;
calc.lowMatType = 's';
calc.lowFeatSize = 2;
calc.lowExponent = 0;
calc.showIt = true;
calc.calcAll;

disp('High slab');
calc = lowHighMatrices01;
calc.highMatType = 's';
calc.highFeatSize = 3;
calc.highExponent = 1;
calc.lowMatType = 'w';
calc.lowFeatSize = 2;
calc.lowExponent = 0;
calc.showIt = true;
calc.calcAll;

disp('Low wedge');
calc = lowHighMatrices01;
calc.highMatType = 's';
calc.highFeatSize = 3;
calc.highExponent = 0;
calc.lowMatType = 'w';
calc.lowFeatSize = 2;
calc.lowExponent = 1;
calc.showIt = true;
calc.calcAll;

disp('Low slab');
calc = lowHighMatrices01;
calc.highMatType = 'w';
calc.highFeatSize = 3;
calc.highExponent = 0;
calc.lowMatType = 's';
calc.lowFeatSize = 2;
calc.lowExponent = 1;
calc.showIt = true;
calc.calcAll;





