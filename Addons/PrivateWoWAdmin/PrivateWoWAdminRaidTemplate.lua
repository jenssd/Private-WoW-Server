PrivateWoWAdminRaidTemplate = PrivateWoWAdminRaidTemplate or {}

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PrivateWoWAdmin:|r " .. tostring(message))
end

local function SendCommand(command)
    if string.sub(command, 1, 1) ~= "." then
        command = "." .. command
    end
    SendChatMessage(command, "SAY")
end

local function CreateButton(parent, text, width, height, x, y, onClick)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetWidth(width)
    button:SetHeight(height)
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    button:SetText(text)
    button:SetScript("OnClick", onClick)
    return button
end

local roles = {
    {
        key = "tank",
        label = "Tank: Schutz-Krieger",
        classToken = "WARRIOR",
        spec = 3,
        note = "Aggro halten, Gegner sammeln und Zauber unterbrechen.",
        items = { 16963, 16961, 19386, 16966, 16959, 16964, 16960, 16962, 16965, 19383, 19376, 19431, 19406, 19341, 19335, 19349 }
    },
    {
        key = "healer",
        label = "Heiler: Heilig-Paladin",
        classToken = "PALADIN",
        spec = 1,
        note = "Tank priorisieren und bannbare Magie-, Gift- und Krankheitseffekte reinigen.",
        items = { 16955, 16953, 19378, 16958, 16951, 16956, 16952, 16954, 16957, 19371, 19382, 19397, 19395, 19312, 19360, 19348 }
    },
    {
        key = "rogue",
        label = "DD: Kampf-Schurke",
        classToken = "ROGUE",
        spec = 2,
        note = "Physischer Nahkampfschaden, Tritt und Betäubungen.",
        items = { 16908, 16832, 19398, 16905, 16911, 16907, 16910, 16909, 16906, 19377, 18821, 19384, 19406, 22954, 19351, 19352 }
    },
    {
        key = "fury",
        label = "DD: Furor-Krieger",
        classToken = "WARRIOR",
        spec = 2,
        note = "Dauerhafter physischer Schaden; auf Level 60 zwei Einhandwaffen verwenden.",
        items = { 16963, 16961, 19398, 16966, 16959, 16964, 16960, 16962, 16965, 19377, 18821, 19384, 19406, 22954, 22808, 23242 }
    },
    {
        key = "hunter",
        label = "DD: Treffsicherheits-Jaeger",
        classToken = "HUNTER",
        spec = 2,
        note = "Physischer Fernkampfschaden; bleibt bei Silence voll einsatzfaehig.",
        items = { 16939, 16937, 19398, 16942, 16935, 16940, 16936, 16938, 16941, 19377, 18821, 19384, 19406, 22954, 19361, 19368 }
    }
}

local queuedItems = {}
local queueElapsed = 0
local pendingRole = nil

local frame = CreateFrame("Frame", "PrivateWoWAdminRaidTemplateFrame", UIParent)
frame:SetWidth(680)
frame:SetHeight(545)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetClampedToScreen(true)
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 24,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
frame:Hide()

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
title:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -16)
title:SetText("Level-60-Raidvorlage")

local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("LEFT", title, "RIGHT", 10, -1)
subtitle:SetText("Elementar-Schamane + physische DDs")

local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)

local intro = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
intro:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -52)
intro:SetWidth(640)
intro:SetJustifyH("LEFT")
intro:SetText("Bot als Ziel waehlen und Konfigurieren klicken. Das Addon setzt den Spec und legt das vorbereitete Gear in dein Inventar. Danach beim Bot: Manage equipment -> Auto-equip.")

local status = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
status:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18, 48)
status:SetWidth(640)
status:SetJustifyH("LEFT")
status:SetText("Bereit.")

local function TargetMatches(role)
    if not UnitExists("target") then
        Print("Bitte zuerst den vorgesehenen NPCBot auswaehlen.")
        return false
    end
    local _, classToken = UnitClass("target")
    if classToken ~= role.classToken then
        Print("Falsche Klasse ausgewaehlt. Erwartet: " .. role.label)
        return false
    end
    return true
end

local function ConfigureRole(role)
    if #queuedItems > 0 then
        Print("Die vorige Itemausgabe laeuft noch.")
        return
    end
    if not TargetMatches(role) then
        return
    end

    SendCommand(".npcbot set spec " .. role.spec)
    pendingRole = role
    queuedItems = {}
    for _, itemId in ipairs(role.items) do
        table.insert(queuedItems, itemId)
    end

    ClearTarget()
    status:SetText(role.label .. ": Spec gesetzt; " .. #queuedItems .. " Gegenstaende werden ausgegeben...")
    Print("Nach der Ausgabe den Bot rechtsklicken: Manage equipment -> Auto-equip.")
end

for index, role in ipairs(roles) do
    local y = -100 - ((index - 1) * 70)
    local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOPLEFT", frame, "TOPLEFT", 24, y)
    label:SetText(role.label)

    local note = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    note:SetPoint("TOPLEFT", frame, "TOPLEFT", 24, y - 21)
    note:SetWidth(450)
    note:SetJustifyH("LEFT")
    note:SetText(role.note)

    CreateButton(frame, "Konfigurieren", 125, 26, 520, y - 4, function()
        ConfigureRole(role)
    end)
end

CreateButton(frame, "Raid vorbereiten", 145, 28, 18, -455, function()
    if GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0 then
        ConvertToRaid()
        Print("Gruppe wurde in einen Raid umgewandelt.")
    elseif GetNumRaidMembers() == 0 then
        Print("Zuerst Bots in eine normale Gruppe aufnehmen.")
    end
    SendCommand(".npcbot command follow")
    SendCommand(".npcbot recall teleport")
    status:SetText("Raid vorbereitet: Follow und Recall wurden gesendet.")
end)

CreateButton(frame, "Follow + Recall", 145, 28, 175, -455, function()
    SendCommand(".npcbot command follow")
    SendCommand(".npcbot recall teleport")
    status:SetText("Follow und Recall wurden gesendet.")
end)

CreateButton(frame, "Bot-Hilfe", 110, 28, 332, -455, function()
    SendCommand(".npcbot help")
end)

frame:SetScript("OnUpdate", function(self, elapsed)
    if #queuedItems == 0 then
        return
    end

    queueElapsed = queueElapsed + elapsed
    if queueElapsed < 0.35 then
        return
    end
    queueElapsed = 0

    local itemId = table.remove(queuedItems, 1)
    SendCommand(".additem " .. itemId .. " 1")

    if #queuedItems == 0 and pendingRole then
        status:SetText(pendingRole.label .. ": Gear ausgegeben. Jetzt am Bot Auto-equip ausfuehren.")
        Print(pendingRole.label .. " vorbereitet.")
        pendingRole = nil
    end
end)

function PrivateWoWAdminRaidTemplate.Toggle()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

local main = _G.PrivateWoWAdminFrame
if main then
    CreateButton(main, "Raidvorlage", 100, 28, 18, -312, PrivateWoWAdminRaidTemplate.Toggle)
end

SLASH_PRIVATEWOWADMINRAIDTEMPLATE1 = "/pwaraid"
SlashCmdList["PRIVATEWOWADMINRAIDTEMPLATE"] = function()
    PrivateWoWAdminRaidTemplate.Toggle()
end
