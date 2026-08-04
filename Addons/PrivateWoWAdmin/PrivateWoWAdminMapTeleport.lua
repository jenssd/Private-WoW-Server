PrivateWoWAdminMapTeleport = PrivateWoWAdminMapTeleport or {}

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PrivateWoWAdmin:|r " .. tostring(message))
end

local function SendTeleport(name)
    if not name or name == "" then
        return
    end

    SendChatMessage(".tele " .. name, "SAY")
    Print("Naechstes Teleportziel: " .. name)
end

local function GetMapClickPosition(button)
    local cursorX, cursorY = GetCursorPosition()
    local scale = button:GetEffectiveScale()
    cursorX = cursorX / scale
    cursorY = cursorY / scale

    local left = button:GetLeft()
    local top = button:GetTop()
    local width = button:GetWidth()
    local height = button:GetHeight()

    if not left or not top or not width or not height or width <= 0 or height <= 0 then
        return nil
    end

    local mapX = (cursorX - left) / width
    local mapY = (top - cursorY) / height
    if mapX < 0 or mapX > 1 or mapY < 0 or mapY > 1 then
        return nil
    end

    return mapX, mapY
end

local function FindNearestTeleport(area, mapX, mapY)
    local data = PrivateWoWAdminMapTeleports
    if not data or not data.pointsByMap then
        return nil
    end

    local points = data.pointsByMap[area.map]
    if not points or #points == 0 then
        return nil
    end

    local worldX = area.top + mapY * (area.bottom - area.top)
    local worldY = area.left + mapX * (area.right - area.left)

    local nearest = nil
    local nearestDistance = nil
    for _, point in ipairs(points) do
        local dx = point.x - worldX
        local dy = point.y - worldY
        local distance = dx * dx + dy * dy
        if not nearestDistance or distance < nearestDistance then
            nearest = point
            nearestDistance = distance
        end
    end

    return nearest, worldX, worldY
end

local function HandleMapClick(button, mouseButton)
    if mouseButton ~= "LeftButton" or not IsControlKeyDown() then
        return
    end

    local areaId = GetCurrentMapAreaID and GetCurrentMapAreaID()
    local data = PrivateWoWAdminMapTeleports
    local area = data and data.areas and areaId and data.areas[areaId]
    if not area then
        Print("Fuer diese Kartenansicht sind keine eindeutigen Gebietsdaten vorhanden. Bitte in ein Gebiet hineinzoomen.")
        return
    end

    local mapX, mapY = GetMapClickPosition(button)
    if not mapX then
        return
    end

    local nearest = FindNearestTeleport(area, mapX, mapY)
    if not nearest then
        Print("Auf dieser Weltkarte wurden keine bekannten Teleportziele gefunden.")
        return
    end

    SendTeleport(nearest.name)
end

local hooked = false
local function HookWorldMap()
    if hooked or not WorldMapButton then
        return
    end

    WorldMapButton:HookScript("OnMouseUp", HandleMapClick)
    hooked = true
    Print("Karten-Teleport aktiv: Strg + Linksklick teleportiert zum naechsten bekannten Ziel.")
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", HookWorldMap)

SLASH_PRIVATEWOWADMINMAPTELEPORT1 = "/pwamaptele"
SlashCmdList["PRIVATEWOWADMINMAPTELEPORT"] = function()
    local areaCount = 0
    local pointCount = 0
    local data = PrivateWoWAdminMapTeleports

    if data and data.areas then
        for _ in pairs(data.areas) do
            areaCount = areaCount + 1
        end
    end

    if data and data.pointsByMap then
        for _, points in pairs(data.pointsByMap) do
            pointCount = pointCount + #points
        end
    end

    Print("Karten-Teleport: " .. areaCount .. " Gebiete, " .. pointCount .. " Ziele geladen.")
    Print("Nutzung: Weltkarte mit M oeffnen, in ein Gebiet zoomen und Strg + Linksklick verwenden.")
end
