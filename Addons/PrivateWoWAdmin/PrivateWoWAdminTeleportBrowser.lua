PrivateWoWAdminTeleportBrowser = PrivateWoWAdminTeleportBrowser or {}

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
    button:SetWidth(width)
    button:SetHeight(height)
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    button:SetText(text)
    button:SetScript("OnClick", onClick)
    return button
end

local function CreateInput(parent, width, x, y)
    local input = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    input:SetWidth(width)
    input:SetHeight(22)
    input:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    input:SetAutoFocus(false)
    return input
end

local frame = CreateFrame("Frame", "PrivateWoWAdminTeleportBrowserFrame", UIParent)
frame:SetWidth(620)
frame:SetHeight(535)
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
title:SetText("Teleportziele")

local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("LEFT", title, "RIGHT", 10, -1)
subtitle:SetText("Aus game_tele + DBC-Gebieten")

local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)

local categoryLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
categoryLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -54)
categoryLabel:SetText("Kategorie")

local zoneLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zoneLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 245, -54)
zoneLabel:SetText("Gebiet")

local searchLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
searchLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -101)
searchLabel:SetText("Ort filtern")

local categoryIndex = 1
local zoneIndex = 1
local categoryButton
local zoneButton
local searchInput = CreateInput(frame, 360, 18, -123)
local searchButton
local clearButton

local resultRows = {}
local currentResults = {}
local selectedItem = nil
local pageOffset = 0
local rowsPerPage = 11

local statusText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
statusText:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -159)
statusText:SetWidth(580)
statusText:SetJustifyH("LEFT")

local selectedText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
selectedText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18, 58)
selectedText:SetWidth(580)
selectedText:SetJustifyH("LEFT")
selectedText:SetText("Ausgewaehlt: nichts")

local function GetCategories()
    if PrivateWoWAdminTeleports and PrivateWoWAdminTeleports.categories then
        return PrivateWoWAdminTeleports.categories
    end
    return {}
end

local function GetSelectedCategory()
    return GetCategories()[categoryIndex]
end

local function GetSelectedZone()
    local category = GetSelectedCategory()
    if not category or not category.zones then
        return nil
    end
    return category.zones[zoneIndex]
end

local function RefreshRows()
    for index = 1, rowsPerPage do
        local row = resultRows[index]
        local item = currentResults[pageOffset + index]
        if item then
            row.item = item
            row.name:SetText(item.name)
            row.meta:SetText("ID " .. item.id .. "  |  Map " .. item.map)
            row:Show()
            if selectedItem and selectedItem.id == item.id then
                row:LockHighlight()
            else
                row:UnlockHighlight()
            end
        else
            row.item = nil
            row:Hide()
        end
    end
end

local function RefreshZoneButton()
    local category = GetSelectedCategory()
    if not category or not category.zones or #category.zones == 0 then
        zoneIndex = 1
        zoneButton:SetText("Keine Gebiete")
        return
    end

    if zoneIndex > #category.zones then
        zoneIndex = 1
    end
    zoneButton:SetText(category.zones[zoneIndex].name)
end

local function RunFilter()
    local category = GetSelectedCategory()
    local zone = GetSelectedZone()
    currentResults = {}
    selectedItem = nil
    pageOffset = 0

    if not category or not zone then
        statusText:SetText("Keine Teleportdaten geladen. Generator ausfuehren und Addon neu installieren.")
        selectedText:SetText("Ausgewaehlt: nichts")
        RefreshRows()
        return
    end

    local needle = string.lower(Trim(searchInput:GetText()))
    for _, item in ipairs(zone.items or {}) do
        if needle == "" or string.find(string.lower(item.name or ""), needle, 1, true) then
            table.insert(currentResults, item)
        end
    end

    statusText:SetText(category.name .. " > " .. zone.name .. ": " .. #currentResults .. " Ziele")
    selectedText:SetText("Ausgewaehlt: nichts")
    RefreshRows()
end

categoryButton = CreateButton(frame, "", 210, 23, 18, -76, function()
    local categories = GetCategories()
    if #categories == 0 then
        Print("Keine Teleportdaten geladen.")
        return
    end

    categoryIndex = categoryIndex + 1
    if categoryIndex > #categories then
        categoryIndex = 1
    end

    zoneIndex = 1
    categoryButton:SetText(categories[categoryIndex].name)
    RefreshZoneButton()
    RunFilter()
end)

zoneButton = CreateButton(frame, "", 342, 23, 245, -76, function()
    local category = GetSelectedCategory()
    if not category or not category.zones or #category.zones == 0 then
        Print("Keine Gebiete in dieser Kategorie vorhanden.")
        return
    end

    zoneIndex = zoneIndex + 1
    if zoneIndex > #category.zones then
        zoneIndex = 1
    end

    RefreshZoneButton()
    RunFilter()
end)

searchButton = CreateButton(frame, "Filtern", 100, 23, 390, -123, RunFilter)
clearButton = CreateButton(frame, "X", 35, 23, 500, -123, function()
    searchInput:SetText("")
    RunFilter()
end)

searchInput:SetScript("OnEnterPressed", function(self)
    RunFilter()
    self:ClearFocus()
end)

for index = 1, rowsPerPage do
    local y = -184 - ((index - 1) * 27)
    local row = CreateFrame("Button", nil, frame)
    row:SetWidth(580)
    row:SetHeight(25)
    row:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, y)
    row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

    local background = row:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(row)
    background:SetTexture(1, 1, 1, index % 2 == 0 and 0.04 or 0.02)

    row.name = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.name:SetPoint("LEFT", row, "LEFT", 6, 0)
    row.name:SetWidth(390)
    row.name:SetJustifyH("LEFT")

    row.meta = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.meta:SetPoint("RIGHT", row, "RIGHT", -6, 0)
    row.meta:SetWidth(165)
    row.meta:SetJustifyH("RIGHT")

    row:SetScript("OnClick", function(self)
        selectedItem = self.item
        if selectedItem then
            selectedText:SetText("Ausgewaehlt: " .. selectedItem.name .. "  (ID " .. selectedItem.id .. ", Map " .. selectedItem.map .. ")")
        end
        RefreshRows()
    end)

    row:SetScript("OnDoubleClick", function(self)
        if self.item then
            SendCommand(".tele " .. self.item.name)
        end
    end)

    resultRows[index] = row
end

CreateButton(frame, "Zurueck", 80, 24, 18, -473, function()
    pageOffset = math.max(0, pageOffset - rowsPerPage)
    RefreshRows()
end)

CreateButton(frame, "Weiter", 80, 24, 106, -473, function()
    if pageOffset + rowsPerPage < #currentResults then
        pageOffset = pageOffset + rowsPerPage
        RefreshRows()
    end
end)

CreateButton(frame, "Teleportieren", 130, 28, 455, -467, function()
    if not selectedItem then
        Print("Bitte zuerst ein Teleportziel auswaehlen.")
        return
    end
    SendCommand(".tele " .. selectedItem.name)
end)

function PrivateWoWAdminTeleportBrowser.Refresh()
    local categories = GetCategories()
    if #categories > 0 then
        if categoryIndex > #categories then
            categoryIndex = 1
        end
        categoryButton:SetText(categories[categoryIndex].name)
    else
        categoryButton:SetText("Keine Daten")
    end

    RefreshZoneButton()
    RunFilter()
end

function PrivateWoWAdminTeleportBrowser.Toggle()
    if frame:IsShown() then
        frame:Hide()
    else
        PrivateWoWAdminTeleportBrowser.Refresh()
        frame:Show()
        searchInput:SetFocus()
    end
end

local main = _G.PrivateWoWAdminFrame
if main then
    CreateButton(main, "Teleportliste", 100, 28, 18, -276, PrivateWoWAdminTeleportBrowser.Toggle)
end

SLASH_PRIVATEWOWADMINTELEPORTS1 = "/pwatele"
SlashCmdList["PRIVATEWOWADMINTELEPORTS"] = function(message)
    PrivateWoWAdminTeleportBrowser.Toggle()
    local query = Trim(message)
    if query ~= "" then
        searchInput:SetText(query)
        RunFilter()
    end
end
