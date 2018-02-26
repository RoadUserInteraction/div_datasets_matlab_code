function Data = removeExtraTrials(Data)

Data = arrayfun(@(a)removeTrial(a, [13:19]), Data, 'UniformOutput', false);
Data = [Data{:}];

end

function a = removeTrial(a, trialToRemove)

[indToRemove, ~] = ismember(a.orderOfExperiments, trialToRemove);

if ~isempty(indToRemove)
    names = fieldnames(a);
    names(cellfun(@(a)strcmp(a, 'participantID'),names)) = [];
    
    for i=1:length(names)
        a.(names{i})(indToRemove)=[];
    end
    
end
end