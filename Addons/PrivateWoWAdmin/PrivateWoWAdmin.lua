local addonName = ...

PrivateWoWAdminDB = PrivateWoWAdminDB or {}

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PrivateWoWAdmin:|r " .. tostring(message))
end

local function SendCommand(command)
    if not command or command == "" then
        return
    end

    if string.sub(command, 1, 1) ~= "." then
        command = "." .. command
    end

    SendChatMessage(command, "SAY")
    Print("Ausgefuehrt: " .. command)
end

local function Trim(value)
    if not value then
        return ""
    end

    return string.gsub(value, "^%s*(.-)%s*$", "%1")
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
    input:SetHeight(24)
    input:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    input:SetAutoFocus(false)
    input:SetText(defaultText or "")
    input:SetCursorPosition(0)
    return input
end

local main = CreateFrame("Frame", "PrivateWoWAdminFrame", UIParent)
main:SetWidth(590)
main:SetHeight(540)
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
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
main:Hide()

local title = main:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
title:SetPoint("TOP", main, "TOP", 0, -17)
title:SetText("PrivateWoWAdmin")

local subtitle = main:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("TOP", title, "BOTTOM", 0, -4)
subtitle:SetText("GM- und NPCBot-Befehle fuer AzerothCore 3.3.5a")

local closeButton = CreateFrame("Button", nil, main, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", main, "TOPRIGHT", -5, -5)

local tabBot = CreateButton(main, "NPCBots", 130, 25, 24, -58, function() end)
local tabGM = CreateButton(main, "GM", 130, 25, 164, -58, function() end)
local tabTele = CreateButton(main, "Teleport", 130, 25, 304, -58, function() end)
local tabCustom = CreateButton(main, "Eigener Befehl", 130, 25, 444, -58, function() end)

local pages = {}

local function CreatePage()
    local page = CreateFrame("Frame", nil, main)
    page:SetPoint("TOPLEFT", main, "TOPLEFT", 20, -92)
    page:SetPoint("BOTTOMRIGHT", main, "BOTTOMRIGHT", -20, 20)
    page:Hide()
    table.insert(pages, page)
    return page
end

local function ShowPage(page)
    for _, current in ipairs(pages) do
        current:Hide()
    end
    page:Show()
end

local botPage = CreatePage()
local gmPage = CreatePage()
local telePage = CreatePage()
local customPage = CreatePage()

-- NPCBots page
CreateLabel(botPage, "Hilfe und Verwaltung", 10, -5)
CreateButton(botPage, "Alle NPCBot-Befehle", 180, 26, 10, -30, function() SendCommand(".npcbot") end)
CreateButton(botPage, "Freie Bots auflisten", 180, 26, 200, -30, function() SendCommand(".npcbot list spawned free") end)
CreateButton(botPage, "Bot-Hilfe", 150, 26, 390, -30, function() SendCommand(".npcbot help") end)

CreateLabel(botPage, "Bot suchen (Klassen-ID)", 10, -76)
local classInput = CreateInput(botPage, 100, 10, -99, "1")
CreateButton(botPage, "Suchen", 130, 24, 120, -99, function()
    local value = Trim(classInput:GetText())
    SendCommand(".npcbot lookup " .. value)
end)

CreateLabel(botPage, "Bot erzeugen (Bot-ID)", 285, -76)
local spawnInput = CreateInput(botPage, 120, 285, -99, "")
CreateButton(botPage, "Erzeugen", 130, 24, 415, -99, function()
    local value = Trim(spawnInput:GetText())
    if value == "" then
        Print("Bitte zuerst eine Bot-ID eingeben.")
        return
    end
    SendCommand(".npcbot spawn " .. value)
end)

CreateLabel(botPage, "Ausgewaehlten Bot verwalten", 10, -146)
CreateButton(botPage, "Bot uebernehmen", 170, 28, 10, -174, function() SendCommand(".npcbot add") end)
CreateButton(botPage, "Bot entfernen", 170, 28, 190, -174, function() SendCommand(".npcbot remove") end)
CreateButton(botPage, "Bots herbeirufen", 170, 28, 370, -174, function() SendCommand(".npcbot recall teleport") end)

CreateLabel(botPage, "Gruppenbewegung", 10, -224)
CreateButton(botPage, "Alle folgen", 170, 28, 10, -252, function() SendCommand(".npcbot command follow") end)
CreateButton(botPage, "Alle warten", 170, 28, 190, -252, function() SendCommand(".npcbot command stay") end)
CreateButton(botPage, "Bots teleportieren", 170, 28, 370, -252, function() SendCommand(".npcbot recall teleport") end)

local botHint = botPage:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
botHint:SetPoint("TOPLEFT", botPage, "TOPLEFT", 10, -315)
botHint:SetWidth(530)
botHint:SetJustifyH("LEFT")
botHint:SetText("Hinweis: Fuer 'Bot uebernehmen' und 'Bot entfernen' vorher den Bot als Ziel auswaehlen. Weitere Einstellungen erreichst du per Rechtsklick auf den Bot.")

-- GM page
CreateLabel(gmPage, "GM-Modus", 10, -5)
CreateButton(gmPage, "GM an", 120, 26, 10, -30, function() SendCommand(".gm on") end)
CreateButton(gmPage, "GM aus", 120, 26, 140, -30, function() SendCommand(".gm off") end)
CreateButton(gmPage, "God an", 120, 26, 270, -30, function() SendCommand(".gm god on") end)
CreateButton(gmPage, "God aus", 120, 26, 400, -30, function() SendCommand(".gm god off") end)

CreateButton(gmPage, "Fliegen an", 120, 26, 10, -66, function() SendCommand(".gm fly on") end)
CreateButton(gmPage, "Fliegen aus", 120, 26, 140, -66, function() SendCommand(".gm fly off") end)
CreateButton(gmPage, "Sichtbar", 120, 26, 270, -66, function() SendCommand(".gm visible on") end)
CreateButton(gmPage, "Unsichtbar", 120, 26, 400, -66, function() SendCommand(".gm visible off") end)

CreateLabel(gmPage, "Charakter", 10, -116)
CreateButton(gmPage, "+79 Level", 120, 26, 10, -141, function() SendCommand(".levelup 79") end)
CreateButton(gmPage, "Wiederbeleben", 120, 26, 140, -141, function() SendCommand(".revive") end)
CreateButton(gmPage, "Position", 120, 26, 270, -141, function() SendCommand(".gps") end)
CreateButton(gmPage, "Rueckruf", 120, 26, 400, -141, function() SendCommand(".recall") end)

CreateButton(gmPage, "Klassenzauber", 120, 26, 10, -177, function() SendCommand(".learn all my class") end)
CreateButton(gmPage, "Reittiere", 120, 26, 140, -177, function() SendCommand(".learn all my mounts") end)
CreateButton(gmPage, "Respawn", 120, 26, 270, -177, function() SendCommand(".respawn") end)
CreateButton(gmPage, "Instanzen reset", 120, 26, 400, -177, function() SendCommand(".instance unbind all") end)

CreateLabel(gmPage, "Gold geben", 10, -228)
local goldInput = CreateInput(gmPage, 100, 10, -251, "100")
CreateButton(gmPage, "Gold hinzufuegen", 160, 24, 120, -251, function()
    local gold = tonumber(Trim(goldInput:GetText()))
    if not gold then
        Print("Bitte einen gueltigen Goldbetrag eingeben.")
        return
    end
    local copper = math.floor(gold * 10000)
    SendCommand(".modify money " .. copper)
end)

CreateLabel(gmPage, "Geschwindigkeit", 310, -228)
local speedInput = CreateInput(gmPage, 70, 310, -251, "2")
CreateButton(gmPage, "Laufen", 75, 24, 390, -251, function()
    SendCommand(".modify speed " .. Trim(speedInput:GetText()))
end)
CreateButton(gmPage, "Fliegen", 75, 24, 470, -251, function()
    SendCommand(".modify speed fly " .. Trim(speedInput:GetText()))
end)

CreateLabel(gmPage, "Hilfe", 10, -305)
CreateButton(gmPage, "Alle Befehle", 160, 26, 10, -330, function() SendCommand(".commands") end)
local helpInput = CreateInput(gmPage, 170, 190, -330, "tele")
CreateButton(gmPage, "Hilfe anzeigen", 160, 26, 370, -330, function()
    SendCommand(".help " .. Trim(helpInput:GetText()))
end)

-- Teleport page
CreateLabel(telePage, "Allianz", 10, -5)
CreateButton(telePage, "Sturmwind", 150, 26, 10, -30, function() SendCommand(".tele stormwind") end)
CreateButton(telePage, "Eisenschmiede", 150, 26, 170, -30, function() SendCommand(".tele ironforge") end)
CreateButton(telePage, "Darnassus", 150, 26, 330, -30, function() SendCommand(".tele darnassus") end)
CreateButton(telePage, "Exodar", 150, 26, 10, -66, function() SendCommand(".tele exodar") end)

CreateLabel(telePage, "Horde", 10, -116)
CreateButton(telePage, "Orgrimmar", 150, 26, 10, -141, function() SendCommand(".tele orgrimmar") end)
CreateButton(telePage, "Unterstadt", 150, 26, 170, -141, function() SendCommand(".tele undercity") end)
CreateButton(telePage, "Donnerfels", 150, 26, 330, -141, function() SendCommand(".tele thunderbluff") end)
CreateButton(telePage, "Silbermond", 150, 26, 10, -177, function() SendCommand(".tele silvermoon") end)

CreateLabel(telePage, "Neutral", 10, -227)
CreateButton(telePage, "Dalaran", 150, 26, 10, -252, function() SendCommand(".tele dalaran") end)
CreateButton(telePage, "Shattrath", 150, 26, 170, -252, function() SendCommand(".tele shattrath") end)

CreateLabel(telePage, "Eigener Teleport", 10, -307)
local teleInput = CreateInput(telePage, 210, 10, -330, "")
CreateButton(telePage, "Teleportieren", 150, 24, 230, -330, function()
    local value = Trim(teleInput:GetText())
    if value == "" then
        Print("Bitte einen Teleportnamen eingeben.")
        return
    end
    SendCommand(".tele " .. value)
end)
CreateButton(telePage, "Teleport suchen", 150, 24, 390, -330, function()
    local value = Trim(teleInput:GetText())
    if value == "" then
        Print("Bitte einen Suchbegriff eingeben.")
        return
    end
    SendCommand(".lookup tele " .. value)
end)

-- Custom page
CreateLabel(customPage, "Beliebigen Serverbefehl ausfuehren", 10, -5)
local customInput = CreateInput(customPage, 520, 10, -32, ".commands")
customInput:SetScript("OnEnterPressed", function(self)
    SendCommand(Trim(self:GetText()))
    self:ClearFocus()
end)
CreateButton(customPage, "Befehl ausfuehren", 200, 30, 10, -70, function()
    SendCommand(Trim(customInput:GetText()))
end)
CreateButton(customPage, "Eingabe leeren", 160, 30, 220, -70, function()
    customInput:SetText("")
    customInput:SetFocus()
end)

local customHint = customPage:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
customHint:SetPoint("TOPLEFT", customPage, "TOPLEFT", 10, -120)
customHint:SetWidth(520)
customHint:SetJustifyH("LEFT")
customHint:SetText("Beispiele:\n.npcbot help spawn\n.lookup item Frostmourne\n.additem 6948 1\n.quest complete 12345\n\nDer fuehrende Punkt wird automatisch ergaenzt, falls er fehlt.")

-- Tab wiring
tabBot:SetScript("OnClick", function() ShowPage(botPage) end)
tabGM:SetScript("OnClick", function() ShowPage(gmPage) end)
tabTele:SetScript("OnClick", function() ShowPage(telePage) end)
tabCustom:SetScript("OnClick", function() ShowPage(customPage) end)

local function ToggleWindow()
    if main:IsShown() then
        main:Hide()
    else
        main:Show()
    end
end

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

    ShowPage(botPage)
    Print("geladen. Fenster mit /pwa oeffnen.")
end)
