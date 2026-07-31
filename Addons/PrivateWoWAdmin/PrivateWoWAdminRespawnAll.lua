-- Change the existing GM-page respawn button to respawn all nearby creatures
-- and pending spawn groups on the current map.

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PrivateWoWAdmin:|r " .. tostring(message))
end

local function FindButtonByText(parent, expectedText)
    if not parent or not parent.GetChildren then
        return nil
    end

    local children = { parent:GetChildren() }
    for _, child in ipairs(children) do
        if child and child.GetText and child:GetText() == expectedText then
            return child
        end

        local nested = FindButtonByText(child, expectedText)
        if nested then
            return nested
        end
    end

    return nil
end

local function ConfigureRespawnAllButton()
    local main = _G.PrivateWoWAdminFrame
    if not main then
        return
    end

    local button = FindButtonByText(main, "Respawn")
    if not button then
        return
    end

    button:SetText("Respawn alle")
    button:SetScript("OnClick", function()
        SendChatMessage(".respawn all", "SAY")
        Print("Ausgefuehrt: .respawn all")
    end)
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self)
    ConfigureRespawnAllButton()
    self:UnregisterEvent("PLAYER_LOGIN")
end)
