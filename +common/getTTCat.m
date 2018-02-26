function TTC = getTTCat(varargin)

switch length(varargin)
    case 3
        Cars = varargin{1};
        VRUs = varargin{2};
        wp   = varargin{3};
        mode = 3;
    case 4
        Cars = varargin{1};
        VRUs = varargin{2};
        i    = varargin{3};
        wp   = varargin{4};
        mode = 4;
end

if wp==2
    longInd = 3;
    longSign = -1;
    CarDim = [2.6 2.2 1.9];
elseif wp==3
    longInd = 2;
    longSign = 1;
    CarDim = [0 4.628 1.865];
end

switch mode
    case 3
        if iscell(Cars)
            TTC = cellfun(@(c,v) getTTC(c, v, CarDim, longInd, longSign), Cars, VRUs, 'UniformOutput', false);
        else
            TTC = getTTC(Cars, VRUs, CarDim, longInd, longSign);
        end
    case 4
        if iscell(Cars)
            TTC = cellfun(@(c,v,f) getTTC(c, v, CarDim, longInd, longSign, f), Cars, VRUs, num2cell(i));
        else
            TTC = getTTC(Cars, VRUs, CarDim, longInd, longSign, i);
        end
end

end

function TTC = getTTC(c, v, CarDim, longInd, longSign, varargin)

if length(varargin)==1
    f = varargin{1};
else
    f = 1:length(c.Speed);
end

if isnan(f)
    TTC = nan;
else
    TTC = longSign*(v.Position(f,longInd)-c.Position(f,longInd)+CarDim(1))./c.Speed(f)*3.6;
end

end