local addonName = ...

local PREFIX = "|cffffd200RaidGearSets|r"
local SEND_INTERVAL = 0.20

local sets = {
    gear60ele = {
        name = "Schamane 60 Elementar",
        commands = {
            -- Gear
            ".additem 19375", ".additem 21608", ".additem 23664", ".additem 23050",
            ".additem 21838", ".additem 21186", ".additem 21585", ".additem 22730",
            ".additem 23070", ".additem 21600", ".additem 21709", ".additem 23031",
            ".additem 19379", ".additem 23046", ".additem 22988", ".additem 23049",
            ".additem 23199",
            -- Glyphs: Lightning Bolt, Totem of Wrath; Water Shield, Renewed Life
            ".additem 41536", ".additem 45776", ".additem 43386", ".additem 43385",
            -- Enchant scrolls: cloak haste, chest stats, bracer SP, glove hit, boots hit/crit, weapon SP
            ".additem 39003", ".additem 44465", ".additem 44470", ".additem 38953",
            ".additem 38986", ".additem 44467"
        }
    },
    gear60enh = {
        name = "Schamane 60 Verstaerker",
        commands = {
            -- Gear and gems
            ".additem 22478", ".additem 19377", ".additem 21665", ".additem 21710",
            ".additem 21680", ".additem 22483", ".additem 18823", ".additem 24063",
            ".additem 24022", ".additem 21612", ".additem 19432", ".additem 22961",
            ".additem 22954", ".additem 23041", ".additem 23221", ".additem 22808",
            ".additem 40118 2", ".additem 40125 3",
            -- Glyphs: Stormstrike, Feral Spirit; Water Shield, Renewed Life
            ".additem 41539", ".additem 45771", ".additem 43386", ".additem 43385",
            -- Enchant scrolls: cloak haste, chest stats, bracer expertise, glove hit, boots hit/crit, Berserking x2
            ".additem 39003", ".additem 44465", ".additem 38984", ".additem 38953",
            ".additem 38986", ".additem 44493 2"
        }
    },
    gear70ele = {
        name = "Schamane 70 Elementar",
        commands = {
            -- Gear and gems
            ".additem 34332", ".additem 34204", ".additem 31023", ".additem 34242",
            ".additem 34364", ".additem 34437", ".additem 34344", ".additem 34542",
            ".additem 34186", ".additem 34566", ".additem 34362", ".additem 34230",
            ".additem 32483", ".additem 34429", ".additem 34336", ".additem 34179",
            ".additem 32330", ".additem 40125 4",
            -- Glyphs: Lightning Bolt, Lava; Water Shield, Renewed Life, Water Walking
            ".additem 41536", ".additem 41524", ".additem 43386", ".additem 43385", ".additem 43388",
            -- Enchant scrolls: cloak haste, chest stats, bracer SP, gloves SP, movement boots, weapon SP
            ".additem 39003", ".additem 44465", ".additem 44470", ".additem 38979",
            ".additem 39006", ".additem 44467"
        }
    },
    gear70enh = {
        name = "Schamane 70 Verstaerker",
        commands = {
            -- Gear and gems
            ".additem 34244", ".additem 34358", ".additem 34392", ".additem 34241",
            ".additem 34397", ".additem 34439", ".additem 34343", ".additem 34545",
            ".additem 34188", ".additem 34567", ".additem 34189", ".additem 32497",
            ".additem 34427", ".additem 34472", ".additem 34331", ".additem 34346",
            ".additem 40125 6",
            -- Glyphs: Stormstrike, Feral Spirit; Water Shield, Renewed Life, Water Walking
            ".additem 41539", ".additem 45771", ".additem 43386", ".additem 43385", ".additem 43388",
            -- Enchant scrolls: cloak haste, chest stats, bracer AP, gloves AP, movement boots, Berserking x2
            ".additem 39003", ".additem 44465", ".additem 44815", ".additem 44458",
            ".additem 39006", ".additem 44493 2"
        }
    },
    gear80ele = {
        name = "Schamane 80 Elementar",
        commands = {
            -- Gear and gems
            ".additem 51237", ".additem 50658", ".additem 50698", ".additem 54583",
            ".additem 51239", ".additem 54582", ".additem 51238", ".additem 54587",
            ".additem 51236", ".additem 50699", ".additem 50664", ".additem 50398",
            ".additem 50348", ".additem 50365", ".additem 50734", ".additem 50616",
            ".additem 50458", ".additem 40125 3",
            -- Glyphs: Lightning Bolt, Lava, Totem of Wrath; Water Shield, Renewed Life, Water Walking
            ".additem 41536", ".additem 41524", ".additem 45776",
            ".additem 43386", ".additem 43385", ".additem 43388",
            -- Enchant scrolls: cloak haste, chest stats, bracer SP, gloves SP, boots hit/crit, weapon SP, shield Int
            ".additem 39003", ".additem 44465", ".additem 44470", ".additem 38979",
            ".additem 38986", ".additem 44467", ".additem 44455"
        }
    },
    gear80enh = {
        name = "Schamane 80 Verstaerker",
        commands = {
            -- Gear and gems
            ".additem 51242", ".additem 50633", ".additem 51240", ".additem 54583",
            ".additem 50656", ".additem 54580", ".additem 51243", ".additem 54587",
            ".additem 51241", ".additem 50711", ".additem 50604", ".additem 50402",
            ".additem 54588", ".additem 50365", ".additem 50734", ".additem 50737",
            ".additem 50458", ".additem 40118", ".additem 40148",
            -- Spellhance glyphs: Stormstrike, Fire Nova, Flametongue Weapon; Water Shield, Renewed Life, Water Walking
            ".additem 41539", ".additem 41530", ".additem 41532",
            ".additem 43386", ".additem 43385", ".additem 43388",
            -- Enchant scrolls: cloak haste, chest stats, bracer expertise, gloves AP, movement boots, Berserking x2
            ".additem 39003", ".additem 44465", ".additem 38984", ".additem 44458",
            ".additem 39006", ".additem 44493 2"
        }
    }
}

local queue = {}
local queueIndex = 1
local elapsed = 0
local runningName = nil

local frame = CreateFrame("Frame")

local function Print(message)
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. ": " .. message)
end

local function StopQueue(silent)
    queue = {}
    queueIndex = 1
    elapsed = 0
    runningName = nil
    frame:SetScript("OnUpdate", nil)
    if not silent then
        Print("Ausgabe abgebrochen.")
    end
end

local function StartSet(key)
    local set = sets[key]
    if not set then
        Print("Unbekanntes Set: " .. tostring(key))
        return
    end

    if runningName then
        Print("Es laeuft bereits '" .. runningName .. "'. Mit /raidgear stop abbrechen.")
        return
    end

    queue = {}
    for i, command in ipairs(set.commands) do
        queue[i] = command
    end

    queueIndex = 1
    elapsed = 0
    runningName = set.name

    Print("Starte " .. set.name .. " (" .. #queue .. " GM-Befehle inkl. Gear/Gems/Glyphen/Verzauberungsrollen).")

    frame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed < SEND_INTERVAL then
            return
        end
        elapsed = 0

        local command = queue[queueIndex]
        if not command then
            local completed = runningName
            StopQueue(true)
            Print(completed .. " abgeschlossen. Glyphen und Verzauberungsrollen liegen im Inventar und muessen manuell angewendet werden.")
            return
        end

        SendChatMessage(command, "SAY")
        queueIndex = queueIndex + 1
    end)
end

local function ShowHelp()
    Print("Verfuegbare Befehle (Gear + Gems + Glyphen + Verzauberungsrollen):")
    Print("/gear60ele - Schamane Level 60 Elementar")
    Print("/gear60enh - Schamane Level 60 Verstaerker")
    Print("/gear70ele - Schamane Level 70 Elementar")
    Print("/gear70enh - Schamane Level 70 Verstaerker")
    Print("/gear80ele - Schamane Level 80 Elementar")
    Print("/gear80enh - Schamane Level 80 Verstaerker")
    Print("/raidgear stop - laufende Ausgabe abbrechen")
    Print("/raidgear help - diese Hilfe anzeigen")
end

local aliases = {
    gear60ele = "gear60ele",
    gear60enh = "gear60enh",
    gear70ele = "gear70ele",
    gear70enh = "gear70enh",
    gear80ele = "gear80ele",
    gear80enh = "gear80enh"
}

for slash, key in pairs(aliases) do
    local globalName = "RAIDGEARSETS_" .. string.upper(slash)
    _G["SLASH_" .. globalName .. "1"] = "/" .. slash
    SlashCmdList[globalName] = function()
        StartSet(key)
    end
end

SLASH_RAIDGEARSETS_MAIN1 = "/raidgear"
SlashCmdList["RAIDGEARSETS_MAIN"] = function(message)
    message = string.lower((message or ""):match("^%s*(.-)%s*$"))
    if message == "stop" then
        StopQueue(false)
    elseif message == "" or message == "help" then
        ShowHelp()
    elseif sets[message] then
        StartSet(message)
    else
        Print("Unbekannter Befehl. /raidgear help zeigt die Hilfe.")
    end
end

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    Print("geladen. /raidgear help zeigt die Gear-Sets.")
end)
