local addonName, addonTable = ...

addonTable.AnnouncementUi = {}

local AnnouncementUI = addonTable.AnnouncementUi

local announcementFrame
local playerLevelText
local challengeTitleText
local challengeDescriptionText

function AnnouncementUI.Initialize()
    announcementFrame = CreateFrame("Frame", nil, UIParent)

    announcementFrame:SetSize(900, 150)
    announcementFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)

    playerLevelText = announcementFrame:CreateFontString(nil, "OVERLAY")
    playerLevelText:SetFont("Fonts\\FRIZQT__.TTF", 32, "OUTLINE")
    playerLevelText:SetPoint("TOP", announcementFrame, "TOP", 0, 0)
    playerLevelText:SetWidth(900)
    playerLevelText:SetJustifyH("CENTER")

    challengeTitleText = announcementFrame:CreateFontString(nil, "OVERLAY")
    challengeTitleText:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE")
    challengeTitleText:SetPoint("TOP", playerLevelText, "BOTTOM", 0, -8)
    challengeTitleText:SetWidth(900)
    challengeTitleText:SetJustifyH("CENTER")

    challengeDescriptionText = announcementFrame:CreateFontString(nil, "OVERLAY")
    challengeDescriptionText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    challengeDescriptionText:SetPoint("TOP", challengeTitleText, "BOTTOM", 0, -8)
    challengeDescriptionText:SetWidth(900)
    challengeDescriptionText:SetJustifyH("CENTER")
    challengeDescriptionText:SetWordWrap(true)

    announcementFrame:Hide()
end

function AnnouncementUI:ShowAnnouncement(playerName, level, challengeID, reason)
    local challenge = addonTable.Roulette:GetChallenge(challengeID)
    if not challenge then
        return
    end

    if(reason == "death") then
        playerLevelText:SetText("Oh nein! " .. playerName .. " ist mit Level " .. tostring(level) .. " gestorben.")
    else
        playerLevelText:SetText("Ding, Level Up! " .. playerName .. " ist jetzt Level " .. tostring(level))
    end

    challengeTitleText:SetText("Seine Challenge lautet: " .. challenge.title)
    challengeDescriptionText:SetText(challenge.description)
    announcementFrame:Show()

    C_Timer.After(5, function()
        announcementFrame:Hide()
    end)
end