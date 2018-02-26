function Data = removeCrashesFromData(Data)

% Remove crashes
trialToRemove.ID = [3164, 3311, 662, 843, 1365, 1563, 2166, 2466, 2944 ,3011];
trialToRemove.task = [9, 35, 29, 22, 35 ,32 , 14, 35 ,35, 30];
Data = arrayfun(@(a)removeTrial(a, trialToRemove), Data, 'UniformOutput', false);
Data = [Data{:}];

end

function a = removeTrial(a, trialToRemove)

[Lia,Locb] = ismember(a.participantID, trialToRemove.ID);

if Lia
    [indToRemove, ~] = ismember(a.orderOfExperiments, trialToRemove.task(Locb));
    a.actualOrderOfExperiments(indToRemove) = [];
    a.orderOfExperiments(indToRemove) = [];
    a.Metrics(indToRemove) = [];
    a.Timestamp(indToRemove) = [];
    a.Car(indToRemove) = [];
    a.Pedestrian(indToRemove) = [];
end

end