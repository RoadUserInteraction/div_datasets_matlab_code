function Data = keepTrials(Data, trialToKeep)

Data = arrayfun(@(a)keepTrial(a, trialToKeep), Data, 'UniformOutput', false);
Data = [Data{:}];

end

function a = keepTrial(a, trialToKeep)

[indToKeep, ~] = ismember(a.orderOfExperiments, trialToKeep);

if ~isempty(indToKeep)
    names = fieldnames(a);
    names(cellfun(@(a)strcmp(a, 'participantID'),names)) = [];
    
    for i=1:length(names)
        a.(names{i})(~indToKeep)=[];
    end
    
end
end