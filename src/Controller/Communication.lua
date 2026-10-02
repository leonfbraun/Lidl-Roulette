local addonName, addonTable = ...

addonTable.Communication = {}

local Communication = addonTable.Communication

function Communication:Initialize()
    local success = C_ChatInfo.RegisterAddonMessagePrefix(addonTable.PREFIX)

    if not success then
        print("|cffff0000[Lidl Roulette]|r Konnte Kommunikations-Prefix nicht registrieren.")
        return false
    end

    return true
end

function Communication:SendLevelUp(playerName, level, challengeID, eventID)
    local message = string.format(
        "LEVELUP|%s|%d|%d|%s",
        playerName,
        level,
        challengeID,
        eventID
    )

    local partyMessageSuccess, partyMessageErrorMessage = C_ChatInfo.SendAddonMessage(
        addonTable.PREFIX,
        message,
        "PARTY"
    )

    local guildMessageSuccess, guildMessageErrorMessage = C_ChatInfo.SendAddonMessage(
        addonTable.PREFIX,
        message,
        "GUILD"
    )

    if partyMessageSuccess == false and guildMessageSuccess == false then
        print("|cffff0000[Lidl Roulette]|r Nachricht konnte nicht gesendet werden.")

        if partyMessageErrorMessage then
            print("|cffff0000Fehler:|r " .. tostring(partyMessageErrorMessage))
        end

        if guildMessageErrorMessage then
            print("|cffff0000Fehler:|r " .. tostring(guildMessageErrorMessage))
        end
    end
end

function Communication:SendDeath(playerName, level, challengeID, eventID)
    local message = string.format(
        "DEATH|%s|%d|%d|%s",
        playerName,
        level,
        challengeID,
        eventID
    )

    local partyMessageSuccess, partyMessageErrorMessage = C_ChatInfo.SendAddonMessage(
        addonTable.PREFIX,
        message,
        "PARTY"
    )

    local guildMessageSuccess, guildMessageErrorMessage = C_ChatInfo.SendAddonMessage(
        addonTable.PREFIX,
        message,
        "GUILD"
    )

    if partyMessageSuccess == false and guildMessageSuccess == false then
        print("|cffff0000[Lidl Roulette]|r Nachricht konnte nicht gesendet werden.")

        if partyMessageErrorMessage then
            print("|cffff0000Fehler:|r " .. tostring(partyMessageErrorMessage))
        end

        if guildMessageErrorMessage then
            print("|cffff0000Fehler:|r " .. tostring(guildMessageErrorMessage))
        end
    end
end


function Communication:OnMessageReceived(prefix, message, channel, sender)
    if prefix ~= addonTable.PREFIX or not message then
        return
    end

    local command, playerName, level, challengeID, eventID =
        strsplit("|", message)

    if command ~= "LEVELUP" and command ~= "DEATH" then
        return
    end

    local playerLevel = tonumber(level)
    local playerChallengeID = tonumber(challengeID)

    if not playerName or not playerLevel or not playerChallengeID or not eventID then
        print("|cffff0000[Lidl Roulette]|r Ungültige Nachricht von " .. tostring(sender))
        return
    end

    addonTable:OnRemoteLevelUp(playerName, playerLevel, playerChallengeID, eventID, sender)
end