MPR_ValkyrTracker = CreateFrame("Frame", "MPR Val'kyr Tracker")
MPR_ValkyrTracker.TimeSinceLastUpdate = 0
MPR_ValkyrTracker.LichKingWarnings = {
--	[%%] = {Warned, Message},
	[77] = {false, ""},
	[74] = {false, "Transition soon!"},
	[47] = {false, ""},
	[44] = {false, "Transition soon!"},
}
MPR_ValkyrTracker.QuakeCount = 0
MPR_ValkyrTracker.SummonShadowTrapCooldown = nil
MPR_ValkyrTracker.SummonValkyrCooldown = nil
MPR_ValkyrTracker.DefileCooldown = nil
MPR_ValkyrTracker.HarvestSoulsCooldown = nil
MPR_ValkyrTracker.InFrostmourne = false
MPR_ValkyrTracker.ValkyrCount = 0
MPR_ValkyrTracker.ValkyrTable = {} -- {IconID, Health, HealthMax, Speed}
MPR_ValkyrTracker.ValkyrUpdated = {}
MPR_ValkyrTracker.GrabbedPlayers = {}
MPR_ValkyrTracker.ValkyrObjects = {}
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
		-- Check if player left Frostmourne
		if MPR_ValkyrTracker.InFrostmourne and GetSubZoneText() ~= "Frostmourne" then
			MPR_ValkyrTracker.InFrostmourne = false
		end
		
		if not MPR_ValkyrTracker.InFrostmourne then
			if MPR_ValkyrTracker.SummonShadowTrapCooldown and MPR_ValkyrTracker.SummonShadowTrapCooldown > 0 then
				MPR_ValkyrTracker.SummonShadowTrapCooldown = MPR_ValkyrTracker.SummonShadowTrapCooldown - elapsed
				if MPR_ValkyrTracker.SummonShadowTrapCooldown < 0 then
					MPR_ValkyrTracker.SummonShadowTrapCooldown = 0
				end
			end
			if MPR_ValkyrTracker.SummonValkyrCooldown and MPR_ValkyrTracker.SummonValkyrCooldown > 0 then
				MPR_ValkyrTracker.SummonValkyrCooldown = MPR_ValkyrTracker.SummonValkyrCooldown - elapsed
				if MPR_ValkyrTracker.SummonValkyrCooldown < 0 then
					MPR_ValkyrTracker.SummonValkyrCooldown = 0
				end
			end
			if MPR_ValkyrTracker.DefileCooldown and MPR_ValkyrTracker.DefileCooldown > 0 then
				MPR_ValkyrTracker.DefileCooldown = MPR_ValkyrTracker.DefileCooldown - elapsed
				if MPR_ValkyrTracker.DefileCooldown < 0 then
					MPR_ValkyrTracker.DefileCooldown = 0
				end
			end
		end
		
		if MPR_ValkyrTracker.HarvestSoulsCooldown and MPR_ValkyrTracker.HarvestSoulsCooldown > 0 then
			MPR_ValkyrTracker.HarvestSoulsCooldown = MPR_ValkyrTracker.HarvestSoulsCooldown - elapsed
			if MPR_ValkyrTracker.HarvestSoulsCooldown < 0 then
				MPR_ValkyrTracker.HarvestSoulsCooldown = 0
			end
		end
		
		MPR_ValkyrTracker:OnUpdate(elapsed)
	end)
	MPR_ValkyrTracker:SetFrameStrata("FULLSCREEN_DIALOG")
	
	MPR_ValkyrTracker.Title = MPR_ValkyrTracker:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Title:SetPoint("TOP", 0, -8)
	MPR_ValkyrTracker.Title:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.Title:SetText("|cff"..MPR.Colors["TITLE"].."MP Reporter|r - Val'kyr Tracker")
	MPR_ValkyrTracker.Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	MPR_ValkyrTracker.Title:SetShadowOffset(1, -1)
	
	MPR_ValkyrTracker.CloseButton = CreateFrame("button","BtnClose", MPR_ValkyrTracker, "UIPanelButtonTemplate")
	MPR_ValkyrTracker.CloseButton:SetHeight(14)
	MPR_ValkyrTracker.CloseButton:SetWidth(14)
	MPR_ValkyrTracker.CloseButton:SetPoint("TOPRIGHT", -8, -8)
	MPR_ValkyrTracker.CloseButton:SetText("x")
	MPR_ValkyrTracker.CloseButton:SetScript("OnClick", function(self) MPR_ValkyrTracker:Hide() end)
	
	-- Summon Val'kyr
	MPR_ValkyrTracker.Label1 = MPR_ValkyrTracker:CreateFontString("Label3", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Label1:SetPoint("TOPLEFT", 8, -22)
	MPR_ValkyrTracker.Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.Label1:SetText(GetSpellLink(69037)..": |cFFbebebenil|r")
	
	-- Defile
	MPR_ValkyrTracker.Label2 = MPR_ValkyrTracker:CreateFontString("Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.Label2:SetPoint("TOPLEFT", 144, -22)
	MPR_ValkyrTracker.Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.Label2:SetText(GetSpellLink(72762).." CD: |cFFbebebenil|r")
		
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
	MPR_ValkyrTracker.Texture1:SetAlpha(0.4)
	
	MPR_ValkyrTracker.T1Label1 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T1Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture1, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T1Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T1Label1:SetTextColor(1,1,1)
	MPR_ValkyrTracker.T1Label1:SetText("Val'kyr 1")
	MPR_ValkyrTracker.T1Label1:SetAlpha(0.4)
	
	MPR_ValkyrTracker.T1Label2 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T1Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture1, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T1Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T1Label2:SetTextColor(0.9,0.9,0.9)
	MPR_ValkyrTracker.T1Label2:SetText("HP: nil")
	MPR_ValkyrTracker.T1Label2:SetAlpha(0.4)
	
	MPR_ValkyrTracker.Texture2 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture2:SetPoint('TOPLEFT', 88, -50)
	MPR_ValkyrTracker.Texture2:SetWidth(24)
	MPR_ValkyrTracker.Texture2:SetHeight(24)
	MPR_ValkyrTracker.Texture2:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture2:SetAlpha(0.4)
	
	MPR_ValkyrTracker.T2Label1 = MPR_ValkyrTracker:CreateFontString("T2Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T2Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture2, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T2Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T2Label1:SetTextColor(0.9,0.9,0.9)
	MPR_ValkyrTracker.T2Label1:SetText("Val'kyr 2")
	MPR_ValkyrTracker.T2Label1:SetAlpha(0.4)
	
	MPR_ValkyrTracker.T2Label2 = MPR_ValkyrTracker:CreateFontString("T2Label2", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T2Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture2, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T2Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T2Label2:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.T2Label2:SetText("HP: nil")
	MPR_ValkyrTracker.T2Label2:SetAlpha(0.4)
	
	MPR_ValkyrTracker.Texture3 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture3:SetPoint('TOPLEFT', 168, -50)
	MPR_ValkyrTracker.Texture3:SetWidth(24)
	MPR_ValkyrTracker.Texture3:SetHeight(24)
	MPR_ValkyrTracker.Texture3:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture3:SetAlpha(0.4)
	
	MPR_ValkyrTracker.T3Label1 = MPR_ValkyrTracker:CreateFontString("T3Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T3Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture3, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T3Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T3Label1:SetTextColor(0.9,0.9,0.9)
	MPR_ValkyrTracker.T3Label1:SetText("Val'kyr 3")
	MPR_ValkyrTracker.T3Label1:SetAlpha(0.4)
	
	MPR_ValkyrTracker.T3Label2 = MPR_ValkyrTracker:CreateFontString("T3Label2", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T3Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture3, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T3Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)	
	MPR_ValkyrTracker.T3Label2:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.T3Label2:SetText("HP: nil")
	MPR_ValkyrTracker.T3Label2:SetAlpha(0.4)
	
	self.ValkyrObjects[1] = {}
	self.ValkyrObjects[1][1] = self.Texture1
	self.ValkyrObjects[1][2] = self.T1Label1
	self.ValkyrObjects[1][3] = self.T1Label2
	self.ValkyrObjects[2] = {}
	self.ValkyrObjects[2][1] = self.Texture2
	self.ValkyrObjects[2][2] = self.T2Label1
	self.ValkyrObjects[2][3] = self.T2Label2
	self.ValkyrObjects[3] = {}
	self.ValkyrObjects[3][1] = self.Texture3
	self.ValkyrObjects[3][2] = self.T3Label1
	self.ValkyrObjects[3][3] = self.T3Label2
end
function MPR_ValkyrTracker:Toggle()
	if MPR_ValkyrTracker:IsVisible() then
		MPR_ValkyrTracker:Hide()
	else
		MPR_ValkyrTracker:Show()
	end
end

function MPR_ValkyrTracker:OnUpdate(elapsed)
	local Seconds, Color
	-- Summon Shadow Trap timer 
	if self.SummonShadowTrapCooldown then
		Seconds = round(self.SummonShadowTrapCooldown,0,true)
		Color = Seconds > 12 and "00FF00" or Seconds > 9 and "FFFF00" or Seconds > 6 and "FFAA00" or Seconds > 3 and "FF7700" or "FF0000"
		MPR_ValkyrTracker.Label1:SetText(GetSpellLink(73539).." CD: |cFF"..Color..Seconds.." sec|r")
	elseif self.HarvestSoulsCooldown then -- Harvest Souls
		Seconds = round(self.HarvestSoulsCooldown,0,true)
		Color = Seconds > 12 and "00FF00" or Seconds > 9 and "FFFF00" or Seconds > 6 and "FFAA00" or Seconds > 3 and "FF7700" or "FF0000"
		MPR_ValkyrTracker.Label1:SetText(GetSpellLink(74297).." CD: |cFF"..Color..Seconds.." sec|r")
	elseif self.SummonValkyrCooldown then -- Summon Val'kyr timer
		Seconds = round(self.SummonValkyrCooldown,0,true)
		Color = Seconds > 20 and "00FF00" or Seconds > 15 and "FFFF00" or Seconds > 10 and "FFAA00" or Seconds > 5 and "FF7700" or "FF0000"
		MPR_ValkyrTracker.Label1:SetText(GetSpellLink(69037)..": |cFF"..Color..Seconds.." sec|r")
	else
		MPR_ValkyrTracker.Label1:SetText(GetSpellLink(69037)..": |cFFbebebenil|r")
	end
	-- Defile CD timer
	if self.DefileCooldown then
		Seconds = round(self.DefileCooldown,0,true)
		Color = Seconds > 20 and "00FF00" or Seconds > 15 and "FFFF00" or Seconds > 10 and "FFAA00" or Seconds > 5 and "FF7700" or "FF0000"
		MPR_ValkyrTracker.Label2:SetText(GetSpellLink(72762).." CD: |cFF"..Color..Seconds.." sec|r")
	else  
		MPR_ValkyrTracker.Label2:SetText(GetSpellLink(72762).." CD: |cFFbebebenil|r")
	end
	
	MPR_ValkyrTracker.TimeSinceLastUpdate = MPR_ValkyrTracker.TimeSinceLastUpdate + elapsed
    if MPR_ValkyrTracker.TimeSinceLastUpdate >= MPR.Settings["UPDATEFREQUENCY"] then
		local diff = MPR_ValkyrTracker.TimeSinceLastUpdate
		MPR_ValkyrTracker.TimeSinceLastUpdate = 0
		MPR_ValkyrTracker:Update(diff)
    end
end

local ClassColors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA", ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
function MPR_ValkyrTracker:Update()
	local countValkyr = 0
	for i=0,GetNumRaidMembers() do
		local UnitID = i == 0 and "player" or "raid"..i
		
		-- Check if grabbed (only during Phase 2 - from first till second/last Quake)
		if self.QuakeCount == 1 and UnitInVehicle(UnitID) then
			if not self.GrabbedPlayers[UnitName(UnitID)] then -- Insert grabbed player
				self.GrabbedPlayers[UnitName(UnitID)] = {} -- {UnitName => TargetMarker}
				self.GrabbedPlayers[UnitName(UnitID)].Name = string.format("|cFF%s%s|r",ClassColors[strupper(select(2,UnitClass(UnitID)))],UnitName(UnitID))
				self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
			elseif GetRaidTargetIndex(UnitID) then -- Update grabbed player's icon if we don't have it yet
				self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
			end
		elseif self.GrabbedPlayers[UnitName(UnitID)] then -- Remove grabbed player
			self.GrabbedPlayers[UnitName(UnitID)] = nil
		end
		
		-- Check if targeting Valkyr and get data
		if UnitName(UnitID.."target") == "Val'kyr Shadowguard" then
			local RaidMarker = GetRaidTargetIndex(UnitID.."target")
			local GUID, Health, HealthMax, Speed = tonumber(string.sub(UnitGUID(UnitID.."target"),6),16), UnitHealth(UnitID.."target"), UnitHealthMax(UnitID.."target"), GetUnitSpeed(UnitID.."target")
			local HealthPct = round(100*Health/HealthMax,0,true) 
			if not self.ValkyrUpdated[GUID] and self.ValkyrTable[GUID] then
				self.ValkyrUpdated[GUID] = true
				if (GetInstanceDifficulty() <= 2 or HealthPct > 50) then -- Update this Val'kyr
					-- {1 => TextureID, 2 => RaidMarkerID, 3 => HealthPct, 4 => Speed}
					self.ValkyrTable[GUID][2] = RaidMarker
					self.ValkyrTable[GUID][3] = HealthPct
					self.ValkyrTable[GUID][4] = Speed
				else  -- Remove this Val'kyr
					self.ValkyrTable[GUID] = nil
				end
			end
		end
	end
		
	-- Print grabbed players
	local arrayGrabbed = {}
	for _,Unit in pairs(self.GrabbedPlayers) do
		table.insert(arrayGrabbed,(Unit.Icon and Unit.Icon > 0 and "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..Unit.Icon..":12:12|t" or "")..Unit.Name)
	end
	-- Blinking label if players are grabbed
	local Color = {R = 1, G = 1, B = 1}
	if #arrayGrabbed > 0 then
		if GetTime()%1.4 < 0.7 then
			Color = {R = 1, G = 0, B = 0}
		end
	end
	
	self.Label3:SetTextColor(Color.R, Color.G, Color.B)
	self.Label3:SetText("Grabbed players: "..table.concat(arrayGrabbed,", "))
	
	-- Print Valky data
	for GUID,Data in pairs(self.ValkyrTable) do
		if self.ValkyrUpdated[GUID] then
			local Index, RaidMarker, HealthPct, Speed = unpack(Data)
			local Color = GetInstanceDifficulty() <= 2 and (HealthPct <= 10 and "00FF00" or HealthPct <= 20 and "FFFF00" or HealthPct <= 30 and "FFAA00" or HealthPct <= 50 and "FF7700" or "FF0000") or (HealthPct <= 55 and "00FF00" or HealthPct <= 60 and "FFFF00" or HealthPct <= 65 and "FFAA00" or HealthPct <= 75 and "FF7700" or "FF0000")
			self.ValkyrObjects[Index][1]:SetAlpha(1)
			self.ValkyrObjects[Index][2]:SetAlpha(1)
			self.ValkyrObjects[Index][3]:SetAlpha(1)
			self.ValkyrObjects[Index][3]:SetText(string.format("HP: |c%s%s%%|r",Color,HealthPct))
		else -- None of members targeting this Val'kyr, so we'll just remove it.
			local Index = Data[1]
			self.ValkyrObjects[Index][1]:SetAlpha(0.4)
			self.ValkyrObjects[Index][2]:SetAlpha(0.4)
			self.ValkyrObjects[Index][3]:SetAlpha(0.4)
			self.ValkyrObjects[Index][3]:SetText("HP: |cFFbebebenil|r")
			self.ValkyrTable[GUID] = nil
		end
	end
	self.ValkyrUpdated = {}
end
function MPR_ValkyrTracker:SummonShadowTrap()
	local Cooldown = 14
	local activeCooldown = round(self.SummonShadowTrapCooldown,0,true)
	if activeCooldown > 0 then
		Cooldown = Cooldown - activeCooldown
		print("|cFFFF0000MP Reporter: New Shadow Trap cooldown - "..Cooldown.." seconds! Please report this number to the addon author!|r")
	end
	self.SummonShadowTrapCooldown = 14
end
function MPR_ValkyrTracker:SummonValkyr(GUID)
	self.ValkyrCount = self.ValkyrCount + 1
	if self.ValkyrCount == 1 then -- First Valkyr
		self.SummonValkyrCooldown = 45
	end
	self.ValkyrTable[GUID] = {}
	self.ValkyrTable[GUID][1] = self.ValkyrCount
	if self.ValkyrCount == (GetInstanceDifficulty()%2 == 1 and 1 or 3) then -- Last Valkyr
		self.ValkyrCount = 0
	end
end
function MPR_ValkyrTracker:Defile()
	local Cooldown = self.QuakeCount == 1 and 32.5 or 30
	local activeCooldown = round(self.DefileCooldown,0,true)
	if activeCooldown > 0 then
		Cooldown = Cooldown - activeCooldown
		print("|cFFFF0000MP Reporter: New Defile cooldown - "..Cooldown.." seconds! Please report this number to the addon author!|r")
	end
	self.DefileCooldown = Cooldown
end
function MPR_ValkyrTracker:HarvestSouls()
	if GetInstanceDifficulty() > 2 then -- Heroic
		self.InFrostmourne = true
		self.HarvestSoulsCooldown = 120
	end
end
function MPR_ValkyrTracker:RemorselessWinter()
	self.SummonShadowTrapCooldown = nil
	self.SummonValkyrCooldown = nil
	self.DefileCooldown = nil
end
function MPR_ValkyrTracker:Quake()
	self.QuakeCount = self.QuakeCount + 1
	self.SummonValkyrCooldown = self.QuakeCount == 1 and 26 or nil
	self.DefileCooldown = self.QuakeCount == 1 and 45 or 32.5 --44
	self.HarvestSoulsCooldown = self.QuakeCount == 2 and 20 or nil
	
	self.Label2:Show() -- Show Defile label
end
function MPR_ValkyrTracker:FuryOfFrostmourne()
	self:Reset()
end
function MPR_ValkyrTracker:Reset()
	self.QuakeCount = 0
	self.ValkyrCount = 0
	self.SummonShadowTrapCooldown = nil
	self.SummonValkyrCooldown = nil
	self.DefileCooldown = nil
	self.HarvestSoulsCooldown = nil
end
function MPR_ValkyrTracker:EncounterStart()
	self:Reset()
	if GetInstanceDifficulty() > 2 then -- Heroic
		self.Label2:Hide() -- Hide Defile label
		self.SummonShadowTrapCooldown = 30
	end
end
