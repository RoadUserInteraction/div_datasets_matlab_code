function TTC = getVRUTTCat(varargin)

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

switch mode
    case 3
        if iscell(Cars)
             TTC = cellfun(@(c,v)  getTTC(c, v, wp), Cars, VRUs, 'UniformOutput', false);
        else
            TTC = getTTC(Cars, VRUs, CarDim, longInd, longSign);
        end
    case 4
        if iscell(Cars)
            TTC = cellfun(@(c,v,f) getTTC(c, v, wp, f), Cars, VRUs, num2cell(i));
        else
            TTC = getTTC(Cars, VRUs, CarDim, longInd, longSign, i);
        end
end

end

function TTC = getTTC(c, v, wp, varargin)

if length(varargin)==1
    f = varargin{1};
    if isnan(f)||v.Speed(f)==0
        TTC = nan;
        return;
    end
else
    f = 1:length(c.Speed);
end

if wp==2
    CarDim = [2.6 2.2 1.9];
    BikeDim = [1.9];
elseif wp==3
    CarDim = [0 4.628 1.865];
    BikeDim = [1.7];
end

%% fix that for vector inputs instead of one single index
if numel(f)>1
    ir = find((v.Position(f,1)-BikeDim/2-(c.Position(f,1)+CarDim(3)/2))>0,1,'last');
    il = find((v.Position(f,1)+BikeDim/2-(c.Position(f,1)-CarDim(3)/2))<=0,1,'first');
    TTCr = (v.Position(f,1)-BikeDim/2-(c.Position(f,1)+CarDim(3)/2))./v.Speed(f)*3.6;
    TTCl = (v.Position(f,1)+BikeDim/2-(c.Position(f,1)-CarDim(3)/2))./v.Speed(f)*3.6;
    TTC = zeros(size(f));
    TTC(1:ir) = TTCr(1:ir);
    TTC(il:end) = TTCl(il:end);
TTC = TTC';
%     TTC = (v.Position(f,1)-c.Position(f,1))./v.Speed(f)*3.6;
else
    if (v.Position(f,1)-BikeDim/2-c.Position(f,1))>-CarDim(3)/2 % bike on the right
        TTC = (v.Position(f,1)-BikeDim/2-(c.Position(f,1)+CarDim(3)/2))./v.Speed(f)*3.6;
    elseif (v.Position(f,1)+BikeDim/2-c.Position(f,1))<=-CarDim(3)/2 % bike on the left
        TTC = (v.Position(f,1)+BikeDim/2-(c.Position(f,1)-CarDim(3)/2))./v.Speed(f)*3.6;
    else
        TTC = 0; 
    end
end

end