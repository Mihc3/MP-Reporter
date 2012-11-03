MPR_ReportOptions = CreateFrame("Frame", "MPR Report Options", UIParent);

local framecount = 0
function GetNewID() 
	framecount = framecount + 1
	return framecount
end
function GetCurrentID()
	return framecount
end

local PositionY = 30
function GetPositionY(Height)
	PositionY = PositionY - Height
	return PositionY + Height
end

function MPR_ReportOptions:Initialize()
	MPR_ReportOptions:Hide()
	MPR_ReportOptions.name = "MPR_ReportOptions"
	MPR_ReportOptions:SetBackdrop({
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
		edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border", 
		tile=1, tileSize=32, edgeSize=32, insets={left=11, right=12, top=12, bottom=11}
	})
	MPR_ReportOptions:SetPoint("CENTER",UIParent)
	MPR_ReportOptions:SetWidth(900)
	MPR_ReportOptions:SetHeight(580)
	MPR_ReportOptions:EnableMouse(true)
	MPR_ReportOptions:SetMovable(true)
	MPR_ReportOptions:RegisterForDrag("LeftButton")
	MPR_ReportOptions:SetUserPlaced(true)
	MPR_ReportOptions:SetScript("OnDragStart", function(self) self:StartMoving() end)
	MPR_ReportOptions:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	MPR_ReportOptions:SetFrameStrata("FULLSCREEN_DIALOG")
	
		--[[ MP Reporter - Report Options ]]--
	MPR_ReportOptions:NewFS("|cFF1E90FFMP Reporter|r - Report Options",nil,0,-12)
	
	MPR_Options_BtnClose = CreateFrame("button","MPR_Options_BtnClose", MPR_ReportOptions, "UIPanelButtonTemplate")
	MPR_Options_BtnClose:SetHeight(14)
	MPR_Options_BtnClose:SetWidth(14)
	MPR_Options_BtnClose:SetPoint("TOPRIGHT", -12, -11)
	MPR_Options_BtnClose:SetText("x")
	MPR_Options_BtnClose:SetScript("OnClick", function(self) MPR_ReportOptions:Hide() end)
	
	--[[ Icecrown Citadel ]]--
	MPR_ReportOptions:NewFS("Icecrown Citadel","00CCFF",16,-30)
		
	MPR_ReportOptions:NewGroup({"Lord Marrowgar","00CCFF",16,-44},
		{"[Impaled] targets", 1.1})
	MPR_ReportOptions:NewGroup({"Lady Deathwhisper","00CCFF",16},
		{"[Dominated Mind] targets", 2.1},{"[Vengeful Shade] summon", 2.2},{"[Vengleful Blast] hits", 2.3})
	MPR_ReportOptions:NewGroup({"Deathbringer Saurfang","00CCFF",16},
		{"[Rune of Blood] target", 4.1},{"[Rune of Blood] heals", 4.2})
	MPR_ReportOptions:NewGroup({"Festergut","00CCFF",16},
		{"[Gas Spore] targets", 5.1},{"[Vile Gas] targets", 5.2})
	MPR_ReportOptions:NewGroup({"Rotface","00CCFF",16},
		{"[Mutated Infection] targets", 6.1},{"[Unstable Ooze Explosion] announce", 6.2},{"[Unstable Ooze Explosion] hits", 6.3})
	MPR_ReportOptions:NewGroup({"Professor Putricide","00CCFF",16},
		{"[Malleable Goo] hits", 7.1},{"[Volatile Ooze Adhesive] target", 7.2},{"[Gaseous Bloat] target", 7.3},{"[Unbound Plague] target",7.4})
	MPR_ReportOptions:NewGroup({"Blood Prince Council","00CCFF",316,-44},
		{"[Dark Nucleus] summon", 8.1})
	MPR_ReportOptions:NewGroup({"Blood-Queen Lana'thel","00CCFF",316},
		{"[Swarming Shadows] target", 9.1},{"[Essence of the Blood Queen] target", 9.2},{"[Frenzied Bloodthirst] target", 9.3},{"[Uncontrollable Frenzy] target", 9.4})
	MPR_ReportOptions:NewGroup({"Sindragosa","00CCFF",316},
		{"[Unchained Magic] targets", 11.1},{"[Frost Beacon] targets", 11.2},{"[Frost Bomb] hits", 11.3},{"[Blistering Cold] hits", 11.4})
	MPR_ReportOptions:NewGroup({"The Lich King","00CCFF",316},
		{"[Necrotic Plague] target", 12.1},{"[Defile] target", 12.2},{"[Defile] hits", 12.3},{"[Soul Reaper] target", 12.4},{"[Shadow Trap] target (HC)", 12.5})
	
	--[[ Trial of the Crusader ]]--
	MPR_ReportOptions:NewFS("Trial of the Crusader","3CAA50",616,-30)
	
	MPR_ReportOptions:NewGroup({"Icehowl","3CAA50",616,-44},
		{"[Trample] hits", 14.1})
	MPR_ReportOptions:NewGroup({"Acidmaw and Dreadscale","3CAA50",616},
		{"[Slime Pool] summon", 15.1})
	MPR_ReportOptions:NewGroup({"Lord Jaraxxus","3CAA50",616},
		{"[Legion Flame] target", 16.1},{"[Touch of Jaraxxus] target", 16.2})
	MPR_ReportOptions:NewGroup({"Twin Valkyr","3CAA50",616},
		{"[Light Vortex] cast", 18.1},{"[Dark Vortex] cast", 18.2})
	
	--[[ Ruby Sanctum ]]--
	MPR_ReportOptions:NewFS("Ruby Sanctum","FF9912",616,-280)
	
	MPR_ReportOptions:NewGroup({"Saviana Ragefire","FF9912",616,-294},
		{"[Enrage] application", 20.1})
	MPR_ReportOptions:NewGroup({"General Zarithrian","FF9912",616},
		{"[Cleave Armor]", 22.1})
	MPR_ReportOptions:NewGroup({"Halion","FF9912",616},
		{"[Meteor Strike] announce", 23.1},{"[Fiery Combustion] target", 23.2},{"[Soul Consumption] target", 23.3})
end

function MPR_ReportOptions:NewFS(Text,Color,LocX,LocY,FontSize) -- Creates a fontstring
	local Title = MPR_ReportOptions:CreateFontString("FontString"..GetNewID(), "ARTWORK", "GameFontNormal")
	Title:SetPoint("TOPLEFT", LocX, LocY)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	Title:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
	Title:SetFont("Fonts\\FRIZQT__.TTF", FontSize or 10, nil)
	Title:SetText(Text)
end

function MPR_ReportOptions:NewCB(Text,Color,Var,LocX,LocY,FontSize) -- Creates a checkbox
	local CheckBox = CreateFrame("CheckButton", "CheckBox"..GetNewID(), MPR_ReportOptions, "UICheckButtonTemplate")
	CheckBox:SetWidth(20)
	CheckBox:SetHeight(20)
	CheckBox:SetPoint("TOPLEFT", LocX, LocY)
	
	local SpellVar, Channel = strsplit("-",Var)
	SpellVar, Channel = tonumber(SpellVar), tonumber(Channel)
	local array = MPR.ReportOptions[SpellVar]
	if array[Channel] == nil then Color = "BEBEBE" end
	_G["CheckBox"..GetCurrentID().."Text"]:SetFont("Fonts\\FRIZQT__.TTF", FontSize or 9, nil)
	_G["CheckBox"..GetCurrentID().."Text"]:SetText("|cFF"..Color..Text.."|r")
	CheckBox:SetScript("OnShow",  function(self) 
		local array = MPR.ReportOptions[SpellVar]
		if array[Channel] == nil then CheckBox:Disable()  end
		CheckBox:SetChecked(array[Channel])
	end)
	CheckBox:SetScript("OnClick", function(self) 
		MPR.ReportOptions[SpellVar][Channel] = not MPR.ReportOptions[SpellVar][Channel]
	end)
end

function MPR_ReportOptions:NewCBGroup(SpellID,Var,PosX,PosY)
	local SpellStr = type(SpellID) == "number" and GetSpellLink(SpellID) or SpellID
	MPR_ReportOptions:NewFS(SpellStr,		"BEBEBE",					PosX+0,		PosY)
	MPR_ReportOptions:NewCB("Self",			"1E90FF",	Var.."-1",		PosX+0,		PosY-9)	-- [ ] Self
	MPR_ReportOptions:NewCB("Raid",			"FF7D00",	Var.."-2",		PosX+37,	PosY-9)	-- [ ] Raid
	MPR_ReportOptions:NewCB("Raid Warning",	"FF4700",	Var.."-3",		PosX+78,	PosY-9)	-- [ ] Raid Warning
	MPR_ReportOptions:NewCB("Say",			"FFFFFF",	Var.."-4",		PosX+166,	PosY-9)	-- [ ] Say
	MPR_ReportOptions:NewCB("Whisper",		"FF7EFF",	Var.."-5",		PosX+203,	PosY-9)	-- [ ] Whisper
end

function MPR_ReportOptions:NewGroup(...)
	local PosX
	for i=1,select("#", ...) do
		local array = select(i, ...)
 		if i == 1 then
			PosX, PositionY = array[3], array[4] or PositionY
			MPR_ReportOptions:NewFS(array[1],array[2],PosX,GetPositionY(10))
		else
			MPR_ReportOptions:NewCBGroup(array[1],tostring(array[2]),PosX+3,GetPositionY(26))
		end
	end
end