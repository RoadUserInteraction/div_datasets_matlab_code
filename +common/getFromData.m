function varargout = getFromData(Data, fieldname)

if iscell(fieldname)
    len = length(fieldname);
elseif ischar(fieldname)
    len = 1;
else
    return
end
varargout = cell(size(fieldname));
Metrics = [Data.Metrics];

for i=1:len
    if ischar(fieldname)
        fieldn = fieldname;
    else
        fieldn = fieldname{i};
    end
    switch fieldn
        case fieldnames(Metrics)
            varargout{i} = vertcat(Metrics.(fieldn));
        case fieldnames(Data)
            try
                varargout{i} = [Data.(fieldn)];
            catch
                varargout{i} = vertcat(Data.(fieldn));
            end
    end
end

end