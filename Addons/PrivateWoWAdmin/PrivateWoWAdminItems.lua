PrivateWoWAdminItems = PrivateWoWAdminItems or {}
PrivateWoWAdminItems.data = PrivateWoWAdminItems.data or {}

function PrivateWoWAdminItems.AddItem(itemId, count)
    itemId = tonumber(itemId)
    count = tonumber(count) or 1
    if not itemId then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99PrivateWoWAdmin:|r Ungueltige Item-ID.")
        return
    end
    count = math.max(1, math.floor(count))
    SendChatMessage(".additem " .. itemId .. " " .. count, "SAY")
end

function PrivateWoWAdminItems.SearchLocal(searchText)
    local results = {}
    local needle = string.lower(searchText or "")
    if needle == "" then
        return results
    end
    for itemId, itemName in pairs(PrivateWoWAdminItems.data) do
        if string.find(string.lower(itemName), needle, 1, true) then
            table.insert(results, { id = itemId, name = itemName })
            if #results >= 50 then
                break
            end
        end
    end
    table.sort(results, function(a, b) return a.name < b.name end)
    return results
end
