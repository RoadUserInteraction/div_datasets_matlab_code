function fi = getIndexAtBikeClearance(Data, wp)

if wp==1
    [Cars, VRUs] = common.getFromData(Data, {'Car' 'Pedestrian'});
    Cars(cellfun(@(a)isempty(a), Cars)) = [];
    VRUs(cellfun(@(a)isempty(a), VRUs)) = [];
else
    [Cars, VRUs] = common.getFromData(Data, {'Car' 'VRU'});
end
fi = cellfun(@(a,b)geti(a,b,wp), Cars', VRUs');

end

function fi = geti(Car, VRU, wp)
    
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
if VRU.Position(2,1)>0
    fi = find(VRU.Position(2:end,1)-Car.Position(2:end,1)<-(CarDim(3)+VRUDim(1))/2,1,'first')+1;
else
    fi = find(VRU.Position(2:end,1)-Car.Position(2:end,1)>(CarDim(3)+VRUDim(1))/2,1,'first')+1;
end

if isempty(fi)
    fi = nan;
end

end