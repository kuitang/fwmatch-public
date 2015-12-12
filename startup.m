dbstop if error;

addpath(genpath('src/'));
addpath expt_framework/;
addpath thirdparty/pmtk3-master; startup_pmtk3;
addpath thirdparty/QPBO-v1.32.src;
addpath thirdparty/libdai/matlab/;

display(sprintf('PATH is now set!'));
