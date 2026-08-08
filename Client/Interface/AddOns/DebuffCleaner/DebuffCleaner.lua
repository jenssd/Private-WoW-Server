local addonName = ...

local MAX_DEBUFFS = 16
local ROW_HEIGHT = 28
local PREFIX = "|cffffd200DebuffCleaner|r"

DebuffCleanerDB = DebuffCleanerDB or {}

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. ": " .. message)
end

local frame = CreateFrame("Frame", "DebuffCleanerFrame", UIParent)
frame:SetWidth(300)
frame:SetHeight(54 + (MAX_DEBUFFS * ROW_HEIGHT))
frame:SetPoint("CENTER", UIParent, "CENTER", 360, 40)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", function(self)
    if not InCombatLockdown() then
        self:StartMoving()
    end
end)
frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, relativePoint, x, y = self:GetPoint(1)
    DebuffCleanerDB.point = point
    DebuffCleanerDB.relativePoint = relativePoint
    DebuffCleanerDB.x = x
    DebuffCleanerDB.y = y
end)

frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 24,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -14)
title:SetText("Debuff Cleaner")

local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("TOPRIGHT", -16, -18)
subtitle:SetText("Klick = .unaura")

local rows = {}

local function FormatRemaining(duration, expirationTime)
    if not duration or duration <= 0 or not expirationTime or expirationTime <= 0 then
        return ""
    end

    local remaining = expirationTime - GetTime()
    if remaining < 0 then
        remaining = 0
    end

    if remaining >= 60 then
        return string.format("%.1fm", remaining / 60)
    end

    return string.format("%.0fs", remaining)
end

for i = 1, MAX_DEBUFFS do
    local button = CreateFrame("Button", "DebuffCleanerRow" .. i, frame, "SecureActionButtonTemplate")
    button:SetHeight(ROW_HEIGHT - 2)
    button:SetPoint("TOPLEFT", 14, -42 - ((i - 1) * ROW_HEIGHT))
    button:SetPoint("TOPRIGHT", -14, -42 - ((i - 1) * ROW_HEIGHT))
    button:RegisterForClicks("AnyUp")

    -- The secure macro is static and therefore combat-safe. Each row always
    -- represents one UnitDebuff slot. On click it briefly targets the player,
    -- resolves the CURRENT spell id in that slot, sends .unaura <spellId>, and
    -- restores the previous target. No secure attribute is changed in combat.
    button:SetAttribute("type", "macro")
    button:SetAttribute("macrotext", string.format(
        "/target [@player]\n/run local _,_,_,_,_,_,_,_,_,_,id=UnitDebuff(\"player\",%d); if id then SendChatMessage(\".unaura \"..id,\"SAY\") end\n/targetlasttarget",
        i
    ))

    button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetWidth(24)
    icon:SetHeight(24)
    icon:SetPoint("LEFT", 2, 0)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    button.icon = icon

    local nameText = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    nameText:SetPoint("LEFT", icon, "RIGHT", 8, 0)
    nameText:SetJustifyH("LEFT")
    nameText:SetWidth(185)
    button.nameText = nameText

    local timeText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    timeText:SetPoint("RIGHT", -4, 0)
    timeText:SetJustifyH("RIGHT")
    timeText:SetWidth(58)
    button.timeText = timeText

    button:SetScript("OnEnter", function(self)
        if not self.spellId then
            return
        end
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetUnitDebuff("player", self.index)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Spell-ID: " .. tostring(self.spellId), 1, 0.82, 0)
        GameTooltip:AddLine("Klicken: diesen Debuff mit .unaura entfernen", 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    button.index = i
    rows[i] = button
end

local function UpdateDebuffs()
    for i = 1, MAX_DEBUFFS do
        local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff("player", i)
        local row = rows[i]

        if name then
            row.spellId = spellId
            row.icon:SetTexture(icon)
            row.icon:SetAlpha(1)
            row.nameText:SetText(name .. (count and count > 1 and (" x" .. count) or ""))
            row.nameText:SetTextColor(1, 1, 1)
            row.timeText:SetText(FormatRemaining(duration, expirationTime))
        else
            -- Keep the secure button itself visible at all times. Hiding or
            -- showing protected buttons from insecure code during combat is
            -- restricted by the WoW client. Empty rows simply become inert.
            row.spellId = nil
            row.icon:SetTexture(nil)
            row.nameText:SetText(i == 1 and "Keine aktiven Debuffs" or "")
            row.nameText:SetTextColor(0.45, 0.45, 0.45)
            row.timeText:SetText("")
        end
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("UNIT_AURA")
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
eventFrame:SetScript("OnEvent", function(self, event, unit)
    if event == "PLAYER_LOGIN" then
        if DebuffCleanerDB.point then
            frame:ClearAllPoints()
            frame:SetPoint(
                DebuffCleanerDB.point,
                UIParent,
                DebuffCleanerDB.relativePoint or DebuffCleanerDB.point,
                DebuffCleanerDB.x or 0,
                DebuffCleanerDB.y or 0
            )
        end

        if DebuffCleanerDB.hidden then
            frame:Hide()
        end

        UpdateDebuffs()
        Print("geladen. Aktive Debuffs werden automatisch angezeigt.")
        return
    end

    if event == "UNIT_AURA" and unit ~= "player" then
        return
    end

    UpdateDebuffs()
end)

-- Refresh durations and row text only. Secure attributes remain untouched.
local elapsed = 0
frame:SetScript("OnUpdate", function(self, delta)
    elapsed = elapsed + delta
    if elapsed >= 0.25 then
        elapsed = 0
        UpdateDebuffs()
    end
end)

SLASH_DEBUFFCLEANER1 = "/debuffcleaner"
SLASH_DEBUFFCLEANER2 = "/dc"
SlashCmdList["DEBUFFCLEANER"] = function(message)
    message = string.lower((message or ""):match("^%s*(.-)%s*$"))

    if InCombatLockdown() and (message == "hide" or message == "show" or message == "" or message == "reset") then
        Print("Fensterposition/-sichtbarkeit bitte ausserhalb des Kampfes aendern.")
        return
    end

    if message == "hide" then
        frame:Hide()
        DebuffCleanerDB.hidden = true
        Print("Fenster ausgeblendet. /dc show zum Einblenden.")
    elseif message == "show" or message == "" then
        frame:Show()
        DebuffCleanerDB.hidden = false
        UpdateDebuffs()
    elseif message == "reset" then
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "CENTER", 360, 40)
        DebuffCleanerDB.point = nil
        DebuffCleanerDB.relativePoint = nil
        DebuffCleanerDB.x = nil
        DebuffCleanerDB.y = nil
        frame:Show()
        DebuffCleanerDB.hidden = false
        Print("Position zurueckgesetzt.")
    else
        Print("Befehle: /dc, /dc show, /dc hide, /dc reset")
    end
end
