MPR_Penalties = CreateFrame("Frame", "MPR Aura Info")

local ID = 0
function GetNewID() 
	ID = ID + 1
	return ID
end
function GetCurrentID()
	return ID
end

function MPR_Penalties:Initialize()
	MPR_Penalties:Hide()
	MPR_Penalties.name = "MPR_Penalties"
	MPR_Penalties:SetBackdrop({
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
		edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
		tile=1, tileSize=32, edgeSize=32, insets={left=11, right=12, top=12, bottom=11}
	})
	MPR_Penalties:SetPoint("CENTER",UIParent)
	MPR_Penalties:SetWidth(410)
	MPR_Penalties:SetHeight(232)
	MPR_Penalties:EnableMouse(true)
	MPR_Penalties:SetMovable(true)
	MPR_Penalties:RegisterForDrag("LeftButton")
	MPR_Penalties:SetUserPlaced(true)
	MPR_Penalties:SetScript("OnDragStart", function(self) self:StartMoving() end)
	MPR_Penalties:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	MPR_Penalties:SetFrameStrata("FULLSCREEN_DIALOG")
	
	--[[ MP Reporter - Options ]]--
	local Title = MPR_Penalties:CreateFontString("Title"..GetNewID(), "ARTWORK", "GameFontNormal")
	Title:SetPoint("TOP", 0, -12)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	Title:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255) 
	Title:SetText("|cFF1E90FFMP Reporter|r - DKP Penalties")
	
	

end