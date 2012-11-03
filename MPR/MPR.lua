MPR = CreateFrame("frame","MPRFrame")
local MPR_Version = "v2.40b"
local Colors = {["TITLE"] = "1e90ff", ["TEXT"] = "bebebe", ["DKPDEDUCTION_LINK"] = "ff4400", ["BOSS"] = "ffffff"}
local MPR_Prefix = "|cFF"..Colors["TITLE"].."|HMPR:Options:Show:nil|h[MP Reporter]|h:|r |cFF"..Colors["TEXT"]
local MPR_Postfix = "|r"
local MPR_ChannelPrefix = "<MPR> "
local ClassColors = {["DEATHKNIGHT"] = "C41F3B", ["DEATH KNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA",
					["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9",	["WARRIOR"] = "C79C6E"}
local InstanceShortNames = {["Icecrown Citadel"] = "ICC",["Vault of Archavon"] = "VOA",["Trial of the Crusader"] = "TOC",["Naxxramas"] = "NAXX",["Ruby Sanctum"] = "RS"}
local BossNames = {
	-- Icecrown CitaFdel
	"Lord Marrowgar", "Lady Deathwhisper", "Deathbringer Saurfang", "Rotface", "Festergut", "Professor Putricide", 
	"Prince Keleseth", "Prince Valanar", "Prince Taldaram", "Queen Lana'thel", "Valithria Dreamwalker", "Sindragosa", "The Lich King",
	-- Trial of the Crusader
	"Gormok", "Acidmaw", "Dreadscale", "Icehowl", "Jaraxxus", "Gorgrim Shadowcleave", "Birana Stormhoof", "Erin Misthoof", 
	"Ruj'kah", "Ginselle Blightslinger", "Liandra Suncaller", "Malithas Brightblade", "Caiphus the Stern", "Vivienne Blackwhisper", 
	"Maz'dinah", "Thrakgar", "Broln Stouthorn", "Harkzog", "Narrhok Steelbreaker", "Fjola Lightbane", "Eydis Darkbane", "Anub'arak",
	-- Ruby Sanctum
	"Baltharus the Warborn", "Saviana Ragefire", "General Zarithrian", "Halion",
}
local EncounterStartYells = {
	-- ICC
	["The Scourge will wash over this world as a swarm of death and destruction!"] = 1,
	["What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!"] = 2,
	["GB"] = 3,
	["BY THE MIGHT OF THE LICH KING!"] = 4,
	["Fun time!"] = 5,
	["WEEEEEE!"] = 6,
	["Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"] = 7,
	["Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!"] = 8,
	["You have made an... unwise... decision."] = 9,
	["Heroes, lend me your aid! I... I cannot hold them off much longer! You must heal my wounds!"] = 10,
	["You are fools to have come to this place. The icy winds of Northrend will consume your souls!"] = 11,
	["You were fools to have come to this place. The icy winds of Northrend will consume your souls!"] = 11,
	["I'll keep you alive to witness the end, Fordring. I would not want the Light's greatest champion to miss seeing this wretched world remade in my image."] = 12,
	-- TOC
	["You face Jaraxxus, eredar lord of the Burning Legion!"] = 16,
	["In the name of our dark master. For the Lich King. You. Will. Die."] = 18,
	-- RS
	["You will sssuffer for this intrusion!"] = 20,
	["Ah, the entertainment has arrived."] = 21,
	["Alexstrasza has chosen capable allies... A pity that I must END YOU!"] = 22,
	["Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!"] = 23,
	
	-- test Naxx
	["Glory to the master!"] = 100,
	["Your life is forfeit."] = 100,
	["Die, trespasser!"] = 100,
}
local EncounterDoneYells = {
	-- test Naxx
	["I will serve the master... in death."] = 100,
	-- ICC
	["I see... Only darkness."] = 1,
	["All part of the Master's plan.... Your end is inevitable...."] = 2,
	["I... Am... Released..."] = 4,
	["Da ... Ddy..."] = 5,
	["Bad news, daddy..."] = 6,
	["Bad news, everyone... I don't think I'm going to make it..."] = 7,
	["My queen, they... come."] = 8,
	["But... we were getting along... so... well..."] = 9,
	["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = 10,
	["Free... at last...."] = 11,
	["Is it truly righteousness that drives you? I wonder..."] = 12,
}
local EncounterNames = {
	-- ICC
	[1] = "Lord Marrowgar",	[2] = "Lady Deathwhisper", [4] = "Deathbringer Saurfang", [5] = "Rotface", [6] = "Festergut", [7] = "Professor Putricide",
	[8] = "Blood Prince Council", [9] = "Queen Lana'thel", [10] = "Valithria Dreamwalker", [11] = "Sindragosa", [12] = "The Lich King",
	-- TOC
	[13] = "Gormok", [14] = "Acidmaw & Dreadscale", [15] = "Icehowl", [16] = "Jaraxxus", [17] = "Faction Champions", [18] = "Twin Val'kyr", [19] = "Anub'arak",
	-- RS
	[20] = "Baltharus the Warborn", [21] = "Saviana Ragefire", [22] = "General Zarithrian", [23] = "Halion",
}
local BossYells = {
	["Watch as the world around you collapses!"]				= "Quake! Run inside!!",
	["The heavens burn!"]										= "Meteor impact in 7 sec. Run to other side!!",
	["I think I made an angry poo-poo. It gonna blow!"]			= "Ooze Explosion in 4 sec. Run away!!",
	["We're taking hull damage, get a battle-mage out here to shut down those cannons!"] = "MAGE SPAWNED!!",
	["We're taking hull damage, get a sorcerer out here to shut down those cannons!"] = "MAGE SPAWNED!!",
}
local BossRaidYells = {
	["I think I made an angry poo-poo. It gonna blow!"]			= "OOZE EXPLOSION! Run away!!",
	["We're taking hull damage, get a battle-mage out here to shut down those cannons!"] = "MAGE SPAWNED on Horde ship! Kill him!!",
	["We're taking hull damage, get a sorcerer out here to shut down those cannons!"] = "MAGE SPAWNED on Alliance ship! Kill him!!",
	["Rocketeers, reload!"] = "Rocketeers spawned! Kill them!!",
	["Mortar team, reload!"] = "Soldiers spawned! Kill them!!",
}
local RaidDifficulty = {[1] = "10n",[2] = "25n",[3] = "10h",[4] = "25h"}

local ClassBIS = {
--	["Class"] = {
--		["Spec1"] = {ItemName1, ItemName2, ItemName3},
--		["Spec2"] = {...},
--		["Spec3"] = {...},
--	}
	["Paladin"] = {
		["Retribution"] = {"Penumbra Pendant", "Shadowvault Slayer's Cloak", "Polar Bear Claw Bracers", "Umbrage Armbands", "Fleshrending Gauntlets", "Astrylian's Sutured Cinch", "Apocalypse's Advance", "Signet of Twilight", "Sharpened Twilight Scale", "Tiny Abomination in a Jar", "Oathbinder, Charge of the Ranger-General"},
		["Holy"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Mail of Crimson Coins", "Bracers of Fiery Night", "Unclean Surgical Gloves", "Split Shape Belt", "Plaguebringer's Stained Pants", "Foreshadow Steps", "Marrowgar's Frigid Eye", "Solace of the Defeated", "Bulwark of Smouldering Steel", "Bloodsurge, Kel'Thuzad's Blade of Agony"},
		["Protection"] = {"Bile-Encrusted Medallion", "Sentinel's Winter Cloak", "Gargoyle Spit Bracers", "Verdigris Chain Belt", "Pillars of Might", "Grinning Skull Greatboots", "Devium's Eternally Cold Ring", "Band of the Twin Val'kyr", "Satrina's Impeding Scarab", "Sindragosa's Flawless Fang", "Mithrios, Bronzebeard's Legacy", "Icecrown Glacial Wall"},
	},
	["Priest"] = {
		["Shadow"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Ring of Rapid Ascent", "Dislodged Foreign Object", "Phylactery of the Nameless Lich", "Royal Scepter of Terenas II", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
		["Holy"] = {"Sentinel's Amulet", "Greatcloak of the Turned Champion", "Sanguine Silk Robes", "Death Surgeon's Sleeves", "Circle of Ossus", "Boots of the Mourning Widow", "Memory of Malygos", "Solace of the Defeated", "Althor's Abacus", "Frozen Bonespike", "Sundial of Eternal Dusk", "Nightmare Ender"},
		["Discipline"] = {},
	},
	["Rogue"] = {
		["Assassination"] = {"Sindragosa's Cruel Claw", "Cultist's Bloodsoaked Spaulders", "Shadowvault Slayer's Cloak", "Ikfirus' Sack of Wonder", "Umbrage Armbands", "Belt of the Merciless Killer", "Frostbitten Fur Boots", "Band of the Bone Colossus", "Tiny Abomination in a Jar", "Herkuml War Token", "Heaven's Fall, Kryss of a Thousand Lies", "Lungbreaker", "Gluth's Fetching Knife"},
		["Combat"] = {"Sindragosa's Cruel Claw", "Shadowvault Slayer's Cloak", "Ikfirus' Sack of Wonder", "Toskk's Maximized Wristguards", "Aldriana's Gloves of Secrecy", "Astrylian's Sutured Cinch", "Gangrenous Leggings", "Frostbrood Sapphire Ring", "Deathbringer's Will", "Whispering Fanged Skull", "Bloodvenom Blade", "Scourgeborne Waraxe", "Stakethrower"},
	},	
	["Shaman"] = {
		["Restoration"] = {"Blood Queen's Crimson Choker", "Frostbinder's Shredded Cape", "Bloodsunder's Bracers", "Crushing Coldwraith Belt", "Plague Scientist's Boots", "Ring of Rapid Ascent","Althor's Abacus", "Glowing Twilight Scale", "Trauma", "Bulwark of Smouldering Steel"},
		["Enhancement"] = {"Precious' Putrid Collar", "Shadowvault Slayer's Cloak", "Umbrage Armbands", "Anub'ar Stalker's Gloves", "Nerub'ar Stalker's Cord", "Returning Footfalls", "Band of the Bone Colossus", "Sharpened Twilight Scale", "Havoc's Call, Blade of Lordaeron Kings"},
		["Elemental"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Gunship Captain's Mittens", "Split Shape Belt", "Plaguebringer's Stained Pants", "Plague Scientists Boots", "Ring of Rapid Ascent", "Dislodged Foreign Object", "Charred Twilight Scale", "Phylactery of the Nameless Lich", "Royal Scepter of Terenas II", "Bulwark of Smouldering Steel"},
	},
	["Druid"] = {
		["Restoration"] = {"Bone Sentinel's Amulet", "Greatcloak of the Turned Champion", "Sanguine Silk Robes", "Bracers of Eternal Dreaming", "Professor's Bloodied Smock", "Memory of Malygos", "Solace of the Defeated", "Althor's Abacus", "Trauma", "Sundial of Eternal Dusk"},
		["Feral-D."] = {"Sindragosa's Cruel Claw", "Toskk's Maximized Wristguards", "Aldriana's Gloves of Secrecy", "Astrylian's Sutured Cinch", "Frostbrood Sapphire Ring", "Deathbringer's Will", "Sharpened Twilight Scale", "Oathbinder, Charge of the Ranger-General"},
		["Feral-T."] = {"Royal Crimson Cloak", "Ikfirus's Sack of Wonder", "Footpads of Impending Death", "Devium's Eternally Cold Ring", "Bloodfall", "Frostbitten Fur Boots", "Bile-Encrusted Medallion", "Sindragosa's Flawless Fang", "Umbrage Armbands", "Astrylian's Sutured Cinch"},	
		["Balance"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Valanar's Other Signet Ring", "Royal Scepter of Terenas II", "Shadow Silk Spindle"},
	},
	["Death Knight"] = {
		["Blood-D."] = {"Lana'thel's Chain of Flagellation", "Winding Sheet", "Polar Bear Claw Bracers", "Coldwraith Links", "Blood-Soaked Saronite Stompers", "Might of Blight", "Deathbringer's Will", "Death's Choice", "Bryntroll, the Bone Arbiter"},
		["Unholy-D."] = {"Scourge Reaver's Legplates", "Lana'thel's Chain of Flagellation", "Winding Sheet", "Polar Bear Claw Bracers", "Coldwraith Links", "Blood-Soaked Saronite Stompers", "Might of Blight", "Deathbringer's Will", "Death's Choice", "Oathbinder, Charge of the Ranger-General"},
		["Frost-D."] = {"Fleshrending Gauntlets", "Lana'thel's Chain of Flagellation", "Winding Sheet", "Polar Bear Claw Bracers", "Coldwraith Links", "Blood-Soaked Saronite Stompers", "Might of Blight", "Deathbringer's Will", "Death's Choice", "Havoc's Call, Blade of Lordaeron Kings"},
	},
	["Hunter"] = {
		["Marksmanship"] = {"Sindragosa's Cruel Claw", "Toskk's Maximized Wristguards", "Nerub'ar Stalker's Cord", "Leggings of Northern Lights", "Frostbrood Sapphire Ring", "Sharpened Twilight Scale", "Deathbringer's Will", "Oathbinder, Charge of the Ranger-General", "Fal'inrush, Defender of Quel'thalas"},
	},
	["Mage"] = {
		["Fire"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Robe of the Waking Nightmare", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Phylactery of the Nameless Lich", "Charred Twilight Scale", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
		["Arcane"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dusk", "Bracers of Fiery Night", "San'layn Ritualist Gloves", "Crushing Coldwraith Belt", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Charred Twilight Scale", "Dislodged Foreign Object", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
	},
	["Warlock"] = {
		["Affliction"] = {"Blood Queen's Crimson Choker", "Frostbinder's Shredded Cape", "The Lady's Brittle Bracers", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Memory of Malygos", "Dislodged Foreign Object", "Phylactery of the Nameless Lich", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
		["Demonology"] = {},
		["Destruction"] = {"Sanctified Dark Coven Hood", "Amulet of the Silent Eulogy", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Valanar's Other Signet Ring", "Dislodged Foreign Object", "Charred Twilight Scale", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
	},
	["Warrior"] = {
		["Fury"] = {"Lana'thel's Chain of Flagellation", "Shawl of Nerubian Silk", "Toskk's Maximized Wristguards", "Aldriana's Gloves of Secrecy", "Astrylian Suttered Cinch", "Frostbitten Fur Boots", "Frostbrood Saphire Ring", "Sharpened Twilight Scale", "Deathbringer's Will", "Cryptmaker", "Stakethrower"},
		["Protection"] = {"Troggbane, Axe of the Frostborne King", "Icecrown Glacial Wall", "Bile-Encrusted Medallion", "Royal Crimson Cloak", "Bracers of Dark Reckoning", "Taldaram's Plated Fists", "Grinning Skull Greatboots", "Juggernaut Band", "Sindragosa's Flawless Fang", "Dreamhunter's Carbine"},
	},
}

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
--| Filter: UnitIsPlayer(Target)
local spellsAOEDamage = {"Dark Martyrdom", "Shadow Cleave", "Deathchill Blast", "Vengeful Blast","Unstable Ooze Explosion", "Malleable Goo", "Choking Gas Explosion", "Frost Bomb", "Blistering Cold", "Defile", "Shadow Trap", "Trample"}
--| Output: Player damages Target with [Spell]. |--
local reportDamageOnTarget = {}

-- Summons (SPELL_SUMMON) --
--| Output: Unit summons Target. [Spell] |--
local npcsSpellSumon = {"Slime Pool"}
--| Output: Target summoned. [Spell] |--
local npcsBossSpellSumon = {"Vengeful Shade"} -- Boss summons, destination is unknown. ("Dark Nucleus" summoned every second - spam)

-- Casts (SPELL_CAST_START and SPELL_CAST_SUCCESS) --
--| Output: Unit casts [Spell]. |--
local spellsCast = {"Remorseless Winter", "Quake", "Dark Vortex", "Light Vortex", "Blessing of Forgotten Kings", "Runescroll of Fortitude", "Drums of the Wild"}
--| Output: Unit casts [Spell] on Target. |--
local spellsCastOnTarget = {"Hand of Protection"}
--| Output: [Spell] on Target. |--
local spellsBossCastOnTarget = {"Rune of Blood", "Vile Gas", "Swarming Shadows", "Necrotic Plague", "Soul Reaper"} -- If sourceName isn't important (ex. Boss casting).

-- Auras (SPELL_AURA_APPLIED, SPELL_AURA_APPLIED_DOSE, SPELL_AURA_STOLEN) --
--| Output: [Spell] applied on Target. |--
--| Filter: UnitIsPlayer(Target)
local aurasAppliedOnTarget = {"Volatile Ooze Adhesive", "Gaseous Bloat", "Unbound Plague", "Soul Consumption", "Fiery Combustion"}
--| Output: [Spell] applied on Target1, Target2, Target3 ... |--
local aurasAppliedOnTargets = {"Impaled", "Gas Spore", "Vile Gas", "Frost Beacon"} 
-- MPR.DB.SayYells = true
local sayAuraOnMe = {
	["Impaled"] = "Bone Spike on me! Kill it fast!!",
	["Dominate Mind"] = "Dominate Mind on me! Don't kill me!!",
	["Volatile Ooze Adhesive"] = "Green on me!",
	["Gaseous Bloat"] = "Orange on me!",
	["Essence of the Blood Queen"] = "I was biten!",
	["Frenzied Bloodthirst"] = "I have to bite!!",
	["Frost Beacon"] = "Frost Beacon on me!",
}
--| Output: Target has Amount stacks of [Spell]. |--
local stackAppliedOnTarget = {"Unstable Ooze", "Cleave Armor"}
--| Output: Player steals [Spell] from Target. |--
-- MPR.DB.ReportAurasStolen = true

-- Dispeling --
--| Output: Player dispels Target. [extraSpell] |--
-- MPR.DB.ReportDispels = true
--| Output: Player mass-dispels Target1 ([extraSpell1]), Target2 ([extraSpell2]), Target3 ([extraSpell3]) ... |--
-- MPR.DB.ReportMassDispels = true
--------------------------------------------

-- Addon Variables --
local usersAddon = {}
local reportedNewerVersion = false
-- Combat Varriables --
local casterHeroism = {}
local targetsHeroism = {}
local nameSpellAOEDamage
local targetsAOEDamage = {}
local targetsSpellAOEDamage = {}
local targetsAura = {}
local casterMassDispel
local targetsMassDispel = {}
-- Boss Variables --
--Blood-Queen Lana'thel
local BS_TargetsName = {}
local BS_TargetsAmount = {}
--------------------------------------------

local DBM_Users = {}

local Events = {
	"ZONE_CHANGED_NEW_AREA",
	"COMBAT_LOG_EVENT_UNFILTERED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_ADDON",
	"CHAT_MSG_WHISPER",
	"RAID_ROSTER_UPDATE",
	"LOOT_OPENED",
}

MPR:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

------------------
--  Hyperlinks  --
------------------
do
	DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3, arg4 = strsplit(":", link)
		if linkType ~= "MPR" then return end
		if arg1 == "Options" then
			if arg2 == "Show" then
				MPR_Options:Show()
			end
		elseif arg1 == "AuraInfo" then
			if arg2 == "Update" then
				MPR_AuraInfo:UpdateFrame(tonumber(arg3))
			elseif arg2 == "ICC" then
				MPR_AuraInfo:UpdateFrame(tonumber(arg3))
			elseif arg2 == "TOC" then
				MPR_AuraInfo:UpdateFrame(tonumber(arg3))
			end
		elseif arg1 == "DeductDKP" then
			arg2 = {strsplit("-",arg2)}
			arg4 = arg4:gsub("{(.-)}", function(a) return GetSpellLink(tonumber(a)) end)
			MPR:DKPDeductionHandler(arg2,tonumber(arg3),arg4)
		elseif arg1 == "DeathReport" then
			MPR:DeathReport(arg2, arg3)
		end
	end)
end

do
	local old = ItemRefTooltip.SetHyperlink -- we have to hook this function since the default ChatFrame code assumes that all links except for player and channel links are valid arguments for this function
	function ItemRefTooltip:SetHyperlink(link, ...)
		if link:match("^MPR") then return end
		return old(self, link, ...)
	end
end

--[[-------------------------------------------------------------------------
	Local Methods
---------------------------------------------------------------------------]]

function numformat(Number)
	-- Number formating
	if strlen(Number) > 3 then
		return string.sub(Number, 1, -4).."k"
	else
		return Number
	end
end

function contains(array, element, ...)
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

function RemoveByKey(tbl,key)
	table.remove(tbl,key)
end

function RemoveByValue(tbl,key)
	for i,v in pairs(tbl) do
		if v == key then
			table.remove(tbl,i)
			return
		end
	end
end

function colorWhite(str)
	return string.format("|r|cFFffffff%s|r|cFF%s",str,Colors["TEXT"])
end

function report(TimerName, ...)
	if TimerName == "Report Users" then
		MPR:SelfReport(string.format("Online guild members using addon: %s",table.concat(usersAddon, ", ")))
		table.wipe(usersAddon)
	else
		MPR:SelfReport(...)
	end
end

function unit(name)
	if name then
		local class = select(2, UnitClass(name)) or select(6, MPR:GetGuildMemberInfo(name))
		if class then
			return string.format("|r|cFF%s|Hplayer:%s|h[%s]|h|r|cFF%s",ClassColors[strupper(class)],name,name,Colors["TEXT"])
			--return string.format("|Hplayer:%s|h[|r|cFF%s%s|r|cFF%s]|h",name,ClassColors[select(2, UnitClass(name))],name,Colors["TEXT"])
		elseif contains(BossNames,name) then
			return "|r|cFFff8c00"..name.."|r|cFF"..Colors["TEXT"]
		else
			return colorWhite(name)
		end
	else
		return "unknown"
	end
end

function WarnLink(Target,String)
	return "|Hplayer:"..name.."|h[Warn Him]|h"
end

function spell(id, ...)
	local bRaid = ...
	if bRaid then return GetSpellLink(id) end
	if type(id) ~= "number" then return id end
	if MPR.Settings["ICONS"] and select(3, GetSpellInfo(id)) then
		return string.format("\124T%s:12:12:0:0:64:64:5:59:5:59\124t |r%s|cFF%s",select(3, GetSpellInfo(id)),GetSpellLink(id),Colors["TEXT"])
	else
		return string.format("|r%s|cFF%s",GetSpellLink(id),Colors["TEXT"])
	end
end

function getStateColor(state) 
	if state then
		return "|r|cFF00FF00enabled|r|cFF"..Colors["TEXT"]
	else
		return "|r|cFFFF0000disabled|r|cFF"..Colors["TEXT"]
	end
end

function GetGold(str)
	for l=1,5 do
		if str:sub(l+2,l+5) == "Gold" then return tonumber(str:sub(1,l)) end
	end
	return 0
end

--[[-------------------------------------------------------------------------
	Timer System
---------------------------------------------------------------------------]]

local lib = DongleStub("Dongle-1.2"):New("MP Reporter")

function MPR:ScheduleTimer(name, func, delay, ...)
	lib:ScheduleTimer(name, func, delay, ...)
end

function MPR:IsTimerScheduled(name)
	return lib:IsTimerScheduled(name)
end

function MPR:CancelTimer(name)
	lib:CancelTimer(name)
end

local function TimerHandler(name, ...)
	if name == "Spell AOE Damage" then
		local SPELL = ...
		local SpellName = GetSpellInfo(SPELL)
				
		local Targets = {}
		local arraySelf = {}
		local arrayRaid = {}
		
		for Target,Amount in pairs(targetsSpellAOEDamage) do
			table.insert(Targets,Target)
			table.insert(arraySelf,unit(Target).." ("..numformat(Amount)..")")
			table.insert(arrayRaid,Target.." ("..numformat(Amount)..")")
		end
		nameSpellAOEDamage = nil
		table.wipe(targetsSpellAOEDamage)
		
		--[[
		local DKPPenaltyData = MPR.DKPPenalties[SpellName] or nil
		local DKPPenaltyLink = ""
		
		
		if CanEditOfficerNote() and DKPPenaltyData and DKPPenaltyData[1] and DKPPenaltyData[2] > 0 then 
			if MPR.Settings["DKPPENALTIES_AUTO"] then
				MPR:DKPDeductionHandler(Targets,DKPPenaltyData[2],"Hit by "..GetSpellLink(SPELL))
			else
				DKPPenaltyLink = MPR:DeductDKPLink(Targets, DKPPenaltyData[2], "Hit by {"..SPELL.."}")
			end
		end
		]]
		
		MPR:HandleReport(string.format("%s hits: %s",spell(SPELL,true),table.concat(arrayRaid,", ")), string.format("%s hits: %s",spell(SPELL),table.concat(arraySelf,", ")))
	elseif name == "Aura Targets" then
		local SPELL = ...
		local array = {}
		local arrayRaid = {}
		for _,Target in pairs(targetsAura) do
			table.insert(array,unit(Target))
			table.insert(arrayRaid,Target)
		end
		table.wipe(targetsAura)
		MPR:HandleReport(string.format("%s on: %s",spell(SPELL,true),table.concat(arrayRaid,", ")), string.format("%s on: %s",spell(SPELL),table.concat(array,", ")))
	elseif name == "Heroism" then
		local SPELL = ...
		if #targetsHeroism > 0 then
			MPR:HandleReport(string.format("%s casts %s (%i/%i players affected)",casterHeroism,spell(SPELL,true),#targetsHeroism,GetNumRaidMembers()), string.format("%s casts %s (%i/%i players affected)",unit(casterHeroism),spell(SPELL),#targetsHeroism,GetNumRaidMembers()))
		else
			MPR:ReportCast(casterHeroism,SPELL)
		end
		casterHeroism = nil
		table.wipe(targetsHeroism)
	elseif contains(spellsCreate,name,true) then
		local SPELL = ...
		MPR:HandleReport(string.format("%s expires in 30 seconds.",spell(SPELL,true)), string.format("%s expires in 30 seconds.",spell(SPELL)))
	elseif name == "Bloodbolt Splash" then
		local SPELL = ...
		local self = {}
		local raid = {}
		for i, TARGET in pairs(BS_TargetsName) do
			local AMOUNT = BS_TargetsAmount[i]
			table.insert(self,string.format("%s (%s)",unit(TARGET),numformat(AMOUNT)))
			table.insert(raid,string.format("%s (%s)",TARGET,numformat(AMOUNT)))
		end
		table.wipe(BS_TargetsName)
		table.wipe(BS_TargetsAmount)
		--MPR:HandleReport(string.format("Range fail (6 yd) - %s hits: %s",spell(SPELL,true),table.concat(raid,", ")), string.format("Range fail (6 yd) - %s hits: %s",spell(SPELL),table.concat(self,", ")))
	end
end

--[[-------------------------------------------------------------------------
	Boss Methods
---------------------------------------------------------------------------]]

local function BPC_ChangeTarget(Prince)
	MPR:RaidWarning(string.format("Switch target to: %s", Prince))
	MPR:HandleReport(string.format("Switch target to: %s", Prince), string.format("Switch target to: %s", unit(Prince)))
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
	self:SelfReport("Combat log entries cleared.")
end

function round(num, idp, ...)
	local up = ...
	local mult = 10^(idp or 0)
	return math.floor(num * mult + (up and 0.99 or 0.5)) / mult
end


local PingTarget, PingTime

function SlashCmdList.MPR(msg, editbox)
	msg = strlower(msg)
	if type(tonumber(msg)) == "number" then
		MPR_AuraInfo:UpdateFrame(tonumber(msg))
	elseif msg == "ai" then
		MPR:SelfReport("Instance: |r|cff3588ff|HMPR:AuraInfo:ICC:1|h[Icecrown Citadel]|h "..
											 "|HMPR:AuraInfo:TOC:13|h[Trial of the Crusader]|h "..
											 "|HMPR:AuraInfo:TOC:20|h[Ruby Sanctum]|h ".."|r")		
	elseif msg == "dbm raid" then
		table.wipe(DBM_Users)
		MPR:SelfReport("Reporting DBM (v4) users in 5 seconds ...", true)
		SendAddonMessage("DBMv4-Ver", "Hi!", "RAID")
		MPR:ScheduleTimer("Report DBM Users",TimerHandler,5)
	elseif msg == "ccl" or msg == "clear" then
		MPR:ClearCombatLog()
	elseif msg:sub(1,4) == "ping" then
		msg = msg:sub(6)
		if msg == "raid" then
			--SendAddonMessage("DBMv4-Ver", "Hi!", "RAID")
		elseif UnitInRaid(msg) then
			PingTarget, PingTime = msg, GetTime()
			SendAddonMessage("DBMv4-Ver", "Hi!", msg:gsub("^%l", string.upper))
		else
			MPR:SelfReport("Player '"..msg.."' is not in your raid.", true)
		end
	elseif msg ~= "" then
		MPR:SelfReport("Unknown command.")
	else -- Options
		if not MPR_Options:IsVisible() then
			MPR_Options:Show()
		else
			MPR_Options:Hide()
		end
	end
end

function MPR:CHAT_MSG_WHISPER(...)
	local Message, Player = ...
	Message = strlower(Message)
	if Message == "raidlocks" or Message == "raid locks" then
		self:ReportLocks(Player)
	end
end

local rrInformed = false
function MPR:RAID_ROSTER_UPDATE(...)
	if UnitInRaid("player") then
		if not self.Settings["RAID"] or rrInformed then return end
		rrInformed = true
		self:SelfReport("Raid Reporting is "..getStateColor(self.Settings["RAID"])..". It is recommended that only one member is reporting to RAID channel to prevent spam.")
	else -- not in raid = left raid?
		rrInformed = false
	end
end

local LootedCreatures = {}
function MPR:LOOT_OPENED()
	if not UnitInRaid("player") or not self.Settings["REPORT_LOOT"] then return end
	local LootMethod, _, MasterLooterRaidID = GetLootMethod()
	if LootMethod == "master" and MasterLooterRaidID and UnitName("player") == UnitName("raid"..MasterLooterRaidID) then
		local guid = tonumber(string.sub(UnitGUID("target"),6),16)
		if contains(LootedCreatures,guid) then return end
		table.insert(LootedCreatures,guid)
		
		local BossName = (contains(BossNames,UnitName("target")) or not UnitPlayerOrPetInRaid("target")) and UnitName("target") or "unknown"
		local Gold = GetGold(select(2,GetLootSlotInfo(1)))
		local WorthGold	= Gold > 0 and " ("..Gold.." Gold)" or ""
		local ItemLinks = {}
		local BoPs = false
		for i=1,GetNumLootItems() do
			local _, Name, _, Rarity, _ = GetLootSlotInfo(i);
			if Rarity >= 3 then -- Uncommon/green (2), Rare/blue (3), Epic/purple (4), ...
				-- make BiS list
				local bisClasses = {}
				if self.Settings["REPORT_LOOT_BIS_INFO"] then
					for Class,Specs in pairs(ClassBIS) do
						local bisSpecs = {}
						for Spec,Items in pairs(Specs) do
							if contains(Items,Name) then
								table.insert(bisSpecs,Spec:sub(1,3).."."..(Spec:sub(1,5) == "Feral" and select(2,strsplit(Spec,"-")) or ""))
							end
						end
						if #bisSpecs > 0 then table.insert(bisClasses,Class.." ("..table.concat(bisSpecs,", ")..")") end
					end
				end
				table.insert(ItemLinks, GetLootSlotLink(i)..(#bisClasses > 0 and " BiS: "..table.concat(bisClasses," ") or ""))
				if select(5,GetLootRollItemInfo(i-1)) then BoPs = true end
			end
		end
		local NotEligible = {}
		if BoPs then -- Check who is not eligible to loot BoP items.
			local Eligible = {}
			for i=1,40 do
				if GetMasterLootCandidate(i) then table.insert(Eligible, GetMasterLootCandidate(i)) end
			end
			for i=1,GetNumRaidMembers() do
				local Member = UnitName("raid"..i)
				if not contains(Eligible,Member) then table.insert(NotEligible,Member) end
			end
		end
		if #ItemLinks > 0 and (BoPs or not self.Settings["REPORT_LOOT_BOP_ONLY"]) then
			self:RaidReport(string.format("%s - items in loot:%s",BossName,WorthGold),true)
			for _,item in pairs(ItemLinks) do
				self:RaidReport(item,true,true)
			end
			if #NotEligible > 0 then
				self:RaidReport("Not eligible: "..table.concat(NotEligible, ", "),true,true)
			end
		end
	end
end

MPR_GameTime = {
  Get = function(self)
  	if(self.LastMinuteTimer == nil) then
  		local h,m = GetGameTime()
  		return h,m,0
  	end
  	local GameSecond = floor(GetTime() - self.LastMinuteTimer)
	GameSecond = (GameSecond <= 59 and GameSecond or 59)
  	return self.LastGameHour, self.LastGameMinute, GameSecond
  end,

  OnUpdate = function(self)
  	local h,m = GetGameTime()
  	if(self.LastGameMinute == nil) then
  		self.LastGameHour = h
  		self.LastGameMinute = m
  		return
  	end
  	if(self.LastGameMinute == m) then
  		return
  	end
  	self.LastGameHour = h
  	self.LastGameMinute = m
  	self.LastMinuteTimer = GetTime()
  end,

  Initialize = function(self)
  	self.Frame = CreateFrame("Frame")
  	self.Frame:SetScript("OnUpdate", function() self:OnUpdate() end)
  end
}
MPR_GameTime:Initialize()

function MPR:ReportDeath(str)
	if self.Settings["PD_RAID"] then
		if UnitInRaid("player") then
			self:RaidReport(str,true)
		elseif GetNumPartyMembers() > 0 then
			self:PartyReport(str,true)
		end
	end
	if self.Settings["PD_WHISPER"] then
		self:Whisper(str,true)
	end
	if self.Settings["PD_GUILD"] then
		self:Guild(str)
	end
end

local Combat = false
local DeathData = {}
function MPR:StartCombat(EncounterName)
	if Combat then return end
	Combat = true
	local h,m,s = MPR_GameTime:Get()
	local index = #DeathData+1
	DeathData[index] = {}
	DeathData[index].Name = EncounterName
	DeathData[index].TimeStart = GetTime()
	DeathData[index].GameTimeStart = string.format("%i:%i:%i",h,m,s)
	DeathData[index].Deaths = {}
	MPR:ScheduleTimer("Wipe Check", WipeCheck, 3)
end

function MPR:StopCombat()
	Combat = false
	local index = #DeathData
	DeathData[index].TimeEnd = GetTime() -- Not used
	local h,m,s = MPR_GameTime:Get()
	DeathData[index].GameTimeEnd = string.format("%i:%i:%i",h,m,s)
	local numDeaths = #DeathData[index].Deaths
	self:SelfReport("Encounter "..DeathData[index].Name.." finished."..(numDeaths > 0 and "("..numDeaths.." death records. Show report to: |HMPR:DeathReport:Self:"..index..":nil|h|cff1E90FF[Self]|r|h |HMPR:DeathReport:Raid:"..index..":nil|h|cffEE7600[Raid]|r|h |HMPR:DeathReport:Guild:"..index..":nil|h|cff40FF40[Guild]|r|h)" or ""))
end

function WipeCheck()
	if not Combat then return end -- StopCombat() was called already
	local Wipe = true
	if UnitInRaid("player") then
		for i=0,GetNumRaidMembers() do
			local UnitID = (i == 0 and "player" or "raid"..i)
			if UnitAffectingCombat(UnitID) and not UnitIsDeadOrGhost(UnitID) then
				Wipe = false
				break
			end
		end
	end
	if Wipe then
		MPR:StopCombat()
	else
		MPR:ScheduleTimer("Wipe Check", WipeCheck, 1)
	end
end

function MPR:DeathReport(channel, index)
	index = tonumber(index or #DeathData)
	local strReportTitle = "Death Report for "..DeathData[index].Name.." ("..DeathData[index].GameTimeStart.." - "..DeathData[index].GameTimeEnd..")"
	if channel == "Raid" then
		self:RaidReport(strReportTitle,true)
	elseif channel == "Guild" then
		self:Guild(strReportTitle)
	elseif channel == "Self" then
		self:SelfReport(strReportTitle)
	end	
	local Data = DeathData[index]
	for i=1,(#DeathData[index]) do
		local Player,Time,Source,Ability,Amount,Overkill = unpack(Data[i])
		local strTime = floor(Time/60)..":"..(strlen(Time%60) == 1 and "0" or "")..(Time%60)
		if channel == "Raid" then
			self:RaidReport(string.format("%i. %s %s - %s: %s (A: %i / O: %i)",i,strTime,Player,Source,Ability,Amount-Overkill,Overkill),true,true)
		elseif channel == "Guild" then
			self:Guild(string.format("%i. %s %s - %s: %s (A: %i / O: %i)",i,strTime,Player,Source,Ability,Amount-Overkill,Overkill),true)
		else
			self:SelfReport(string.format("%i. %s - %s: %s %s (A: %i / O: %i)",i,strTime,Player,Source,Ability,Amount-Overkill,Overkill))
		end
	end
end

function MPR:InsertDeath(Player,Source,Ability,Amount,Overkill)
	if not Combat then return end
	local Time = math.floor(GetTime()-DeathData[#DeathData].TimeStart)
	local tbl = {Player,Time,Source,Ability,Amount,Overkill}
	table.insert(DeathData[#DeathData].Deaths,tbl)
end

local PotencialDeaths = {}
function MPR:COMBAT_LOG_EVENT_UNFILTERED(...)
	if not self.Settings["SELF"] then return end 
	local timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)
	
	if UnitIsPlayer(destName) then --(UnitInParty(destName) or UnitInRaid(destName)) and 
		if event == "SWING_DAMAGE" then
			if PotencialDeaths[destName] then PotencialDeaths[destName] = nil end
			
			local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
			if overkill > 0 then
				self:InsertDeath(destName,(sourceName or "Unknown"),"Melee",amount,overkill)
				if self.Settings["PD_SELF"] then
					self:SelfReport(unit(destName).." died. ("..(sourceName or "Unknown")..": Melee - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")")
				end
				self:ReportDeath(destName.." died. ("..(sourceName or "Unknown")..": Melee - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")")
			end
		elseif event == "RANGED_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" then
			if PotencialDeaths[destName] then PotencialDeaths[destName] = nil end
			
			local spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
			if overkill > 0 then
				self:InsertDeath(destName,(sourceName or "Unknown"),GetSpellLink(spellId),amount,overkill)
				if self.Settings["PD_SELF"] then
					self:SelfReport(unit(destName).." died. ("..(sourceName or "Unknown")..": "..spell(spellId).." - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")")
				end
				self:ReportDeath(destName.." died. ("..(sourceName or "Unknown")..": "..GetSpellLink(spellId).." - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")")
			end
		elseif event == "ENVIRONMENTAL_DAMAGE" then
			if PotencialDeaths[destName] then PotencialDeaths[destName] = nil end
			
			local environmentalType, amount, overkill = select(9, ...)
			if overkill > 0 then
				self:InsertDeath(destName,"Environment",(environmentalType or "Unknown"),amount,overkill)
				if self.Settings["PD_SELF"] then
					self:SelfReport(unit(destName).." died. (Environment: "..(environmentalType or "Unknown").." - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")")
				end
				self:ReportDeath(destName.." died. (Environment: "..(environmentalType or "Unknown").." - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")")
			else
				PotencialDeaths[destName] = {timestamp,environmentalType,amount}
			end
		elseif event == "UNIT_DIED" then		
			if PotencialDeaths[destName] then
				if (timestamp - PotencialDeaths[destName][1]) < 1 then
					self:InsertDeath(destName,"Environment",(PotencialDeaths[destName][2] or "Unknown"),amount,overkill)
					if self.Settings["PD_SELF"] then
						self:SelfReport(unit(destName).." died. (Environment: "..(PotencialDeaths[destName][2] or "Unknown").." - A: "..numformat(PotencialDeaths[destName][3])..")")
					end
					self:ReportDeath(destName.." died. (Environment: "..(PotencialDeaths[destName][2] or "Unknown").." - A: "..numformat(PotencialDeaths[destName][3])..")")
				end
				PotencialDeaths[destName] = nil
			end
		end
		
		--[[
		if sourceName == UnitName("player") and event == "SPELL_ENERGIZE" then
			local spellId, spellName, _, amount, powerType = select(9, ...)
			if spellId == 48542 or spellId == 48541 or spellId == 48540 or spellId == 48543 then
				powerType = (powerType == 0 and "Mana" or powerType == 1 and "Rage" or powerType == 4 and "Energy" or powerType == 6 and "Runic Power" or "Unknown")
				self:SelfReport("Revitalized "..unit(destName).." ("..amount.." "..powerType..")")
			end
		end
		]]
	end
	
	-- taken from Blizzard_CombatLog.lua
	if event == "SWING_DAMAGE" then
		local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
		
		if sourceName == "Vengeful Shade" and UnitIsPlayer(destName) then
			self:SelfReport(string.format("%s failed to run from %s",unit(destName),unit(sourceName)))
			self:RaidReport(string.format("%s failed to run from %s",destName,sourceName))
		elseif contains(reportDamageOnTarget,destName) then
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
				table.wipe(targetsHeroism)
				casterHeroism = sourceName
				self:ScheduleTimer("Heroism", TimerHandler, 1, spellId)
			elseif contains(spellsCast,spellName) or spellId == 69381 then -- 69381 - [Gift of the Wild] Drums!
				self:ReportCast(sourceName,spellId)
			elseif contains(spellsCastOnTarget,spellName) then
				self:ReportCastOnTarget(sourceName,destName,spellId)
			elseif contains(spellsBossCastOnTarget,spellName) then
				self:ReportBossCastOnTarget(spellId,destName)
			end
			
			if sourceName == "Shadow Trap" and spellName == "Shadow Trap" then
				self:RaidReport(GetSpellLink(spellId))
			elseif spellName == "Swarming Shadows" then
				self:Whisper(destName, GetSpellLink(spellId).." on you! Run along walls!!")
			elseif spellId == 74502 then
				self:Whisper(destName, GetSpellLink(spellId).." on you! Run awayy!!")
			end
		elseif event == "SPELL_CREATE" then
			if contains(spellsCreate,destName,true) then
				self:ReportSpellCreate(sourceName,spellId)
				self:CancelTimer(destName)
				self:ScheduleTimer(destName, TimerHandler, spellsCreate[destName]-30, spellId)
			end
		elseif event == "SPELL_SUMMON" then
			if contains(npcsSpellSumon,destName) then
				self:ReportSummon(sourceName,destName,spellId)
			elseif contains(npcsBossSpellSumon,destName) then
				self:ReportBossSummon(destName,spellId)
			end			
		elseif event == "SPELL_DAMAGE" then
			local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)
			
			if spellName == "Pain and Suffering" and UnitInRaid(destName) then 
				local Count = select(4,UnitDebuff(destName,"Pain and Suffering")) or 0
				print(UnitDebuff(destName,"Pain and Suffering"))
				for i=1,40 do
					local Debuff, _, _, Count = Unitdebuff(destName,i)
					if not Debuff then break end
					if Debuff == "Pain and Suffering" and Count == 5 then
						self:Whisper(destName, GetSpellLink(spellId).." (5 stacks) on you! Spread!! ("..amount.." damage)")
						break
					end
				end
			end
			
			if contains(spellsDamage,spellName) and UnitIsPlayer(destName) then
				self:ReportSpellDamage(spellId,destName,amount,critical)
			elseif contains(spellsAOEDamage,spellName) and UnitIsPlayer(destName) then
				if not nameSpellAOEDamage then
					nameSpellAOEDamage = spellName
				elseif nameSpellAOEDamage ~= spellName then
					return
				end
				
				self:CancelTimer("Spell AOE Damage")
				self:ScheduleTimer("Spell AOE Damage", TimerHandler, 0.5, spellId)
				
				targetsSpellAOEDamage[destName] = amount
			elseif contains(reportDamageOnTarget,destName) then
				self:ReportDamageOnTarget(sourceName,destName,spellId)
			--elseif spellId == 71447 or spellId == 71481 then -- Blood-Queen Lana'thel: Bloodbolt Splash
			--	if not self:IsTimerScheduled("Bloodbolt Splash") then
			--		self:ScheduleTimer("Bloodbolt Splash", TimerHandler, 1, spellId)
			--	end
			--	table.insert(BS_TargetsName,destName)
			--	table.insert(BS_TargetsAmount,amount)
			elseif spellId == 69770 and amount > 20000 and GetRaidDifficulty() < 3 then -- Sindragosa: Backlash
				self:ReportSpellDamage(spellId,destName,amount,critical)
			--elseif spellId == 71044 or spellId == 71045 or spellId == 71046 then -- Sindragosa: Backlash (hc)
			end
		elseif event == "SPELL_HEAL" then
			local amount, overheal, absorbed, critical = select(12, ...)
			local school = spellSchool
			
			if contains(spellsHeal,spellName) then
				self:ReportSpellHeal(spellId,destName,amount,critical)
			end
		elseif event:sub(1, 14) == "SPELL_PERIODIC" then
			if event == "SPELL_PERIODIC_DAMAGE" then
				local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)
				
				if contains(spellsPeriodicDamage,spellName) and UnitInRaid(destName) then
					self:ReportSpellDamage(spellId,destName,amount,critical)
				end
			elseif event == "SPELL_PERIODIC_HEAL" then
				local amount, overheal, absorbed, critical = select(12, ...)
				local school = spellSchool
				
				if contains(spellsPeriodicHeal,spellName) then
					self:ReportSpellHeal(spellId,destName,amount,critical)
				end
			end
		elseif event == "SPELL_DISPEL" then
			local extraSpellId, extraSpellName, extraSpellSchool, auraType = select(12, ...)
			
			if extraSpellName == "Necrotic Plague" and sourceName ~= destName then
				self:Whisper(destName, GetSpellLink(extraSpellId).." dispeled from you!")
			end
			
			if self.Settings["REPORT_DISPELS"] and (spellName ~= "Mass Dispel" or self.Settings["REPORT_MASSDISPELS"]) then
				self:ReportDispel(sourceName,destName,extraSpellId)
			end
		elseif event == "SPELL_AURA_APPLIED" then
			local auraType = select(12, ...)
			
			if spellName == "Frost Beacon" then
				self:Whisper(destName, GetSpellLink(70126).." on you! Run away from others!!")
			elseif spellName == "Gaseous Bloat" then
				self:Whisper(destName, GetSpellLink(spellId).." on you! Kite it!!")
			end
			
			if contains(aurasAppliedOnTarget,spellName) and UnitIsPlayer(destName) then
				if destName == UnitName("player") and contains(sayAuraOnMe,spellName) then
					self:Say(sayAuraOnMe[spellName])
				end
				self:ReportAppliedOnTarget(spellId,destName)
			elseif contains(aurasAppliedOnTargets,spellName) then
				if destName == UnitName("player") and contains(sayAuraOnMe,spellName) then
					self:Say(sayAuraOnMe[spellName])
				end
				table.insert(targetsAura,destName)
				self:CancelTimer("Aura Targets")
				self:ScheduleTimer("Aura Targets", TimerHandler, 0.5, spellId)
			elseif spellName == "Heroism" and sourceName == casterHeroism and UnitIsPlayer(destName) then
				table.insert(targetsHeroism,destName)
			elseif spellName == "Enrage" and destName == "Saviana Ragefire" then
				self:ReportAppliedOnTarget(spellId,destName)
			elseif contains({70952,70982,70981},spellId) then -- BPC: Target Switch
				BPC_ChangeTarget(destName)
			elseif spellName == "Essence of the Blood Queen" and UnitIsPlayer(destName) then
				--self:Whisper(destName, "Bite on you! (+100% dmg)")
			elseif spellName == "Frenzied Bloodthirst" and UnitIsPlayer(destName) then
				self:Whisper(destName, "You have to bite!!")
			elseif spellName == "Uncontrollable Frenzy" and UnitIsPlayer(destName) then
				--self:Whisper(destName, "You failed to bite.")
				self:RaidReport(string.format("%s failed to bite.", destName))
			elseif spellName == "Touch of Jaraxxus" then -- Jaraxxus: Touch of Jaraxxus
				self:Whisper(destName, GetSpellLink(spellId).." on you! Run away till debuff is gone!!")
			elseif spellName == "Incinerate Flesh" then -- Jaraxxus: Incinerate Flesh
				self:ReportAppliedOnTarget(spellId,destName)
			end
		elseif event == "SPELL_AURA_APPLIED_DOSE" then
			local auraType, amount = select(12, ...)
			if contains(stackAppliedOnTarget,spellName) then
				self:ReportStacksOnTarget(destName,spellId,amount)
			end
		elseif event == "SPELL_RESURRECT" and spellId == 48477 then -- Rebirth (Druid)
			self:ReportCombatResurrect(sourceName,spellId,destName)
		end
	end
end

function MPR:CHAT_MSG_MONSTER_YELL(msg)
	if not self.Settings["SELF"] then return end
	if EncounterStartYells[msg] then
		local EncounterName = EncounterNames[EncounterStartYells[msg]]
		self:SelfReport("Encounter |r|cFFffffff"..EncounterName.."|r|cFFbebebe started. |r|cff3588ff|HMPR:AuraInfo:Update:"..EncounterStartYells[msg].."|h[Click here]|h|r|cFFbebebe to show Aura Info frame.")
		self:StartCombat(EncounterName)
	elseif EncounterDoneYells[msg] then
		self:StopCombat()
	end
	
	if BossRaidYells[msg] then
		self:RaidReport(BossRaidYells[msg])
	end
	
	if BossYells[msg] then
		self:Say(BossYells[msg])
	end
end

--[[ SWING_DAMAGE, SPELL_DAMAGE, SPELL_PERIODIC_DAMAGE, SPELL_HEAL, SPELL_PERIODIC_HEAL ]]--
function MPR:ReportSpellDamage(SPELL,TARGET,AMOUNT,CRIT) -- [Spell] hits Target for Amount [(Critical)].
	local CRIT = CRIT and " (Critical)" or ""
	self:HandleReport(nil, string.format("%s hits %s for %s%s",spell(SPELL),unit(TARGET),numformat(AMOUNT),CRIT))
end
function MPR:ReportSpellHeal(SPELL,TARGET,AMOUNT,CRIT) -- [Spell] heals Target for Amount [(Critical)].
	local CRIT = CRIT and " (Critical)" or ""
	self:HandleReport(string.format("%s heals %s for %s%s",spell(SPELL,true),TARGET,numformat(AMOUNT),CRIT), string.format("%s heals %s for %s%s",spell(SPELL),unit(TARGET),numformat(AMOUNT),CRIT))
end
function MPR:ReportDamageOnTarget(UNIT,TARGET,SPELL) -- Unit damages Target with [Spell].
	self:HandleReport(nil, self:SelfReport(string.format("%s damages %s with %s",unit(UNIT),unit(TARGET),spell(SPELL))))
	-- string.format("%s damages %s with %s",UNIT,TARGET,spell(SPELL,true))
end

--[[ SPELL_SUMMON ]]--
function MPR:ReportSummon(UNIT,TARGET,SPELL) -- Unit summons Target. [Spell].
	self:HandleReport(string.format("%s summons %s (%s)",UNIT,TARGET,spell(SPELL,true)), string.format("%s summons %s (%s)",unit(UNIT),unit(TARGET),spell(SPELL)))
end
function MPR:ReportBossSummon(TARGET,SPELL) -- Target summoned. [Spell]
	self:HandleReport(string.format("%s summoned. (%s)",TARGET,spell(SPELL,true)), string.format("%s summoned. (%s)",unit(TARGET),spell(SPELL)))
end

--[[ SPELL_CAST_START, SPELL_CAST_SUCCESS ]]--
function MPR:ReportCast(UNIT,SPELL) -- Unit casts [Spell].
	self:HandleReport(string.format("%s casts %s",UNIT,spell(SPELL,true)), string.format("%s casts %s",unit(UNIT),spell(SPELL)))
end
function MPR:ReportCastOnTarget(UNIT,TARGET,SPELL) -- Unit casts [Spell] on Target.
	self:HandleReport(string.format("%s casts %s on %s",UNIT,spell(SPELL,true),TARGET), string.format("%s casts %s on %s",unit(UNIT),spell(SPELL),unit(TARGET)))
end

--[[ SPELL_AURA_APPLIED ]]--
function MPR:ReportBossCastOnTarget(SPELL,TARGET) -- [Spell] on Target.
	self:HandleReport(string.format("%s on %s",spell(SPELL,true),TARGET), string.format("%s on %s",spell(SPELL),unit(TARGET)))
end

function MPR:ReportAppliedOnTarget(SPELL,TARGET) -- [Spell] applied on Target.	
	self:HandleReport(string.format("%s applied on %s",spell(SPELL,true),TARGET), string.format("%s applied on %s",spell(SPELL),unit(TARGET)))
end

--[[ SPELL_AURA_APPLIED_DOSE ]]--
function MPR:ReportStacksOnTarget(TARGET,SPELL,AMOUNT) -- Target has Amount stacks of [Spell].
	self:HandleReport(string.format("%s has %i stacks of %s",TARGET,AMOUNT,spell(SPELL,true)), string.format("%s has %i stacks of %s",unit(TARGET),AMOUNT,spell(SPELL)))
end

--[[ SPELL_DISPEL ]]--
function MPR:ReportDispel(UNIT,TARGET,SPELL) -- Unit dispels [Spell] from Target.
	self:HandleReport(string.format("%s dispels %s (%s)",UNIT,TARGET,spell(SPELL,true)), string.format("%s dispels %s (%s)",unit(UNIT),unit(TARGET),spell(SPELL)))
end

--[[ SPELL_CREATE ]]--
function MPR:ReportSpellCreate(UNIT,SPELL) -- Unit prepares [Spell].
	self:HandleReport(string.format("%s prepares %s",UNIT,spell(SPELL,true)), string.format("%s prepares %s",unit(UNIT),spell(SPELL)))
end

--[[ SPELL_RESURRECT ]]-- only dudu ress
function MPR:ReportCombatResurrect(UNIT,SPELL,TARGET) -- Unit prepares [Spell].
	self:HandleReport(string.format("%s resurrects %s (%s)",UNIT,TARGET,spell(SPELL,true)), string.format("%s resurrects %s (%s)",unit(UNIT),unit(TARGET),spell(SPELL)))
end

-- REPORT HANDLER
-- Formatted (string) - string supporting colors and images
-- Unformatted (string) - colors and images not allowed (unsupported)
function MPR:HandleReport(Formatted, Unformatted, IgnoreRaidSettings, WithoutChannelPrefix)
	if Unformatted and (self.Settings["RAID"] or IgnoreRaidSettings) then
		self:RaidReport(msg,IgnoreRaidSettings, WithoutChannelPrefix)
	elseif Formatted and self.Settings["SELF"] then
		self:SelfReport(msg)
	end
end

-- Just adds MPR prefix.
function MPR:SelfReport(msg)
	print(MPR_Prefix..msg..MPR_Postfix)
end

-- Just adds MPR channel prefix
function MPR:RaidReport(msg, ...)
	local rrBypass, prefixBypass = ...
	if not (msg and (self.Settings["RAID"] or rrBypass)) then return end
	if not prefixBypass then
		SendChatMessage(MPR_ChannelPrefix..msg, "RAID")
	else
		SendChatMessage(msg, "RAID")
	end
end

function MPR:PartyReport(msg, ...)
	local prBypass, prefixBypass = ...
	if not (msg and (self.Settings["RAID"] or prBypass)) then return end
	if not prefixBypass then
		SendChatMessage(MPR_ChannelPrefix..msg, "PARTY")
	else
		SendChatMessage(msg, "PARTY")
	end
end

-- Raid Warning
function MPR:RaidWarning(MESSAGE, ...)
	local rwBypass = ...
	if not (MESSAGE and (self.Settings["RAID"] or rwBypass)) then return end
	SendChatMessage(MESSAGE, "RAID_WARNING")
end

-- Guild Message
function MPR:Guild(MESSAGE, ...)
	if not (MESSAGE) then return end
	local noPrefix = ...
	SendChatMessage((noPrefix and "" or MPR_ChannelPrefix)..MESSAGE, "GUILD")
end

-- Whisper Message
function MPR:Whisper(TARGET, MESSAGE, ...)
	local wBypass = ...
	if not (MESSAGE and (self.Settings["WHISPER"] or wBypass)) then return end
	SendChatMessage(MPR_ChannelPrefix..MESSAGE, "WHISPER", nil, TARGET)
end

-- Say Message
function MPR:Say(MESSAGE, ...)
	local smBypass = ...
	if not (MESSAGE and (self.Settings["SAY"] or smBypass)) then return end
	SendChatMessage(MESSAGE, "SAY")
end

--[[-------------------------------------------------------------------------
	Other Methods
---------------------------------------------------------------------------]]
function MPR:ReportLocks(Player)
	local Locks = {}
	for i=1,GetNumSavedInstances() do
		local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i)
		if isRaid and InstanceShortNames[name] then
			table.insert(Locks, string.format("%s %s (%i)",InstanceShortNames[name],RaidDifficulty[difficulty],id))
		end
	end
	if #Locks > 0 then
		SendChatMessage(string.format("Raid Locks: %s",table.concat(Locks,", ")), "WHISPER", nil, Player);
	else
		SendChatMessage("No Raid Locks.", "WHISPER", "Common", Player);
	end
end

function MPR:GetGuildMemberInfo(Name)
	local Searching, i = true, 0
	while Searching do
		i = i + 1
		local n = GetGuildRosterInfo(i)
		if not n then break end
		if Name == n then
			return i, GetGuildRosterInfo(i)
		end
	end
end

--[[
function MPR:DeductDKPLink(Targets, Amount, Reason)
	return "|r|HMPR:DeductDKP:"..table.concat(Targets,"-")..":"..Amount..":"..Reason.."|h|cFF"..Colors["DKPDEDUCTION_LINK"].."[Deduct "..Amount.." DKP]|r|h|cFF"..Colors["TEXT"]
end

function MPR:DKPDeductionHandler(Targets,Amount,Reason)
	local Channel = self.Settings["DKPPENALTIES_OUTPUT"]
	local DeductedTargets = {}
	for _, Target in pairs(Targets) do
		local TargetNewNet = self:DeductDKP(Target, Amount)
		if TargetNewNet then
			if Channel == "WHISPER"	then
				SendChatMessage(MPR_ChannelPrefix.."Deducted "..Amount.." DKP (New NET: "..TargetNewNet.." DKP). Reason: "..(Reason or "no reason given"), "WHISPER", nil, Target)
			else
				DeductedTargets[#DeductedTargets+1] = Target
			end
		end
	end
	
	if Channel == "RAID" or Channel == "GUILD" then
		SendChatMessage(MPR_ChannelPrefix.."Deducted "..Amount.." DKP from: "..table.concat(DeductedTargets,", ")..". Reason: "..(Reason or "no reason given"), Channel)
	end
end

function MPR:DeductDKP(Name, Amount)
	if not (Name and Amount) then return end
	if not CanEditOfficerNote() then
		print("MPR: No permission to edit officer notes.")
		return
	end
	local Index, Member, _, _, _, _, _, _, OfficerNote = self:GetGuildMemberInfo(Name)
	if Member then -- Is a guild member?
		if OfficerNote == "" then
			GuildRosterSetOfficerNote(Index, "Net:0 Tot:0 Hrs:0")
		end
		local DeductedMember_Name, DeductedMember_OfficerNote
		if not self:IsDKPFormat(OfficerNote) then -- Is not a main character?
			OfficerNote = select(9,self:GetGuildMemberInfo(OfficerNote)) or nil
			if not OfficerNote or not self:IsDKPFormat(OfficerNote) then 
				return
			end
		end
		
		local Net, Tot, Hrs = strsplit(" ", OfficerNote)
		local NetNum = select(2, strsplit(":", Net))
		NetNum = tonumber(NetNum) - Amount
		
		GuildRosterSetOfficerNote(Index, "Net:"..NetNum.." "..Tot.." "..Hrs)
		return NetNum
	end
end

function MPR:IsDKPFormat(Note)
	if Note:sub(1,4) == "Net:" and Note:find("Tot:") and Note:find("Hrs:") then 
		return true
	end
end
]]

function MPR:CHAT_MSG_ADDON(prefix, msg, channel, sender)
	if prefix == "DBMv4-Ver" then
		if PingTarget == sender then
			MPR:SelfReport(sender.."'s latency: "..(GetTime()-PingTime).."s", true)
		else
			table.insert(DBM_Users,sender)
			return
		end
	end
	if prefix ~= "MPR" or sender == UnitName("player") then return end
	if msg == "request-version" then
		SendAddonMessage("MPR", "version:"..MPR_Version, "WHISPER", sender)
	elseif msg:sub(1, 8) == "version:" then
		local sender_version = msg:sub(10, 10)..msg:sub(12, 13)
		local player_version = MPR_Version:sub(2,2)..MPR_Version:sub(4,5)	
		self:ScheduleTimer("Report Users",report,0.5,true)
		if player_version >= sender_version then 
			table.insert(usersAddon, string.format("%s (%s)",unit(sender),msg:sub(9, 13)))
			return
		end
		table.insert(usersAddon, string.format("%s (|cFF00FF00%s|r)",unit(sender),msg:sub(9, 13)))
		if reportedNewerVersion then return end
		reportedNewerVersion = true
		self:SelfReport(string.format("|cFF00FF00%s|r","A newer version is available!"))
 	end
end

function MPR:ZONE_CHANGED_NEW_AREA()
	local inInstance, instanceType = IsInInstance()
	local state = inInstance and (instanceType == "party" or instanceType == "raid")
	if self.Settings["SELF"] ~= state then
		self.Settings["SELF"] = state
		self:SelfReport((state and "Instance detected." or "Player not in instance.").." Reporting has been "..getStateColor(self.Settings["SELF"])..".")
	end
	--if MPR_AuraInfo.Loaded then	Title:SetText("|cff1e90ffMP Reporter|r - Aura Info") end
end

function MPR:ADDON_LOADED(addon)
	if addon ~= "MPR" then return end
	MPR_Settings = MPR_Settings or {
		["SELF"] = false, ["RAID"] = false, ["SAY"] = false, ["WHISPER"] = false,
		["REPORT_DISPELS"] = false,	["REPORT_MASSDISPELS"] = false,
		["PD_SELF"] = true, ["PD_RAID"] = false, ["PD_SAY"] = false, ["PD_WHISPER"] = false,
		["UPDATEFREQUENCY"] = 0.1,
		["CCL_ONLOAD"] = true,
		["ICONS"] = false,
		["REPORT_LOOT"] = false, ["REPORT_LOOT_BOP_ONLY"] = false,
		["DKPPENALTIES_AUTO"] = false,
		["DKPPENALTIES_OUTPUT"] = "RAID",
	}
	self.Settings = MPR_Settings
	--[[
	MPR_DKPPenalties = nil or {
		["Malleable Goo"] = 		{false,1},
		["Choking Gas Explosion"] =	{false,1},
		["Frost Bomb"] = 			{false,1},
		["Defile"] = 				{false,1},
		["Trample"] = 				{false,1},
	}
	self.DKPPenalties = MPR_DKPPenalties
	]]
	MPR_Options:Initialize()
	MPR_AuraInfo:Initialize()
	SLASH_MPR1 = '/mpr';
	
	local inInstance, instanceType = IsInInstance()
	local state = inInstance and (instanceType == "raid")
	self.Settings["SELF"] = state
	self:SelfReport(string.format("Addon (%s) loaded! Reporting is %s. |r|HMPR:Options:Show:nil|h|cff3588ff[Options]|r|h",MPR_Version,getStateColor(self.Settings["SELF"])))
	
	if self.Settings["CCL_ONLOAD"] then
		self:ClearCombatLog(true)
	end
	self:RegisterEvents()
	SendAddonMessage("MPR", "request-version", "GUILD")
end

MPR:RegisterEvent("ADDON_LOADED")