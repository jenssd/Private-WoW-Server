-- AzerothCore exposes God mode as `.cheat god`, not `.gm god`.
-- Existing button callbacks still use the old command, so normalize it centrally.

local function NormalizeCommand(message)
    if type(message) ~= "string" then
        return message
    end

    if message == ".gm god on" then
        return ".cheat god on"
    elseif message == ".gm god off" then
        return ".cheat god off"
    end

    return message
end

local originalSendChatMessage = SendChatMessage

function SendChatMessage(message, chatType, language, channel)
    return originalSendChatMessage(
        NormalizeCommand(message),
        chatType,
        language,
        channel
    )
end

-- PrivateWoWAdmin.lua logs the original callback text after sending it. Rewrite
-- only these two addon status messages so the chat reflects the command that was
-- actually sent to AzerothCore.
local originalAddMessage = DEFAULT_CHAT_FRAME.AddMessage

function DEFAULT_CHAT_FRAME:AddMessage(message, red, green, blue, messageId, holdTime)
    if type(message) == "string" and string.find(message, "PrivateWoWAdmin:", 1, true) then
        message = string.gsub(message, "%.gm god on", ".cheat god on")
        message = string.gsub(message, "%.gm god off", ".cheat god off")
    end

    return originalAddMessage(self, message, red, green, blue, messageId, holdTime)
end
