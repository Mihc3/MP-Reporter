MPR_Options = CreateFrame("Frame", "MPR Options", UIParent);

local framecount = 0
function GetNewID() 
	framecount = framecount + 1
	return framecount
end
function GetCurrentID()
	return framecount
end

function MPR_Options:Initialize()
	MPR_Options:Hide()
	MPR_Options.name = "MPR_Options"
	
	MPR_Options:SetBackdrop({
		bgFile = "Interface\\TabardFrame\\TabardFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 25, insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	MPR_Options:SetBackdropColor(0, 0, 0, 0.7)
	MPR_Options:SetBackdropBorderColor(30/255, 144/255, 255/255)
	
	MPR_Options:SetPoint("CENTER",UIParent)
	MPR_Options:SetWidth(410)
	MPR_Options:SetHeight(232)
	MPR_Options:EnableMouse(true)
	MPR_Options:SetMovable(true)
	MPR_Options:RegisterForDrag("LeftButton")
	MPR_Options:SetUserPlaced(true)
	MPR_Options:SetScript("OnDragStart", function(self) self:StartMoving() end)
	MPR_Options:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	MPR_Options:SetFrameStrata("FULLSCREEN_DIALOG")
	
	--[[ MP Reporter - Options ]]--
	local Title = MPR_Options:CreateFontString("Title"..GetNewID(), "ARTWORK", "GameFontNormal")
	Title:SetPoint("TOP", 0, -12)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	Title:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255) 
	Title:SetText("|cFF1E90FFMP Reporter|r - Options")
	Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	Title:SetShadowOffset(1, -1)
	
	MPR_Options_BtnClose = CreateFrame("button","MPR_Options_BtnClose", MPR_Options, "UIPanelButtonTemplate")
	MPR_Options_BtnClose:SetHeight(14)
	MPR_Options_BtnClose:SetWidth(14)
	MPR_Options_BtnClose:SetPoint("TOPRIGHT", -12, -11)
	MPR_Options_BtnClose:SetText("x")
	MPR_Options_BtnClose:SetScript("OnClick", function(self) MPR_Options:Hide() end)
	
	--[[ General ]]--
	MPR_Options:NewFS("General","00CCFF",16,-30)
	MPR_Options:NewCB("Self",	"1E90FF",	"SELF",14,-44)		-- [ ] Self
	MPR_Options:NewCB("Raid",	"EE7600",	"RAID",54,-44)		-- [ ] Raid
	MPR_Options:NewCB("Say",	"FFFFFF",	"SAY",100,-44)		-- [ ] Say
	MPR_Options:NewCB("Whisper","DA70D6",	"WHISPER",140,-44)	-- [ ] Whisper
	
	-- Reporting...
	MPR_Options:NewFS("Reporting ...","3CB371",16,-63)
	MPR_Options:NewCB("Dispels",nil,"REPORT_DISPELS",14,-74)			-- [ ] Dispels
	MPR_Options:NewCB("Mass Dispels",nil,"REPORT_MASSDISPELS",89,-74)	-- [ ] Mass Dispels
	
	-- Player Deaths
	MPR_Options:NewFS("Player Deaths","3CB371",16,-93)
	MPR_Options:NewCB("Self",	"1E90FF",	"PD_SELF",14,-104)		-- [ ] Self
	MPR_Options:NewCB("Raid",	"EE7600",	"PD_RAID",54,-104)		-- [ ] Raid
	MPR_Options:NewCB("Whisper","DA70D6",	"PD_SAY",100,-104)		-- [ ] Whisper
	MPR_Options:NewCB("Guild",	"40FF40",	"PD_GUILD",160,-104)	-- [ ] Guild
	
	--[[ Aura Info ]]--
	MPR_Options:NewFS("Aura Info","00CCFF",16,-135)
	local Button = CreateFrame("button","BtnToggleAuraInfo", MPR_Options, "UIPanelButtonTemplate")
	Button:SetHeight(18)
	Button:SetWidth(110)
	Button:SetPoint("TOPLEFT", 14, -149)
	Button:SetText("Show window")
	Button:SetScript("OnShow", function(self) Button:SetText(MPR_AuraInfo:IsVisible() and "Hide window" or "Show window") end)
	Button:SetScript("OnClick", function(self)
		if not MPR_AuraInfo:IsVisible() then 
			MPR_AuraInfo:UpdateFrame()
			Button:SetText("Hide window")
		else 
			MPR_AuraInfo:Hide() 
			Button:SetText("Show window")
		end
	end)
	
	-- Frame Update Period slider --
	MPR_Slider = CreateFrame("Slider", "MPR_Slider", MPR_Options, "OptionsSliderTemplate")
	MPR_Slider:SetWidth(160)
	MPR_Slider:SetHeight(20)
	MPR_Slider:SetPoint('TOPLEFT', 20, -181)
	MPR_Slider:SetOrientation('HORIZONTAL')
	
	MPR_Slider:SetMinMaxValues(0.1, 3)
	MPR_Slider:SetValueStep(0.1)
	
	MPR_Slider:SetValue(MPR.Settings["UPDATEFREQUENCY"])
	
	_G[MPR_Slider:GetName().."Low"]:SetText("0.1")
	_G[MPR_Slider:GetName().."High"]:SetText("3")
	_G[MPR_Slider:GetName().."Text"]:SetText("|cFFffffffUpdate Period: "..round(MPR_Slider:GetValue(),1).."s|r")
	
	MPR_Slider:SetScript("OnValueChanged",function()
		_G[MPR_Slider:GetName()..'Text']:SetText("|cFFffffffUpdate Period: "..round(MPR_Slider:GetValue(),1).."s|r")
		MPR.Settings["UPDATEFREQUENCY"] = round(MPR_Slider:GetValue(),1)
	end)
	
	--[[ Miscellaneous ]]--
	MPR_Options:NewFS("Miscellaneous","00CCFF",216,-30)
	MPR_Options:NewCB("Clear combat entries on load",nil,"CCL_ONLOAD",214,-44)	-- [ ] ClearEntriesOnLoad
  	MPR_Options:NewCB("Spell Icons (|r\124T"..select(3, GetSpellInfo(33054))..":12:12:0:0:64:64:5:59:5:59\124t "..GetSpellLink(33054)..")",nil,"ICONS",214,-58) -- [ ] Spell Icons
	
	-- Masterloot
	MPR_Options:NewFS("Masterloot","3CB371",216,-77)
	MPR_Options:NewCB("Report items in loot",nil,"REPORT_LOOT", 214, -88)	-- [ ] ReportLoot
	MPR_Options:NewCB("Only when BoP in loot",nil,"REPORT_LOOT_BOP_ONLY", 234, -102) -- [ ] ReportOnlyWhenBOP
	MPR_Options:NewCB("Add BiS information",nil,"REPORT_LOOT_BIS_INFO", 234, -116) -- [ ] AddClassBISinfo
	
	--[[
	--if not CanEditOfficerNote() then return end
	
	-- DKP Deductions
	MPR_Options:NewFS("DKP Deductions","FF9912",216,-107)
	MPR_Options:NewCB("Automatic",nil,"DKPPENALTIES_AUTO",310,-105)	-- [ ] Automatic
	
	MPR_Options.CB_WHISPER = CreateFrame("CheckButton", "CB_WHISPER", MPR_Options, "UICheckButtonTemplate")
	MPR_Options.CB_WHISPER:SetWidth(20)
	MPR_Options.CB_WHISPER:SetHeight(20)
	MPR_Options.CB_WHISPER:SetPoint("TOPLEFT", 214, -118)
	local Color = "DA70D6"
	_G["CB_WHISPERText"]:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
	_G["CB_WHISPERText"]:SetText("Whisper")
	MPR_Options.CB_WHISPER:SetScript("OnShow",  function(self) MPR_Options.CB_WHISPER:SetChecked(MPR.Settings["DKPPENALTIES_OUTPUT"] == "WHISPER") end)
	MPR_Options.CB_WHISPER:SetScript("OnClick", function(self) MPR.Settings["DKPPENALTIES_OUTPUT"] = "WHISPER"; MPR_Options:HandleChecks() end)
	
	MPR_Options.CB_RAID = CreateFrame("CheckButton", "CB_RAID", MPR_Options, "UICheckButtonTemplate")
	MPR_Options.CB_RAID:SetWidth(20)
	MPR_Options.CB_RAID:SetHeight(20)
	MPR_Options.CB_RAID:SetPoint("TOPLEFT", 276, -118)
	local Color = "EE7600"
	_G["CB_RAIDText"]:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
	_G["CB_RAIDText"]:SetText("Raid")
	MPR_Options.CB_RAID:SetScript("OnShow",  function(self) MPR_Options.CB_RAID:SetChecked(MPR.Settings["DKPPENALTIES_OUTPUT"] == "RAID") end)
	MPR_Options.CB_RAID:SetScript("OnClick", function(self) MPR.Settings["DKPPENALTIES_OUTPUT"] = "RAID"; MPR_Options:HandleChecks() end)
	
	MPR_Options.CB_GUILD = CreateFrame("CheckButton", "CB_GUILD", MPR_Options, "UICheckButtonTemplate")
	MPR_Options.CB_GUILD:SetWidth(20)
	MPR_Options.CB_GUILD:SetHeight(20)
	MPR_Options.CB_GUILD:SetPoint("TOPLEFT", 320, -118)
	local Color = "40FF40"
	_G["CB_GUILDText"]:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
	_G["CB_GUILDText"]:SetText("Guild")
	MPR_Options.CB_GUILD:SetScript("OnShow",  function(self) MPR_Options.CB_GUILD:SetChecked(MPR.Settings["DKPPENALTIES_OUTPUT"] == "GUILD") end)
	MPR_Options.CB_GUILD:SetScript("OnClick", function(self) MPR.Settings["DKPPENALTIES_OUTPUT"] = "GUILD"; MPR_Options:HandleChecks() end)
	
	MPR_Options:NewFS("AoE Spell",nil,214,Pack_PosY-4)
	MPR_Options:NewFS("Amount",nil,350,Pack_PosY-4)
	Pack_PosY = Pack_PosY - 16
	for SpellName, Data in pairs(MPR.DKPPenalties) do
		local Enabled, Amount = Data
		MPR_Options:NewPack(SpellName,Enabled,Amount)
		Pack_PosY = Pack_PosY - 14
	end
	]]
end

Pack_PosY = -133
function MPR_Options:NewPack(SpellName,Enabled,Amount)
	local CheckBox = CreateFrame("CheckButton", "CheckBox"..GetNewID(), MPR_Options, "UICheckButtonTemplate")
	CheckBox:SetWidth(20)
	CheckBox:SetHeight(20)
	CheckBox:SetPoint("TOPLEFT", 213, Pack_PosY)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	_G["CheckBox"..GetCurrentID().."Text"]:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
	_G["CheckBox"..GetCurrentID().."Text"]:SetText("["..SpellName.."]")
	CheckBox:SetScript("OnShow",  function(self) CheckBox:SetChecked(MPR.DKPPenalties[SpellName][1]) end)
	CheckBox:SetScript("OnClick", function(self) MPR.DKPPenalties[SpellName][1] = not MPR.DKPPenalties[SpellName][1] end)
	
	local Label = MPR_Options:CreateFontString("Label"..GetNewID(), "ARTWORK", "GameFontNormal")
	Label:SetPoint("TOPLEFT", 378, Pack_PosY)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	Label:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255) 
	Label:SetText(MPR.DKPPenalties[SpellName][2])
	
	local Button = CreateFrame("button","BtnDKPMore"..GetCurrentID(), MPR_Options, "UIPanelButtonTemplate")
	Button:SetHeight(14)
	Button:SetWidth(14)
	Button:SetPoint("TOPLEFT", 350, Pack_PosY)
	Button:SetText("+")
	Button:SetScript("OnClick", function(self) MPR.DKPPenalties[SpellName][2] = MPR.DKPPenalties[SpellName][2] + 1; Label:SetText(MPR.DKPPenalties[SpellName][2]) end)
	
	local Button = CreateFrame("button","BtnDKPLess"..GetCurrentID(), MPR_Options, "UIPanelButtonTemplate")
	Button:SetHeight(14)
	Button:SetWidth(14)
	Button:SetPoint("TOPLEFT", 364, Pack_PosY)
	Button:SetText("-")
	Button:SetScript("OnClick", function(self) if MPR.DKPPenalties[SpellName][2] > 1 then MPR.DKPPenalties[SpellName][2] = MPR.DKPPenalties[SpellName][2] - 1 end; Label:SetText(MPR.DKPPenalties[SpellName][2]) end)
end

function MPR_Options:HandleChecks()
	MPR_Options.CB_WHISPER:SetChecked(MPR.Settings["DKPPENALTIES_OUTPUT"] == "WHISPER")
	MPR_Options.CB_RAID:SetChecked(MPR.Settings["DKPPENALTIES_OUTPUT"] == "RAID")
	MPR_Options.CB_GUILD:SetChecked(MPR.Settings["DKPPENALTIES_OUTPUT"] == "GUILD")
end

function MPR_Options:NewFS(Text,Color,LocX,LocY) -- Creates a fontstring
	local Title = MPR_Options:CreateFontString("Title"..GetNewID(), "ARTWORK", "GameFontNormal")
	Title:SetPoint("TOPLEFT", LocX, LocY)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	Title:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255) 
	Title:SetText(Text)
end

function MPR_Options:NewCB(Text,Color,Var,LocX,LocY) -- Creates a checkbox
	local CheckBox = CreateFrame("CheckButton", "CheckBox"..GetNewID(), MPR_Options, "UICheckButtonTemplate")
	CheckBox:SetWidth(20)
	CheckBox:SetHeight(20)
	CheckBox:SetPoint("TOPLEFT", LocX, LocY)
	if type(Color) ~= "string" then Color = "FFFFFF" end
	_G["CheckBox"..GetCurrentID().."Text"]:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
	_G["CheckBox"..GetCurrentID().."Text"]:SetText(Text)
	CheckBox:SetScript("OnShow",  function(self) CheckBox:SetChecked(MPR.Settings[Var]) end)
	CheckBox:SetScript("OnClick", function(self) MPR.Settings[Var] = not MPR.Settings[Var] end)
end