function TTAbo = getTTAbo(Data, wp)

if wp==1
    [Indices, Cars, VRUs] = common.getFromData(Data, {'Index', 'Car', 'Pedestrian'});
    wp = 2;
else
    [Indices, Cars, VRUs] = common.getFromData(Data, {'Index', 'Car', 'VRU'});
end

TTAbo = common.getTTCat(Cars, VRUs, Indices(:,3)', wp);

end