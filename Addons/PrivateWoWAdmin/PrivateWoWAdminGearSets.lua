PrivateWoWAdminGearSets = PrivateWoWAdminGearSets or {}

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

local function ItemExists(itemId)
    return PrivateWoWAdminItems
        and PrivateWoWAdminItems.data
        and PrivateWoWAdminItems.data[itemId] ~= nil
end

local function GetLocalizedItemName(itemId, fallback)
    local item = PrivateWoWAdminItems and PrivateWoWAdminItems.data and PrivateWoWAdminItems.data[itemId]
    if type(item) == "table" then
        return item.de or item.en or fallback
    elseif item then
        return tostring(item)
    end
    return fallback
end

-- Curated leveling sets. They are intentionally strong and convenient rather
-- than strict best-in-slot lists. New classes, specs and level brackets can be
-- added here without changing the set delivery logic.
PrivateWoWAdminGearSets.catalog = {
    shaman_enhancement = {
        className = "Schamane",
        specName = "Verstaerkung / Melee",
        ranges = {
            {
                key = "1-9",
                label = "Level 1-9",
                minLevel = 1,
                maxLevel = 9,
                sets = {
                    balanced = {
                        label = "Ausgewogen",
                        description = "Guter Start ohne das komplette Leveln zu trivialisieren.",
                        items = {
                            { id = 48716, slot = "Waffe", fallback = "Venerable Mass of McGowan" },
                            { id = 48677, slot = "Brust", fallback = "Champion's Deathdealer Breastplate" }
                        }
                    },
                    strong = {
                        label = "Stark",
                        description = "Mehr Schaden und deutlich weniger Ausruestungssorgen.",
                        items = {
                            { id = 48716, slot = "Waffe", fallback = "Venerable Mass of McGowan" },
                            { id = 48677, slot = "Brust", fallback = "Champion's Deathdealer Breastplate" },
                            { id = 42950, slot = "Schulter", fallback = "Champion Herod's Shoulder" },
                            { id = 42991, slot = "Schmuck", fallback = "Swift Hand of Justice" }
                        }
                    },
                    heirloom = {
                        label = "Erbstuecke",
                        description = "Komfortpaket mit skalierenden Gegenstaenden fuer viele Level.",
                        items = {
                            { id = 48716, slot = "Waffe", fallback = "Venerable Mass of McGowan" },
                            { id = 48677, slot = "Brust", fallback = "Champion's Deathdealer Breastplate" },
                            { id = 42950, slot = "Schulter", fallback = "Champion Herod's Shoulder" },
                            { id = 42991, slot = "Schmuck 1", fallback = "Swift Hand of Justice" },
                            { id = 42991, slot = "Schmuck 2", fallback = "Swift Hand of Justice" }
                        }
                    }
                }
            },
            {
                key = "10-19",
                label = "Level 10-19",
                minLevel = 10,
                maxLevel = 19,
                sets = {
                    balanced = {
                        label = "Ausgewogen",
                        description = "Solides Dungeon-Niveau fuer normales, angenehmes Questen.",
                        items = {
                            { id = 10400, slot = "Beine", fallback = "Blackened Defias Leggings" },
                            { id = 10403, slot = "Guertel", fallback = "Blackened Defias Belt" },
                            { id = 48716, slot = "Waffe", fallback = "Venerable Mass of McGowan" }
                        }
                    },
                    strong = {
                        label = "Stark",
                        description = "Twink-nahe Ausruestung, aber noch nicht komplett absurd.",
                        items = {
                            { id = 10399, slot = "Brust", fallback = "Blackened Defias Armor" },
                            { id = 10400, slot = "Beine", fallback = "Blackened Defias Leggings" },
                            { id = 10403, slot = "Guertel", fallback = "Blackened Defias Belt" },
                            { id = 6468, slot = "Guertel-Alternative", fallback = "Deviate Scale Belt" },
                            { id = 48716, slot = "Waffe", fallback = "Venerable Mass of McGowan" },
                            { id = 42991, slot = "Schmuck", fallback = "Swift Hand of Justice" }
                        }
                    },
                    heirloom = {
                        label = "Erbstuecke",
                        description = "Skalierendes Komfortset; bleibt auch nach Level 19 nuetzlich.",
                        items = {
                            { id = 48716, slot = "Waffe", fallback = "Venerable Mass of McGowan" },
                            { id = 48677, slot = "Brust", fallback = "Champion's Deathdealer Breastplate" },
                            { id = 42950, slot = "Schulter", fallback = "Champion Herod's Shoulder" },
                            { id = 42991, slot = "Schmuck 1", fallback = "Swift Hand of Justice" },
                            { id = 42991, slot = "Schmuck 2", fallback = "Swift Hand of Justice" }
                        }
                    }
                }
            }
        }
    },
    shaman_elemental = {
        className = "Schamane",
        specName = "Elementar / Fernkampf",
        ranges = {
            {
                key = "20-29",
                label = "Level 20-29",
                minLevel = 20,
                maxLevel = 29,
                sets = {
                    balanced = {
                        label = "Ausgewogen",
                        description = "Solides Caster-Set mit Intelligenz und Zauberschaden fuer entspanntes Questen.",
                        items = {
                            { id = 5404, slot = "Schulter", fallback = "Serpent's Shoulders" },
                            { id = 6465, slot = "Brust", fallback = "Robe of the Moccasin" },
                            { id = 2911, slot = "Guertel", fallback = "Keller's Girdle" },
                            { id = 12987, slot = "Beine", fallback = "Darkweave Breeches" },
                            { id = 5201, slot = "Waffe", fallback = "Emberstone Staff" },
                            { id = 1156, slot = "Ring", fallback = "Lavishly Jeweled Ring" }
                        }
                    },
                    strong = {
                        label = "Stark",
                        description = "Sehr starke Level-20-Ausrüstung mit vielen seltenen Caster-Gegenstaenden.",
                        items = {
                            { id = 5404, slot = "Schulter", fallback = "Serpent's Shoulders" },
                            { id = 6465, slot = "Brust", fallback = "Robe of the Moccasin" },
                            { id = 1974, slot = "Handgelenke", fallback = "Mindthrust Bracers" },
                            { id = 5195, slot = "Haende", fallback = "Gold-flecked Gloves" },
                            { id = 2911, slot = "Guertel", fallback = "Keller's Girdle" },
                            { id = 12987, slot = "Beine", fallback = "Darkweave Breeches" },
                            { id = 1121, slot = "Fuesse", fallback = "Feet of the Lynx" },
                            { id = 5201, slot = "Waffe", fallback = "Emberstone Staff" }
                        }
                    },
                    heirloom = {
                        label = "Erbstuecke",
                        description = "Skalierendes Elementar-Komfortset mit Zaubermacht, Intelligenz und Mana-Regeneration.",
                        items = {
                            { id = 42948, slot = "Waffe", fallback = "Devout Aurastone Hammer" },
                            { id = 48683, slot = "Brust", fallback = "Mystical Vest of Elements" },
                            { id = 42951, slot = "Schulter", fallback = "Mystical Pauldrons of Elements" },
                            { id = 42992, slot = "Schmuck 1", fallback = "Discerning Eye of the Beast" },
                            { id = 42992, slot = "Schmuck 2", fallback = "Discerning Eye of the Beast" }
                        }
                    }
                }
            }
        }
    }
}

local catalogKeys = { "shaman_enhancement", "shaman_elemental" }
local selectedCatalogIndex = 1
local selectedRangeIndex = 1
local selectedMode = "balanced"
local queuedItems = {}
local queueElapsed = 0

local function GetSelectedCatalog()
    return PrivateWoWAdminGearSets.catalog[catalogKeys[selectedCatalogIndex]]
end

local function GetSelectedRange()
    local catalog = GetSelectedCatalog()
    return catalog.ranges[selectedRangeIndex]
end

local frame = CreateFrame("Frame", "PrivateWoWAdminGearSetFrame", UIParent)
frame:SetWidth(570)
frame:SetHeight(485)
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
title:SetText("Level-Sets")

local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("LEFT", title, "RIGHT", 10, -1)

local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)

local currentLevelText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
currentLevelText:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -52)

local specLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
specLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -79)
specLabel:SetText("Skillung")

local specButton = CreateButton(frame, "", 175, 24, 18, -99, function()
    selectedCatalogIndex = selectedCatalogIndex + 1
    if selectedCatalogIndex > #catalogKeys then
        selectedCatalogIndex = 1
    end
    selectedRangeIndex = 1
    PrivateWoWAdminGearSets.Refresh()
end)

local rangeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
rangeLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 210, -79)
rangeLabel:SetText("Levelbereich")

local rangeButton = CreateButton(frame, "", 130, 24, 210, -99, function()
    local ranges = GetSelectedCatalog().ranges
    selectedRangeIndex = selectedRangeIndex + 1
    if selectedRangeIndex > #ranges then
        selectedRangeIndex = 1
    end
    PrivateWoWAdminGearSets.Refresh()
end)

local modeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
modeLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -137)
modeLabel:SetText("Staerke")

local balancedButton = CreateButton(frame, "Ausgewogen", 105, 24, 18, -157, function()
    selectedMode = "balanced"
    PrivateWoWAdminGearSets.Refresh()
end)
local strongButton = CreateButton(frame, "Stark", 85, 24, 128, -157, function()
    selectedMode = "strong"
    PrivateWoWAdminGearSets.Refresh()
end)
local heirloomButton = CreateButton(frame, "Erbstuecke", 105, 24, 218, -157, function()
    selectedMode = "heirloom"
    PrivateWoWAdminGearSets.Refresh()
end)

local description = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
description:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -195)
description:SetWidth(530)
description:SetJustifyH("LEFT")

local itemRows = {}
for index = 1, 8 do
    local row = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row:SetPoint("TOPLEFT", frame, "TOPLEFT", 24, -228 - ((index - 1) * 25))
    row:SetWidth(520)
    row:SetJustifyH("LEFT")
    itemRows[index] = row
end

local status = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
status:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18, 55)
status:SetWidth(530)
status:SetJustifyH("LEFT")

local giveButton = CreateButton(frame, "Komplettes Set geben", 180, 28, 18, -412, function()
    local range = GetSelectedRange()
    local set = range.sets[selectedMode]
    queuedItems = {}

    for _, item in ipairs(set.items) do
        if ItemExists(item.id) then
            table.insert(queuedItems, item.id)
        else
            Print("Item-ID " .. item.id .. " fehlt in der lokalen Itemdatenbank und wurde uebersprungen.")
        end
    end

    if #queuedItems == 0 then
        status:SetText("Keine gueltigen Items gefunden. Itemdatenbank bitte neu erzeugen.")
        return
    end

    ClearTarget()
    status:SetText("Set wird gegeben: " .. #queuedItems .. " Gegenstaende...")
end)

CreateButton(frame, "Itemdatenbank", 130, 28, 210, -412, function()
    if _G.PrivateWoWAdminItemFrame then
        _G.PrivateWoWAdminItemFrame:Show()
    end
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

    if #queuedItems == 0 then
        status:SetText("Set wurde ausgegeben. Freie Inventarplaetze und Levelanforderungen beachten.")
        Print("Level-Set wurde ausgegeben.")
    end
end)

function PrivateWoWAdminGearSets.Refresh()
    local catalog = GetSelectedCatalog()
    local range = GetSelectedRange()
    local set = range.sets[selectedMode]
    local level = UnitLevel("player") or 1

    subtitle:SetText(catalog.className .. " - " .. catalog.specName)
    currentLevelText:SetText("Aktuelles Charakterlevel: " .. level)
    specButton:SetText(catalog.specName)
    rangeButton:SetText(range.label)
    description:SetText(set.label .. ": " .. set.description)

    for index = 1, #itemRows do
        local item = set.items[index]
        if item then
            local name = GetLocalizedItemName(item.id, item.fallback)
            local availability = ItemExists(item.id) and "|cff66ff66vorhanden|r" or "|cffff6666fehlt|r"
            itemRows[index]:SetText(item.slot .. ": " .. name .. "  |cffaaaaaa(ID " .. item.id .. ")|r  " .. availability)
        else
            itemRows[index]:SetText("")
        end
    end

    if level < range.minLevel then
        status:SetText("Hinweis: Dieses Set ist erst ab Level " .. range.minLevel .. " vorgesehen.")
    elseif level > range.maxLevel then
        status:SetText("Hinweis: Dieses Set ist fuer Level " .. range.minLevel .. "-" .. range.maxLevel .. " vorgesehen.")
    else
        status:SetText("Hinweis: Das Set wird ins Inventar gelegt, nicht automatisch angezogen.")
    end
end

local function SelectCatalogAndRangeForCurrentLevel()
    local level = UnitLevel("player") or 1

    if level >= 20 then
        selectedCatalogIndex = 2
    else
        selectedCatalogIndex = 1
    end

    local catalog = GetSelectedCatalog()
    selectedRangeIndex = 1
    for index, range in ipairs(catalog.ranges) do
        if level >= range.minLevel and level <= range.maxLevel then
            selectedRangeIndex = index
            break
        end
    end
end

function PrivateWoWAdminGearSets.Toggle()
    if frame:IsShown() then
        frame:Hide()
    else
        SelectCatalogAndRangeForCurrentLevel()
        PrivateWoWAdminGearSets.Refresh()
        frame:Show()
    end
end

local main = _G.PrivateWoWAdminFrame
if main then
    CreateButton(main, "Level-Sets", 100, 28, 18, -240, PrivateWoWAdminGearSets.Toggle)
end

SLASH_PRIVATEWOWADMINGEARSETS1 = "/pwaset"
SlashCmdList["PRIVATEWOWADMINGEARSETS"] = function()
    PrivateWoWAdminGearSets.Toggle()
end
