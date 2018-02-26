function getIndexAtCarStartup(Data, wp)

% Find start of acceleration after braking/regulation of speed before
% pedestrian/cyclist. The idea is to show that the start of acceleration
% correspond to when people feel that it is safe to pass after the VRU.
% 2 cases:
%  1) car reached full stop
%  2) car does not reach full stop

% 1) if the car reaches full stop, then the first time the driver
% accelerates should be the right one
% 2) if the car does not reach full stop

FullStopIndices = getFullStopIndices(Data); %true is case 1, false is case 2
reStartIndices = getReStartIndices(Data);
[Cars, VRUs] = common.getFromData(Data, {'Car' 'VRU'});
TTAAtReStart = common.getTTCat(Cars, VRUs, reStartIndices', wp);
VRUTTAAtReStart = common.getVRUTTCat(VRUs, reStartIndices', wp);
g = findgroups(~isnan(FullStopIndices));
for i = 1:2
    subplot(2,2,2*i-1)
    histogram(TTAAtReStart(g==i));
    subplot(2,2,2*i)
    histogram(VRUTTAAtReStart(g==i));
end
end

function reStartIndices = getReStartIndices(Data)

 [Cars, visibility] = common.getFromData(Data, ...
        {'Car' 'indexOfVisibility'});
reStartIndices = cellfun(@(a,b)getReStartIndex(a, b), Cars, num2cell(visibility)')';

end

function i = getReStartIndex(a, b)

[mS, i] = min(a.Speed(b:end));
i = i + b - 1;

if mS==0
    if any(a.Speed(i:end))>0
        i_new = find(a.Speed(i:end)>0, 1, 'first');
        i = i_new + i -1;
    else
        i = nan;
    end
end

end

function FullStopIndices = getFullStopIndices(Data)

% Threshold full stop
speedThreshold = 0.5; %km/h

 [Cars, visibility] = common.getFromData(Data, ...
        {'Car' 'indexOfVisibility'});
FullStopIndices = cellfun(@(a,b)getFullStopIndex(a, b, speedThreshold), Cars, num2cell(visibility)')';

end

function i = getFullStopIndex(a, b, t)

[mS, i] = min(a.Speed(b:end));
i = i + b - 1;
i(mS>t) = NaN;

end