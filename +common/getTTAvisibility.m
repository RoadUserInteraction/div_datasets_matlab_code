function TTAvisibility = getTTAvisibility(Data, wp)

if wp==1
    [Cars, VRUs, visibility] = common.getFromData(Data, {'Car' 'Pedestrian' 'indexOfVisibility'});
    wp = 2;
else
    [Cars, VRUs, visibility] = common.getFromData(Data, {'Car' 'VRU' 'indexOfVisibility'});
end
TTAvisibility = common.getTTCat(Cars, VRUs, visibility', wp);

end
