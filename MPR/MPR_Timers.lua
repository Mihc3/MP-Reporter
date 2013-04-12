MPR_Timers = CreateFrame("Frame", "MPR LK Timers", UIParent)
MPR_Timers.TimeSinceLastUpdate = 0
MPR_Timers.LichKingWarnings = {
-- Will warn: "Warning: The Lich King has {%%}% HP remaining! {Message}"
--	[%%] = {Warned, Message},
	[77] = {false, nil},
	[74] = {false, "Transition soon!"},
	[47] = {false, nil},
	[44] = {false, "Transition soon!"},
}
MPR_Timers.QuakeCount = 0
MPR_Timers.InfoTimers = {
	[1] = {
		[1] = {['name'] = "Bone Spike Graveyard",	['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
		[2] = {['name'] = "Bone Storm",				['format'] = "{SpellLink} CD: {Time}",	['label'] = 2},
	},
	[2] = {
		[1] = {['name'] = "Summon Adds",			['format'] = "{Name}: {Time}",			['label'] = 1},
		[2] = {['name'] = "Summon Vengeful Shade",	['format'] = "{SpellLink} CD: {Time}",	['label'] = 2},
	},
	[3] = {
		[1] = {['name'] = "Below Zero",				['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
	},
	[4] = {
		[1] = {['name'] = "Rune of Blood",			['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
	},
	[5] = {
		[1] = {['name'] = "Gas Spore",				['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
		[2] = {['name'] = "Gastric Bloat",			['format'] = "{SpellLink} CD: {Time}",	['label'] = 2},
	},
	[6] = {
		[1] = {['name'] = "Slime Spray",			['format'] = "{SpellLink}: {Time}",		['label'] = 1},
		[2] = {['name'] = "Mutated Infection",		['format'] = "{SpellLink}: {Time}",		['label'] = 2},
		[3] = {['name'] = "Vile Gas",				['format'] = "{SpellLink} CD: {Time}",	['label'] = 3},
	},
	[7] = {
		[1] = {['name'] = "Unstable Experiment",	['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
		[2] = {['name'] = "Malleable Goo",			['format'] = "{SpellLink} CD: {Time}",	['label'] = 2},
		[3] = {['name'] = "Choking Gas Bomb",		['format'] = "{SpellLink} CD: {Time}",	['label'] = 3},
	},
	[8] = {
		[1] = {['name'] = "Target Switch",			['format'] = "{Name}: {Time}",			['label'] = 1},
		[2] = {['name'] = "Empowered Shock Vortex",	['format'] = "{SpellLink} CD: {Time}",	['label'] = 2},
		[3] = {['name'] = "Shadow Resonance",		['format'] = "{SpellLink} CD: {Time}",	['label'] = 3},
	},
	[9] = {
		[1] = {['name'] = "Incite Terror",			['format'] = "{SpellLink}: {Time}",		['label'] = 1},
		[2] = {['name'] = "Swarming Shadows",		['format'] = "{SpellLink}: {Time}",		['label'] = 2},
		[3] = {['name'] = "Berserk",				['format'] = "{SpellLink}: {Time}",		['label'] = 3},
	},
	[10] = {
		[1] = {['name'] = "Summon Portal",			['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
	},
	[11] = {
		[1] = {['name'] = "Blistering Cold",		['format'] = "{SpellLink} CD: {Time}",	['label'] = 1},
		[2] = {['name'] = "Air Phase",				['format'] = "{Name}: {Time}",			['label'] = 2},
		[3] = {['name'] = "Frost Beacon",			['format'] = "{SpellLink} CD: {Time}",	['label'] = 2},
	},
	[12] = {
		[1] = {['name'] = "Summon Shadow Trap",		['format'] = "{SpellLink} CD: {Time}",		['label'] = 1},
		[2] = {['name'] = "Summon Val'kyr",			['format'] = "{SpellLink}: {Time}",			['label'] = 1},
		[3] = {['name'] = "Defile",					['format'] = "{SpellLink} CD: {Time}",		['label'] = 2},
		[4] = {['name'] = "Harvest Soul/s",			['format'] = "{SpellLink}: {Time}",			['label'] = 1},
		[5] = {['name'] = "Raging Spirit",			['format'] = "{Name} CD: {Time}",			['label'] = 1},
		[6] = {['name'] = "Quake",					['format'] = "{SpellLink}: {Time}",			['label'] = 2},
	},
}
MPR_Timers.DataTimers = {[1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {}, [10] = {}, [11] = {}, [12] = {}} -- structure generated as timers are set
MPR_Timers.TimerWarns = {
	[9] = {
		[1] = {[10] = {false, 3}, [5] = {false, 3}}, -- Incite Terror: 10s,5s
		[2] = {[3] = {false, 7}, [2] = {false, 7}, [1] = {false, 7}}, -- Swarming Shadows: 3s,2s,1s
		[3] = {[30] = {false, 8}, [20] = {false, 8}, [10] = {false, 8}, [5] = {false, 7}}, -- Berserk: 30s,20s,10s,5s
	},
	[12] = {
		[1] = {[3] = {false, 8}, [2] = {false, 8}, [1] = {false, 8}},
		[2] = {[10] = {false, 4}, [5] = {false, 4}},
		[3] = {[10] = {false, 7}, [5] = {false, 7}},
		[4] = {[10] = {false, 6}, [5] = {false, 6}},
	},
}
MPR_Timers.ValkyrCount = 0
MPR_Timers.ValkyrTable = {} -- {IconID, Health, HealthMax, Speed}
MPR_Timers.ValkyrUpdated = {}
MPR_Timers.GrabbedPlayers = {}
MPR_Timers.ValkyrObjects = {}
MPR_Timers.BossNum = 0
MPR_Timers.Bosses = {[0] = "N/a", [1] = "LK",[2] = "LD", [3] = "GB", [4] = "DB", [5] = "Fes", [6] = "Rot", [7] = "PP", [8] = "BPC", [9] = "BQL", [10] = "VD", [11] = "Sin", [12] = "LK"}
function MPR_Timers:Initialize()
	MPR_Timers:Hide()
	MPR_Timers:SetBackdrop(MPR.Settings["BACKDROP"])
	MPR_Timers:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
	MPR_Timers:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)
	MPR_Timers:SetPoint("CENTER",UIParent)
	MPR_Timers:SetWidth(200)
	MPR_Timers:SetHeight(56)
	MPR_Timers:EnableMouse(true)
	MPR_Timers:SetMovable(true)
	MPR_Timers:RegisterForDrag("LeftButton")
	MPR_Timers:SetUserPlaced(true)
	MPR_Timers:SetScript("OnDragStart", function(self) MPR_Timers:StartMoving() end)
	MPR_Timers:SetScript("OnDragStop", function(self) MPR_Timers:StopMovingOrSizing() end)
	MPR_Timers:SetFrameStrata("FULLSCREEN_DIALOG")
	
	MPR_Timers.Title = MPR_Timers:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	MPR_Timers.Title:SetPoint("TOPLEFT", 8, -8)
	MPR_Timers.Title:SetTextColor(190/255, 190/255, 190/255)
	MPR_Timers.Title:SetText("|cff"..MPR.Colors["TITLE"].."MPR|r Timers:")
	MPR_Timers.Title:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
	MPR_Timers.Title:SetShadowOffset(1, -1)
	
	MPR_Timers.Title2 = MPR_Timers:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	MPR_Timers.Title2:SetPoint("LEFT", MPR_Timers.Title, "RIGHT", 0, 0)
	MPR_Timers.Title2:SetTextColor(190/255, 190/255, 190/255)
	MPR_Timers.Title2:SetText("|cFF00CCFF"..MPR.BossData[MPR_Timers.BossNum or 0][1])
	MPR_Timers.Title2:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
	MPR_Timers.Title2:SetShadowOffset(1, -1)
	
	MPR_Timers.CloseButton = CreateFrame("button","BtnClose", MPR_Timers, "UIPanelButtonTemplate")
	MPR_Timers.CloseButton:SetHeight(14)
	MPR_Timers.CloseButton:SetWidth(14)
	MPR_Timers.CloseButton:SetPoint("TOPRIGHT", -8, -8)
	MPR_Timers.CloseButton:SetText("x")
	MPR_Timers.CloseButton:SetScript("OnClick", function(self) MPR_Timers_Options:Hide(); MPR_Timers:Hide() end)
	
	MPR_Timers.CloseButton = CreateFrame("button","BtnClose", MPR_Timers, "UIPanelButtonTemplate")
	MPR_Timers.CloseButton:SetHeight(14)
	MPR_Timers.CloseButton:SetWidth(14)
	MPR_Timers.CloseButton:SetPoint("TOPRIGHT", -24, -8)
	MPR_Timers.CloseButton:SetText("o")
	MPR_Timers.CloseButton:SetScript("OnClick", function(self) MPR_Timers_Options:Show() end)
	MPR_Timers.CloseButton:Disable()
	MPR_Timers.CloseButton:Hide()
	
	MPR_Timers.Label1 = MPR_Timers:CreateFontString("Label1", "OVERLAY", "GameTooltipText")
	MPR_Timers.Label1:SetPoint("TOPLEFT", 8, -22)
	MPR_Timers.Label1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_Timers.Label1:SetText("|cFFbebebeTimer1|r")
	
	MPR_Timers.Label2 = MPR_Timers:CreateFontString("Label2", "OVERLAY", "GameTooltipText")
	MPR_Timers.Label2:SetPoint("TOPLEFT", 8, -36)
	MPR_Timers.Label2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_Timers.Label2:SetText("|cFFbebebeTimer2|r")
		
	MPR_Timers.Label3 = MPR_Timers:CreateFontString("Label3", "OVERLAY", "GameTooltipText")
	MPR_Timers.Label3:SetPoint("TOPLEFT", 8, -50)
	MPR_Timers.Label3:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
	MPR_Timers.Label3:SetText("Grabbed players: ")
	
	MPR_Timers_Options:Initialize()
end
function MPR_Timers:Toggle()
	if MPR_Timers:IsVisible() then
		MPR_Timers:Hide()
	else
		MPR_Timers:Show()
	end
end

function MPR_Timers:GetSpellID(spellName)
			-- Lord Marrowgar
	return spellName == "Bone Spike Graveyard"		and 69057 or
			spellName == "Bone Storm"				and 69076 or
			-- Lady Deathwhisper
			spellName == "Summon Vengeful Shade"	and 71426 or
			-- Gunship Battle
			spellName == "Below Zero"				and 69705 or
			-- Deathbringer Saurfang
			spellName == "Rune of Blood"			and 72410 or
			-- Festergut
			spellName == "Gas Spore"				and 69278 or
			spellName == "Gastric Bloat"			and 72219 or
			-- Rotface
			spellName == "Slime Spray"				and 69508 or
			spellName == "Mutated Infection"		and 69674 or
			spellName == "Vile Gas"					and 69240 or
			-- Professor Putricide
			spellName == "Unstable Experiment"		and 70351 or
			spellName == "Malleable Goo"			and 70852 or
			spellName == "Choking Gas Bomb"			and 71255 or
			-- Blood Prince Council
			spellName == "Empowered Shock Vortex"	and 72039 or
			spellName == "Shadow Resonance"			and 71943 or
			-- Blood-Queen Lana'thel
			spellName == "Incite Terror"			and 73070 or
			spellName == "Swarming Shadows"			and 71264 or
			spellName == "Berserk"					and 26662 or
			-- Valithria Dreamwalker
			spellName == "Summon Portal"			and (self:IsNormal() and 72224 or 72480) or
			-- Sindragosa
			spellName == "Blistering Cold"			and 70123 or
			spellName == "Frost Beacon"				and 70126 or
			-- The Lich King
			spellName == "Summon Shadow Trap"		and 73539 or
			spellName == "Harvest Soul/s"			and (self:IsNormal() and 74325 or 74297) or
			spellName == "Summon Val'kyr"			and 69037 or
			spellName == "Defile"					and 72762 or
			spellName == "Raging Spirit"			and 69200 or
			spellName == "Quake"					and 72262
			
			
			
			
end

function MPR_Timers:RaidMode(Mode10N, Mode25N, Mode10H, Mode25H)
	local Mode = GetInstanceDifficulty()
	return Mode == 1 and Mode10N or Mode == 2 and Mode25N or Mode == 3 and Mode10H or Mode == 4 and Mode25H
end
function MPR_Timers:IsNormal() return self:RaidMode(true, true, false, false) end
function MPR_Timers:IsHeroic() return self:RaidMode(false, false, true, true) end
function MPR_Timers:Is10Man() return self:RaidMode(true, false, true, false) end
function MPR_Timers:Is25Man() return self:RaidMode(false, true, false, true) end

function MPR_Timers:OnUpdate(elapsed)
	local bWhite = GetTime()%1.5 < 0.75
	
	local Label1HasText = nil
	local Label2HasText = nil
	local Label3HasText = nil
	
	local e = self.BossNum
	if e then
		self.DataTimers[e] = self.DataTimers[e] or {}
		for i,_ in pairs(self.DataTimers[e]) do
			local info = self.InfoTimers[e][i]
			local timer = self.DataTimers[e][i]
			local warns = self.TimerWarns[e] and self.TimerWarns[e][i] or nil
			
			if timer then -- timer must be set
				local Seconds, String, Color
				Seconds = round(timer,0,true)
				Color = Seconds > 12 and "00FF00" or Seconds > 9 and "FFFF00" or Seconds > 6 and "FFAA00" or Seconds > 3 and "FF7700" or "FF0000"
				String = info['format']:gsub("{SpellLink}",GetSpellLink(self:GetSpellID(info['name']) or 0)):gsub("{Name}",info['name']):gsub("{Time}","|cFF"..Color..Seconds.." sec|r")
				if info['label'] == 1 then
					self.Label1:SetText(String)
					self.Label1:Show()
					Label1HasText = true
				elseif info['label'] == 2 then
					self.Label2:SetText(String)
					self.Label2:Show()
					Label2HasText = true
				elseif info['label'] == 3 then
					self.Label3:SetText(String)
					self.Label3:Show()
					Label3HasText = true
				end
				
				
				if warns then
					if warns[Seconds] and not warns[Seconds][1] then
						warns[Seconds][1] = true
						local formatted = (warns[Seconds][2] and "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..warns[Seconds][2].."|t " or "")..String..(warns[Seconds][2] and " |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..warns[Seconds][2].."|t" or "")
						String = info['format']:gsub("{SpellLink}",GetSpellLink(self:GetSpellID(info['name']) or 0)):gsub("{Name}",info['name']):gsub("{Time}",Seconds.." sec")
						local unformattted = (warns[Seconds][2] and "{rt"..warns[Seconds][2].."} " or "")..String..(warns[Seconds][2] and " {rt"..warns[Seconds][2].."}" or "")
						MPR:HandleReport(unformattted,formatted)
					elseif warns[Seconds+1] and warns[Seconds+1][1] then
						warns[Seconds+1][1] = false
					end
				end
			end
		end
	end
	
	if not Label3HasText and (e ~= 12 or self.QuakeCount ~= 1) then
		self.Label3:SetText("")
		self.Label3:Hide()
		if not Label2HasText then 
			self.Label2:SetText("")
			self.Label2:Hide()
			if not Label1HasText then 
				self.Label1:SetText("No timers active.")
			end
			self:SetHeight(43)
		else
			self:SetHeight(56)
		end
	else
		self:SetHeight(69)
	end	
	
	if e == 12 then -- LK only
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
		if self.TimeSinceLastUpdate >= MPR.Settings["UPDATEFREQUENCY"] then
			local diff = self.TimeSinceLastUpdate
			self.TimeSinceLastUpdate = 0
			self:Update(diff)
		end
	end
end

local ClassColors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA", ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
function MPR_Timers:Update()
	local countValkyr = 0
	local arrayGrabbed = {}
	local Color = {R = 1, G = 1, B = 1}
	
	local LKHealthPct = nil
	for i=1,GetNumRaidMembers() do
		local UnitIDTarget = (i > 0 and "raid"..i or "").."target"
		if UnitName(UnitIDTarget) == "The Lich King" then
			LKHealthPct = round(100*UnitHealth(UnitIDTarget)/UnitHealthMax(UnitIDTarget),0,true)
			break
		end
	end
	if LKHealthPct and LKHealthPct > 40 and self.LichKingWarnings[LKHealthPct] and not self.LichKingWarnings[LKHealthPct][1] then
		self.LichKingWarnings[LKHealthPct][1] = true
		MPR:RaidReport("Warning: The Lich King has "..LKHealthPct.."% HP remaining! "..(self.LichKingWarnings[LKHealthPct][2] or ""),true)
	end
	
	if self.QuakeCount == 1 then -- During Phase 2 only
		for i=0,GetNumRaidMembers() do
			local UnitID = i == 0 and "player" or "raid"..i
			
			-- Check if grabbed
			if UnitInVehicle(UnitID) then
				if not self.GrabbedPlayers[UnitName(UnitID)] then -- Insert grabbed player
					MPR:ReportValkyrGrab(UnitName(UnitID))
					self.GrabbedPlayers[UnitName(UnitID)] = {} -- {UnitName => TargetMarker}
					self.GrabbedPlayers[UnitName(UnitID)].Name = string.format("|cFF%s%s|r",ClassColors[strupper(select(2,UnitClass(UnitID)))],UnitName(UnitID))
					self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
				elseif GetRaidTargetIndex(UnitID) then -- Update grabbed player's icon if we don't have it yet
					self.GrabbedPlayers[UnitName(UnitID)].Icon = GetRaidTargetIndex(UnitID)
				end
			elseif self.GrabbedPlayers[UnitName(UnitID)] then -- Remove grabbed player
				self.GrabbedPlayers[UnitName(UnitID)] = nil
			end
		end
		
			
		-- Print grabbed players
		for _,Unit in pairs(self.GrabbedPlayers) do
			table.insert(arrayGrabbed,(Unit.Icon and Unit.Icon > 0 and "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..Unit.Icon..":12:12|t" or "")..Unit.Name)
		end
		-- Blinking label if players are grabbed
		if #arrayGrabbed > 0 then
			if GetTime()%1.4 < 0.7 then
				Color = {R = 1, G = 0, B = 0}
			end
		end
		
		self:SetHeight(69)
		MPR_Timers.Label3:Show()
	else
		self.GrabbedPlayers = {}
		self.ValkyrTable = {}
		
		self:SetHeight(56)
		MPR_Timers.Label3:Hide()
	end
	
	self.Label3:SetTextColor(Color.R, Color.G, Color.B)
	self.Label3:SetText("Grabbed players: "..table.concat(arrayGrabbed,", "))
end

function MPR_Timers:NewTimer(ability,cd_left,special)
	local TimeInCB = math.floor(GetTime()-MPR.DataDeaths[#MPR.DataDeaths].TimeStart)
	TimeInCB = string.format("%2d:%02d",floor(TimeInCB/60),(TimeInCB%60))
	self:SelfReport("|r|cFFFF0000New cooldown! Ability: |r|cFFFFFFFF"..ability.."|r|cFFFF0000; CD Left: |r|cFFFFFFFF"..cd_left.."|r|cFFFF0000 s; Encounter Time: |r|cFFFFFFFF"..TimeInCB.."; Instance Diff.: |r|cFFFFFFFF"..GetInstanceDifficulty().."|r|cFFFF0000"..(special and "; |r|cFFFFFFFF"..special.."|r|cFFFF0000" or "").."). |r|cFFFFFF00|HMPR:CopyUrl:https://github.com/Mihapro/MP-Reporter/issues?labels=timer|h[Open an issue on GitHub!]|h|r|cFFBEBEBE")
end

function MPR_Timers:EncounterStart(ID)
	self:Reset()
	self.DataTimers[ID] = {}
	if ID == 1 then
		self.DataTimers[1][1] = 10
		self.DataTimers[1][2] = 45
	elseif ID == 2 then
		self.DataTimers[2][1] = 5
		self.DataTimers[2][2] = nil
	elseif ID == 3 then
		self.DataTimers[3][1] = 45
	elseif ID == 4 then
		self.DataTimers[4][1] = 20
	elseif ID == 5 then
		self.DataTimers[5][1] = 20
		self.DataTimers[5][2] = 12.5
	elseif ID == 6 then
		self.DataTimers[6][1] = 20
		self.DataTimers[6][2] = 14
		self.DataTimers[6][3] = self:IsHeroic() and 15 or nil
	elseif ID == 7 then
		self.PP_Phase = 1
		self.DataTimers[7][1] = 25
	elseif ID == 8 then
		self.DataTimers[8][1] = 46.5
	elseif ID == 9 then
		self.DataTimers[9][1] = self:Is25Man() and 127 or 124
		self.DataTimers[9][2] = 30.5
		self.DataTimers[9][3] = 330
	elseif ID == 10 then
		self.DataTimers[10][1] = 45
	elseif ID == 11 then
		self.SindragosaPhase = 1
		self.DataTimers[11][1] = 39
		self.DataTimers[11][2] = 50
	elseif ID == 12 then
		self.QuakeCount = 0
		self.ValkyrCount = 0
		self.RagingSpiritCount = 0
		if self:IsHeroic() then
			self.Label2:Hide() -- Hide Defile label
			self.DataTimers[12][1] = 30
		end
	else
		return
	end
	self.BossNum = ID
	self.Title2:SetText("|cFF00CCFF"..MPR.BossData[MPR_Timers.BossNum or 0][1])
end

-- 1: Lord Marrowgar
function MPR_Timers:BoneSpikeGraveyard()
	local cd = round(self.DataTimers[1][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Bone Spike Graveyard")),cd,nil) end
	self.DataTimers[1][1] = 15
end
function MPR_Timers:BoneStorm()
	local cd = round(self.DataTimers[1][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Bone Storm")),cd,nil) end
	if self:IsNormal() then  
		self.DataTimers[1][1] = self:Is10Man() and 35 or 45
	end
	self.DataTimers[1][2] = 90
end
-- 2: Lady Deathwhisper
function MPR_Timers:WaveSummoned()
	self.DataTimers[2][1] = self:IsNormal() and 60 or 45
end
function MPR_Timers:ManaBarrierRemoved()
	if self:IsNormal() then
		self.DataTimers[2][1] = nil
	end
	self.DataTimers[2][2] = 12
end
function MPR_Timers:SummonVengefulShade()
	local cd = round(self.DataTimers[2][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Summon Vengeful Shade")),cd,nil) end
	self.DataTimers[2][2] = 18
end
-- 3: Gunship Battle
function MPR_Timers:BelowZero()
	local cd = round(self.DataTimers[3][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Below Zero")),cd,nil) end
	self.DataTimers[3][1] = 60
end
-- 4: Deathbringer Saurfang
function MPR_Timers:RuneOfBlood()
	local cd = round(self.DataTimers[4][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Rune of Blood")),cd,nil) end
	self.DataTimers[4][1] = 18
end
-- 5: Festergut
function MPR_Timers:GasSpore()
	local cd = round(self.DataTimers[5][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Gas Spore")),cd,nil) end
	self.DataTimers[5][1] = 40
end
function MPR_Timers:GastricBloat()
	local cd = round(self.DataTimers[5][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Gastric Bloat")),cd,nil) end
	self.DataTimers[5][2] = 15
end
-- 6: Rotface
function MPR_Timers:SlimeSpray()
	local cd = round(self.DataTimers[6][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Slime Spray")),cd,nil) end
	self.DataTimers[6][1] = 20
end
function MPR_Timers:MutatedInfection()
	local cd = round(self.DataTimers[6][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Mutated Infection")),cd,nil) end
	self.DataTimers[6][2] = 14
end
function MPR_Timers:VileGas()
	local cd = round(self.DataTimers[6][3],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Vile Gas")),cd,nil) end
	self.DataTimers[6][3] = 15
end
-- 7: Professor Putricide
MPR_Timers.PP_Phase = 1
function MPR_Timers:TearGas()
	self.PP_Phase = self.PP_Phase + 1
	self.DataTimers[7][1] = self:IsNormal() and (self.DataTimers[7][1] + 30) or 35
	self.DataTimers[7][2] = self.PP_Phase == 2 and 21 or (self.DataTimers[7][2] + 30)
	self.DataTimers[7][3] = self.PP_Phase == 2 and 35 or (self.DataTimers[7][3] + 30)
end
function MPR_Timers:UnstableExperiment()
	local cd = round(self.DataTimers[7][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Unstable Experiment")),cd,nil) end
	self.DataTimers[7][1] = 30
end
function MPR_Timers:MalleableGoo()
	local cd = round(self.DataTimers[7][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Malleable Goo")),cd,nil) end
	self.DataTimers[7][2] = 25
end
function MPR_Timers:ChokingGasBomb()
	local cd = round(self.DataTimers[7][3],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Choking Gas Bomb")),cd,nil) end
	self.DataTimers[7][3] = 35
end
-- 8: Blood Prince Council
function MPR_Timers:InvocationOfBlood(Prince)
	local cd = round(self.DataTimers[8][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Invocation Of Blood")),cd,nil) end
	self.DataTimers[8][1] = 46.5
	self.DataTimers[8][2] = nil
end
function MPR_Timers:EmpoweredShockVortex()
	local cd = round(self.DataTimers[8][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Empowered Shock Vortex")),cd,nil) end
	self.DataTimers[8][2] = 15
end
function MPR_Timers:ShadowResonance()
	local cd = round(self.DataTimers[8][3],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Shadow Resonance")),cd,nil) end
	self.DataTimers[8][3] = 15
end
-- 9: Blood-Queen Lana'thel
function MPR_Timers:InciteTerror()
	local cd = round(self.DataTimers[9][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Incite Terror")),cd,nil) end
	self.DataTimers[9][1] = 100 + self:Is25Man() and 0 or 20
	self.DataTimers[9][2] = 30.5
end
function MPR_Timers:SwarmingShadows()
	local cd = round(self.DataTimers[9][2],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Swarming Shadows")),cd,nil) end
	self.DataTimers[9][2] = 30.5
end
-- 10: Valithria Dreamwalker
function MPR_Timers:SummonPortal()
	local cd = round(self.DataTimers[10][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Summon Portal")),cd,nil) end
	self.DataTimers[10][1] = 45
end
-- 11: Sindragosa
MPR_Timers.SindragosaPhase = 1
function MPR_Timers:BlisteringCold()
	local cd = round(self.DataTimers[11][1],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Blistering Cold")),cd,"Phase "..self.SindragosaPhase) end
	--if self.SindragosaPhase ~= 2 then return end
	self.DataTimers[11][1] = 33
end
function MPR_Timers:AirPhase()
	local cd = round(self.DataTimers[11][2],1,true)
	if cd > 0 then self:NewTimer("Air Phase",cd,nil) end
	self.DataTimers[11][1] = 60
	self.DataTimers[11][2] = 108
end
function MPR_Timers:SecondPhase()
	self.SindragosaPhase = 2
	self.DataTimers[11][1] = 35
	self.DataTimers[11][2] = nil
	self.DataTimers[11][3] = 7
end
function MPR_Timers:FrostBeacon()
	if self.SindragosaPhase ~= 2 then return end
	local cd = round(self.DataTimers[11][3],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Frost Beacon")),cd,nil) end
	self.DataTimers[11][3] = 16
end
-- 12: The Lich King 
function MPR_Timers:SummonShadowTrap()
	self.DataTimers[12][1] = 14
end
function MPR_Timers:SummonValkyr(GUID)
	self.ValkyrCount = self.ValkyrCount + 1
	if self.ValkyrCount == 1 then -- First Valkyr
		self.DataTimers[12][2] = 45
	end
	--self.ValkyrTable[GUID] = {}
	--self.ValkyrTable[GUID][1] = self.ValkyrCount
	if self.ValkyrCount == (self:Is10Man() and 1 or 3) then -- Last Valkyr
		self.ValkyrCount = 0
	end
end
function MPR_Timers:Defile()
	self.DataTimers[12][3] = 31
end
function MPR_Timers:HarvestSoul()
	self.DataTimers[12][4] = 75
end
function MPR_Timers:HarvestSouls()
	self.DataTimers[12][4] = 120
	self.DataTimers[12][3] = 50
end
function MPR_Timers:RemorselessWinter()
	self.DataTimers[12][1] = nil
	self.DataTimers[12][2] = nil
	self.DataTimers[12][3] = nil
	
	self.DataTimers[12][5] = self.QuakeCount == 0 and 3 or 5
	self.DataTimers[12][6] = 60
end
MPR_Timers.RagingSpiritCount = 0
function MPR_Timers:RagingSpiritSummoned()
	self.RagingSpiritCount = self.RagingSpiritCount + 1
	self.DataTimers[12][5] = self.RagingSpiritCount < 3 and 22 or nil
end
function MPR_Timers:Quake()
	local cd = round(self.DataTimers[12][5],1,true)
	if cd > 0 then self:NewTimer(GetSpellLink(self:GetSpellID("Quake")),cd,"Quake #"..(self.QuakeCount+1)) end
	self.DataTimers[12][5] = nil
	
	self.QuakeCount = self.QuakeCount + 1
	self.DataTimers[12][2] = self.QuakeCount == 1 and 26 or nil
	self.DataTimers[12][3] = self.QuakeCount == 1 and 44 or 32
	self.DataTimers[12][4] = self.QuakeCount == 2 and 20 or nil
	
	self.Label2:Show() -- Show Defile label
end
function MPR_Timers:FuryOfFrostmourne()
	self:Reset()
end

function MPR_Timers:EncounterEnd(ID)
	self:Reset()
end

function MPR_Timers:Reset()
	self.BossNum = nil
	MPR_Timers.Title2:SetText("|cFF00CCFF"..MPR.BossData[MPR_Timers.BossNum or 0][1])
	
	for e,_ in pairs(MPR_Timers.DataTimers) do
		for i,_ in pairs(MPR_Timers.DataTimers[e]) do
			MPR_Timers.DataTimers[e][i] = nil
		end
	end
end

MPR_Timers_Updater = CreateFrame("frame", "MPR Timers (Updater)", UIParent)
MPR_Timers_Updater.Interval = 0.1
MPR_Timers_Updater.LastUpdate = 0
MPR_Timers_Updater:SetScript("OnUpdate", function(self, elapsed)
	if MPR.Settings["CCL_ONLOAD"] then CombatLogClearEntries() end
	if GetZoneText() ~= "Icecrown Citadel" then
		MPR_Timers.Label3:SetText("")
		MPR_Timers.Label3:Hide()
		MPR_Timers.Label2:SetText("")
		MPR_Timers.Label2:Hide()
		MPR_Timers.Label1:SetText("No timers active.")
		MPR_Timers:SetHeight(43)
		return
	end
	
	MPR_Timers_Updater.LastUpdate = MPR_Timers_Updater.LastUpdate + elapsed
	if MPR_Timers_Updater.LastUpdate < MPR_Timers_Updater.Interval then return end
	local diff = MPR_Timers_Updater.LastUpdate
	MPR_Timers_Updater.LastUpdate = 0
	
	local e = MPR_Timers.BossNum
	if e then
		MPR_Timers.DataTimers[e] = MPR_Timers.DataTimers[e] or {}
		if MPR_Timers.DataTimers[e] then
			for i=1,6 do
				if MPR_Timers.DataTimers[e][i] then
					if MPR_Timers.DataTimers[e][i] and MPR_Timers.DataTimers[e][i] > 0 then
						MPR_Timers.DataTimers[e][i] = MPR_Timers.DataTimers[e][i] - diff
						if MPR_Timers.DataTimers[e][i] < 0 then 
							MPR_Timers.DataTimers[e][i] = 0 
							if e == 2 and i == 1 then
								MPR_Timers:WaveSummoned()
							end
						end
					end
				end
			end
		end
	end
	MPR_Timers:OnUpdate(diff)
end)

MPR_Timers_Options = CreateFrame("Frame", "MPR Timers (Options)")
function MPR_Timers_Options:Initialize()
	MPR_Timers_Options:Hide()
	MPR_Timers_Options:SetBackdrop(MPR.Settings["BACKDROP"])
	MPR_Timers_Options:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
	MPR_Timers_Options:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)
	MPR_Timers_Options:SetPoint("CENTER",UIParent)
	MPR_Timers_Options:SetWidth(250)
	MPR_Timers_Options:SetHeight(56)
	MPR_Timers_Options:EnableMouse(true)
	MPR_Timers_Options:SetMovable(true)
	MPR_Timers_Options:RegisterForDrag("LeftButton")
	MPR_Timers_Options:SetUserPlaced(true)
	MPR_Timers_Options:SetScript("OnDragStart", function(self) MPR_Timers_Options:StartMoving() end)
	MPR_Timers_Options:SetScript("OnDragStop", function(self) MPR_Timers_Options:StopMovingOrSizing() end)
	MPR_Timers_Options:SetFrameStrata("FULLSCREEN_DIALOG")

	MPR_Timers_Options.Title = MPR_Timers_Options:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	MPR_Timers_Options.Title:SetPoint("TOP", 0, -8)
	MPR_Timers_Options.Title:SetTextColor(190/255, 190/255, 190/255)
	MPR_Timers_Options.Title:SetText("|cff"..MPR.Colors["TITLE"].."MP Reporter|r - LK Timers")
	MPR_Timers_Options.Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	MPR_Timers_Options.Title:SetShadowOffset(1, -1)

	MPR_Timers_Options.CloseButton = CreateFrame("button","BtnClose", MPR_Timers_Options, "UIPanelButtonTemplate")
	MPR_Timers_Options.CloseButton:SetHeight(14)
	MPR_Timers_Options.CloseButton:SetWidth(14)
	MPR_Timers_Options.CloseButton:SetPoint("TOPRIGHT", -8, -8)
	MPR_Timers_Options.CloseButton:SetText("x")
	MPR_Timers_Options.CloseButton:SetScript("OnClick", function(self) MPR_Timers_Options:Hide() end)
	
	-- ...
end