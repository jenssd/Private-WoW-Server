local addonName = ...

PrivateWoWAdminDB = PrivateWoWAdminDB or {}

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PrivateWoWAdmin:|r " .. tostring(message))
end

local function Trim(value)
    if not value then
        return ""
    end
    return string.gsub(value, "^%s*(.-)%s*$", "%1")
end

local function SendCommand(command)
    command = Trim(command)
    if command == "" then
        return
    end

    if string.sub(command, 1, 1) ~= "." then
        command = "." .. command
    end

    SendChatMessage(command, "SAY")
    Print("Ausgefuehrt: " .. command)
end

local function CreateButton(parent, text, width, height, x, y, onClick)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetWidth(width or 150)
    button:SetHeight(height or 24)
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x or 0, y or 0)
    button:SetText(text)
    button:SetScript("OnClick", onClick)
    return button
end

local function CreateLabel(parent, text, x, y)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    label:SetText(text)
    return label
end

local function CreateInput(parent, width, x, y, defaultText)
    local input = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    input:SetWidth(width)
    input:SetHeight(22)
    input:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    input:SetAutoFocus(false)
    input:SetText(defaultText or "")
    input:SetCursorPosition(0)
    return input
end

local main = CreateFrame("Frame", "PrivateWoWAdminFrame", UIParent)
main:SetWidth(520)
main:SetHeight(410)
main:SetPoint("CENTER")
main:SetMovable(true)
main:EnableMouse(true)
main:RegisterForDrag("LeftButton")
main:SetScript("OnDragStart", main.StartMoving)
main:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, relativePoint, x, y = self:GetPoint()
    PrivateWoWAdminDB.point = point
    PrivateWoWAdminDB.relativePoint = relativePoint
    PrivateWoWAdminDB.x = x
    PrivateWoWAdminDB.y = y
end)
main:SetClampedToScreen(true)
main:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 24,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
main:Hide()

local title = main:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
title:SetPoint("TOPLEFT", main, "TOPLEFT", 20, -16)
title:SetText("PrivateWoWAdmin")

local subtitle = main:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("LEFT", title, "RIGHT", 10, -1)
subtitle:SetText("GM + NPCBots")

local closeButton = CreateFrame("Button", nil, main, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", main, "TOPRIGHT", -4, -4)

local separator = main:CreateTexture(nil, "ARTWORK")
separator:SetTexture(1, 1, 1, 0.12)
separator:SetPoint("TOPLEFT", main, "TOPLEFT", 126, -48)
separator:SetPoint("BOTTOMLEFT", main, "BOTTOMLEFT", 126, 18)
separator:SetWidth(1)

local pages = {}
local tabs = {}

local function CreatePage()
    local page = CreateFrame("Frame", nil, main)
    page:SetPoint("TOPLEFT", main, "TOPLEFT", 140, -58)
    page:SetPoint("BOTTOMRIGHT", main, "BOTTOMRIGHT", -18, 18)
    page:Hide()
    table.insert(pages, page)
    return page
end

local function ShowPage(page, activeTab)
    for _, current in ipairs(pages) do
        current:Hide()
    end
    for _, tab in ipairs(tabs) do
        tab:UnlockHighlight()
    end
    page:Show()
    if activeTab then
        activeTab:LockHighlight()
    end
end

local botPage = CreatePage()
local gmPage = CreatePage()
local telePage = CreatePage()
local customPage = CreatePage()

local tabBot
local tabGM
local tabTele
local tabCustom

tabBot = CreateButton(main, "NPCBots", 100, 28, 18, -64, function() ShowPage(botPage, tabBot) end)
tabGM = CreateButton(main, "GM", 100, 28, 18, -100, function() ShowPage(gmPage, tabGM) end)
tabTele = CreateButton(main, "Teleport", 100, 28, 18, -136, function() ShowPage(telePage, tabTele) end)
tabCustom = CreateButton(main, "Befehl", 100, 28, 18, -172, function() ShowPage(customPage, tabCustom) end)

table.insert(tabs, tabBot)
table.insert(tabs, tabGM)
table.insert(tabs, tabTele)
table.insert(tabs, tabCustom)

local tabHint = main:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
tabHint:SetPoint("TOPLEFT", main, "TOPLEFT", 20, -222)
tabHint:SetWidth(96)
tabHint:SetJustifyH("LEFT")
tabHint:SetText("/pwa\n\nMinimap-Symbol:\nLinksklick oeffnet das Fenster.")

-- NPCBots
CreateLabel(botPage, "NPCBot-Steuerung", 0, 0)
CreateButton(botPage, "Alle Befehle", 105, 25, 0, -25, function() SendCommand(".npcbot") end)
CreateButton(botPage, "Freie Bots", 105, 25, 112, -25, function() SendCommand(".npcbot list spawned free") end)
CreateButton(botPage, "Hilfe", 105, 25, 224, -25, function() SendCommand(".npcbot help") end)

CreateLabel(botPage, "Klassen-ID", 0, -68)
local classInput = CreateInput(botPage, 72, 0, -89, "1")
CreateButton(botPage, "Bot suchen", 118, 23, 82, -89, function()
    local value = Trim(classInput:GetText())
    if value == "" then
        Print("Bitte eine Klassen-ID eingeben.")
        return
    end
    SendCommand(".npcbot lookup " .. value)
end)

CreateLabel(botPage, "Bot-ID", 214, -68)
local spawnInput = CreateInput(botPage, 82, 214, -89, "")
CreateButton(botPage, "Erzeugen", 92, 23, 306, -89, function()
    local value = Trim(spawnInput:GetText())
    if value == "" then
        Print("Bitte eine Bot-ID eingeben.")
        return
    end
    SendCommand(".npcbot spawn " .. value)
end)

CreateLabel(botPage, "Ausgewaehlter Bot", 0, -135)
CreateButton(botPage, "Uebernehmen", 105, 25, 0, -158, function() SendCommand(".npcbot add") end)
CreateButton(botPage, "Entfernen", 105, 25, 112, -158, function() SendCommand(".npcbot remove") end)
CreateButton(botPage, "Herbeirufen", 105, 25, 224, -158, function() SendCommand(".npcbot recall teleport") end)

CreateLabel(botPage, "Gruppe", 0, -202)
CreateButton(botPage, "Folgen", 105, 25, 0, -225, function() SendCommand(".npcbot command follow") end)
CreateButton(botPage, "Warten", 105, 25, 112, -225, function() SendCommand(".npcbot command stay") end)
CreateButton(botPage, "Teleportieren", 105, 25, 224, -225, function() SendCommand(".npcbot recall teleport") end)

local botHint = botPage:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
botHint:SetPoint("TOPLEFT", botPage, "TOPLEFT", 0, -274)
botHint:SetWidth(350)
botHint:SetJustifyH("LEFT")
botHint:SetText("Vor Uebernehmen oder Entfernen den Bot als Ziel auswaehlen. Weitere Optionen gibt es per Rechtsklick auf den Bot.")

-- GM
CreateLabel(gmPage, "GM-Modus", 0, 0)
CreateButton(gmPage, "GM an", 78, 24, 0, -24, function() SendCommand(".gm on") end)
CreateButton(gmPage, "GM aus", 78, 24, 84, -24, function() SendCommand(".gm off") end)
CreateButton(gmPage, "God an", 78, 24, 168, -24, function() SendCommand(".gm god on") end)
CreateButton(gmPage, "God aus", 78, 24, 252, -24, function() SendCommand(".gm god off") end)

CreateButton(gmPage, "Flug an", 78, 24, 0, -55, function() SendCommand(".gm fly on") end)
CreateButton(gmPage, "Flug aus", 78, 24, 84, -55, function() SendCommand(".gm fly off") end)
CreateButton(gmPage, "Sichtbar", 78, 24, 168, -55, function() SendCommand(".gm visible on") end)
CreateButton(gmPage, "Unsichtbar", 78, 24, 252, -55, function() SendCommand(".gm visible off") end)

CreateLabel(gmPage, "Charakter", 0, -95)
CreateButton(gmPage, "+79 Level", 78, 24, 0, -118, function() SendCommand(".levelup 79") end)
CreateButton(gmPage, "Beleben", 78, 24, 84, -118, function() SendCommand(".revive") end)
CreateButton(gmPage, "Position", 78, 24, 168, -118, function() SendCommand(".gps") end)
CreateButton(gmPage, "Rueckruf", 78, 24, 252, -118, function() SendCommand(".recall") end)

CreateButton(gmPage, "Zauber", 78, 24, 0, -149, function() SendCommand(".learn all my class") end)
CreateButton(gmPage, "Reittiere", 78, 24, 84, -149, function() SendCommand(".learn all my mounts") end)
CreateButton(gmPage, "Respawn", 78, 24, 168, -149, function() SendCommand(".respawn") end)
CreateButton(gmPage, "Reset Inst.", 78, 24, 252, -149, function() SendCommand(".instance unbind all") end)

CreateLabel(gmPage, "Gold an eigenen Charakter", 0, -192)
local goldInput = CreateInput(gmPage, 80, 0, -214, "100")
CreateButton(gmPage, "Gold geben", 105, 23, 90, -214, function()
    local text = Trim(goldInput:GetText())
    local gold = tonumber(text)
    if not gold or gold <= 0 then
        Print("Bitte einen positiven Goldbetrag eingeben.")
        return
    end

    gold = math.floor(gold)
    local copper = gold * 10000
    ClearTarget()
    SendCommand(".modify money " .. string.format("%.0f", copper))
end)
CreateButton(gmPage, "+100 Gold", 105, 23, 205, -214, function()
    ClearTarget()
    SendCommand(".modify money 1000000")
end)

CreateLabel(gmPage, "Geschwindigkeit", 0, -255)
local speedInput = CreateInput(gmPage, 55, 0, -277, "2")
CreateButton(gmPage, "Laufen", 78, 23, 65, -277, function()
    SendCommand(".modify speed " .. Trim(speedInput:GetText()))
end)
CreateButton(gmPage, "Fliegen", 78, 23, 149, -277, function()
    SendCommand(".modify speed fly " .. Trim(speedInput:GetText()))
end)

CreateButton(gmPage, "Alle Befehle", 105, 23, 235, -277, function() SendCommand(".commands") end)

-- Teleports
CreateLabel(telePage, "Allianz", 0, 0)
CreateButton(telePage, "Sturmwind", 105, 24, 0, -24, function() SendCommand(".tele stormwind") end)
CreateButton(telePage, "Eisenschmiede", 105, 24, 112, -24, function() SendCommand(".tele ironforge") end)
CreateButton(telePage, "Darnassus", 105, 24, 224, -24, function() SendCommand(".tele darnassus") end)
CreateButton(telePage, "Exodar", 105, 24, 0, -55, function() SendCommand(".tele exodar") end)

CreateLabel(telePage, "Horde", 0, -95)
CreateButton(telePage, "Orgrimmar", 105, 24, 0, -118, function() SendCommand(".tele orgrimmar") end)
CreateButton(telePage, "Unterstadt", 105, 24, 112, -118, function() SendCommand(".tele undercity") end)
CreateButton(telePage, "Donnerfels", 105, 24, 224, -118, function() SendCommand(".tele thunderbluff") end)
CreateButton(telePage, "Silbermond", 105, 24, 0, -149, function() SendCommand(".tele silvermoon") end)

CreateLabel(telePage, "Neutral", 0, -189)
CreateButton(telePage, "Dalaran", 105, 24, 0, -212, function() SendCommand(".tele dalaran") end)
CreateButton(telePage, "Shattrath", 105, 24, 112, -212, function() SendCommand(".tele shattrath") end)

CreateLabel(telePage, "Eigener Teleport", 0, -254)
local teleInput = CreateInput(telePage, 150, 0, -276, "")
CreateButton(telePage, "Teleport", 82, 23, 160, -276, function()
    local value = Trim(teleInput:GetText())
    if value == "" then
        Print("Bitte einen Teleportnamen eingeben.")
        return
    end
    SendCommand(".tele " .. value)
end)
CreateButton(telePage, "Suchen", 82, 23, 248, -276, function()
    local value = Trim(teleInput:GetText())
    if value == "" then
        Print("Bitte einen Suchbegriff eingeben.")
        return
    end
    SendCommand(".lookup tele " .. value)
end)

-- Eigener Befehl
CreateLabel(customPage, "Beliebigen Serverbefehl ausfuehren", 0, 0)
local customInput = CreateInput(customPage, 330, 0, -28, ".commands")
customInput:SetScript("OnEnterPressed", function(self)
    SendCommand(self:GetText())
    self:ClearFocus()
end)
CreateButton(customPage, "Ausfuehren", 105, 26, 0, -65, function()
    SendCommand(customInput:GetText())
end)
CreateButton(customPage, "Leeren", 105, 26, 112, -65, function()
    customInput:SetText("")
    customInput:SetFocus()
end)

CreateLabel(customPage, "Befehlshilfe", 0, -112)
local helpInput = CreateInput(customPage, 160, 0, -134, "tele")
CreateButton(customPage, "Hilfe anzeigen", 130, 23, 170, -134, function()
    local value = Trim(helpInput:GetText())
    if value == "" then
        SendCommand(".commands")
    else
        SendCommand(".help " .. value)
    end
end)

local customHint = customPage:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
customHint:SetPoint("TOPLEFT", customPage, "TOPLEFT", 0, -186)
customHint:SetWidth(340)
customHint:SetJustifyH("LEFT")
customHint:SetText("Beispiele:\n.npcbot help spawn\n.lookup item Frostmourne\n.additem 6948 1\n.quest complete 12345\n\nDer fuehrende Punkt wird automatisch ergaenzt.")

local function ToggleWindow()
    if main:IsShown() then
        main:Hide()
    else
        main:Show()
    end
end

-- Minimap button
local minimapButton = CreateFrame("Button", "PrivateWoWAdminMinimapButton", Minimap)
minimapButton:SetWidth(32)
minimapButton:SetHeight(32)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetFrameLevel(8)
minimapButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
minimapButton:RegisterForDrag("LeftButton")

local minimapBackground = minimapButton:CreateTexture(nil, "BACKGROUND")
minimapBackground:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
minimapBackground:SetWidth(54)
minimapBackground:SetHeight(54)
minimapBackground:SetPoint("TOPLEFT", minimapButton, "TOPLEFT", 0, 0)

local minimapIcon = minimapButton:CreateTexture(nil, "ARTWORK")
minimapIcon:SetTexture("Interface\\Icons\\INV_Misc_Gear_01")
minimapIcon:SetWidth(20)
minimapIcon:SetHeight(20)
minimapIcon:SetPoint("CENTER", minimapButton, "CENTER", 0, 0)
minimapIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

local minimapHighlight = minimapButton:CreateTexture(nil, "HIGHLIGHT")
minimapHighlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
minimapHighlight:SetBlendMode("ADD")
minimapHighlight:SetAllPoints(minimapButton)

local function UpdateMinimapPosition(angle)
    angle = angle or PrivateWoWAdminDB.minimapAngle or 225
    PrivateWoWAdminDB.minimapAngle = angle
    local radians = math.rad(angle)
    local radius = 80
    minimapButton:ClearAllPoints()
    minimapButton:SetPoint("CENTER", Minimap, "CENTER", math.cos(radians) * radius, math.sin(radians) * radius)
end

minimapButton:SetScript("OnClick", function(_, button)
    if button == "RightButton" then
        Print("Fenster mit Linksklick oder /pwa oeffnen.")
    else
        ToggleWindow()
    end
end)

minimapButton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText("PrivateWoWAdmin")
    GameTooltip:AddLine("Linksklick: Fenster oeffnen", 1, 1, 1)
    GameTooltip:AddLine("Ziehen: Symbol verschieben", 0.8, 0.8, 0.8)
    GameTooltip:Show()
end)
minimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

minimapButton:SetScript("OnDragStart", function(self)
    self:SetScript("OnUpdate", function()
        local mx, my = Minimap:GetCenter()
        local scale = UIParent:GetEffectiveScale()
        local cx, cy = GetCursorPosition()
        cx = cx / scale
        cy = cy / scale
        local angle = math.deg(math.atan2(cy - my, cx - mx))
        UpdateMinimapPosition(angle)
    end)
end)
minimapButton:SetScript("OnDragStop", function(self)
    self:SetScript("OnUpdate", nil)
end)

SLASH_PRIVATEWOWADMIN1 = "/pwa"
SLASH_PRIVATEWOWADMIN2 = "/privatewowadmin"
SlashCmdList["PRIVATEWOWADMIN"] = function(message)
    local value = Trim(message)
    if value == "" then
        ToggleWindow()
    else
        SendCommand(value)
    end
end

main:RegisterEvent("PLAYER_LOGIN")
main:SetScript("OnEvent", function(self, event)
    if event ~= "PLAYER_LOGIN" then
        return
    end

    if PrivateWoWAdminDB.point then
        self:ClearAllPoints()
        self:SetPoint(
            PrivateWoWAdminDB.point,
            UIParent,
            PrivateWoWAdminDB.relativePoint or PrivateWoWAdminDB.point,
            PrivateWoWAdminDB.x or 0,
            PrivateWoWAdminDB.y or 0
        )
    end

    UpdateMinimapPosition()
    ShowPage(botPage, tabBot)
    Print("geladen. Oeffnen mit Minimap-Symbol oder /pwa.")
end)
