local MPR = CreateFrame("frame")
local MPR_Version = "v1.37"
local MPR_Prefix = "|cFF1e90ffMP Reporter|r|cFFbebebe - "
local MPR_Postfix = "|r"
local MPR_ChannelPrefix = "<MPR> "

local ClassColors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA",
					["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9",	["WARRIOR"] = "C79C6E"}
local InstanceShortNames = {["Icecrown Citadel"] = "ICC",["Vault of Archavon"] = "VOA",["Trial of the Crusader"] = "TOC",["Naxxramas"] = "NAXX",["Ruby Sanctum"] = "RS"}
local BossNames = {
	-- Icecrown Citadel
	"Lord Marrowgar", "Lady Deathwhisper", "Deathbringer Saurfang", "Rotface", "Festergut", "Professor Putricide", 
	"Prince Keleseth", "Prince Valanar", "Prince Taldaram", "Queen Lana'thel", "Valithria Dreamwalker", "Sindragosa", "The Lich King",
	-- Vault of Archavon
	"Archavon the Stone Watcher", "Emalon the Storm Watcher", "Koralon the Flamewatcher", "Toravon the Ice Watcher",
	-- Trial of the Crusader
	"Gormok", "Acidmaw", "Dreadscale", "Icehowl", "Jaraxxus", "Gorgrim Shadowcleave", "Birana Stormhoof", "Erin Misthoof", 
	"Ruj'kah", "Ginselle Blightslinger", "Liandra Suncaller", "Malithas Brightblade", "Caiphus the Stern", "Vivienne Blackwhisper", 
	"Maz'dinah", "Thrakgar", "Broln Stouthorn", "Harkzog", "Narrhok Steelbreaker", "Fjola Lightbane", "Eydis Darkbane", "Anub'arak",
	-- Ruby Sanctum
	"Halion",
}
local BossYells = {
	["The heavens burn!"] = "Meteor Strike"
}
local RaidDifficulty = {[1] = "10n",[2] = "25n",[3] = "10h",[4] = "25h"}
					
------ You can change these settings! ------
-- Created objects --
--| Output: Player prepares [Spell]. |--
local spellsCreate = {["Great Feast"] = 180, ["Fish Feast"] = 180, ["Ritual of Souls"] = 120, ["Ritual of Refreshment"] = 180}

-- Damage & Healing --
--| Output: [Spell] hits Target for Amount [(Critical)]. |--
local spellsDamage = {}
local spellsPeriodicDamage = {"Necrotic Plague"}
--| Output: [Spell] heals Target for Amount [(Critical)]. |--
local spellsHeal = {"Rune of Blood"}
local spellsPeriodicHeal = {}
--| Output: [Spell] hits: Target1 (Amount3), Target2 (Amount3), Target3 (Amount3), ... |--
local spellsAOEDamage = {"Malleable Goo", "Backlash", "Frost Bomb", "Blistering Cold", "Meteor Strike", "Whiteout"}
--| Output: Player damages Target with [Spell]. |--
local reportDamageOnTarget = {}

-- Summons --
--| Output: Unit summons Target. [Spell] |--
local npcsSpellSumon = {"Slime Pool"} 
--| Output: Target summoned. [Spell] |--
local npcsBossSpellSumon = {"Growing Ooze Puddle", "Vengeful Shade"} -- Boss summons, destination is unknown. ("Dark Nucleus" summoned every second - spam)

-- Casts (SPELL_CAST_SUCCESS) --
--| Output: Unit casts [Spell]. |--
local spellsCast = {"Blessing of Forgotten Kings", "Runescroll of Fortitude", "Drums of the Wild", "Dark Vortex", "Light Vortex"}
--| Output: Unit casts [Spell] on Target. |--
local spellsCastOnTarget = {"Hand of Protection"}
--| Output: [Spell] on Target. |--
local spellsBossCastOnTarget = {"Swarming Shadows", "Necrotic Plague"} -- If sourceName isn't important (ex. Boss casting).

-- Auras (SPELL_AURA_APPLIED, SPELL_AURA_APPLIED_DOSE, SPELL_AURA_STOLEN) --
--| Output: [Spell] applied on Target. |--
local aurasAppliedOnTarget = {"Frenzied Bloodthirst", "Essence of the Blood Queen", "Incinerate Flesh", "Soul Consumption", "Fiery Combustion"}
--| Output: [Spell] applied on Target1, Target2, Target3 ... |--
local aurasAppliedOnTargets = {"Impaled", "Dominate Mind", "Gas Spore", "Vile Gas", "Gut Spray", "Unchained Magic", "Frost Beacon"}
-- MPR.DB.SayMessages = true
local sayAuraOnMe = {
	["Impaled"] = "Bone Spike on me! Kill it fast!!",
	["Dominate Mind"] = "Dominate Mind on me! Don't kill me!!",
	["Gut Spray"] = "Gut Spray on me! Dispel me!!",
	["Unchained Magic"] = "Unchained Magic on me!",
	["Frost Beacon"] = "Frost Beacon on me!",
}
--| Output: Target has Amount stacks of [Spell]. |--
local stackAppliedOnTarget = {"Unstable Ooze"}
--| Output: Player steals [Spell] from Target. |--
-- MPR.DB.ReportAurasStolen = true

-- Dispeling --
--| Output: Player dispels Target. [extraSpell] |--
-- MPR.DB.ReportDispels = true
--| Output: Player mass-dispels Target1 ([extraSpell1]), Target2 ([extraSpell2]), Target3 ([extraSpell3]) ... |--
-- MPR.DB.ReportMassDispels = true

-- Deaths --
--| Output: Unit died. |--
-- MPR.DB.ReportDeaths = true
local reportDeathsPlayersOnly = true
--------------------------------------------
-- Other Variables --
local usersAddon = {}
local reportedNewerVersion = false
local targetsHeroism = {}
local nameSpellAOEDamage
local targetsSpellAOEDamage = {}
local targetsAura = {}
local casterMassDispel
local targetsMassDispel = {}
--------------------------------------------

local Events = {
	"ZONE_CHANGED_NEW_AREA",
	"COMBAT_LOG_EVENT_UNFILTERED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_ADDON",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_IGNORED",
	"PARTY_CONVERTED_TO_RAID"
}

MPR:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

--[[-------------------------------------------------------------------------
	Local Methods (accessible by Class Methods)
---------------------------------------------------------------------------]]

local function amount(num)
	return num
	
	--[[ Number formating
	if strlen(num) > 4 then
		return string.sub(num, 1, -4).."k"
	else
		return num
	end]]
end

local function contains(array, element, ...)
	boolKey = ...
	if boolKey then
		for key, _ in pairs(array) do
			if key == element then
				return true
			end
		end
	else
		for _, value in pairs(array) do
			if value == element then
				return true
			end
		end
	end
	return false
end

local function colorWhite(str)
	return string.format("|r|cFFffffff%s|r|cFFbebebe",str)
end

local function report(TimerName, ...)
	if TimerName == "Report Users" then
		MPR:Report("Online guild members using MP Reporter: "..table.concat(usersAddon, ", "))
		table.wipe(usersAddon)
	else
		MPR:Report(...)
	end
end

local function unit(name)
	if name then
		if UnitInRaid(name) and UnitClass(name) then
			return string.format("|r|cFF%s%s|r|cFFbebebe",ClassColors[select(2, UnitClass(name))],name)
		elseif contains(BossNames,name) then
			return "|r|cFFff8c00"..name.."|r|cFFbebebe"
		else
			return colorWhite(name)
		end
	else
		return "unknown"
	end
	
end

local function spell(id)
	if type(id) ~= "number" then return id end
	if MPR.DB.IconsEnabled and select(3, GetSpellInfo(id)) then
		return string.format("|r\124T%s:12:12:0:0:64:64:5:59:5:59\124t |cFF71d5ff|Hspell:%s|h[%s]|h|r",select(3, GetSpellInfo(id)),id,GetSpellInfo(id))
	else
		return string.format("|r|cFF71d5ff|Hspell:%s|h[%s]|h|r|cFFbebebe",id,GetSpellInfo(id))
	end
end

function getStateColor(state) 
	if state then
		return "|r|cFF00FF00enabled|r|cFFbebebe"
	else
		return "|r|cFFFF0000disabled|r|cFFbebebe"
	end
end

function ListCommands()
	MPR:Report("Available commands:\n"..
		colorWhite("/mpr").." (disable or enable MP Reporter)\n"..
		colorWhite("/mpr status").." (show setting status)\n"..
		colorWhite("/mpr icon")..", "..colorWhite("/mpr icons").." (disable or enable spell icons)\n"..
		colorWhite("/mpr ccl")..", "..colorWhite("/mpr clear").." (clear combat log)\n"..
		colorWhite("/mpr buff <keyword>")..", "..colorWhite("/mpr buffs").." (list players without buff/buffs)\n"..
		colorWhite("/mpr raid-reporting")..", "..colorWhite("/mpr rr").." (toggle reporting to raid)\n"..
		colorWhite("/mpr say").." (toggle sending SAY messages, ex. Aura on me!)\n"..
		colorWhite("/mpr report dispels").." (toggle reporting dispels)"..
		colorWhite("/mpr report mass-dispels").." (toggle reporting mass dispels)"..
		colorWhite("/mpr report deaths").." (toggle reporting deaths)"
	)
end

--[[-------------------------------------------------------------------------
	Boss Methods
---------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------
	Timer System
---------------------------------------------------------------------------]]

local lib = DongleStub("Dongle-1.2"):New("MP Reporter")

function MPR:ScheduleTimer(name, func, delay, ...)
	lib:ScheduleTimer(name, func, delay, ...)
end

function MPR:IsTimerScheduled(name)
	lib:IsTimerScheduled(name)
end

function MPR:CancelTimer(name)
	lib:CancelTimer(name)
end

local function TimerHandler(name, ...)
	if name == "Spell AOE Damage" then
		local Spell = ...
		local array = {}
		local arrayRaid = {}
		for Target,Amount in targetsSpellAOEDamage do
			table.insert(array,string.format("%s (%i)",unit(Target),amount(Amount)))
			table.insert(arrayRaid,string.format("%s (%i)",Target,amount(Amount)))
		end
		table.wipe(targetsSpellAOEDamage)
		nameSpellAOEDamage = nil
		MPR:Report(spell(Spell).." on: "..table.concat(array,", "))
		if MPR.DB.RaidReporting then
			MPR:RaidReport("["..GetSpellInfo(Spell).."] on: "..table.concat(arrayRaid,", "))
		end
	elseif name == "Aura Targets" then
		local Spell = ...
		local array = {}
		local arrayRaid = {}
		for _,Target in targetsAura do
			table.insert(array,unit(Target))
			table.insert(arrayRaid,Target)
		end
		table.wipe(targetsAura)
		MPR:Report(spell(Spell).." on: "..table.concat(array,", "))
		if MPR.DB.RaidReporting then
			MPR:RaidReport("["..GetSpellInfo(Spell).."] on: "..table.concat(arrayRaid,", "))
		end
	elseif name == "Mass Dispel" then
		local Player = casterMassDispel
		local array = {}
		local arrayRaid = {}
		for Target,extraSpell in targetsMassDispel do
			table.insert(array,string.format("%s (%s)",unit(Target),spell(extraSpell)))
			table.insert(arrayRaid,string.format("%s (%s)",Target,GetSpellInfo(extraSpell)))
		end
		table.wipe(targetsMassDispel)
		casterMassDispel = nil
		MPR:Report(unit(Player).." mass-dispels: "..table.concat(array,", "))
		if MPR.DB.RaidReporting then
			MPR:RaidReport(Player.." mass-dispels: "..table.concat(arrayRaid,", "))
		end
	elseif name == "Heroism" then
		local Player, Spell = ...
		if #targetsHeroism > 0 then
			MPR:Report(string.format("%s casts %s (%i/%i players affected).",unit(Player),spell(Spell),#targetsHeroism,GetNumRaidMembers()))
			if MPR.DB.RaidReporting then
				MPR:RaidReport(string.format("%s casts [%s] (%i/%i players affected).",Player,GetSpellInfo(Spell),#targetsHeroism,GetNumRaidMembers()))
			end
		else
			MPR:Report(string.format("%s casts %s.",unit(Player),spell(Spell)))
			if MPR.DB.RaidReporting then
				MPR:RaidReport(string.format("%s casts [%s].",Player,GetSpellInfo(Spell)))
			end
		end
		table.wipe(targetsHeroism)
	elseif contains(spellsCreate,name,true) then
		local Spell = ...
		MPR:Report(string.format("%s expires in 30 seconds.",spell(Spell)))
		if MPR.DB.RaidReporting then
			MPR:RaidReport(string.format("[%s] expires in 30 seconds.",GetSpellInfo(Spell)))
		end	
	end
end

--[[-------------------------------------------------------------------------
	Class Methods
---------------------------------------------------------------------------]]

function MPR:RegisterEvents()
	for _,event in pairs(Events) do
		this:RegisterEvent(event)
	end
end

function MPR:ClearCombatLog(bAuto)
	local f = CreateFrame("frame",nil,UIParent)
	f:SetScript("OnUpdate",CombatLogClearEntries)
	CombatLogClearEntries()
	self:Report(not bAuto and "Combat log entries cleared." or "Combat log entries cleared. |cFFbebebeUse "..colorWhite("/mpr auto-ccl").." to toggle combat log clear on startup.|r")
end

function SlashCmdList.MPR(msg, editbox)
	msg = strlower(msg)
	if msg == "help" then
		ListCommands()
		MPR:BuffHelp()
	elseif msg == "status" then
		MPR:Report("Status:\n"..
			"Reporting "..getStateColor(MPR.DB.Reporting).."\n"..
			"Startup combat log clear "..getStateColor(MPR.DB.ClearEntriesOnLoad).."\n"..
			"Icons "..getStateColor(MPR.DB.IconsEnabled).."\n"..
			"Raid reporting "..getStateColor(MPR.DB.RaidReporting).."\n"..
			"Sending SAY messages "..getStateColor(MPR.DB.SayMessages).."\n"..
			"Reporting aura stolen "..getStateColor(MPR.DB.ReportAuraStolen).."\n"..
			"Reporting dispels "..getStateColor(MPR.DB.ReportDispels).."\n"..
			"Reporting mass-dispels "..getStateColor(MPR.DB.ReportMassDispels).."\n"..
			"Reporting deaths "..getStateColor(MPR.DB.ReportDeaths)
		)
	elseif msg == "icon" or msg == "icons" then
		MPR.DB.IconsEnabled = not MPR.DB.IconsEnabled
		MPR:Report("Icons "..getStateColor(MPR.DB.IconsEnabled)..".")
	elseif msg == "auto-ccl" then
		MPR.DB.ClearEntriesOnLoad = not MPR.DB.ClearEntriesOnLoad
		MPR:Report("Startup combat log clear "..getStateColor(MPR.DB.ClearEntriesOnLoad)..".")
	elseif msg == "rr" or msg == "raidreporting" or msg == "raid reporting" or msg == "raid-reporting" then
		MPR.DB.RaidReporting = not MPR.DB.RaidReporting
		MPR:PARTY_CONVERTED_TO_RAID()
	elseif msg == "ccl" or msg == "clear" then
		MPR:ClearCombatLog()
	elseif msg == "say" then
		MPR.DB.SayMessages = not MPR.DB.SayMessages
		MPR:Report("Sending SAY messages "..getStateColor(MPR.DB.SayMessages)..".")
	elseif msg:sub(1,6) == "report" then
		msg = msg:sub(8)
		if msg == "aura stolen" then
			MPR.DB.ReportAuraStolen = not MPR.DB.ReportAuraStolen
			MPR:Report("Report aura stolen "..getStateColor(MPR.DB.ReportAuraStolen)..".")
		elseif msg == "dispels" then
			MPR.DB.ReportDispels = not MPR.DB.ReportDispels
			MPR:Report("Report dispels "..getStateColor(MPR.DB.ReportDispels)..".")
		elseif msg == "mass-dispels" then
			MPR.DB.ReportMassDispels = not MPR.DB.ReportMassDispels
			MPR:Report("Report mass-dispels "..getStateColor(MPR.DB.ReportMassDispels)..".")
		elseif msg == "deaths" then
			MPR.DB.ReportDeaths = not MPR.DB.ReportDeaths
			MPR:Report("Report deaths "..getStateColor(MPR.DB.ReportDeaths)..".")
		else
			MPR:Report("Unknown command.")
		end
	elseif msg:sub(1,4) == "buff" then
		local sBuff = strlower(msg:sub(6))
		MPR:ReportWithoutBuff(sBuff)
	elseif msg == "buffs" then
		MPR:ReportWithoutBuffs()
	elseif msg == "ignores" then
		if UnitInRaid(UnitName("player")) then
			for i=1,GetNumRaidMembers() do
				if UnitName("raid"..i) ~= UnitName("player") then
					SendChatMessage("<MPR> Auto-Whisper: Checking people ignoring me.", "WHISPER", "Common", UnitName("raid"..i));
				end
			end
		end
	elseif msg ~= "" then
		MPR:Report("Unknown command.")
	else
		MPR.DB.Reporting = not MPR.DB.Reporting
		MPR:Report(string.format("Reporting %s.",getStateColor(MPR.DB.Reporting)))
	end
end

function MPR:CHAT_MSG_WHISPER(...)
	local Message, Player = ...
	if strlower(Message) == "raidlocks" or strlower(Message) == "raid locks" then
		self:ReportLocks(Player)
	end
end

function MPR:CHAT_MSG_IGNORED(...)
	local Player = ...
	MPR:Report(unit(Player).." is ignoring you.")
	SendChatMessage("Retard "..Player.." is ignoring me.", "RAID")
end

function MPR:PARTY_CONVERTED_TO_RAID(...)
	if not self.DB.Reporting then return end
	self:Report("Raid Reporting is "..getStateColor(self.DB.RaidReporting)..". It is recommended that only one member is reporting to RAID channel to prevent spam. Use "..colorWhite("/mpr rr").." to toggle Raid Reporting.")
end

function MPR:COMBAT_LOG_EVENT_UNFILTERED(...)
	if not self.DB.Reporting then return end 
	local timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
	
	-- taken from Blizzard_CombatLog.lua
	if event == "SWING_DAMAGE" then
		local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
	
		if contains(reportDamageOnTarget,destName) then
			self:ReportDamageOnTarget(sourceName,destName,spellId)
		end
	elseif event == "SWING_MISSED" then
		local spellName = ACTION_SWING
		local missType = select(9, ...)
	elseif event == "SWING_LEECH" then
			local amount, powerType, extraAmount = select(12, ...)
			local valueType = 2
	elseif event:sub(1, 5) == "RANGE" then
		local spellId, spellName, spellSchool = select(9, ...)
		if event == "RANGE_DAMAGE" then
			local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)
			
			if contains(reportDamageOnTarget,destName) then
				self:ReportDamageOnTarget(sourceName,destName,spellId)
			end
		elseif event == "RANGE_MISSED" then
			local missType = select(12, ...)
		end
	elseif event:sub(1, 5) == "SPELL" then
		local spellId, spellName, spellSchool = select(9, ...)
		if event == "SPELL_CAST_START" or event == "SPELL_CAST_SUCCESS" then
			if spellName == "Heroism" and UnitInRaid(sourceName) then
				if not self:IsTimerScheduled("Heroism") then
					table.wipe(targetsHeroism)
					self:ScheduleTimer("Heroism", TimerHandler, 0.3, sourceName, spellId)
				end
			elseif contains(spellsCast,spellName) then
				self:ReportCast(sourceName,spellId)
			elseif contains(spellsCastOnTarget,spellName) then
				self:ReportCastOnTarget(sourceName,spellId,destName)
			elseif contains(spellsBossCastOnTarget,spellName) then
				self:ReportBossCastOnTarget(spellId,destName)
			end
		elseif event == "SPELL_CREATE" then
			if contains(spellsCreate,destName,true) then
				self:ReportSpellCreate(sourceName,spellId)
				self:CancelTimer(destName)
				self:ScheduleTimer(destName, TimerHandler, spellsCreate[destName]-30, spell(spellId))
			end
		elseif event == "SPELL_SUMMON" then
			if contains(npcsBossSpellSumon,destName) then
				self:ReportBossSummon(destName,spellId)
			elseif contains(npcsSpellSumon,destName) then
				self:ReportSummon(sourceName,destName,spellId)
			end			
		elseif event == "SPELL_DAMAGE" then
			local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)
			
			if contains(spellsDamage,spellName) then
				self:ReportSpellDamage(spellId,destName,amount,critical)
			elseif contains(spellsAOEDamage,spellName) then
				if not nameSpellAOEDamage then
					nameSpellAOEDamage = spellName
				elseif nameSpellAOEDamage ~= spellName then
					return
				end
				
				if not self:IsTimerScheduled("Spell AOE Damage") then
					self:ScheduleTimer("Spell AOE Damage", TimerHandler, 0.3, spellId)
				end
				
				table.insert(targetsSpellAOEDamage,destName,amount)
			elseif contains(reportDamageOnTarget,destName) then
				self:ReportDamageOnTarget(sourceName,destName,spellId)
			end
		elseif event == "SPELL_HEAL" then
			local amount, overheal, absorbed, critical = select(12, ...)
			local school = spellSchool
			
			if contains(spellsHeal,spellName) then
				self:ReportSpellHeal(spellId,destName,amount,critical)
			end
		elseif event == "SPELL_ENERGIZE" then
			local valueType = 2
			local amount, powerType = select(12, ...)
		elseif event:sub(1, 14) == "SPELL_PERIODIC" then
			if event == "SPELL_PERIODIC_MISSED" then
				local missType = select(12, ...)
			elseif event == "SPELL_PERIODIC_DAMAGE" then
				local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)
				
				if contains(spellsPeriodicDamage,spellName) then
					self:ReportSpellPeriodicDamage(spellId,destName,amount,critical)
				end
			elseif event == "SPELL_PERIODIC_HEAL" then
				local amount, overheal, absorbed, critical = select(12, ...)
				local school = spellSchool
				
				if contains(spellsPeriodicHeal,spellName) then
					self:ReportSpellPeriodicHeal(spellId,destName,amount,critical)
				end
			elseif event == "SPELL_PERIODIC_DRAIN" then
				local amount, powerType, extraAmount = select(12, ...)
				local valueType = 2
			elseif event == "SPELL_PERIODIC_LEECH" then
				local amount, powerType, extraAmount = select(12, ...)
				local valueType = 2
			elseif event == "SPELL_PERIODIC_ENERGIZE" then
				local amount, powerType = select(12, ...)
				local valueType = 2
			end
		elseif event == "SPELL_DISPEL" then
			local extraSpellId, extraSpellName, extraSpellSchool, auraType = select(12, ...)
			
			if self.DB.ReportDispels and spellName ~= "Mass Dispel" then
				self:ReportDispel(sourceName,destName,extraSpellId)
			elseif self.DB.ReportMassDispels and spellName == "Mass Dispel" then
				if not casterMassDispel then
					casterMassDispel = sourceName
				elseif casterMassDispel ~= sourceName then
					return
				end
				
				if not self:IsTimerScheduled("Mass Dispel") then
					self:ScheduleTimer("Mass Dispel", TimerHandler, 0.2)
				end
				table.insert(targetsMassDispel,destName,extraSpellName)
			end
		elseif event == "SPELL_AURA_APPLIED" then
			local auraType = select(12, ...)
			
			if spellName == "Heroism" and UnitInRaid(destName) then
				targetsHeroism[#targetsHeroism + 1] = destName
			elseif contains(aurasAppliedOnTarget,spellName) then
				self:ReportAppliedOnTarget(spellId,destName)
			elseif contains(aurasAppliedOnTargets,spellName) then
				if destName == UnitName("player") and self.DB.SayMessages and contains(sayAuraOnMe,spellName) then
					self:Say(sayAuraOnMe[spellName])
				end
				table.insert(targetsAura,destName)
				MPR:CancelTimer("Aura Targets")
				MPR:ScheduleTimer("Aura Targets", TimerHandler, 0.3, spellId)
			end
		elseif event == "SPELL_AURA_APPLIED_DOSE" then
			local auraType, amount = select(12, ...)
			
			if contains(stackAppliedOnTarget,spellName) then
				self:ReportStacksOnTarget(destName,spellId,amount)
			end
		elseif event == "SPELL_AURA_STOLEN" then
			local extraSpellId, extraSpellName, extraSpellSchool = select(12, ...)
			local auraType = select(15, ...)
			
			if self.DB.ReportAurasStolen then
				self:ReportAuraStolen(sourceName,extraSpellId,destName)
			end
		end
	elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
		local sourceName = destName
		local sourceGUID = destGUID
		local sourceFlags = destFlags
		
		if self.DB.ReportDeaths then
			if not reportDeathsPlayersOnly or UnitIsPlayer(sourceName) then
				self:ReportDeath(sourceName)
			end
		end
	end
end

function MPR:CHAT_MSG_MONSTER_YELL(msg)
	if not self.DB.Reporting or not contains(BossYells,msg,true) then return end
	local event = BossYells[msg]
	if event == "Meteor Strike" then
		if self.DB.RaidReporting then
			SendChatMessage("Meteor impact in 7 sec. Run to other side!!", "SAY")
		end
	end
end

-- Player summons Target. [Spell].
function MPR:ReportSummon(Player,Spell,Target)
	self:Report(string.format("%s summons %s. (%s)",unit(Player),unit(Target),spell(Spell)))
end

-- Target summoned. [Spell]
function MPR:ReportBossSummon(Target,Spell)
	self:Report(string.format("%s summoned. (%s)",unit(Target),spell(Spell)))
end

-- Player damages Target with [Spell].
function MPR:ReportDamageOnTarget(Player,Target,Spell)
	self:Report(string.format("%s damages %s with %s.",unit(Player),unit(Target),spell(Spell)))
end

-- Player casts [Spell].
function MPR:ReportCast(Player,Spell)
	self:Report(string.format("%s casts %s.",unit(Player),spell(Spell)))
	if self.DB.RaidReporting then
		SendChatMessage(MPR_ChannelPrefix..Player.." casts "..GetSpellInfo(Spell)..".", "RAID")
	end
end

-- Player casts [Spell] on Target.
function MPR:ReportCastOnTarget(Player,Spell,Target)
	self:Report(string.format("%s casts %s on %s.",unit(Player),spell(Spell),unit(Target)))
	if self.DB.RaidReporting then
		SendChantMessage(MPR_ChannelPrefix..Player.." casts "..GetSpellInfo(Spell).." on "..Target..".", "RAID")
	end
end

-- [Spell] on Target.
function MPR:ReportBossCastOnTarget(Spell,Target)
	self:Report(string.format("%s on %s.",spell(Spell),unit(Target)))
	if self.DB.RaidReporting then
		SendChantMessage(MPR_ChannelPrefix..GetSpellInfo(Spell).." on "..Target..".", "RAID")
	end
end

-- [Spell] applied on Target.
function MPR:ReportAppliedOnTarget(Spell,Target)
	self:Report(string.format("%s applied on %s.",spell(Spell),unit(Target)))
end

-- Target has Amount stacks of [Spell].
function MPR:ReportStacksOnTarget(Target,Spell,Amount)
	self:Report(string.format("%s has %i stacks of %s.",unit(Target),Amount,spell(Spell)))
end

-- Player steals [Spell] from Target.
function MPR:ReportAuraStolen(Player,Spell,Target)
	self:Report(string.format("%s steals %s from %s.",unit(Player),spell(Spell),unit(Target)))
	if self.DB.RaidReporting then
		self:RaidReport(string.format("%s steals %s from %s.",Player,GetSpellInfo(Spell),Target))
	end
end

-- Player dispels [extraSpell] from Target.
function MPR:ReportDispel(Player,Target,extraSpell)
	self:Report(string.format("%s dispels %s from %s.",unit(Player),spell(extraSpell),unit(Target)))
	if self.DB.RaidReporting then
		self:RaidReport(string.format("%s dispels [%s] from %s.",Player,GetSpellInfo(extraSpell),Target))
	end
end

-- Player died.
function MPR:ReportDeath(Player)
	if UnitIsDead(Player) then self:Report(string.format("%s died.",unit(Player))) end
end

-- Player prepares [Spell].
function MPR:ReportSpellCreate(Player,Spell)
	self:Report(string.format("%s prepares %s.",unit(Player),spell(Spell)))
	if self.DB.RaidReporting then
		self:RaidReport(string.format("%s prepares %s.",Player,GetSpellInfo(Spell)))
	end
end

-- [Spell] hits Target for Amount [(Critical)].
function MPR:ReportSpellDamage(Spell,Target,Amount,bCrit)
	local strCrit = bCrit and " (Critical)" or ""
	self:Report(string.format("%s hit %s for %s%s.",spell(Spell),unit(Target),amount(Amount),strCrit))
end
function MPR:ReportSpellPeriodicDamage(Spell,Target,Amount,bCrit)
	local strCrit = bCrit and " (Critical)" or ""
	self:Report(string.format("%s hits %s for %s%s.",spell(Spell),unit(Target),amount(Amount),strCrit))
end

-- [Spell] heals Target for Amount [(Critical)].
function MPR:ReportSpellHeal(Spell,Target,Amount,bCrit)
	local strCrit = bCrit and " (Critical)" or ""
	self:Report(string.format("%s heals %s for %s%s.",spell(Spell),unit(Target),amount(Amount),strCrit))
end
function MPR:ReportSpellPeriodicHeal(Spell,Target,Amount,bCrit)
	local strCrit = bCrit and " (Critical)" or ""
	self:Report(string.format("%s heals %s for %s%s.",spell(Spell),unit(Target),amount(Amount),strCrit))
end

-- Just adds MPR prefix and postfix.
function MPR:Report(msg)
	if not msg then return end
	print(MPR_Prefix..msg..MPR_Postfix)
end

-- Just adds MPR channel prefix
function MPR:RaidReport(msg)
	if not msg then return end
	SendChatMessage(MPR_ChannelPrefix..msg, "RAID")
end

function MPR:Say(msg)
	if not msg then return end
	SendChatMessage(msg, "SAY")
end

--[[-------------------------------------------------------------------------
	Other Methods
---------------------------------------------------------------------------]]

function MPR:BuffHelp()
	self:Report("Use "..colorWhite("/mpr check <buff keyword>").." to list players not having provided buff. Buff keywords:\n"..
	spell(20217)..": bok, gbok; "..spell(48932).." - bom, gbom; "..spell(48936).." - bow, gbow; "..spell(67480).." - bos, gbos; "..
	spell(48469).." - motw, gotw; "..	spell(42995).." - ai, db; "..	spell(57399).." - food, fish")
end

function MPR:ReportWithoutBuff(sBuff)
	if not UnitInRaid(UnitName("player")) then self:Report("Must be in a raid group.") end
	
	local eligibleBuffs = {}
	local buff1 = "empty"
	local buff2 = "empty"
	local buff3 = "empty"
	local idBuff
	if sBuff == "bok" or sBuff == "gbok" then
		buff1 = "Blessing of Kings"
		buff2 = "Greater Blessing of Kings"
		idBuff = 20217
	elseif sBuff == "bom" or sBuff == "gbom" then
		buff1 = "Blessing of Might"
		buff2 = "Greater Blessing of Might"
		idBuff = 48932
	elseif sBuff == "bow" or sBuff == "gbow" then
		buff1 = "Blessing of Wisdom"
		buff2 = "Greater Blessing of Wisdom"
		idBuff = 48936
	elseif sBuff == "bos" or sBuff == "gbos" then
		buff1 = "Blessing of Sanctuary"
		buff2 = "Greater Blessing of Sanctuary"
		idBuff = 67480
	elseif sBuff == "priest1" or sBuff == "pwf" or sBuff == "pof" or sBuff == "fortitude" then
		buff1 = "Power Word: Fortitude"
		buff2 = "Prayer of Fortitude"
		idBuff = 48161
	elseif sBuff == "priest2" or sBuff == "ds" or sBuff == "pos" or sBuff == "spirit" then
		buff1 = "Divine Spirit"
		buff2 = "Prayer of Spirit"
		idBuff = 48073
	elseif sBuff == "priest3" or sBuff == "sp" or sBuff == "psp" or sBuff == "shadow" or sBuff == "shadow protection" then
		buff1 = "Shadow Protection"
		buff2 = "Prayer of Shadow Protection"
		idBuff = 48169
	elseif sBuff == "druid" or sBuff == "motw" or sBuff == "gotw" or sBuff == "mark" or sBuff == "gift" then
		buff1 = "Mark of the Wild"
		buff2 = "Gift of the Wild"
		idBuff = 48469
	elseif sBuff == "mage" or sBuff == "arcane" or sBuff == "ai" or sBuff == "db" then
		buff1 = "Arcane Intellect"
		buff2 = "Arcane Brilliance"
		buff3 = "Dalaran Brilliance"
		idBuff = 42995
	elseif sBuff == "warrior1" or sBuff == "cs" then
		buff1 = "Commanding Shout"
		idBuff = 47440
	elseif sBuff == "food" or sBuff == "fish" then
		buff1 = "Food"
		buff2 = "Well Fed"
		idBuff = 57399
	else
		buff1 = GetSpellInfo(sBuff)
		idBuff = sBuff
	end
	-- Without buff arrays
	local array = {}
	local arrayRaid = {}
	if UnitInRaid(UnitName("player")) then
		for i=1,GetNumRaidMembers() do
			if UnitPowerType("raid"..i) == 0 or (idBuff ~= 48936 and idBuff ~= 42995) then -- BoW and mage buff only for mana classes
				if not UnitBuff(UnitName("raid"..i),buff1) and not UnitBuff(UnitName("raid"..i),buff2) and not UnitBuff(UnitName("raid"..i),buff3) then
					array[#array + 1] = unit(UnitName("raid"..i))
					arrayRaid[#arrayRaid + 1] = UnitName("raid"..i)
				end
			end
		end
	end
	-- Report
	if #array > 0 then
		self:Report(string.format("Without %s: %s", spell(idBuff), table.concat(array, ", ")));
		if self.DB.RaidReporting then
			self:RaidReport(string.format("Without [%s]: %s", GetSpellInfo(idBuff), table.concat(arrayRaid, ", ")));
		end
	else
		self:Report(string.format("Everyone has %s.",spell(idBuff)));
		if self.DB.RaidReporting then
			self:Report(string.format("Everyone has %s.",GetSpellInfo(idBuff)));
		end
	end
end

function MPR:ReportWithoutBuffs()
	if not UnitInRaid(UnitName("player")) then self:Report("You have to be in a raid group.") end
	
	local Paladin = {}
	local raidPaladin = {}
	local Priest = {}
	local raidPriest = {}
	local Druid = {}
	local raidDruid = {}
	local Mage = {}
	local raidMage = {}
	local Warrior = {}
	local raidWarrior = {}
	
	for i=1,GetNumRaidMembers() do
		local Player = UnitName("raid"..i)
		local Class = UnitClass(Player)
		if Class == "Paladin" then
			table.insert(Paladin,unit(Player))
			table.insert(raidPaladin,Player)
		elseif Class == "Priest" then
			table.insert(Priest,unit(Player))
			table.insert(raidPriest,Player)
		elseif Class == "Druid" then
			table.insert(Druid,unit(Player))
			table.insert(raidDruid,Player)
		elseif Class == "Mage" then
			table.insert(Mage,unit(Player))
			table.insert(raidMage,Player)
		elseif Class == "Warrior" then
			table.insert(Warrior,unit(Player))
			table.insert(raidWarrior,Player)
		end
	end
	
	local NoClassInRaid = {}
	if #Paladin == 0 then
		table.insert(NoClassInRaid,"Paladin")
	elseif #Paladin > 0 then --bok
		self:Report(string.format("Available Paladins: %s", table.concat(Paladin, ", ")));
		if self.DB.RaidReporting then
			self:RaidReport(string.format("Available Paladins: %s", table.concat(raidPaladin, ", ")));
		end
		self:ReportWithoutBuff("bok")
		
		if #Paladin > 1 then --bom,bow
			self:ReportWithoutBuff("bom")
			self:ReportWithoutBuff("bow")
		end
	end
	
	if #Priest == 0 then
		table.insert(NoClassInRaid,"Priest")
	elseif #Priest > 0 then --fortitude,spirit,shadow protection
		self:Report(string.format("Available Priests: %s", table.concat(Priest, ", ")));
		if self.DB.RaidReporting then
			self:RaidReport(string.format("Available Priests: %s", table.concat(raidPriest, ", ")));
		end
		self:ReportWithoutBuff("fortitude")
		self:ReportWithoutBuff("spirit")
		self:ReportWithoutBuff("shadow protection")
	end
	
	if #Druid == 0 then
		table.insert(NoClassInRaid,"Druid")
	elseif #Druid > 0 then --motw
		self:Report(string.format("Available Druids: %s", table.concat(Druid, ", ")));
		if self.DB.RaidReporting then
			self:RaidReport(string.format("Available Druids: %s", table.concat(raidDruid, ", ")));
		end
		self:ReportWithoutBuff("motw")
	end
	
	if #Mage == 0 then
		table.insert(NoClassInRaid,"Mage")
	elseif #Mage > 0 then --ai
		self:Report(string.format("Available Mages: %s", table.concat(Mage, ", ")));
		if self.DB.RaidReporting then
			self:RaidReport(string.format("Available Mages: %s", table.concat(raidMage, ", ")));
		end
		self:ReportWithoutBuff("ai")
	end
	
	if #Warrior == 0 then
		table.insert(NoClassInRaid,"Warrior")
	elseif #Warrior > 0 then --cs
		self:Report(string.format("Available Warriors: %s", table.concat(Warrior, ", ")));
		if self.DB.RaidReporting then
			self:RaidReport(string.format("Available Warriors: %s", table.concat(raidWarrior, ", ")));
		end
		self:ReportWithoutBuff("cs")
	end
	
	if #NoClassInRaid > 0 then
		self:Report("Missing classes in raid: "..table.concat(NoClassInRaid,", "));
		if self.DB.RaidReporting then
			self:RaidReport("Missing classes in raid: "..table.concat(NoClassInRaid,", "));
		end
	end
end

function MPR:ReportLocks(Player)
	local locks = {}
	for i=1,GetNumSavedInstances() do
		local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i)
		if isRaid and InstanceShortNames[name] then
			table.insert(locks, string.format("%s %s (%i)",InstanceShortNames[name],RaidDifficulty[difficulty],id))
		end
	end
	if #locks > 0 then
		SendChatMessage("Raid Locks: "..table.concat(locks,", "), "WHISPER", nil, Player);
	else
		SendChatMessage("No Raid Locks.", "WHISPER", "Common", Player);
	end
end

function MPR:CHAT_MSG_ADDON(prefix, msg, channel, sender)
	if prefix ~= "MPR" or sender == UnitName("player") then return end
	if msg == "request-version" then
		SendAddonMessage("MPR", "version:"..MPR_Version, "WHISPER", sender)
	elseif msg:sub(1, 8) == "version:" then
		local sender_version = msg:sub(10, 10)..msg:sub(12, 13)
		local player_version = MPR_Version:sub(2,2)..MPR_Version:sub(4,5)	
		if not self:IsTimerScheduled("Report Users") then self:ScheduleTimer("Report Users",report,0.5,true) end
		if player_version >= sender_version then 
			table.insert(usersAddon, string.format("%s (%s)",unit(sender),msg:sub(9, 13)))
			return
		end
		table.insert(usersAddon, string.format("%s (|cFF00FF00%s|r)",unit(sender),msg:sub(9, 13)))
		if reportedNewerVersion then return end
		reportedNewerVersion = true
		self:Report(string.format("|cFF00FF00A newer version is available!|r"))
 	end
end

function MPR:ZONE_CHANGED_NEW_AREA()
	--local zoneName = GetRealZoneText()
	--local zoneId = GetCurrentMapAreaID()
end

function MPR:ADDON_LOADED(addon)
	if addon ~= "MPR" then return end
	SendAddonMessage("MPR", "request-version", "GUILD")
	MPR_DB = MPR_DB or { Reporting = true, ClearEntriesOnLoad = true, IconsEnabled = false, RaidReporting = false,
						SayMessages = true, ReportAuraStolen = true, ReportDispels = true, ReportMassDispels = true,
						ReportDeaths = true}
	self.DB = MPR_DB
	SLASH_MPR1 = '/mpr';
	print("|cFF1e90ffMP Reporter|r |cFFbebebe("..MPR_Version..") loaded! Reporting is |r"..getStateColor(self.DB.Reporting).."|cFFbebebe. Use "..colorWhite("/mpr help").." to list commands.|r")
	if self.DB.ClearEntriesOnLoad then
		self:ClearCombatLog(true)
	end
	self:RegisterEvents()
end

MPR:RegisterEvent("ADDON_LOADED")