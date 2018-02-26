function out = getFullIDListFrom(Data)

res = arrayfun(@(a,b)repmat(a,1,b), common.getFromData(Data, 'participantID'), cellfun(@(a)length(a),({Data.orderOfExperiments})), 'UniformOutput', 0);
out = [res{:}]';

end