function Data = removeParticipantFromData(Data)

% Remove crashes
trialToRemove.ID = [10 17];
Data = arrayfun(@(a)removeParticipant(a, trialToRemove), Data, 'UniformOutput', false);
Data = [Data{:}];

end

function a = removeParticipant(a, trialToRemove)

[Lia,~] = ismember(a.participantID, trialToRemove.ID);

if Lia
    a = [];
end

end