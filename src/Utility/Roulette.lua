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

function Roulette:GetRarityColor(rarity)
    local colors = {
        common = { 1, 1, 1 },
        uncommon = { 0.12, 1, 0 },
        rare = { 0, 0.44, 0.87 },
        epic = { 0.64, 0.21, 0.93 },
        legendary = { 1, 0.5, 0 },
    }

    return colors[rarity] or { 1, 1, 1 } 
end