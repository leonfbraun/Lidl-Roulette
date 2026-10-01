local addonName, addonTable = ...

addonTable.PREFIX = "LIDL_ROULETTE"
addonTable.VERSION = "0.1.0"
addonTable.ProcessedEvents = {}

function addonTable:Initialize()
    if not self.Communication:Initialize() then
        return
    end

    self.Events:RegisterCommunicationEvents()
end