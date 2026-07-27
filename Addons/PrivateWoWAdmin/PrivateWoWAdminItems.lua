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

local function Normalize(value)
    return string.lower(value or "")
end

function PrivateWoWAdminItems.SearchLocal(searchText)
    local results = {}
    local needle = Normalize(searchText)
    if needle == "" then
        return results
    end

    for itemId, item in pairs(PrivateWoWAdminItems.data) do
        local nameEn
        local nameDe

        if type(item) == "table" then
            nameEn = item.en or ""
            nameDe = item.de or nameEn
        else
            -- Rueckwaertskompatibilitaet mit alten einsprachigen Exporten.
            nameEn = tostring(item or "")
            nameDe = nameEn
        end

        if string.find(Normalize(nameEn), needle, 1, true)
            or string.find(Normalize(nameDe), needle, 1, true)
            or tostring(itemId) == needle then
            table.insert(results, {
                id = itemId,
                en = nameEn,
                de = nameDe,
                name = nameDe ~= "" and nameDe or nameEn
            })

            if #results >= 50 then
                break
            end
        end
    end

    table.sort(results, function(a, b)
        local aName = Normalize(a.de ~= "" and a.de or a.en)
        local bName = Normalize(b.de ~= "" and b.de or b.en)
        if aName == bName then
            return a.id < b.id
        end
        return aName < bName
    end)

    return results
end

function PrivateWoWAdminItems.GetDisplayName(itemId)
    local item = PrivateWoWAdminItems.data[tonumber(itemId)]
    if not item then
        return nil
    end

    if type(item) ~= "table" then
        return tostring(item), tostring(item)
    end

    local nameEn = item.en or ""
    local nameDe = item.de or nameEn
    return nameDe, nameEn
end
