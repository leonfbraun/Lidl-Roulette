local addonName, addonTable = ...

addonTable.Communication = {}

local Communictaion = addonTable.Communication

function Communictaion:Initialize()
  	local success = C_ChatInfo.RegisterAddonMessagePrefix(addonTable.PREFIX)

    if not success then
        print("|cffff0000[Lidl Roulette]|r Konnte Kommunikations-Prefix nicht registrieren.")
        return
   end
end