local addonName, addonTable = ...

addonTable.Events = {}

local Events = addonTable.Events

--Init Events
local frame = CreateFrame("Frame")

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("PLAYER_DEAD")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        addonTable:Initialize()
    elseif event == "PLAYER_LEVEL_UP" then
        local level = ...
        addonTable:OnLocalLevelUp(level)
    elseif event == "PLAYER_DEAD" then
        addonTable:OnLocalDeath()
    elseif event == "CHAT_MSG_ADDON" then
        addonTable.Communication:OnMessage(...)
    end
end)

function Events.RegisterCommunicationEvents()
    frame:RegisterEvent("CHAT_MSG_ADDON")
end

