-- AzerothCore exposes God mode as `.cheat god`, not `.gm god`.
-- Keep this compatibility layer small and explicit so existing button callbacks
-- continue to work without duplicating the main window implementation.

local originalSendChatMessage = SendChatMessage

function SendChatMessage(message, chatType, language, channel)
    if type(message) == "string" then
        if message == ".gm god on" then
            message = ".cheat god on"
        elseif message == ".gm god off" then
            message = ".cheat god off"
        end
    end

    return originalSendChatMessage(message, chatType, language, channel)
end
