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

    local success, errorMessage = C_ChatInfo.SendAddonMessage(
        addonTable.PREFIX,
        message,
        "PARTY"
    )

    if success == false then
        print("|cffff0000[Lidl Roulette]|r Nachricht konnte nicht gesendet werden.")

        if errorMessage then
            print("|cffff0000Fehler:|r " .. tostring(errorMessage))
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

    local success, errorMessage = C_ChatInfo.SendAddonMessage(
        addonTable.PREFIX,
        message,
        "PARTY"
    )

    if success == false then
        print("|cffff0000[Lidl Roulette]|r Nachricht konnte nicht gesendet werden.")

        if errorMessage then
            print("|cffff0000Fehler:|r " .. tostring(errorMessage))
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

    addonTable.OnRemoteLevelUp(playerName, playerLevel, playerChallengeID, eventID, sender)
end