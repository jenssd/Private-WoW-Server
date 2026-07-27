PrivateWoWAdminItems = PrivateWoWAdminItems or {}
PrivateWoWAdminItems.data = PrivateWoWAdminItems.data or {}

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

function PrivateWoWAdminItems.AddItem(itemId, count)
    itemId = tonumber(itemId)
    count = tonumber(count) or 1
    if not itemId then
        Print("Ungueltige Item-ID.")
        return
    end
    count = math.max(1, math.floor(count))
    ClearTarget()
    SendCommand(".additem " .. itemId .. " " .. count)
end

function PrivateWoWAdminItems.SearchLocal(searchText, limit)
    local results = {}
    local needle = string.lower(Trim(searchText))
    limit = tonumber(limit) or 12

    if needle == "" then
        return results
    end

    local numericId = tonumber(needle)

    for itemId, item in pairs(PrivateWoWAdminItems.data) do
        local nameEn
        local nameDe

        if type(item) == "table" then
            nameEn = item.en or ""
            nameDe = item.de or nameEn
        else
            nameEn = tostring(item or "")
            nameDe = nameEn
        end

        local matchesId = numericId and tonumber(itemId) == numericId
        local matchesEn = string.find(string.lower(nameEn), needle, 1, true)
        local matchesDe = string.find(string.lower(nameDe), needle, 1, true)

        if matchesId or matchesEn or matchesDe then
            table.insert(results, {
                id = tonumber(itemId),
                en = nameEn,
                de = nameDe
            })
        end
    end

    table.sort(results, function(a, b)
        local aName = string.lower(a.de ~= "" and a.de or a.en)
        local bName = string.lower(b.de ~= "" and b.de or b.en)
        if aName == bName then
            return a.id < b.id
        end
        return aName < bName
    end)

    while #results > limit do
        table.remove(results)
    end

    return results
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

local function CreateInput(parent, width, x, y, defaultText)
    local input = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    input:SetWidth(width)
    input:SetHeight(22)
    input:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    input:SetAutoFocus(false)
    input:SetText(defaultText or "")
    return input
end

local itemFrame = CreateFrame("Frame", "PrivateWoWAdminItemFrame", UIParent)
itemFrame:SetWidth(560)
itemFrame:SetHeight(500)
itemFrame:SetPoint("CENTER")
itemFrame:SetMovable(true)
itemFrame:EnableMouse(true)
itemFrame:RegisterForDrag("LeftButton")
itemFrame:SetScript("OnDragStart", itemFrame.StartMoving)
itemFrame:SetScript("OnDragStop", itemFrame.StopMovingOrSizing)
itemFrame:SetClampedToScreen(true)
itemFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 24,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
itemFrame:Hide()

local title = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
title:SetPoint("TOPLEFT", itemFrame, "TOPLEFT", 18, -16)
title:SetText("Item-Datenbank")

local subtitle = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("LEFT", title, "RIGHT", 10, -1)
subtitle:SetText("Deutsch + Englisch")

local closeButton = CreateFrame("Button", nil, itemFrame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", itemFrame, "TOPRIGHT", -4, -4)

local searchLabel = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
searchLabel:SetPoint("TOPLEFT", itemFrame, "TOPLEFT", 18, -54)
searchLabel:SetText("Name oder Item-ID")

local searchInput = CreateInput(itemFrame, 280, 18, -76, "")
local searchButton

local countLabel = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
countLabel:SetPoint("TOPLEFT", itemFrame, "TOPLEFT", 410, -54)
countLabel:SetText("Anzahl")
local countInput = CreateInput(itemFrame, 55, 410, -76, "1")

local statusText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
statusText:SetPoint("TOPLEFT", itemFrame, "TOPLEFT", 18, -108)
statusText:SetWidth(520)
statusText:SetJustifyH("LEFT")
statusText:SetText("Suchbegriff eingeben. Es werden maximal 10 Treffer angezeigt.")

local resultRows = {}
local currentResults = {}

local function GetItemDisplay(item)
    local de = item.de or ""
    local en = item.en or ""
    if de == "" then
        de = en
    end
    return de, en
end

local function RefreshRows()
    for index = 1, 10 do
        local row = resultRows[index]
        local item = currentResults[index]

        if item then
            local de, en = GetItemDisplay(item)
            row.item = item
            row.nameDe:SetText(de)
            if en ~= "" and en ~= de then
                row.nameEn:SetText(en)
            else
                row.nameEn:SetText("")
            end
            row.itemId:SetText("ID: " .. item.id)
            row:Show()
        else
            row.item = nil
            row:Hide()
        end
    end
end

local function RunSearch()
    local query = Trim(searchInput:GetText())
    if query == "" then
        currentResults = {}
        statusText:SetText("Bitte einen deutschen oder englischen Namen beziehungsweise eine Item-ID eingeben.")
        RefreshRows()
        return
    end

    currentResults = PrivateWoWAdminItems.SearchLocal(query, 10)
    statusText:SetText(#currentResults .. " Treffer angezeigt.")
    RefreshRows()
end

searchButton = CreateButton(itemFrame, "Suchen", 92, 23, 308, -76, RunSearch)
searchInput:SetScript("OnEnterPressed", function(self)
    RunSearch()
    self:ClearFocus()
end)

for index = 1, 10 do
    local y = -135 - ((index - 1) * 32)
    local row = CreateFrame("Frame", nil, itemFrame)
    row:SetWidth(520)
    row:SetHeight(30)
    row:SetPoint("TOPLEFT", itemFrame, "TOPLEFT", 18, y)

    local background = row:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints(row)
    background:SetTexture(1, 1, 1, index % 2 == 0 and 0.04 or 0.02)

    row.nameDe = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.nameDe:SetPoint("TOPLEFT", row, "TOPLEFT", 5, -3)
    row.nameDe:SetWidth(305)
    row.nameDe:SetJustifyH("LEFT")

    row.nameEn = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.nameEn:SetPoint("TOPLEFT", row, "TOPLEFT", 5, -16)
    row.nameEn:SetWidth(305)
    row.nameEn:SetJustifyH("LEFT")

    row.itemId = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.itemId:SetPoint("TOPLEFT", row, "TOPLEFT", 315, -9)
    row.itemId:SetWidth(75)
    row.itemId:SetJustifyH("LEFT")

    row.addOne = CreateButton(row, "+1", 52, 22, 392, -4, function()
        if row.item then
            PrivateWoWAdminItems.AddItem(row.item.id, 1)
        end
    end)

    row.addCount = CreateButton(row, "+Anzahl", 72, 22, 446, -4, function()
        if row.item then
            local count = tonumber(Trim(countInput:GetText())) or 1
            PrivateWoWAdminItems.AddItem(row.item.id, count)
        end
    end)

    row:SetScript("OnEnter", function(self)
        if not self.item then
            return
        end
        local itemName, itemLink = GetItemInfo(self.item.id)
        if itemLink then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(itemLink)
            GameTooltip:Show()
        elseif itemName then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(itemName)
            GameTooltip:AddLine("Item-ID: " .. self.item.id, 1, 1, 1)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    resultRows[index] = row
end

local directLabel = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
directLabel:SetPoint("BOTTOMLEFT", itemFrame, "BOTTOMLEFT", 18, 47)
directLabel:SetText("Direkt per Item-ID")

local directIdInput = CreateInput(itemFrame, 100, 130, -430, "6948")
CreateButton(itemFrame, "Hinzufuegen", 110, 23, 240, -430, function()
    local itemId = tonumber(Trim(directIdInput:GetText()))
    local count = tonumber(Trim(countInput:GetText())) or 1
    PrivateWoWAdminItems.AddItem(itemId, count)
end)

local footer = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
footer:SetPoint("BOTTOMLEFT", itemFrame, "BOTTOMLEFT", 18, 15)
footer:SetWidth(520)
footer:SetJustifyH("LEFT")
footer:SetText("Hinweis: Das Inventar benoetigt freien Platz. Die Tooltip-Daten kommen aus dem lokalen WoW-Clientcache.")

local function ToggleItemWindow()
    if itemFrame:IsShown() then
        itemFrame:Hide()
    else
        itemFrame:Show()
        searchInput:SetFocus()
    end
end

local main = _G.PrivateWoWAdminFrame
if main then
    CreateButton(main, "Items", 100, 28, 18, -208, ToggleItemWindow)
end

SLASH_PRIVATEWOWADMINITEMS1 = "/pwai"
SlashCmdList["PRIVATEWOWADMINITEMS"] = function(message)
    local query = Trim(message)
    if query == "" then
        ToggleItemWindow()
    else
        itemFrame:Show()
        searchInput:SetText(query)
        RunSearch()
    end
end
