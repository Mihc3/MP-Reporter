MPR_ValkyrTracker = CreateFrame("Frame", "MPR Val'kyr Tracker")
MPR_ValkyrTracker.TimeSinceLastUpdate = 0
MPR_ValkyrTracker.QuakeCount = 0
MPR_ValkyrTracker.DefileCooldown = 32
MPR_ValkyrTracker.SummonValkyrCooldown = 45
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
		if MPR_ValkyrTracker.DefileCooldown and MPR_ValkyrTracker.DefileCooldown > 0 then
			MPR_ValkyrTracker.DefileCooldown = MPR_ValkyrTracker.DefileCooldown - elapsed
			if MPR_ValkyrTracker.DefileCooldown < 0 then
				MPR_ValkyrTracker.DefileCooldown = 0
			end
		end
		if MPR_ValkyrTracker.SummonValkyrCooldown and MPR_ValkyrTracker.SummonValkyrCooldown > 0 then
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
	MPR_ValkyrTracker.Texture1:SetAlpha(0.6)
	
	MPR_ValkyrTracker.T1Label1 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T1Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture1, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T1Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T1Label1:SetTextColor(160/255, 160/255, 160/255)
	MPR_ValkyrTracker.T1Label1:SetText("Val'kyr 1")
	
	MPR_ValkyrTracker.T1Label2 = MPR_ValkyrTracker:CreateFontString("Label5", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T1Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture1, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T1Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T1Label2:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.T1Label2:SetText("HP: nil")
	
	MPR_ValkyrTracker.Texture2 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture2:SetPoint('TOPLEFT', 88, -50)
	MPR_ValkyrTracker.Texture2:SetWidth(24)
	MPR_ValkyrTracker.Texture2:SetHeight(24)
	MPR_ValkyrTracker.Texture2:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture2:SetAlpha(0.6)
	
	MPR_ValkyrTracker.T2Label1 = MPR_ValkyrTracker:CreateFontString("T2Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T2Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture2, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T2Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T2Label1:SetTextColor(160/255, 160/255, 160/255)
	MPR_ValkyrTracker.T2Label1:SetText("Val'kyr 2")
	
	MPR_ValkyrTracker.T2Label2 = MPR_ValkyrTracker:CreateFontString("T2Label2", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T2Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture2, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T2Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T2Label2:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.T2Label2:SetText("HP: nil")
	
	MPR_ValkyrTracker.Texture3 = MPR_ValkyrTracker:CreateTexture("$parentTexture")
	MPR_ValkyrTracker.Texture3:SetPoint('TOPLEFT', 168, -50)
	MPR_ValkyrTracker.Texture3:SetWidth(24)
	MPR_ValkyrTracker.Texture3:SetHeight(24)
	MPR_ValkyrTracker.Texture3:SetTexture(ValkyrIcon)
	MPR_ValkyrTracker.Texture3:SetAlpha(0.6)
	
	MPR_ValkyrTracker.T3Label1 = MPR_ValkyrTracker:CreateFontString("T3Label1", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T3Label1:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture3, "TOPRIGHT", 4, 0)
	MPR_ValkyrTracker.T3Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_ValkyrTracker.T3Label1:SetTextColor(160/255, 160/255, 160/255)
	MPR_ValkyrTracker.T3Label1:SetText("Val'kyr 3")
	
	MPR_ValkyrTracker.T3Label2 = MPR_ValkyrTracker:CreateFontString("T3Label2", "OVERLAY", "GameTooltipText")
	MPR_ValkyrTracker.T3Label2:SetPoint("TOPLEFT", MPR_ValkyrTracker.Texture3, "TOPRIGHT", 4, -12)
	MPR_ValkyrTracker.T3Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)	
	MPR_ValkyrTracker.T3Label2:SetTextColor(190/255, 190/255, 190/255)
	MPR_ValkyrTracker.T3Label2:SetText("HP: nil")
	
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
			if not self.GrabbedPlayers[UnitName(UnitID)] then -- Insert grabbed player
				self.GrabbedPlayers[UnitName(UnitID)] = {} -- {UnitName => TargetMarker}
				self.GrabbedPlayers[UnitName(UnitID)].Name = string.format("|c%s%s|r",ClassColors[strupper(select(2,UnitClass(UnitID)))],UnitName(UnitID))
				self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
			elseif not self.GrabbedPlayers[UnitName(UnitID)].Icon then -- Update grabbed player's icon if we don't have it yet
				self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
			end
		elseif self.GrabbedPlayers[UnitName(UnitID)] then -- Remove grabbed player
			self.GrabbedPlayers[UnitName(UnitID)] = nil
		end
		
		-- Check if targeting Valkyr and get data
		if UnitName(UnitID.."target") == "Val'kyr Shadowguard" then
			local RaidMarker = GetRaidTargetIndex(UnitID.."target")
			local Health, HealthMax, Speed = UnitHealth(UnitID.."target"), UnitHealthMax(UnitID.."target"), GetUnitSpeed(UnitID.."target")
			local HealthPct = round(100*Health/HealthMax,0,true)
			local ValkyrGUID = tonumber(string.sub(UnitGUID(UnitID.."target"),6),16)
			if not self.ValkyrUpdated[ValkyrGUID] then
				self.ValkyrUpdated[ValkyrGUID] = true
				if not self.ValkyrTable[ValkyrGUID] then -- Val'kyr not in table yet
					if (GetInstanceDifficulty() <= 2 or HealthPct > 50) then -- Insert Val'kyr
						-- {1 => TextureID, 2 => RaidMarkerID, 3 => HealthPct, 4 => Speed}
						self.ValkyrTable[ValkyrGUID] = {}
						self.ValkyrTable[ValkyrGUID][1] = #self.ValkyrTable
						self.ValkyrTable[ValkyrGUID][2] = RaidMarker
						self.ValkyrTable[ValkyrGUID][3] = HealthPct						
						self.ValkyrTable[ValkyrGUID][4] = Speed
					end -- Else, do nothing because we don't want to print a Val'kyr under 50% HP on heroic diff.
				else -- Val'kyr in table already
					if (GetInstanceDifficulty() <= 2 or HealthPct > 50) then -- Update Val'kyr
						self.ValkyrTable[ValkyrGUID][2] = RaidMarker
						self.ValkyrTable[ValkyrGUID][3] = HealthPct
						self.ValkyrTable[ValkyrGUID][4] = Speed
					else  -- Remove Val'kyr
						self.ValkyrTable[ValkyrGUID] = nil
					end
				end
			end -- Else, do nothing because we updated this Val'kyr already.
		end
	end
	
	-- Print grabbed players
	local arrayGrabbed = {}
	for _,Unit in pairs(self.GrabbedPlayers) do
		table.insert(arrayGrabbed,string.format("%s %s",Unit.Icon and "{rt"..Unit.Icon.."}" or "",Unit.Name))
	end
	self.Label3:SetText("Grabbed players: "..table.concat(arrayGrabbed,", "))
	
	-- Print Valky data
	for GUID,Data in pairs(self.ValkyrTable) do
		if self.ValkyrUpdated[GUID] then
			local Index, RaidMarker, HealthPct, Speed = unpack(Data)
			local Color = GetInstanceDifficulty() <= 2 and (HealthPct <= 10 and "00FF00" or HealthPct <= 20 and "FFFF00" or HealthPct <= 30 and "FFAA00" or HealthPct <= 50 and "FF7700" or "FF0000") or (HealthPct <= 55 and "00FF00" or HealthPct <= 60 and "FFFF00" or HealthPct <= 65 and "FFAA00" or HealthPct <= 75 and "FF7700" or "FF0000")
			self.ValkyrObjects[Index][1]:SetAlpha(1)
			self.ValkyrObjects[Index][2]:SetColor(0, 0.44, 0.87)
			self.ValkyrObjects[Index][3]:SetColor(1, 1, 1)
			self.ValkyrObjects[Index][3]:SetText(string.format("HP: |c%s%s%%|r",Color,HealthPct))
		else -- None of members targeting this Val'kyr, so we'll just remove it.
			local Index = Data[1]
			self.ValkyrObjects[Index][1]:SetAlpha(0.6)
			self.ValkyrObjects[Index][2]:SetColor(160/255, 160/255, 160/255)
			self.ValkyrObjects[Index][3]:SetColor(190/255, 190/255, 190/255)
			self.ValkyrObjects[Index][3]:SetText("HP: <>")
			self.ValkyrTable[GUID] = nil
		end
	end
	self.ValkyrUpdated = {}
end

function MPR_ValkyrTracker:ValkyrSummoned(GUID)
	self.ValkyrCount = self.ValkyrCount + 1
	if self.ValkyrCount == 1 then -- First Valkyr
		self.SummonValkyrCooldown = 45
	end
	self.ValkyrTable[GUID] = {}
	if self.ValkyrCount == (GetInstanceDifficulty()%2 == 1 and 1 or 3) then -- Last Valkyr
		self.ValkyrCount = 0
	end
end

function MPR_ValkyrTracker:DefileCast()
	self.DefileCooldown = QuakeCount == 1 and 32 or 31
end
function MPR_ValkyrTracker:RemorselessWinterCast()
	self.SummonValkyrCooldown = nil
	self.DefileCooldown = nil
end
function MPR_ValkyrTracker:QuakeCast()
	QuakeCount = QuakeCount + 1
	self.SummonValkyrCooldown = QuakeCount == 1 and 16 or nil
	self.DefileCooldown = QuakeCount == 1 and 45 or 44
end
function MPR_ValkyrTracker:FuryOfFrostmourneCast()
	self:Reset()
end
function MPR_ValkyrTracker:Reset()
	self.QuakeCount = 0
	self.SummonValkyrCooldown = nil
	self.DefileCooldown = nil
end
