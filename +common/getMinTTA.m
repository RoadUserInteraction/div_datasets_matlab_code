function [mTTC, i] = getMinTTA(Data, wp)

if wp==2
    longInd = 3;
    longSign = -1;
    CarDim = [2.6 2.2 1.9];
elseif wp==3
    longInd = 2;
    longSign = 1;
    CarDim = [0 4.628 1.865];
end

[Cars, VRUs]= common.getFromData(Data, {'Car' 'VRU'});
fi = common.getIndexAtBikeClearance(Data, wp);
len = cellfun(@(c)length(c.Speed),Cars);
fi(isnan(fi)) = len(isnan(fi));
[mTTC, i] = cellfun(@(c,v,f) getMinTTC(c, v, f, CarDim, longInd, longSign), Cars, VRUs, num2cell(fi'));

end

function [mTTC, i] = getMinTTC(c, v, f, CarDim, longInd, longSign)
[mTTC, i] = min(longSign*(v.Position(1:f,longInd)-c.Position(1:f,longInd)+CarDim(1))./c.Speed(1:f)*3.6);
end