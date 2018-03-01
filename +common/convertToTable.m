function tbl=convertToTable(Data, fieldNames)

IDs = common.getFullIDListFrom(Data);
trialNr = common.getFromData(Data, {'orderOfExperiments'});
vrus =  common.getFromData(Data, 'VRU');
cars =  common.getFromData(Data, 'Car');
nb = cellfun(@(c)length(c.Speed), cars)';

for i=1:length(fieldNames)
    if regexp(fieldNames{i}, 'Car\. *')
        data{i} = cellfun(@(c)c.(fieldNames{i}(5:end)), cars, 'UniformOutput', false);
    elseif regexp(fieldNames{i}, 'VRU\. *')
        data{i} = cellfun(@(c)c.(fieldNames{i}(5:end)), vrus, 'UniformOutput', false);
    else
        data{i} = common.getFromData(Data, fieldNames{i});
    end
    if size(data{i},1) == 1
        data{i} = data{i}';
    end
end

hasContinuousData = false;
for i=1:length(data)
    hasContinuousData = iscell(data{i});
    if hasContinuousData
        break;
    end
end

if hasContinuousData % prepare data for table
    dataForTable{1} = repmatValues(IDs, nb);
    dataForTable{2} = repmatValues(trialNr, nb);
    for i=1:length(data)
        if iscell(data{i})
            dataForTable{i+2} = vertcat(data{i}{:});
        else
            dataForTable{i+2} = repmatValues(data{i}, nb);
        end
    end
else
    dataForTable{1} = IDs;
    dataForTable{2} = trialNr;
    for i=1:length(data)
        dataForTable{i+2} = vertcat(data{i}{:});
    end
end
tbl = table(dataForTable{:}, 'VariableNames', strrep({'ID', 'trialNr', fieldNames{:}},'.','_'));
end

function dataForTable = repmatValues(data, nb)
out = arrayfun(@(d,nb)repmat(d,nb,1),data,repmat(nb,1,size(data,2)), 'uniformoutput',false);
for j=1:size(data,2)
    dataForTable(:,j) = vertcat(out{:,j});
end

end