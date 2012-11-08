MPR_ValkyrTracker = CreateFrame("Frame", "MPR Val'kyr Tracker")
MPR_ValkyrTracker.TimeSinceLastUpdate = 0
MPR_ValkyrTracker.DefileCooldown = 32
MPR_ValkyrTracker.SummonValkyrCooldown = 45
MPR_ValkyrTracker.ValkyrCount = 0
MPR_ValkyrTracker.ValkyrTable = {} -- {IconID, Health, HealthMax, Speed}
MPR_ValkyrTracker.ValkyrUpdated = {}
MPR_ValkyrTracker.GrabbedPlayers = {}
MPR_ValkyrTracker.LeroyTimer = 15
function MPR_ValkyrTracker:Initialize()
	MPR_ValkyrTracker:Hide()
	MPR_ValkyrTracker.name = "MPR_ValkyrTracker"
	MPR_ValkyrTracker:SetBackdrop(MPR.Settings["BACKDROP"])
	MPR_ValkyrTracker:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
	MPR_ValkyrTracker:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)
	MPR_ValkyrTracker:SetPoint("CENTER",UIParent)
	MPR_ValkyrTracker:SetWidth(250)
	MPR_ValkyrTracker:SetHeight(83)
	MPR_ValkyrTracker:EnableMouse(true)
	MPR_ValkyrTracker:SetMovable(true)
	MPR_ValkyrTracker:RegisterForDrag("LeftButton")
	MPR_ValkyrTracker:SetUserPlaced(true)
	MPR_ValkyrTracker:SetScript("OnDragStart", function(self) MPR_ValkyrTracker:StartMoving() end)
	MPR_ValkyrTracker:SetScript("OnDragStop", function(self) MPR_ValkyrTracker:StopMovingOrSizing() end)
	MPR_ValkyrTracker:SetScript("OnUpdate", function(self, elapsed)
		if MPR_ValkyrTracker.DefileCooldown > 0 then
			MPR_ValkyrTracker.DefileCooldown = MPR_ValkyrTracker.DefileCooldown - elapsed
			if MPR_ValkyrTracker.DefileCooldown < 0 then
				MPR_ValkyrTracker.DefileCooldown = 0
			end
		end
		if MPR_ValkyrTracker.SummonValkyrCooldown > 0 then
			MPR_ValkyrTracker.SummonValkyrCooldown = MPR_ValkyrTracker.SummonValkyrCooldown - elapsed
			if MPR_ValkyrTracker.SummonValkyrCooldown < 0 then
				MPR_ValkyrTracker.SummonValkyrCooldown = 0
			end
		end
		if MPR_ValkyrTracker:IsVisible() then 
			MPR_ValkyrTracker:OnUpdate(elapsed)
		end 
	end)
	MPR_ValkyrTracker:SetFrameStrata("FULLSCREEN_DIALOG")
	
	MPR_ValkyrTracker.Title = MPR_ValkyrTracker:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Title:SetPoint("TOP", 0, -8)
	MPR_ValkyrTracker.Title:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.Title:SetText("|cff"..MPR.Colors["TITLE"].."MPR|r - Val'kyr Tracker")
	MPR_ValkyrTracker.Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	MPR_ValkyrTracker.Title:SetShadowOffset(1, -1)
	
	-- Summon Val'kyr
	MPR_ValkyrTracker.Label1 = MPR_ValkyrTracker:CreateFontString("Label3", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Label1:SetPoint("TOPLEFT", 8, -22)
	MPR_ValkyrTracker.Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.Label1:SetText(GetSpellLink(69037)..": <>")
	
	-- Defile
	MPR_ValkyrTracker.Label2 = MPR_ValkyrTracker:CreateFontString("Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Label2:SetPoint("TOPLEFT", 146, -22)
	MPR_ValkyrTracker.Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.Label2:SetText(GetSpellLink(72762).." CD: <>")
		
	MPR_ValkyrTracker.Label3 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Label3:SetPoint("TOPLEFT", 8, -36)
	MPR_ValkyrTracker.Label3:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.Label3:SetText("Grabbed players: ")
	
	local ValkyrIcon = select(3,GetSpellInfo(71843))
	MPR_ValkyrTracker.Texture1 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture1:SetPoint('TOPLEFT', 8, -50)
	MPR_ValkyrTracker.Texture1:SetWidth(24)
	MPR_ValkyrTracker.Texture1:SetHeight(24)
	MPR_ValkyrTracker.Texture1:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture1:SetAlpha(1)
	
	MPR_ValkyrTracker.T1Label1 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T1Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture1, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T1Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T1Label1:SetText("Val'kyr")
	
	MPR_ValkyrTracker.T1Label2 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T1Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture1, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T1Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T1Label2:SetText("HP: 0%")
	
	MPR_ValkyrTracker.Texture2 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture2:SetPoint('TOPLEFT', 88, -50)
	MPR_ValkyrTracker.Texture2:SetWidth(24)
	MPR_ValkyrTracker.Texture2:SetHeight(24)
	MPR_ValkyrTracker.Texture2:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture2:SetAlpha(1)
	
	MPR_ValkyrTracker.T2Label1 = MPR_ValkyrTracker:CreateFontString("T2Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T2Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture2, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T2Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T2Label1:SetText("Val'kyr")
	
	MPR_ValkyrTracker.T2Label2 = MPR_ValkyrTracker:CreateFontString("T2Label2", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T2Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture2, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T2Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T2Label2:SetText("HP: 0%")
	
	MPR_ValkyrTracker.Texture3 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture3:SetPoint('TOPLEFT', 168, -50)
	MPR_ValkyrTracker.Texture3:SetWidth(24)
	MPR_ValkyrTracker.Texture3:SetHeight(24)
	MPR_ValkyrTracker.Texture3:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture3:SetAlpha(1)
	
	MPR_ValkyrTracker.T3Label1 = MPR_ValkyrTracker:CreateFontString("T3Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T3Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture3, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T3Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T3Label1:SetText("Val'kyr")
	
	MPR_ValkyrTracker.T3Label2 = MPR_ValkyrTracker:CreateFontString("T3Label2", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T3Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture3, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T3Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T3Label2:SetText("HP: 0%")
end
function MPR_ValkyrTracker:Toggle()
	MPR_ValkyrTracker.LeroyTimer = 15
	if MPR_ValkyrTracker:IsVisible() then
		MPR_ValkyrTracker:Hide()
	else
		MPR_ValkyrTracker:Show()
	end
end

local CountingWhelps = false
local CountWhelps = 0
function MPR_ValkyrTracker:KillCredit()
	if not CountingWhelps then
		CountingWhelps = true
		SendChatMessage("< Leroy timer started! (15 sec) >", "PARTY")
	end
	CountWhelps = CountWhelps + 1
	SendChatMessage("< Rookery Whelps slain: "..CountWhelps.."/50 >", "PARTY")
	--[[
	if CountWhelps % 10 == 0 then
		SendChatMessage("< Rookery Whelps slain: "..CountWhelps.."/50 >", "PARTY")
	end
	]]
end

function MPR_ValkyrTracker:OnUpdate(elapsed)
	if self.LeroyTimer == 15 then
		
	end
	if self.LeroyTimer > 0 and CountingWhelps then
		self.LeroyTimer = self.LeroyTimer - elapsed
		if self.LeroyTimer < 0 then
			SendChatMessage("< OVER! "..CountWhelps.."/50 Rookery Whelps killed. >", "PARTY")
			CountWhelps = 0
			CountingWhelps = false
			self.LeroyTimer = 15
		end
	end

	local Seconds, Color
	-- Defile CD timer
	if self.DefileCooldown then
		Seconds = round(self.DefileCooldown,0,true)
		Color = Seconds > 20 and "00FF00" or Seconds > 15 and "FFFF00" or Seconds > 10 and "FFAA00" or Seconds > 5 and "FF7700" or "FF0000"
		MPR_ValkyrTracker.Label2:SetText(GetSpellLink(72762).." CD: |cFF"..Color..Seconds.." sec.|r")
	else  
		MPR_ValkyrTracker.Label2:SetText(GetSpellLink(72762).." CD: <>")
	end
	-- Summon Val'kyr timer
	if self.DefileCooldown then
		Seconds = round(self.SummonValkyrCooldown,0,true)
		Color = Seconds > 20 and "00FF00" or Seconds > 15 and "FFFF00" or Seconds > 10 and "FFAA00" or Seconds > 5 and "FF7700" or "FF0000"
		MPR_ValkyrTracker.Label1:SetText(GetSpellLink(69037)..": |cFF"..Color..Seconds.." sec.|r")
	else
		MPR_ValkyrTracker.Label1:SetText(GetSpellLink(69037)..": <>")
	end
	
	MPR_ValkyrTracker.TimeSinceLastUpdate = MPR_ValkyrTracker.TimeSinceLastUpdate + elapsed
    if MPR_ValkyrTracker.TimeSinceLastUpdate >= MPR.Settings["UPDATEFREQUENCY"] then
		local diff = MPR_ValkyrTracker.TimeSinceLastUpdate
		MPR_ValkyrTracker.TimeSinceLastUpdate = 0
		MPR_ValkyrTracker:Update(diff)
    end
end
function MPR_ValkyrTracker:Update()
	local countValkyr = 0
	for i=0,GetNumRaidMembers() do
		local UnitID = i == 0 and "player" or "raid"..i
		
		-- Check if grabbed
		if UnitInVehicle(UnitID) then
			if not self.GrabbedPlayers[UnitName(UnitID)] then
				self.GrabbedPlayers[UnitName(UnitID)] = {} -- {UnitName => TargetMarker}
				self.GrabbedPlayers[UnitName(UnitID)].Name = string.format("",ClassColors[strupper(select(2,UnitClass(UnitID)))],UnitName(UnitID))
				self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
			elseif not self.GrabbedPlayers[UnitName(UnitID)].Icon then
				self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
			end
		elseif self.GrabbedPlayers[UnitName(UnitID)] then
			self.GrabbedPlayers[UnitName(UnitID)] = nil
		end
		
		-- Check if targeting Valkyr and get data
		if UnitName(UnitID.."target") == "Val'kyr Shadowguard" then
			local RaidMarker = GetRaidTargetIndex(UnitID.."target")
			local Health, HealthMax, Speed = UnitHealth(UnitID.."target"), UnitHealthMax(UnitID.."target"), GetUnitSpeed(UnitID.."target")
			local HealthPct = round(100*Health/HealthMax,0,true)
			
			local ValkyrGUID = tonumber(string.sub(UnitGUID("target"),6),16)
			if not self.ValkyrUpdated[ValkyrGUID] and (GetInstanceDifficulty() <= 2 or HealthPct > 50) then -- Add to table
				self.ValkyrUpdated[ValkyrGUID] = true
				-- {1 => TextureID, 2 => RaidMarkerID, 3 => Health, 4 => HealthMax, 5 => Speed}
				self.ValkyrTable[ValkyrGUID] = {}
				self.ValkyrTable[ValkyrGUID][1] = #self.ValkyrTable
				self.ValkyrTable[ValkyrGUID][2] = RaidMarker
				self.ValkyrTable[ValkyrGUID][3] = Health
				self.ValkyrTable[ValkyrGUID][4] = HealthMax
				self.ValkyrTable[ValkyrGUID][5] = Speed
			elseif not self.ValkyrUpdated[ValkyrGUID] and self.ValkyrTable[ValkyrGUID] and GetInstanceDifficulty() >= 3 and HealthPct <= 50 then -- Remove from table 
				self.ValkyrUpdated[ValkyrGUID] = true
				self.ValkyrTable[ValkyrGUID] = nil
			end
			if #self.ValkyrUpdated == (GetInstanceDifficulty()%2 == 1 and 1 or 3) then
				break
			end
		end
	end
	
	-- Print grabbed players
	local arrayGrabbed = {}
	for _,Unit in pairs(self.GrabbedPlayers) do
		table.insert(arrayGrabbed,string.format("{rt%i} %s",Unit.Icon,Unit.Name))
	end
	self.Label3:SetText("Grabbed players: "..table.concat(arrayGrabbed,", "))
	
	-- Print Valky data
	-- print only self.ValkyrUpdated
end

function MPR_ValkyrTracker:ValkyrSummoned(GUID)
	MPR_ValkyrTracker.ValkyrCount = MPR_ValkyrTracker.ValkyrCount + 1
	if MPR_ValkyrTracker.ValkyrCount == 0 then -- First Valkyr
		MPR_ValkyrTracker.SummonValkyrCooldown = 45
	end
	MPR_ValkyrTracker.ValkyrTable[GUID] = {}
end

function MPR_ValkyrTracker:DefileCast()
	MPR_ValkyrTracker.DefileCooldown = 32
end

local QuakeCount = 0
function MPR_ValkyrTracker:RemorselessWinterCast()
	MPR_ValkyrTracker.SummonValkyrCooldown = nil
	MPR_ValkyrTracker.DefileCooldown = nil
end
function MPR_ValkyrTracker:QuakeCast()
	QuakeCount = QuakeCount + 1
	MPR_ValkyrTracker.SummonValkyrCooldown = QuakeCount == 1 and 15.5 or nil
	MPR_ValkyrTracker.DefileCooldown = QuakeCount == 1 and 34.5 or 33
end
function MPR_ValkyrTracker:Reset()
	QuakeCount = 0
	MPR_ValkyrTracker.SummonValkyrCooldown = nil
	MPR_ValkyrTracker.DefileCooldown = nil
end
