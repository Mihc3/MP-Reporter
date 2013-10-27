MPR_Penalties = CreateFrame("Frame", "MPR Penalties", UIParent)
MPR_Penalties.Frames = {} -- we will store numeric field frames here
MPR_Penalties.Rows = {} -- contains arrays of object for each row
MPR_Penalties.LastUpdate = 0
MPR_Penalties.PenaltySpells = {
    ["Unstable Ooze Explosion"] = {"UOE", "00C957"},
    ["Choking Gas Bomb"] = {"CGB","00C957"},
    ["Malleable Goo"] =    {"MG", "00C957"},
    ["Blistering Cold"] =  {"BC", "1C86EE"},
    ["Frost Bomb"] =       {"FB", "1C86EE"},
    ["Shadow Trap"] =      {"ST", "FFC125"},
}

function MPR_Penalties:Toggle()
    if MPR_Penalties:IsVisible() then
        MPR_Penalties:Hide()
    else
        MPR_Penalties:Show()
    end
end

function MPR_Penalties:Initialize()
    MPR_Penalties:Hide()
    MPR_Penalties.name = "MPR_Penalties"
    
    MPR_Penalties:SetBackdrop(MPR.Settings["BACKDROP"])
    MPR_Penalties:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
    MPR_Penalties:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)
    
    MPR_Penalties:SetPoint("CENTER",UIParent)
    MPR_Penalties:SetWidth(564)
    MPR_Penalties:SetHeight(282)
    MPR_Penalties:EnableMouse(true)
    MPR_Penalties:SetMovable(true)
    MPR_Penalties:RegisterForDrag("LeftButton")
    MPR_Penalties:SetUserPlaced(true)
    MPR_Penalties:SetScript("OnDragStart", function(self) self:StartMoving() end)
    MPR_Penalties:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    MPR_Penalties:SetFrameStrata("FULLSCREEN_DIALOG")

    --[[ MP Reporter - Options ]]--
    MPR_Penalties.Title = MPR_Penalties:CreateFontString("Title"..GetNewID(), "ARTWORK", "GameFontNormal")
    MPR_Penalties.Title:SetPoint("TOP", 0, -12)
    if type(Color) ~= "string" then Color = "FFFFFF" end
    MPR_Penalties.Title:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255) 
    MPR_Penalties.Title:SetText("|cFF1E90FFMP Reporter|r - DKP Penalties (for QuickDKP)")
    
    MPR_Penalties_BtnClose = CreateFrame("button","MPR_Penalties_BtnClose", MPR_Penalties, "UIPanelButtonTemplate")
    MPR_Penalties_BtnClose:SetHeight(14)
    MPR_Penalties_BtnClose:SetWidth(14)
    MPR_Penalties_BtnClose:SetPoint("TOPRIGHT", -12, -11)
    MPR_Penalties_BtnClose:SetText("x")
    MPR_Penalties_BtnClose:SetScript("OnClick", function(self) MPR_Penalties:Hide() end)
    
    MPR_Penalties:NewSP("|cFF00C957[Ooze Explosion]|r","UOE",10,-30)
    MPR_Penalties:NewSP("|cFF00C957[Choking Gas Bomb]|r","CGB",100,-30,-6)
    MPR_Penalties:NewSP("|cFF00C957[Malleable Goo]|r","MG",200,-30)
    MPR_Penalties:NewSP("|cFF1C86EE[Blistering Cold]|r","BC",290,-30)
    MPR_Penalties:NewSP("|cFF1C86EE[Frost Bomb]|r","FB",380,-30,10)
    MPR_Penalties:NewSP("|cFFFFC125[Shadow Trap]|r","ST",470,-30,2)
    
    MPR_Penalties:NewFS("|cFF00FF00Ignore:|r",nil,10,-76)
    
    MPR_Penalties:NewCB("\124TInterface\\GroupFrame\\UI-Group-LeaderIcon:12:12:0:0:64:64:5:59:5:59\124tRL",nil,"PENALTIES_IGNORE_RL",50,-72)
    MPR_Penalties:NewCB("\124TInterface\\GroupFrame\\UI-Group-MainAssistIcon:12:12:0:0:64:64:5:59:5:59\124tRA",nil,"PENALTIES_IGNORE_RA",98,-72)
    MPR_Penalties:NewCB("\124TInterface\\RaidFrame\\UI-RaidFrame-MainTank:12:12:0:0:64:64:5:59:5:59\124tMT",nil,"PENALTIES_IGNORE_MT",146,-72)
    MPR_Penalties:NewCB("\124TInterface\\RaidFrame\\UI-RaidFrame-MainAssist:12:12:0:0:64:64:5:59:5:59\124tMA",nil,"PENALTIES_IGNORE_MA",194,-72)
    
    MPR_Penalties:NewFS("Announce to:",nil,280,-76)
    
    MPR_Penalties:NewCB("Self","1E90FF","PENALTIES_SELF",352,-72)
    MPR_Penalties:NewCB("Whisper","DA70D6","PENALTIES_WHISPER",390,-72)
    MPR_Penalties:NewCB("Raid","EE7600","PENALTIES_RAID",451,-72)
    MPR_Penalties:NewCB("Guild","40FF40","PENALTIES_GUILD",495,-72)
    
    MPR_Penalties:NewFS("TIMESTAMP",9,10,-96)
    MPR_Penalties:NewFS("PLAYER",9,80,-96)
    MPR_Penalties:NewCB("main","FFFFFF","PENALTIES_LIST_SHOWMAIN",118,-90,"UPDATELIST")
    MPR_Penalties:NewFS("REASON",9,194,-96)
    MPR_Penalties:NewCB("(A/O)","FFFFFF","PENALTIES_LIST_SHOWAMOUNTOVERKILL",234,-90,"UPDATELIST")
    MPR_Penalties:NewFS("STATUS",9,400,-96)
    MPR_Penalties:NewCB("P","FFFF00","PENALTIES_LIST_SHOWPENDING",440,-90,"UPDATELIST")
    MPR_Penalties:NewCB("D","FF0000","PENALTIES_LIST_SHOWDEDUCTED",468,-90,"UPDATELIST")
    MPR_Penalties:NewCB("S","CCCCCC","PENALTIES_LIST_SHOWSKIPPED",496,-90,"UPDATELIST")
    MPR_Penalties:NewCB("I","00FF00","PENALTIES_LIST_SHOWIGNORED",524,-90,"UPDATELIST")
    local LocY,FS1,FS2,FS3,FS4,BTN1,BTN2
    for i=0,9 do
        LocY = -110-16*i 
        FS1 = MPR_Penalties:NewFS("time1",nil,10,LocY)
        FS1:SetTextColor(1,1,1)
        FS2 = MPR_Penalties:NewFS("player1",nil,80,LocY)
        FS2:SetTextColor(1,1,1)
        FS3 = MPR_Penalties:NewFS("spell1",nil,194,LocY)
        FS3:SetTextColor(1,1,1)
        FS4 = MPR_Penalties:NewFS("status1",nil,400,LocY)
        BTN1 = MPR_Penalties:NewBTN("Deduct","DEDUCT_"..i,64,456,LocY)
        BTN2 = MPR_Penalties:NewBTN("Skip","SKIP_UNDO_"..i,36,520,LocY)
        MPR_Penalties.Rows[i] = {["Time"] = FS1,["Player"] = FS2,["Spell"] = FS3,["Status"] = FS4,["Deduct"] = BTN1,["Skip"] = BTN2}
    end
    
    MPR_Penalties:RefreshList()
    MPR_Penalties:SetScript("OnUpdate", function(self, elapsed)
        if MPR_Penalties:IsVisible() then
            if MPR_Penalties.LastUpdate ~= time() then
                MPR_Penalties.LastUpdate = time()
                MPR_Penalties:RefreshList()
            end
        end
    end)
end

function MPR_Penalties:RefreshList()
    -- hide all objects in list
    for i,row in pairs(MPR_Penalties.Rows) do -- for each row
        for _,obj in pairs(row) do -- for each object in a row
            if type(obj) ~= "number" then
                obj:Hide()
            end
        end
    end
    
    local n = 0
    local i = #MPR.DataPenalties
    if i == 0 then
        MPR_Penalties.Rows[0]["Time"]:SetText("No penalties to display.")
        MPR_Penalties.Rows[0]["Time"]:Show()
        return
    end
    local Colors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA", ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
    
    while n < 10 do
        if i <= 0 then break end
        if MPR.DataPenalties[i] then
            local Penalty = MPR.DataPenalties[i]
            
            -- Filter check
            if Penalty.Status == 0 and MPR.Settings["PENALTIES_LIST_SHOWPENDING"] or Penalty.Status == 1 and MPR.Settings["PENALTIES_LIST_SHOWDEDUCTED"] or Penalty.Status == 2 and MPR.Settings["PENALTIES_LIST_SHOWSKIPPED"] or Penalty.Status == 3 and MPR.Settings["PENALTIES_LIST_SHOWIGNORED"] then
                -- Display
                local LocY = -100-(n*20)
                MPR_Penalties.Rows[n]["Index"] = i
                MPR_Penalties.Rows[n]["Time"]:SetText(MPR_Penalties:GetTimeAgoString(Penalty.Time).." ago",nil,10,LocY)
                MPR_Penalties.Rows[n]["Time"]:Show()
                local PlayerText = "|cFF"..Colors[Penalty.Class]..Penalty.Player.."|r"
                if MPR.Settings["PENALTIES_LIST_SHOWMAIN"] then
                    local Main = MPR_Penalties:GetMain(Penalty.Player)
                    if Main then
                        PlayerText = PlayerText.." ("..Main..")"
                    end
                end
                MPR_Penalties.Rows[n]["Player"]:SetText(PlayerText)
                MPR_Penalties.Rows[n]["Player"]:Show()
                local SpellText = "|cFFCCCCCC[Unknown]|r"
                for SpellName,Data in pairs(MPR_Penalties.PenaltySpells) do
                    if Data[1] == Penalty.Spell then
                        SpellText = "|cFF"..Data[2].."["..SpellName.."]|r"
                        break
                    end
                end
                
                local AOText = Penalty.Overkill and Penalty.Overkill > 0 and "|cFFFF0000(Died!)|r" or ""
                if MPR.Settings["PENALTIES_LIST_SHOWAMOUNTOVERKILL"] then
                    local A,O = Penalty.Amount, Penalty.Overkill and Penalty.Overkill > 0 and Penalty.Overkill or nil
                    A = A >= 1000 and string.sub(A, 1, -4).."k" or A
                    if O then
                        O = O >= 1000 and string.sub(O, 1, -4).."k" or O
                        AOText = string.format("(A: %s / |cFFFF0000O: %s|r)",A,O)
                    else
                        AOText = string.format("(A: %s)",A)
                    end
                end
                MPR_Penalties.Rows[n]["Spell"]:SetText(string.format("Hit by %s %s",SpellText,AOText))
                MPR_Penalties.Rows[n]["Spell"]:Show()
                MPR_Penalties.Rows[n]["Status"]:SetText(Penalty.Status == 0 and "|cFFFFFF00Pending|r" or Penalty.Status == 1 and "|cFFFF0000Deducted|r" or Penalty.Status == 2 and "|cFFCCCCCCSkipped|r" or Penalty.Status == 3 and "|cFF00FF00Ignored|r" or "|cFFFF0000error|r")
                MPR_Penalties.Rows[n]["Status"]:Show()
                if Penalty.Status == 1 then MPR_Penalties.Rows[n]["Deduct"]:Disable() else MPR_Penalties.Rows[n]["Deduct"]:Enable() end
                MPR_Penalties.Rows[n]["Deduct"]:SetText("- "..MPR.Settings["PENALTIES_"..Penalty.Spell.."_AMOUNT"].." DKP")
                MPR_Penalties.Rows[n]["Deduct"]:Show()
                if Penalty.Status <= 1 then MPR_Penalties.Rows[n]["Skip"]:Enable() else MPR_Penalties.Rows[n]["Skip"]:Disable() end
                MPR_Penalties.Rows[n]["Skip"]:SetText(Penalty.Status == 1 and "Undo" or "Skip")
                MPR_Penalties.Rows[n]["Skip"]:Show()
                n = n + 1
            end
        end
        i = i - 1
    end
    if n == 0 then
        MPR_Penalties.Rows[0]["Time"]:SetText("No penalties to display, check status filters.")
        MPR_Penalties.Rows[0]["Time"]:Show()
    end
end

function MPR_Penalties:NewSP(Text,VarPrefix,LocX,LocY,TextAlign,TitleSize)
    VarPrefix = "PENALTIES_"..VarPrefix
    MPR_Penalties:NewFS(Text,TitleSize,LocX+(TextAlign or 0),LocY)
    MPR_Penalties:NewCB("List",nil,VarPrefix.."_LIST",LocX,LocY-10)
    MPR_Penalties:NewCB("Auto",nil,VarPrefix.."_AUTO",LocX+38,LocY-10)
    MPR_Penalties:NewNF(VarPrefix.."_AMOUNT",LocX+32,LocY-28)
    MPR_Penalties:NewFS("DKP",10,LocX+62,LocY-29)
end

function MPR_Penalties:NewFS(Text,Size,LocX,LocY) -- Creates a fontstring
    local FontString = MPR_Penalties:CreateFontString("FontString"..GetNewID(), "ARTWORK", "GameFontNormal")
    FontString:SetPoint("TOPLEFT",LocX,LocY)
    FontString:SetText(Text)
    FontString:SetFont("Fonts\\FRIZQT__.TTF", Size or 10, "OUTLINE")
    return FontString
end

function MPR_Penalties:NewBTN(Text,Action,Width,LocX,LocY)
    local button = CreateFrame("button","MPR_Penalties_Button_"..GetNewID(), MPR_Penalties, "UIPanelButtonTemplate")
    button:SetHeight(14)
    button:SetWidth(Width)
    button:SetPoint("TOPLEFT", LocX, LocY)
    button:SetText(Text)
    local n = tonumber(Action:sub(-1))
    if Action:sub(0,7) == "DEDUCT_" then
        button:SetScript("OnClick", function(self) MPR_Penalties:HandleClick_Deduct(n) end)
    elseif Action:sub(0,10) == "SKIP_UNDO_" then
        button:SetScript("OnClick", function(self) if self:GetText() == "Skip" then MPR_Penalties:HandleClick_Skip(n) else MPR_Penalties:HandleClick_UndoDeduct(n) end end)
    end
    return button
end
function MPR_Penalties:HandleClick_Deduct(n)
    local i = MPR_Penalties.Rows[n]["Index"]
    MPR.DataPenalties[i].DKP = MPR.Settings["PENALTIES_"..MPR.DataPenalties[i].Spell.."_AMOUNT"]
    local Player, DKP = MPR.DataPenalties[i].Player, MPR.DataPenalties[i].DKP
    local NewNet = MPR_Penalties:DeductDKP(Player,MPR.DataPenalties[i].DKP)
    if type(NewNet) == "number" then
        MPR.DataPenalties[i].Status = 1
        MPR_Penalties:AnnounceDeductions({{Name = Player, Net = NewNet, Amount = MPR.DataPenalties[i].Amount, Overkill = MPR.DataPenalties[i].Overkill}},DKP,MPR.DataPenalties[i].Spell,MPR.DataPenalties[i].SpellID)
    else
        MPR:SelfReport(string.format("ERROR: Couldn't deduct %s DKP from %s. %s",DKP or MPR:CS("nil","FF0000"),Player or MPR:CS("unknown player","FF0000"),type(NewNet) == "string" and MPR:CS(NewNet,"FF0000") or "No message given."))
    end
    MPR_Penalties:RefreshList()
end
function MPR_Penalties:HandleClick_UndoDeduct(n)
    local i = MPR_Penalties.Rows[n]["Index"]
    local Player, DKP = MPR.DataPenalties[i].Player, MPR.DataPenalties[i].DKP
    local NewNet = MPR_Penalties:DeductDKP(Player,-MPR.DataPenalties[i].DKP) -- we deduct negative value, - - => +
    if type(NewNet) == "number" then
        MPR.DataPenalties[i].Status = 0
        MPR_Penalties:AnnounceUndoDeduct(Player,DKP,MPR.DataPenalties[i].SpellID)
    else
        MPR:SelfReport(string.format("ERROR: Couldn't undo deduction of %s DKP to %s. %s",DKP or MPR:CS("nil","FF0000"),Player or MPR:CS("unknown player","FF0000"),type(NewNet) == "string" and MPR:CS(NewNet,"FF0000") or "No message given."))
    end
    MPR_Penalties:RefreshList()
end
function MPR_Penalties:HandleClick_Skip(n)
    local i = MPR_Penalties.Rows[n]["Index"]
    MPR.DataPenalties[i].Status = 2
    MPR_Penalties:RefreshList()
end

function MPR_Penalties:NewCB(Text,Color,Var,LocX,LocY,Special) -- Creates a checkbox
    local CheckBox = CreateFrame("CheckButton", "CheckBox"..GetNewID(), MPR_Penalties, "UICheckButtonTemplate")
    CheckBox:SetWidth(20)
    CheckBox:SetHeight(20)
    CheckBox:SetPoint("TOPLEFT", LocX, LocY)
    if Var then
        CheckBox:SetScript("OnShow",  function(self) CheckBox:SetChecked(MPR.Settings[Var]); end)
        if Special == "UPDATELIST" then
            CheckBox:SetScript("OnClick", function(self) MPR.Settings[Var] = not MPR.Settings[Var]; MPR_Penalties:RefreshList() end)
        else
            CheckBox:SetScript("OnClick", function(self) MPR.Settings[Var] = not MPR.Settings[Var] end)
        end
        if type(Color) ~= "string" then Color = "FFFFFF" end
    else
        CheckBox:Disable()
        Color = "BEBEBE"
    end
    _G["CheckBox"..GetCurrentID().."Text"]:SetTextColor(tonumber(Color:sub(1,2),16)/255, tonumber(Color:sub(3,4),16)/255, tonumber(Color:sub(5,6),16)/255)
    _G["CheckBox"..GetCurrentID().."Text"]:SetText(Text)
end

function MPR_Penalties:NewNF(Var,LocX,LocY) -- Creates an numeric field
    -- Frame Names
    local ID = GetNewID()
    local FN_Less = "BTN_NF_"..ID.."_LESS"
    local FN_Amount = "FS_NF_"..ID.."_AMOUNT"
    local FN_More = "BTN_NF_"..ID.."_MORE"

    local F_Less = CreateFrame("button",FN_Less, MPR_Penalties, "UIPanelButtonTemplate")
    F_Less:SetHeight(14)
    F_Less:SetWidth(14)
    F_Less:SetPoint("TOPLEFT", LocX, LocY)
    F_Less:SetText("-")
    F_Less:SetScript("OnClick", function(self) MPR_Penalties:NF_HandleOnClick(ID,Var,false) end)
    MPR_Penalties.Frames[FN_Less] = F_Less

    local F_Amount = MPR_Penalties:CreateFontString(FN_Amount, "ARTWORK", "GameFontNormal")
    F_Amount:SetPoint("TOPRIGHT", FN_Less, "TOPLEFT", -2, 0)
    F_Amount:SetTextColor(1,1,1) 
    F_Amount:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    MPR_Penalties.Frames[FN_Amount] = F_Amount
    
    local F_More = CreateFrame("button",FN_More, MPR_Penalties, "UIPanelButtonTemplate")
    F_More:SetHeight(14)
    F_More:SetWidth(14)
    F_More:SetPoint("TOPLEFT", FN_Less, "TOPRIGHT", 1, 0)
    F_More:SetText("+")
    F_More:SetScript("OnClick", function(self) MPR_Penalties:NF_HandleOnClick(ID,Var,true) end)
    MPR_Penalties.Frames[FN_More] = F_More
    
    MPR_Penalties:NF_UpdateButtons(ID,Var)
end

function MPR_Penalties:NF_HandleOnClick(ID,Var,Increment)
    local amount = MPR.Settings[Var]
    if Increment then -- increase amount
        amount = amount + (amount < 5 and 1 or amount < 50 and 5 or amount < 100 and 10 or amount < 200 and 20 or amount < 500 and 50 or 0)
    else -- decrease amount
        amount = amount - (amount > 200 and 50 or amount > 100 and 20 or amount > 50 and 10 or amount > 5 and 5 or amount > 0 and 1 or 0)
    end
    MPR.Settings[Var] = amount
    
    MPR_Penalties:NF_UpdateButtons(ID,Var)
end

function MPR_Penalties:NF_UpdateButtons(ID,Var)
    local amount = MPR.Settings[Var]
    MPR_Penalties.Frames["FS_NF_"..ID.."_AMOUNT"]:SetText(amount)
    if amount < 500 then MPR_Penalties.Frames["BTN_NF_"..ID.."_MORE"]:Enable() else MPR_Penalties.Frames["BTN_NF_"..ID.."_MORE"]:Disable() end
    if amount > 1 then MPR_Penalties.Frames["BTN_NF_"..ID.."_LESS"]:Enable() else MPR_Penalties.Frames["BTN_NF_"..ID.."_LESS"]:Disable() end
end

--[[ unused
function MPR_Penalties:DeductDKPLink(Targets, Amount, Reason)
    return "|r|HMPR:DeductDKP:"..table.concat(Targets,"-")..":"..Amount..":"..Reason.."|h|cFF"..self.Colors["DKPDEDUCTION_LINK"].."[Deduct "..Amount.." DKP]|r|h|cFF"..self.Colors["TEXT"]
end
]]

function MPR_Penalties:HandleHits(Targets,Spell,SpellID)
    local List, Auto, DKP = MPR.Settings["PENALTIES_"..Spell.."_LIST"], MPR.Settings["PENALTIES_"..Spell.."_AUTO"], MPR.Settings["PENALTIES_"..Spell.."_AMOUNT"]
    if not List and not Auto or not DKP then return end
    local DeductedPlayers = {}
    for Target,Data in pairs(Targets) do
        local Status = 0 -- pending
        local Rank = MPR_Penalties:GetRaidMemberRank(Target)
        if Rank == "RL" and MPR.Settings["PENALTIES_IGNORE_RL"] or Rank == "RA" and MPR.Settings["PENALTIES_IGNORE_RA"] or Rank == "MT" and MPR.Settings["PENALTIES_IGNORE_MT"] or Rank == "MA" and MPR.Settings["PENALTIES_IGNORE_MA"] then
            Status = 3 -- ignored
        elseif Auto then
            local NewNet = MPR_Penalties:DeductDKP(Target,DKP)
            if type(NewNet) == "number" then
                table.insert(DeductedPlayers,{Name = Target, Net = NewNet, Amount = Data.Amount, Overkill = Data.Overkill})
                Status = 1 -- deducted
            else
                --List = false -- error, don't log this
                MPR:SelfReport(string.format("ERROR: Couldn't deduct %s DKP from %s. %s",DKP or MPR:CS("nil","FF0000"),Target or MPR:CS("unknown player","FF0000"),type(NewNet) == "string" and MPR:CS(NewNet,"FF0000") or "No message given."))
            end
        end
        if List then
            MPR_Penalties:LogHit(Target,Spell,SpellID,Data.Amount,Data.Overkill,Status,Auto and DKP or nil)
        end
    end
    MPR_Penalties:AnnounceDeductions(DeductedPlayers,DKP,Spell,SpellID)
end

function MPR_Penalties:GetRaidMemberRank(Player)
    for i=1,GetNumRaidMembers() do
        Name, Rank, _, _, _, _, _, _, _, Role = GetRaidRosterInfo(i)
        if Name == Player then
            return (Rank == 2 and "RL" or Rank == 1 and "RA" or Role == "maintank" and "MT" or Role == "mainassist" and "MA" or nil)
        end
    end
end

function MPR_Penalties:LogHit(Player,Spell,SpellID,Amount,Overkill,Status,DKP)
    local tbl = {Player = Player, Class = select(2, UnitClass(Player)), Time = time(), Spell = Spell, SpellID = SpellID, Amount = Amount, Overkill = Overkill, Status = Status, DKP = DKP}
    table.insert(MPR.DataPenalties,tbl)
end

function MPR_Penalties:GetMain(Name)
    if not Name then return end
    local Index, Member, _, _, _, _, _, _, OfficerNote = MPR:GetGuildMemberInfo(Name)
    if not Member or OfficerNote == "" or MPR_Penalties:IsDKPFormat(OfficerNote) then
        return nil
    end
    local Index, Main, _, _, _, _, _, _, OfficerNote, _, _, Class = MPR:GetGuildMemberInfo(OfficerNote)
    if Main then
        local Colors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA", ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
        return "|cFF"..Colors[Class]..Main.."|r"
    end
end

function MPR_Penalties:DeductDKP(Name, Amount)
    if not (Name and type(Amount) == "number") then return end
    if not CanEditOfficerNote() then
        return "No permission to edit officer notes."
    end
    local Index, Member, _, _, _, _, _, _, OfficerNote = MPR:GetGuildMemberInfo(Name)
    if Member then -- Is a guild member?
        if OfficerNote == "" then
            GuildRosterSetOfficerNote(Index, "Net:0 Tot:0 Hrs:0")
        end
        local DeductedMember_Name, DeductedMember_OfficerNote
        if not MPR_Penalties:IsDKPFormat(OfficerNote) then -- Is not a main character?
            Index, Main, _, _, _, _, _, _, OfficerNote = MPR:GetGuildMemberInfo(OfficerNote)
            if not Main then
                return Member.."'s officer note has strange DKP format."
            elseif OfficerNote == "" then
                GuildRosterSetOfficerNote(Index, "Net:0 Tot:0 Hrs:0")
            elseif not OfficerNote or not MPR_Penalties:IsDKPFormat(OfficerNote) then
                return Main.."'s officer note has strange DKP format."
            end
        end
        
        local Net, Tot, Hrs = strsplit(" ", OfficerNote)
        local NetNum = select(2, strsplit(":", Net))
        NetNum = tonumber(NetNum) - Amount
        
        GuildRosterSetOfficerNote(Index, "Net:"..NetNum.." "..Tot.." "..Hrs)
        
        return NetNum
    end
    return Member.." not found in your guild."
end

function MPR_Penalties:AnnounceDeductions(Players,DKP,Spell,SpellID)
    -- Announce
    if #Players == 1 then
        local Name, Net = Players[1].Name, Players[1].Net
        local Reason = (Players[1].Overkill > 0 and "Killed" or "Hit").." by "..(SpellID and GetSpellLink(SpellID) or "[Unknown]")

        if MPR.Settings["PENALTIES_SELF"] then
            MPR:SelfReport(string.format("Deducted %i DKP from %s (New NET: %s). Reason: %s",DKP,Name,Net,Reason))
        end
        if MPR.Settings["PENALTIES_WHISPER"] then
            MPR:Whisper(Name, string.format("Deducted %i DKP (New NET: %s). Reason: %s",DKP,Net,Reason))
        end
        if MPR.Settings["PENALTIES_RAID"] then
            if UnitInRaid("player") then
                MPR:RaidReport(string.format("Deducted %i DKP from %s. Reason: %s",DKP,Name,Reason),true)
            elseif UnitInParty("player") then
                MPR:PartyReport(string.format("Deducted %i DKP from %s. Reason: %s",DKP,Name,Reason),true)
            end
        end
        if MPR.Settings["PENALTIES_GUILD"] then
            SendChatMessage(string.format("<MPR> Deducted %i DKP from %s. Reason: %s",DKP,Name,Reason), "GUILD")
        end
    elseif #Players > 1 then
        local Reason = "Hit by "..GetSpellLink(SpellID)
        local arrSelf, arrRaidGuild = {}, {}
        local Colors = {["DEATHKNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA", ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
        for _, Player in pairs(Players) do
            table.insert(arrSelf, MPR:CS("|Hplayer:"..Player.Name.."|h["..Player.Name.."]|h",Colors[select(2,UnitClass(Player.Name))]).." ("..Player.Net..")")
        end
        
        if MPR.Settings["PENALTIES_SELF"] then
            MPR:SelfReport(string.format("Deducted %i DKP from: %s. Reason: %s",DKP,table.concat(arrSelf,", "),Net,Reason))
        end
        if MPR.Settings["PENALTIES_WHISPER"] then
            for _, Player in pairs(Players) do
                MPR:Whisper(Player.Name, string.format("Deducted %i DKP (New NET: %s). Reason: %s",DKP,Player.Net,Reason))
            end
        end
        if MPR.Settings["PENALTIES_RAID"] then
            if UnitInRaid("player") then
                MPR:RaidReport(string.format("Deducted %i DKP from: %s. Reason: %s",DKP,table.concat(arrRaidGuild,", "),Reason),true)
            elseif UnitInParty("player") then
                MPR:PartyReport(string.format("Deducted %i DKP from: %s. Reason: %s",DKP,table.concat(arrRaidGuild,", "),Reason),true)
            end
        end
        if MPR.Settings["PENALTIES_GUILD"] then
            SendChatMessage(string.format("<MPR> Deducted %i DKP from: %s. Reason: %s",DKP,table.concat(arrRaidGuild,", "),Reason), "GUILD")
        end
    end
end

function MPR_Penalties:AnnounceUndoDeduct(Name,DKP,SpellID)
    local Reason = SpellID and GetSpellLink(SpellID) or "[Unknown]"
    if MPR.Settings["PENALTIES_SELF"] then
        MPR:SelfReport(string.format("Deduction to %s for %s has been undone. %i DKP restored.",Name,Reason,DKP))
    end
    if MPR.Settings["PENALTIES_WHISPER"] then
        MPR:Whisper(Name, string.format("Deduction for %s has been undone. %i DKP restored.",Reason,DKP))
    end
    if MPR.Settings["PENALTIES_RAID"] then
        if UnitInRaid("player") then
            MPR:RaidReport(string.format("Deduction to %s for %s has been undone. %i DKP restored.",Name,Reason,DKP),true)
        elseif UnitInParty("player") then
            MPR:PartyReport(string.format("Deduction to %s for %s has been undone. %i DKP restored.",Name,Reason,DKP),true)
        end
    end
    if MPR.Settings["PENALTIES_GUILD"] then
        SendChatMessage(string.format("<MPR> Deduction to %s for %s has been undone. %i DKP restored.",Name,Reason,DKP), "GUILD")
    end
end

function MPR_Penalties:IsDKPFormat(Note)
    if Note:sub(1,4) == "Net:" and Note:find("Tot:") and Note:find("Hrs:") then 
        return true
    end
end

function MPR_Penalties:GetTimeAgoString(Time)
    local s = time()-Time
    if s < 60 then return s.." sec" end
    local m = floor(s/60)
    if m < 60 then return m.." min" end
    local h = floor(m/60)
    if h < 24 then return h.." hr"..(h > 1 and "s" or "") end
    local d = floor(h/24)
    return d.." day"..(d > 1 and "s" or "")
end