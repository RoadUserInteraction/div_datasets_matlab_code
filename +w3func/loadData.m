load('WP3Data_v12.mat')
DataWP3withE = w3exclusionFcn.removeCrashesFromData(DataWP3);
DataWP3withE = w3exclusionFcn.removeParticipantFromData(DataWP3withE);
DataWP3withE = w3exclusionFcn.removeWrongTopSpeedTrials(DataWP3withE);
DataWP3 = w3exclusionFcn.removeExtraTrials(DataWP3withE);
load('experimentalTable.mat')