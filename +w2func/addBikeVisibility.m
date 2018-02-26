function Data = addBikeVisibility(Data)

%bike is said to be visible when half the bike is visible to the driver
%Here, visibility is the car's time-to-arrival at visibility

[id, Task, Car, VRU] = common.getFromData(Data,{'participantID', 'orderOfExperiments', 'Car', 'VRU'});
fullID = common.getFullIDListFrom(Data);
Visibility = splitapply(@(a,b,c)getVisibility(a,b,c), Task', Car, VRU, 1:length(Task));

for i=1:length(id)
    Data(i).Metrics = arrayfun(@(a,b)setfield(a,'visibility',b), Data(i).Metrics, Visibility(fullID==id(i)));
end

end
function visibility = getVisibility(task, Car, VRU)

visibility=NaN;
Car = Car{1}; VRU = VRU{1};
if any(ismember(task, [0 17 18]))
else
    Bumper_distance = 2.6;
    if task == 19
        Trigger_distance = 37.5;
        ZIntersectionPoint = -4.5;
        XIntersectionPoint = 1.75;
        x2 = 5.4; %distance of the wall from the intersection point
        z2 = 5.5;
    else
        Trigger_distance = 114;
        ZIntersectionPoint = 4.5;
        XIntersectionPoint = 1.75;
        x2 = 17.54; %distance of the wall from the intersection point
        z2 = 5.5;
    end
    
    trigger_index = find(abs(Car.Position(:,3)-ZIntersectionPoint)...
        <=Trigger_distance,1,'first');
    for i=1:length(Car.Position(trigger_index:end,3))
        
        i = trigger_index+i; %after the index point each step
        if i>length(Car.Position(:,3))
            break
        end
        
        % Car coordinates
        x1 = Car.Position(i,1);
        z1 = Car.Position(i,3)-Bumper_distance;
        
        %VRU coordinates
        x0 = VRU.Position(i,1);
        z0 = VRU.Position(i,3);
        
        % distance between the line of sight and the VRU distance
        % The line of sight is iterated after the trigger point
        % as a line eqataion whole slope varies as the car moves
        % using this the visibility is calculated
        % Find the distance between the line of sight and the VRU coordinate
        % points if the distance is Positive the bike is visible
        
        d =((x0-x1)*(z2-z1))-((z0-z1)*(x2-x1));
        
        if d>0
            distance = sqrt((z1-ZIntersectionPoint)^2+(x1-XIntersectionPoint)^2);
            Car_speed =  Car.Speed(i);
            visibility = (distance/(Car_speed/3.6));
            if isinf(visibility)
                visibility=NaN;
            end
            break
            
        end
    end
end
end