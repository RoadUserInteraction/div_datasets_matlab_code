load('WP2Data_v6.mat')
DataWP2 = w2exclusionFcn.removeCrashesFromData(DataWP2);
DataWP2withE = w2exclusionFcn.removeParticipantFromData(DataWP2);
DataWP2withE = w2exclusionFcn.removeWrongTopSpeedTrials(DataWP2withE);
%Add the visibility metric
DataWP2withE = w2func.addBikeVisibility(DataWP2withE);
DataWP2withE = w2exclusionFcn.removeReturnTrials(DataWP2withE);
DataWP2 = w2exclusionFcn.removeExtraTrials(DataWP2withE);
load('experimentalTable.mat')