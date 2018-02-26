function Data = removeWrongTopSpeedTrials(Data)

Data = arrayfun(@(a)removeTrial(a, .1), Data, 'UniformOutput', false);
Data = [Data{:}];

end

function a = removeTrial(a, margin)

Metrics = [a.Metrics];
diffSpeed = vertcat(Metrics.diffTopSpeed);
indToRemove = diffSpeed>margin&a.orderOfExperiments~=19;

names = fieldnames(a);
names(cellfun(@(a)strcmp(a, 'participantID'),names)) = [];

for i=1:length(names)
    a.(names{i})(indToRemove)=[];
end

end