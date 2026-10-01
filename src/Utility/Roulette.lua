local addonName, addonTable = ...

addonTable.Roulette = {}
local Roulette = addonTable.Roulette

function Roulette:GetChallengeCount()
    return #addonTable.Challenges
end

function Roulette:Roll()
    local count = self:GetChallengeCount()

    if count == 0 then
        print("|cffff0000[Lidll Roulette]|r Es sind keine Challenges vorhanden.")
        return nil
    end

    return math.random(1, count)
end

function Roulette:GetChallenge(id)
    if not id then
        return nil
    end

    return addonTable.Challenges[id]
end
