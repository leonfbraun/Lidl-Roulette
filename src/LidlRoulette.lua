local addonName, addonTable = ...

addonTable.PREFIX = "LIDL_ROULETTE"
addonTable.VERSION = "0.1.0"
addonTable.ProcessedEvents = {}

function addonTable:Initialize()
    if not self.Communication:Initialize() then
        return
    end
    self.Events:RegisterCommunicationEvents()

    self.ChallengeRouletteUi:Initialize()
    self.AnnouncementUi:Initialize()

    math.randomseed(time())

    self:PrintHelp()
end

-- creates a unique event ID based on the player's name, current timestamp, and a random number
function addonTable:CreateEventID()
    local playerName = UnitName("player") or "Unknown"
    local timestamp = time()
    local randomNumber = math.random(100000, 999999)

    return string.format("%s-%d-%d", playerName, timestamp, randomNumber)
end

-- handles local level up
function addonTable:OnLocalLevelUp(level)
    local playerName = UnitName("player")

    if not playerName then
        return
    end

    print("|cff00ff00[Lidl Roulette]|r " .. playerName ..
        " ist jetzt Level " .. tostring(level) .. "!")

    local eventID = self:CreateEventID()
    local challengeID = self.Roulette:Roll()

    self.ProcessedEvents[eventID] = true

    self.ChallengeRouletteUi:ShowChallenge(playerName, level, challengeID, "levelup")
    
    C_Timer.After(3, function() 
        self.Communication:SendLevelUp(playerName, level, challengeID, eventID)
    end)
end

-- handles local death
function addonTable:OnLocalDeath(level)
    local playerName = UnitName("player")

    if not playerName then
        return
    end

    print("|cff00ff00[Lidl Roulette]|r " .. playerName .. "ist mit Level " .. tostring(level) .. " gestorben.")

    local eventID = self:CreateEventID()
    local challengeID = self.Roulette:Roll()

    self.ProcessedEvents[eventID] = true

    self.ChallengeRouletteUi:ShowChallenge(playerName, level, challengeID, "death")
    
    C_Timer.After(3, function() 
        self.Communication:SendDeath(playerName, level, challengeID, eventID)
    end)
    
end

-- draft function for handling remote level up events
function addonTable:OnRemoteLevelUp(playerName, level, challengeID, eventID, sender)
    if self.ProcessedEvents[eventID] then
        return
    end

    self.ProcessedEvents[eventID] = true

    print("|cff00ff00[Lidl Roulette]|r " .. playerName .. " ist Level " .. tostring(level) .. " geworden.")

    self.AnnouncementUi:ShowAnnouncement(playerName, level, challengeID, "levelup")
end

-- draft function for handling remote death events
function addonTable:OnRemoteDeath(playerName, level, challengeID, eventID, sender)
    if self.ProcessedEvents[eventID] then
        return
    end

    self.ProcessedEvents[eventID] = true

    self.AnnouncementUi:ShowAnnouncement(playerName, level, challengeID, "death")
end

-- shows optional help message when the addon is loaded
function addonTable:PrintHelp()
    print("|cff00ff00[Lidl Roulette]|r Addon geladen. Version: " .. self.VERSION)
    print("|cff00ff00[Lidl Roulette]|r Verfügbare Befehle:")
    print("|cff00ff00/lidl test|r - Zeigt eine Test-Challenge an.")
    print("|cff00ff00/lidl testAnnouncement|r - Zeigt eine Test-Meldung an.")
    print("|cff00ff00/lidl challenges|r - Listet alle verfügbaren Challenges auf.")
end

SLASH_LEVELROULETTE1 = "/lidl"

SlashCmdList["LEVELROULETTE"] = function(message)
    message = string.lower(message or "")

    if message == "test" then
        local playerName = UnitName("player") or "Testspieler"
        local level = UnitLevel("player") or 1
        local challengeID = addonTable.Roulette:Roll()

        addonTable.ChallengeRouletteUi:ShowChallenge(playerName, level, challengeID, "levelup")
        return
    end

    if message == "testAnnouncement" then
        local playerName = UnitName("player") or "Testspieler"
        local level = UnitLevel("player") or 1
        local challengeID = addonTable.Roulette:Roll()

        addonTable.AnnouncementUi:ShowAnnouncement(playerName, level, challengeID, "levelup")
        return
    end

    if message == "challenges" then
        for id, challenge in ipairs(addonTable.Challenges) do
            print("|cff00ff00" .. tostring(id) .. ".|r " .. challenge.title)
        end
        return
    end

    addonTable:PrintHelp()
end