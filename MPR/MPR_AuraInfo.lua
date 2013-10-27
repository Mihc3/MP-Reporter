MPR_AuraInfo = CreateFrame("Frame", "MPR Aura Info", UIParent)
MPR_AuraInfo.Loaded = false
MPR_AuraInfo.TimeSinceLastUpdate = 0
MPR_AuraInfo.FrameNumber = nil
MPR_AuraInfo.FrameNumbers = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,18,19,20,21,22,23}
MPR_AuraInfo.FrameSize = nil
MPR_AuraInfo.MaxFrameSize = nil
MPR_AuraInfo.Strings = {
--  [i] = {FrameSize, Subtitle.text, Name1.text, Text1.fontsize, nNme2.text, Text2.fontsize, Name3.text, Text3.fontsize, Name4.text, Text4.fontsize},
    [1] = {1, "ICC: Lord Marrowgar",        GetSpellLink(69065).." on: |cFFbebebe(health)|r", 16},
    [2] = {1, "ICC: Lady Deathwhisper",     GetSpellLink(71289).." on: |cFFbebebe(health)(expiration)|r", 16},
    [3] = {1, "ICC: Gunship Battle",        "Ships (Hit Points):", 16},
    [4] = {1, "ICC: Saurfang Deathbringer", GetSpellLink(72448).." on: |cFFbebebe(expiration)|r", 18},
    [5] = {2, "ICC: Festergut",             GetSpellLink(72219).." on: |cFFbebebe|r", 18,
                                            GetSpellLink(72103).." (without 3 stacks) on:", nil},
    [6] = {1, "ICC: Rotface",               GetSpellLink(69674).." on: |cFFbebebe(expiration)|r", 18},
    [7] = {4, "ICC: Professor Putricide",   GetSpellLink(70853).." on: |cFFbebebe(-200% casting speed)|r", nil,
                                            GetSpellLink(71279).." on: |cFFbebebe(-75% hit chance)|r", nil,
                                            GetSpellLink(72672).." on: |cFFbebebe(stacks)(expiration)|r", 16,
                                            GetSpellLink(72854).." on: |cFFbebebe(expiration)|r", 18},
    [8] = {2, "ICC: Blood Prince Council",  GetSpellLink(71822).." on: |cFFbebebe(count)|r", 16,
                                            GetSpellLink(72999).." on: |cFFbebebe(stacks)|r", nil},
    [9] = {3, "ICC: Blood-Queen Lana'thel", GetSpellLink(71473).." on: |cFFbebebe(biten)|r", nil,
                                            GetSpellLink(70877).." on: |cFFbebebe(must bite)|r", nil,
                                            GetSpellLink(70923).." on: |cFFbebebe(bite failed)|r", nil},
    [10] = {2, "ICC: Dreamwalker Valithria","Boss Health, HPS:", 16,
                                            GetSpellLink(70873).." or "..GetSpellLink(71941).." on:", 16},
    [11] = {3, "ICC: Sindragosa",           GetSpellLink(72530).." on: |cFFbebebe(stacks)|r (Phase 3)", nil,
                                            GetSpellLink(69766).." on: |cFFbebebe(stacks)(expiration)|r", nil,
                                            GetSpellLink(70106).." on: |cFFbebebe(stacks)(expiration)|r", nil},
    [12] = {3, "ICC: The Lich King",        GetSpellLink(70337).." on: |cFFbebebe(next hit)|r", 18,
                                            GetSpellLink(70541).." on: |cFFbebebe(health)|r", nil,
                                            GetSpellLink(72133).." on: |cFFbebebe(5 stacks)|r", nil},
    [13] = {1, "TOC: Gormok the Impaler",   GetSpellLink(66331).." on: |cFFbebebe(stacks)(expiration)|r", 14},                    
    [14] = {1, "TOC: Acidmaw & Dreadscale", GetSpellLink(67619).." on: |cFFbebebe(health)(expiration)|r", 14},
    [16] = {2, "TOC: Lord Jaraxxus",        GetSpellLink(66209).." on: |cFFbebebe(must run away)|r", 18,
                                            GetSpellLink(66211).." on: |cFFbebebe(must be dispeled)|r", nil},
    [18] = {1, "TOC: Twin Valkyr",          "Without "..GetSpellLink(65684).." or "..GetSpellLink(65686)..":", nil},
    [19] = {1, "TOC: Anub'arak",            "DPS, Assumed Finish:", nil},
    [20] = {1, "RS: Saviana Ragefire",      GetSpellLink(78722).." on: |cFFbebebe(expiration)(|r"..GetSpellLink(78723).."|cFFbebebe hits left)|r", 14},
    [21] = {1, "RS: Baltharus the Warborn", GetSpellLink(74502).." on: |cFFbebebe(stacks)|r", nil},
    [22] = {1, "RS: General Zarithrian",    GetSpellLink(74367).." on: |cFFbebebe(stacks)(expiration)|r", 14},
    [23] = {2, "RS: Halion",                GetSpellLink(74792).." or "..GetSpellLink(74562).." on: |cFFbebebe|r", 18,
                                            GetSpellLink(74826).." (Phase 3): n/a", nil},
}

function Halion_CorporealityInfo(SpellID)
    if SpellID == 74836 then
        return "FF0000","0","-100","-70","+400","+200"
    elseif SpellID == 74835 then
        return "FF0000","10","-80","-50","+200","+100"
    elseif SpellID == 74834 then
        return "FFFF00","20","-50","-30","+100","+60"
    elseif SpellID == 74833 then
        return "FFFF00","30","-30","-20","+50","+30"
    elseif SpellID == 74832 then
        return "00FF00","40","-15","-10","+20","+15"
    elseif SpellID == 74826 then
        return "00FF00","50","+0","+0","+0","+0"
    elseif SpellID == 74827 then
        return "00FF00","60","+20","+15","-15","-10"
    elseif SpellID == 74828 then
        return "FFFF00","70","+50","+30","-30","-20"
    elseif SpellID == 74829 then
        return "FFFF00","80","+100","+60","-50","-30"
    elseif SpellID == 74830 then
        return "FF0000","90","+200","+100","-80","-50"
    elseif SpellID == 74831 then
        return "FF0000","100","+400","+200","-100","-70"
    else
        error("Unknown Corporeality ID: "..tostring(SpellID))
    end
end

function cursorInHitBox(frame)
    local x = GetCursorPosition()
    local fX = frame:GetCenter()
    local hitBoxSize = -100 -- default value from the default UI template
    return x - fX < hitBoxSize
end
local currActiveButton
local updateFrame = CreateFrame("Frame")
function onUpdate(self, elapsed)
    local inHitBox = cursorInHitBox(currActiveButton)
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    x, y = x / scale, y / scale
    GameTooltip:SetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", x + 5, y + 2)
end
function onHyperlinkClick(self, data, link)
    if IsShiftKeyDown() then
        local msg = link:gsub("|h(.*)|h", "|h[%1]|h")
        local chatWindow = ChatEdit_GetActiveWindow()
        if chatWindow then
            chatWindow:Insert(msg)
        end
    end
end
function onHyperlinkEnter(self, data, link)
    GameTooltip:SetOwner(self, "ANCHOR_NONE") -- I want to anchor BOTTOMLEFT of the tooltip to the cursor... (not BOTTOM as in ANCHOR_CURSOR)
    GameTooltip:SetHyperlink(data)
    GameTooltip:Show()
    currActiveButton = self:GetParent()
    updateFrame:SetScript("OnUpdate", onUpdate)
end
function onHyperlinkLeave(self, data, link)
    GameTooltip:Hide()
    updateFrame:SetScript("OnUpdate", nil)
end

function MPR_AuraInfo:UnitRaid(Name)
    local Colors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA", ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
    return string.format("|cFF%s%s|r",Colors[strupper(select(2, UnitClass(Name)))],Name)
end

function MPR_AuraInfo:Initialize()
    MPR_AuraInfo:Hide()
    MPR_AuraInfo.name = "MPR_AuraInfo"
    MPR_AuraInfo:SetBackdrop(MPR.Settings["BACKDROP"])
    MPR_AuraInfo:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
    MPR_AuraInfo:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)
    MPR_AuraInfo:SetPoint("CENTER",UIParent)
    MPR_AuraInfo:EnableMouse(true)
    MPR_AuraInfo:SetMovable(true)
    MPR_AuraInfo:RegisterForDrag("LeftButton")
    MPR_AuraInfo:SetUserPlaced(true)
    MPR_AuraInfo:SetScript("OnDragStart", function(self) MPR_AuraInfo:StartMoving() end)
    MPR_AuraInfo:SetScript("OnDragStop", function(self) MPR_AuraInfo:StopMovingOrSizing() end)
    MPR_AuraInfo:SetScript("OnUpdate", function(self, elapsed) if MPR.Settings["AURAINFO"] and MPR_AuraInfo:IsVisible() then MPR_AuraInfo:OnUpdate(elapsed) end end)
    MPR_AuraInfo:SetFrameStrata("FULLSCREEN_DIALOG")
    
    MPR_AuraInfo:SetWidth(250)
    MPR_AuraInfo:SetHeight(238) -- 114, 176, 238
    
    MPR_AuraInfo.Title = MPR_AuraInfo:CreateFontString(nil, "OVERLAY", "GameTooltipText")
    MPR_AuraInfo.Title:SetPoint("TOP", 0, -8)
    MPR_AuraInfo.Title:SetTextColor(190/255, 190/255, 190/255)
    MPR_AuraInfo.Title:SetText("|cff"..MPR.Colors["TITLE"].."MP Reporter|r - Aura Info")
    MPR_AuraInfo.Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    MPR_AuraInfo.Title:SetShadowOffset(1, -1)
    
    Button1 = CreateFrame("button","BtnPrev", MPR_AuraInfo, "UIPanelButtonTemplate")
    Button1:SetHeight(14)
    Button1:SetWidth(14)
    Button1:SetPoint("TOPLEFT", 8, -8)
    Button1:SetText("<")
    Button1:SetScript("OnShow", function(self) 
        if MPR_AuraInfo.FrameNumber == 1 then
            Button1:Disable()
        end
        Button2:Enable()
    end)
    Button1:SetScript("OnClick", function(self)
        MPR_AuraInfo:UpdateFrameNumber(false)
        if MPR_AuraInfo.FrameNumber == 1 then
            Button1:Disable()
        end
        Button2:Enable()
    end)
    
    Button2 = CreateFrame("button","BtnNext", MPR_AuraInfo, "UIPanelButtonTemplate")
    Button2:SetHeight(14)
    Button2:SetWidth(14)
    Button2:SetPoint("TOPRIGHT", -8, -8)
    Button2:SetText(">")
    Button2:SetScript("OnShow", function(self)
        if MPR_AuraInfo.FrameNumber == MPR_AuraInfo.FrameNumbers[#MPR_AuraInfo.FrameNumbers] then
            Button2:Disable()
        end
        Button1:Enable()
    end)
    Button2:SetScript("OnClick", function(self)
        MPR_AuraInfo:UpdateFrameNumber(true)
        if MPR_AuraInfo.FrameNumber == MPR_AuraInfo.FrameNumbers[#MPR_AuraInfo.FrameNumbers] then
            Button2:Disable()
        end
        Button1:Enable()
    end)
    
    Button3 = CreateFrame("button","BtnLess", MPR_AuraInfo, "UIPanelButtonTemplate")
    Button3:SetHeight(14)
    Button3:SetWidth(14)
    Button3:SetPoint("TOPLEFT", "BtnPrev", "TOPRIGHT", 2, 0)
    Button3:SetText("-")
    Button3:SetScript("OnClick", function(self) MPR_AuraInfo:UpdateFrameSize(false) end)
    
    Button4 = CreateFrame("button","BtnMore", MPR_AuraInfo, "UIPanelButtonTemplate")
    Button4:SetHeight(14)
    Button4:SetWidth(14)
    Button4:SetPoint("TOPLEFT", "BtnLess", "TOPRIGHT", 1, 0)
    Button4:SetText("+")
    Button4:SetScript("OnClick", function(self) MPR_AuraInfo:UpdateFrameSize(true) end)
    
    Button5 = CreateFrame("button","BtnClose", MPR_AuraInfo, "UIPanelButtonTemplate")
    Button5:SetHeight(14)
    Button5:SetWidth(14)
    Button5:SetPoint("TOPRIGHT", "BtnNext", "TOPLEFT", -2, 0)
    Button5:SetText("x")
    Button5:SetScript("OnClick", function(self) MPR_AuraInfo.FrameNumber = nil; MPR_AuraInfo:Hide() end)
    
    Subtitle = MPR_AuraInfo:CreateFontString("Subtitle", "OVERLAY", "GameTooltipText")
    Subtitle:SetPoint("TOPLEFT", 8, -22)
    Subtitle:SetTextColor(0/255, 204/255, 255/255)
    Subtitle:SetText("Instance: Boss")
    
    -- 1 --
    -- Testing HTML Frame
    Name1 = CreateFrame("SimpleHTML", "Name1", MPR_AuraInfo);
    Name1:SetWidth(MPR_AuraInfo:GetWidth()-2*8)
    Name1:SetHeight(12)
    Name1:SetPoint("TOPLEFT", 8, -36)
    Name1:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    Name1:SetText("Name1")
    Name1:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Name1:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Name1:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    Text1 = CreateFrame("SimpleHTML", "Text1", MPR_AuraInfo);
    Text1:SetHeight(50)
    Text1:SetWidth(MPR_AuraInfo:GetWidth()-2*9)
    Text1:SetPoint("TOPLEFT",9,-48)
    Text1:SetJustifyV("TOP")
    Text1:SetTextColor(190/255, 190/255, 190/255)
    Text1:SetFont("Fonts\\FRIZQT__.TTF", 9, nil)
    Text1:SetText("Text1")
    Text1:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Text1:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Text1:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    -- 2 --
    Name2 = CreateFrame("SimpleHTML", "Name2", MPR_AuraInfo);
    Name2:SetWidth(MPR_AuraInfo:GetWidth()-2*8)
    Name2:SetHeight(12)
    Name2:SetPoint("TOPLEFT", 8, -98)
    Name2:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    Name2:SetText("Name2")
    Name2:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Name2:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Name2:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    Text2 = CreateFrame("SimpleHTML", "Text2", MPR_AuraInfo);
    Text2:SetHeight(50)
    Text2:SetWidth(MPR_AuraInfo:GetWidth()-2*9)
    Text2:SetPoint("TOPLEFT",9,-110)
    Text2:SetJustifyV("TOP")
    Text2:SetTextColor(190/255, 190/255, 190/255)
    Text2:SetFont("Fonts\\FRIZQT__.TTF", 9, nil)
    Text2:SetText("Text2")
    Text2:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Text2:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Text2:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    -- 3 --
    Name3 = CreateFrame("SimpleHTML", "Name3", MPR_AuraInfo);
    Name3:SetWidth(MPR_AuraInfo:GetWidth()-2*8)
    Name3:SetHeight(12)
    Name3:SetPoint("TOPLEFT", 8, -160)
    Name3:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    Name3:SetText("Name3")
    Name3:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Name3:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Name3:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    Text3 = CreateFrame("SimpleHTML", "Text3", MPR_AuraInfo);
    Text3:SetHeight(50)
    Text3:SetWidth(MPR_AuraInfo:GetWidth()-2*9)
    Text3:SetPoint("TOPLEFT",9,-172)
    Text3:SetJustifyV("TOP")
    Text3:SetTextColor(190/255, 190/255, 190/255)
    Text3:SetFont("Fonts\\FRIZQT__.TTF", 9, nil)
    Text3:SetText("Text3")
    Text3:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Text3:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Text3:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    -- 4 --
    Name4 = CreateFrame("SimpleHTML", "Name4", MPR_AuraInfo);
    Name4:SetWidth(MPR_AuraInfo:GetWidth()-2*8)
    Name4:SetHeight(12)
    Name4:SetPoint("TOPLEFT", 8, -222)
    Name4:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)
    Name4:SetText("Name4")
    Name4:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Name4:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Name4:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    Text4 = CreateFrame("SimpleHTML", "Text4", MPR_AuraInfo);
    Text4:SetHeight(50)
    Text4:SetWidth(MPR_AuraInfo:GetWidth()-2*9)
    Text4:SetPoint("TOPLEFT",9,-234)
    Text4:SetJustifyV("TOP")
    Text4:SetTextColor(190/255, 190/255, 190/255)
    Text4:SetFont("Fonts\\FRIZQT__.TTF", 9, nil)
    Text4:SetText("Text4")
    Text4:SetScript("OnHyperlinkClick", OnHyperlinkClick)
    Text4:SetScript("OnHyperlinkEnter", onHyperlinkEnter)
    Text4:SetScript("OnHyperlinkLeave", onHyperlinkLeave)
    
    MPR_AuraInfo.Loaded = true
end

function MPR_AuraInfo:ClearFrame(n)
    MPR_AuraInfo.FrameSize = n
    MPR_AuraInfo.MaxFrameSize = n
    MPR_AuraInfo:UpdateFrameSize()
    --MPR:SetHeight(n == 1 and 114 or n == 2 and 176 or n == 3 and 238 or n == 4 and 300 or 52)
    Name1:SetText("")
    Text1:SetText("")
    Name2:SetText("")
    Text2:SetText("")
    Name3:SetText("")
    Text3:SetText("")
    Name4:SetText("")
    Text4:SetText("")
end

function MPR_AuraInfo:UpdateFrameSize(more)
    if more ~= nil then 
        MPR_AuraInfo.FrameSize = more and MPR_AuraInfo.FrameSize + 1 or MPR_AuraInfo.FrameSize - 1
    end
    local NewHeight = 44
    Name1:Hide()
    Text1:Hide()
    Name2:Hide()
    Text2:Hide()
    Name3:Hide()
    Text3:Hide()
    Name4:Hide()
    Text4:Hide()
    if MPR_AuraInfo.FrameSize > 0 then
        NewHeight = 106
        Name1:Show()
        Text1:Show()
        if MPR_AuraInfo.FrameSize > 1 then
            NewHeight = 168
            Name2:Show()
            Text2:Show()
            if MPR_AuraInfo.FrameSize > 2 then
                NewHeight = 230
                Name3:Show()
                Text3:Show()
                if MPR_AuraInfo.FrameSize > 3 then
                    NewHeight = 292
                    Name4:Show()
                    Text4:Show()
                end
            end
        end
    end
    MPR_AuraInfo:SetHeight(NewHeight)
    BtnLess:Enable()
    BtnMore:Enable()
    if MPR_AuraInfo.FrameSize <= 0 then
        BtnLess:Disable()
    elseif MPR_AuraInfo.FrameSize >= MPR_AuraInfo.MaxFrameSize then
        BtnMore:Disable()
    end
end

function MPR_AuraInfo:UpdateFrameNumber(up)
    for i,num in pairs(MPR_AuraInfo.FrameNumbers) do
        if num == MPR_AuraInfo.FrameNumber then
            MPR_AuraInfo:UpdateFrame(MPR_AuraInfo.FrameNumbers[up and i + 1 or i - 1])
            return
        end    
    end
end

function MPR_AuraInfo:UpdateFrame(num)    
    if num == nil then
        num = MPR_AuraInfo.FrameNumber or 1
        MPR_AuraInfo.FrameNumber = MPR_AuraInfo.FrameNumber or 1
    elseif num == MPR_AuraInfo.FrameNumber then
        MPR_AuraInfo.FrameNumber = nil
        MPR_AuraInfo:Hide()
        return
    else
        MPR_AuraInfo.FrameNumber = num
    end
    
    local AI_Strings = MPR_AuraInfo.Strings[num] or nil
    if not AI_Strings then error("Unknown frame number: "..tostring(num)) end
    
    MPR_AuraInfo:ClearFrame(AI_Strings[1])
    Subtitle:SetText(AI_Strings[2])
    
    Name1:SetText(AI_Strings[3])
    if MPR_AuraInfo.FrameNumber == 3 then
        Name1:SetText("|cFF6666FFSkybreaker|r and |cFFFF6666Orgrim's Hammer|r (Hit Points):")
    end
    Text1:SetFont("Fonts\\FRIZQT__.TTF", AI_Strings[4] or 9, nil)
    if num > 1 then
        Name2:SetText(AI_Strings[5])
        Text2:SetFont("Fonts\\FRIZQT__.TTF", AI_Strings[6] or 9, nil)
        if num > 2 then
            Name3:SetText(AI_Strings[7])
            Text3:SetFont("Fonts\\FRIZQT__.TTF", AI_Strings[8] or 9, nil)
            if num > 3 then
                Name4:SetText(AI_Strings[9])
                Text4:SetFont("Fonts\\FRIZQT__.TTF", AI_Strings[10] or 9, nil)
            end
        end
    end
    
    if 1 <= num and num <= 12 then -- ICC
        Subtitle:SetTextColor(0/255, 204/255, 255/255)
    elseif 13 <= num and num <= 19 then -- TOC
        Subtitle:SetTextColor(60/255, 170/255, 80/255)
    elseif 20 <= num and num <= 23 then -- RS
        Subtitle:SetTextColor(255/255, 153/255, 18/255)
    end
    
    MPR_AuraInfo:Show()
    if not MPR.Settings["AURAINFO"] then
        MPR:SelfReport("Aura Info is |cFFFF0000disabled|r. |cff3588ff|HMPR:Options:Show|h[Options]|h|r")
    end
end

function MPR_AuraInfo:OnUpdate(elapsed)
    MPR_AuraInfo.TimeSinceLastUpdate = MPR_AuraInfo.TimeSinceLastUpdate + elapsed
    if MPR_AuraInfo.TimeSinceLastUpdate >= MPR.Settings["UPDATEFREQUENCY"] then
        local diff = MPR_AuraInfo.TimeSinceLastUpdate
        MPR_AuraInfo.TimeSinceLastUpdate = 0
        MPR_AuraInfo:UpdateFrameData(diff)
    end
end

function MPR_AuraInfo:GetBossID(Name)
    for i=1,GetNumRaidMembers() do
        if UnitName("raid"..i.."target") == Name then
            return "raid"..i.."target"
        end
    end
    return nil, (GetNumRaidMembers() > 0 and "Looking for "..Name.." UnitID ..." or "Not in a raid group.")
end

function MPR_AuraInfo:GetBuffInfo(Unit,Name)
    local i = 0
    while true do
        i = i + 1
        local Buff, _, _, Count, _, _, ExpirationTime, _, _, _, SpellID = UnitBuff(Unit,i)
        if not Buff then
            break
        elseif Buff == Name then
            return Buff, Count, ExpirationTime, SpellID
        end
    end
end

-- Variables
local GB_String1, GB_LastCheck, GB_LastCheckHP, Under10Pct, Under5Pct, Under3Pct -- Gunship Battle
local VD_String1, VD_LastCheck, VD_LastCheckHP = "" -- Valithria Dreamwalker
local AR_LastCheck, AR_LastCheckHP -- Anub'arak
--

function MPR_AuraInfo:UpdateFrameData(diff)
    if not MPR_AuraInfo.FrameNumber then return end
    
    if MPR_AuraInfo.FrameNumber == 1 then -- ICC: Lord Marrowgar
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            if UnitDebuff(Unit,"Impaled") then
                local Health = round(UnitHealth(Unit) * 100 / UnitHealthMax(Unit),0,true)
                table.insert(array,string.format("%s (%s%%)",self:UnitRaid(Unit),Health))
            end
        end
        Text1:SetText(table.concat(array,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 2 then -- ICC: Lady Deathwhisper
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Dominate Mind")
            if Debuff then
                local Health = round(UnitHealth(Unit) * 100 / UnitHealthMax(Unit),0,true)
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array,string.format("%s (%s%%)(%ss)",self:UnitRaid(Unit),Health,Expiration))
            end
        end
        Text1:SetText(table.concat(array,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 3 then -- ICC: Gunship Battle
        --if not (UnitName("Boss1") == "Skybreaker" or UnitName("Boss1") == "Orgrim's Hammer") then return end
        local A_Health, A_HealthMax = UnitHealth("Boss2"), UnitHealthMax("Boss2")
        local H_Health, H_HealthMax = UnitHealth("Boss1"), UnitHealthMax("Boss1")
        local Skybreaker, OgrimsHammer = "|cFF6666FFSB|r", "|cFFFF6666OH|r"
        local Alliance = UnitFactionGroup("player") == "Alliance"
        local A_Ship, H_Ship = Alliance and Skybreaker or OgrimsHammer, Alliance and OgrimsHammer or Skybreaker
        local String = ""
        String = String..A_Ship..": "
        if A_HealthMax > 0 then
            String = String..string.format("%sk / %sk (%s%%)\n", math.floor(A_Health*10^-3), math.floor(A_HealthMax*10^-3), round(100*A_Health/A_HealthMax,0,true))
        else
            String = String.."No information\n"
        end
        String = String..H_Ship..": "
        if H_HealthMax > 0 then
            String = String..string.format("%sk / %sk (%s%%)\n", math.floor(H_Health*10^-3), math.floor(H_HealthMax*10^-3), round(100*H_Health/H_HealthMax,0,true))
        else
            String = String.."No information\n"
        end
        
        if H_Health > 0 then
            GB_LastCheck = (GB_LastCheck or 0) + diff
            if not GB_LastCheckHP then
                GB_LastCheckHP = H_Health
                GB_LastCheck = 0
                GB_String1 = "DPS: nil; - Est. Finish: nil"
            elseif GB_LastCheck >= 5 then
                local HealthDiff = GB_LastCheckHP - H_Health
                local DPS = HealthDiff/GB_LastCheck
                local TimeLeft = H_Health/DPS
                
                GB_LastCheckHP = H_Health
                GB_LastCheck = 0
                GB_String1 = string.format("DPS: %s; Est. Finish: %s sec", round(DPS,-2,true), round(TimeLeft,0,true))
            end
        else
            GB_String1 = "DPS: nil; - Est. Finish: nil"
        end
        
        Text1:SetText(String..GB_String1)
        
        -- Warning: FALL BACK!
        if round(100*H_Health/H_HealthMax,0,true) <= 10 and not Under10Pct then
            Under10Pct = true
            MPR:RaidReport("Warning: Enemy ship has 10% HP remaining!")
        elseif round(100*H_Health/H_HealthMax,0,true) > 10 and Under10Pct then
            Under10Pct = nil
        end
        
        if round(100*H_Health/H_HealthMax,0,true) <= 5 and not Under5Pct then
            Under5Pct = true
            MPR:RaidReport("Warning: Enemy ship has 5% HP remaining! Prepare to fall back!")    
        elseif round(100*H_Health/H_HealthMax,0,true) > 5 and Under5Pct then
            Under5Pct = nil
        end
        
        if round(100*H_Health/H_HealthMax,0,true) <= 3 and not Under3Pct then
            Under3Pct = true
            MPR:RaidReport("Warning: Enemy ship has 3% HP remaining! FALL BACK!!")
        elseif round(100*H_Health/H_HealthMax,0,true) > 3 and Under3Pct then
            Under3Pct = nil
        end
    elseif MPR_AuraInfo.FrameNumber == 4 then -- ICC: Saurfang Deathbringer
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Rune of Blood")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
        end
        Text1:SetText(table.concat(array,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 5 then -- ICC: Festergut
        local array1 = {}
        local array2 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            if UnitIsConnected(Unit) and not UnitIsDeadOrGhost(Unit) and UnitAffectingCombat(Unit) then
                local Count = select(4,UnitDebuff(Unit,"Gastric Bloat")) or 0
                if Count > 0 then
                    table.insert(array1,string.format("%s (%s)",self:UnitRaid(Unit),Count))
                end
                local Count = select(4,UnitDebuff(Unit,"Inoculated")) or 0
                if Count < 3 then
                    table.insert(array2,string.format("%s (%s)",self:UnitRaid(Unit),Count))
                end
            end
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,", "))
    elseif MPR_AuraInfo.FrameNumber == 6 then -- ICC: Rotface
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Mutated Infection")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
        end
        Text1:SetText(table.concat(array,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 7 then -- ICC: Professor Putricide
        local array1 = {}
        local array2 = {}
        local array3 = {}
        local array4 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Malleable Goo")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array1,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
            Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Choking Gas Explosion")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array2,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
            Debuff, _, _, Count, _, _, ExpirationTime = UnitDebuff(Unit,"Mutated Plague")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array3,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end
            Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Unbound Plague")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array4,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,", "))
        Text3:SetText(table.concat(array3,"\n"))
        Text4:SetText(table.concat(array4,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 8 then -- ICC: Blood Prince Council
        local array1 = {}
        local array2 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            if UnitDebuff(Unit,"Shadow Resonance") then
                local Count = 0
                for i=1,40 do
                    if UnitDebuff(Unit,i) == "Shadow Resonance" then Count = Count + 1 end
                end
                table.insert(array1,string.format("%s (%s)",self:UnitRaid(Unit),Count))
            end
            Debuff, _, _, Count, _, _, ExpirationTime = UnitDebuff(Unit,"Shadow Prison")
            if Debuff and Count >= 10 then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array2,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,", "))
    elseif MPR_AuraInfo.FrameNumber == 9 then -- ICC: Blood-Queen Lana'thel
        local array1 = {}
        local array2 = {}
        local array3 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, ExpirationTime
            Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Essence of the Blood Queen")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array1,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            else
                Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Frenzied Bloodthirst")
                if Debuff then
                    local Expiration = round(ExpirationTime-GetTime(),0,true)
                    table.insert(array2,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
                else
                    Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Uncontrollable Frenzy")
                    if Debuff then
                        --local Expiration = round(ExpirationTime-GetTime(),0,true)
                        local Health = round(UnitHealth(Unit) * 100 / UnitHealthMax(Unit),0,true)
                        table.insert(array3,string.format("%s (%s%%)",self:UnitRaid(Unit),Health))
                    end
                end
            end            
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,", "))
        Text3:SetText(table.concat(array3,", "))
    elseif MPR_AuraInfo.FrameNumber == 10 then -- ICC: Dreamwalker Valithria
        local String
        local UnitID = UnitName("Boss1") == "Valithria Dreamwalker" and "Boss1" or UnitName("Boss2") == "Valithria Dreamwalker" and "Boss2" or "Boss3"
        if UnitName(UnitID) == "Valithria Dreamwalker" then
            local Health, HealthMax = UnitHealth(UnitID), UnitHealthMax(UnitID)
            local HealthPct = math.floor(Health*100/HealthMax) + (Health == HealthMax and 0 or 1)
            String = string.format("|cFF00ff00VD|r: %.1fM/%.1fM (%i%%)", round(Health/1000000,1,true), round(HealthMax/1000000,1,true), HealthPct)
            
            VD_LastCheck = (VD_LastCheck or 0) + diff
            if not VD_LastCheckHP then
                VD_LastCheckHP = Health
                VD_LastCheck = 0
                VD_String1 = "Diff/HPS: No information"
            elseif VD_LastCheck >= 5 then
                local HealthDiff = VD_LastCheckHP - Health
                local HPS = HealthDiff/VD_LastCheck
                local strHPS = ""
                strHPS = "|cFF"..(HPS > 0 and "00FF" or "FF00").."00"..tostring(round(HPS,-3,true)).."k|r"
                
                VD_LastCheckHP = Health
                VD_LastCheck = 0
                VD_String1 = string.format("Diff/HPS: %s", strHPS)
            end
        else
            String = "|cFF00ff00VD|r: No information"
        end
        Text1:SetText(String.."\n"..VD_String1)
        
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, Count, _, _, ExpiraitonTime = UnitDebuff(Unit,"Emerald Vigor")
            if Debuff then
                local Expiration = round(ExpiraitonTime-GetTime(),0,true)
                table.insert(array,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end
            local Debuff, _, _, Count, _, _, ExpiraitonTime = UnitDebuff(Unit,"Twisted Nightmares")
            if Debuff then
                local Expiration = round(ExpiraitonTime-GetTime(),0,true)
                table.insert(array,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end
        end
        Text2:SetText(table.concat(array,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 11 then -- ICC: Sindragosa
        local array1 = {}
        local array2 = {}
        local array3 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, Count, _, _, ExpirationTime = UnitDebuff(Unit,"Mystic Buffet")
            if Debuff and Count >= 5 then
                --local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array1,string.format("%s (%s)",self:UnitRaid(Unit),Count))
            end                        
            local Debuff, _, _, Count, _, _, ExpirationTime = UnitDebuff(Unit,"Instability")
            if UnitDebuff(Unit,"Unchained Magic") or Debuff then
                if Debuff then
                    local Expiration = round(ExpirationTime-GetTime(),0,true)
                    table.insert(array2,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
                else
                    table.insert(array2,string.format("%s (0)(N/A)",self:UnitRaid(Unit)))
                end
            end
            local Debuff, _, _, Count, _, _, ExpirationTime = UnitDebuff(Unit,"Chilled to the Bone")
            if Debuff and Count >= 5 then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array3,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end        
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,"\n"))
        Text3:SetText(table.concat(array3,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 12 then -- ICC: The Lich King
        local array1 = {}
        local array2 = {}
        local array3 = {} 
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Necrotic Plague")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),1,true)%5
                table.insert(array1,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
            local Debuff = UnitDebuff(Unit,"Infest")
            if Debuff then
                local Health = round(UnitHealth(Unit) * 100 / UnitHealthMax(Unit),0,true)
                table.insert(array2,string.format("%s (%s%%)",self:UnitRaid(Unit),Health))
            end
            local Debuff, _, _, Count = UnitDebuff(Unit,"Pain and Suffering")
            if Debuff and Count >= 5 then
                table.insert(array3,string.format("%s (%s)",self:UnitRaid(Unit),Count))
            end
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,", "))
        Text3:SetText(table.concat(array3,", "))
    elseif MPR_AuraInfo.FrameNumber == 13 then -- TOC: Gormok the Impaler
        local array1 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, Count, _, _, ExpirationTime = UnitDebuff(Unit,"Impale")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array1,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end    
        end
        Text1:SetText(table.concat(array1,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 14 then -- TOC: Acidmaw & Dreadscale
        local array1 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Paralytic Toxin")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                local Health = round(UnitHealth(Unit) * 100 / UnitHealthMax(Unit),0,true)
                table.insert(array1,string.format("%s (%s%%)(%ss)",self:UnitRaid(Unit),Health,Expiration))
            end    
        end
        Text1:SetText(table.concat(array1,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 16 then -- TOC: Lord Jaraxxus
        local array1 = {}
        local array2 = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Touch of Jaraxxus")
            if Debuff then
                local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array1,string.format("%s (%ss)",self:UnitRaid(Unit),Expiration))
            end
            local Debuff, _, _, _, _, _, ExpirationTime = UnitDebuff(Unit,"Curse of the Nether")
            if Debuff then
                --local Expiration = round(ExpirationTime-GetTime(),0,true)
                table.insert(array2,string.format("%s",self:UnitRaid(Unit)))
            end
        end
        Text1:SetText(table.concat(array1,", "))
        Text2:SetText(table.concat(array2,", "))
    elseif MPR_AuraInfo.FrameNumber == 18 then -- TOC: Twin Valkyr
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            if UnitIsConnected(Unit) and not UnitIsDeadOrGhost(Unit) and UnitAffectingCombat(Unit) then
                if not (UnitDebuff(Unit,"Dark Essence") or UnitDebuff(Unit,"Light Essence")) then
                    table.insert(array,self:UnitRaid(Unit))
                end
            end
        end
        Text1:SetText(table.concat(array,", "))
    elseif MPR_AuraInfo.FrameNumber == 19 then -- TOC: Anub'arak
        local UnitID, Message = self:GetBossID("Anub'arak")
        if UnitID then
            AR_LastCheck = (AR_LastCheck or 0) + diff
            if not AR_LastCheckHP then
                AR_LastCheckHP = UnitHealth(UnitID)
                AR_LastCheck = 0
                Text1:SetText("Calculating ...")
            elseif AR_LastCheck >= 2 then
                
                local Health = UnitHealth(UnitID)
                local modHP = AR_LastCheckHP - Health
                local DPS = modHP/AR_LastCheck
                local TimeLeft = Health/DPS
                
                AR_LastCheckHP = Health
                AR_LastCheck = 0
                
                Text1:SetText("DPS: "..round(DPS,-3,true).."\nAssumed Finish: "..round(TimeLeft,0,true).." sec")
            end
        else
            Text1:SetText(Message) 
        end
    elseif MPR_AuraInfo.FrameNumber == 20 then -- RS: Saviana Ragefire
        local UnitID, Message = self:GetBossID("Saviana Ragefire")
        if UnitID then
            local Debuff, _, ExpiraitonTime = self:GetBuffInfo(UnitID,"Enrage")
            if Debuff then
                local Expiration = round(ExpiraitonTime-GetTime(),0,true)
                local HitsLeft = math.floor(Expiration / 2) + 1
                Text1:SetText(string.format("Saviana Ragefire (%ss)(%s)",Expiration,HitsLeft))
            else
                Text1:SetText("")
            end
        else
            Text1:SetText(Message) 
        end
    elseif MPR_AuraInfo.FrameNumber == 21 then -- RS: Baltharus the Warborn
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, Count, _, _, _, _, _, _, SpellID = UnitDebuff(Unit,"Enervating Brand")
            if Debuff and SpellID == 74502 then
                table.insert(array,string.format("%s (%s)",self:UnitRaid(Unit),Count))
            end
        end
        Text1:SetText(table.concat(array,", "))
    elseif MPR_AuraInfo.FrameNumber == 22 then -- RS: General Zarithrian
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, Count, _, _, ExpiraitonTime = UnitDebuff(Unit,"Cleave Armor")
            if Debuff then
                local Expiration = round(ExpiraitonTime-GetTime(),0,true)
                table.insert(array,string.format("%s (%s)(%ss)",self:UnitRaid(Unit),Count,Expiration))
            end
        end
        Text1:SetText(table.concat(array,"\n"))
    elseif MPR_AuraInfo.FrameNumber == 23 then -- RS: Halion
        local array = {}
        for i=1,GetNumRaidMembers() do
            local Unit = UnitName("raid"..i)
            local Debuff, _, _, _, _, _, ExpiraitonTime = UnitDebuff(Unit,"Fiery Combustion")
            if Debuff then
                local Expiration = round(ExpiraitonTime-GetTime(),0,true)
                local Count = select(4,UnitDebuff(Unit,"Mark of Combustion"))
                table.insert(array,string.format("%s (%ss)(%s)",self:UnitRaid(Unit),Expiration,Count or 0))
            end
            local Debuff, _, _, _, _, _, ExpiraitonTime = UnitDebuff(Unit,"Soul Consuption")
            if Debuff then
                local Expiration = round(ExpiraitonTime-GetTime(),0,true)
                local Count = select(4,UnitDebuff(Unit,"Mark of Consuption"))
                table.insert(array,string.format("%s (%ss)(%s)",self:UnitRaid(Unit),Expiration,Count or 0))
            end
        end
        Text1:SetText(table.concat(array,", "))        
        
        local UnitID, Message = self:GetBossID("Halion")
        if UnitID then
            local Debuff, _, _, SpellID = self:GetBuffInfo(UnitID,"Corporeality")
            if Debuff then
                local Color, Percentage, DamageTaken, DamageDealt, DamageTaken2, DamageDealt2 = Halion_CorporealityInfo(SpellID)
                Name2:SetText(GetSpellLink(74826).." (Phase 3): |cFF"..Color..Percentage.."%|r")
                Percentage = tonumber(Percentage)
                local Msg = Percentage < 40 and "More DPS in this realm!!" or --0-20
                            Percentage == 40 and "More DPS in this realm!" or --40-50
                            Percentage == 50 and "Balanced DPS." or -- 50
                            Percentage == 60 and "More DPS in opposite realm!" or --
                            Percentage > 60 and "More DPS in opposite realm!!" or "" --
                Text2:SetText("|cFF"..Color..Msg.."|r\n"..
                                "|cFFFFFFFFPlayer's Realm:|r\n"..
                                    "Boss Damage Taken |cFF"..Color..DamageTaken.."%|r, Boss Damage |cFF"..Color..DamageDealt.."%|r\n"..
                                "|cFFFFFFFFOpposite Realm:|r\n"..
                                    "Boss Damage Taken |cFF"..Color..DamageTaken2.."%|r, Boss Damage |cFF"..Color..DamageDealt2.."%|r")
            else
                Name2:SetText(GetSpellLink(74826).." (Phase 3): n/a")
                Text2:SetText("Waiting for Phase 3 ...")
            end
        else
            Name2:SetText(GetSpellLink(74826).." (Phase 3): n/a") 
            Text2:SetText(Message)
        end
    end
end