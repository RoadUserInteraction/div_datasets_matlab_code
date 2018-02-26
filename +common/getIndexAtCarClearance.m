function fj = getIndexAtCarClearance(Data, wp)

if wp==1
    [Cars, VRUs] = common.getFromData(Data, {'Car' 'Pedestrian'});
    Cars(cellfun(@(a)isempty(a), Cars)) = [];
    VRUs(cellfun(@(a)isempty(a), VRUs)) = [];
else
    [Cars, VRUs] = common.getFromData(Data, {'Car' 'VRU'});
end
fj = cellfun(@(a,b)geti(a,b,wp), Cars', VRUs');

end

function fj = geti(Car, VRU,wp)

switch wp
    case 1
        VRU.Speed = [0;diff(sqrt(sum(VRU.Position.^2,2)))./0.05*3.6];
        VRU.Speed(abs(VRU.Speed)>10) = 0;
        VRUDim = [0.3 0.6];
        CarDim = [2.6 2.2 1.9];
        LongInd = 3;
    case 2
        VRUDim = [1.9 0];
        CarDim = [2.6 2.2 1.9];
        LongInd = 3;
        LatInter = 1.75;
    case 3
        VRUDim = [1.7 0];
        CarDim = [0 4.628 1.865];
        LongInd = 2;
        %         angle = 0.010187500000000;
        %         Car.Position = (rotz(angle)*Car.Position')';
        Car.Position(:,LongInd) = -Car.Position(:,LongInd);
        VRU.Position(:,LongInd) = -VRU.Position(:,LongInd);
        Car.Speed = smooth(Car.Speed,10);
        LatInter = 0;
end

fj = find(VRU.Position(2:end,LongInd)-Car.Position(2:end,LongInd)>CarDim(2),1,'first')+1;

if isempty(fj)
   fj = nan;
end


end