MPR_ValkyrTracker = CreateFrame("Frame", "MPR Val'kyr Tracker")
MPR_ValkyrTracker.Loaded = false
MPR_ValkyrTracker.TimeSinceLastUpdate = 0
function MPR_ValkyrTracker:Update()
	
	GetUnitSpeed("unit")
end


