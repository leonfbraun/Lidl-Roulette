local addonName, addonTable = ...

addonTable.AnnouncementUi = {}

local AnnouncementUI = addonTable.AnnouncementUi

local announcementFrame
local playerAnnouncementText
local challengeTitleText
local challengeDescriptionText

function AnnouncementUI:Initialize()
    announcementFrame = CreateFrame("Frame", nil, UIParent)
    announcementFrame:SetSize(900, 150)
    announcementFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)

    playerAnnouncementText = announcementFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    playerAnnouncementText:SetFont("Fonts\\FRIZQT__.TTF", 26, "OUTLINE")
    playerAnnouncementText:SetPoint("TOP", announcementFrame, "TOP", 0, -10)
    playerAnnouncementText:SetWidth(880)
    playerAnnouncementText:SetJustifyH("CENTER")

    challengeTitleText = announcementFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    challengeTitleText:SetFont("Fonts\\FRIZQT__.TTF", 22, "OUTLINE")
    challengeTitleText:SetPoint("TOP", playerAnnouncementText, "BOTTOM", 0, -8)
    challengeTitleText:SetWidth(880)
    challengeTitleText:SetJustifyH("CENTER")

    challengeDescriptionText = announcementFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    challengeDescriptionText:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
    challengeDescriptionText:SetPoint("TOP", challengeTitleText, "BOTTOM", 0, -8)
    challengeDescriptionText:SetWidth(880)
    challengeDescriptionText:SetJustifyH("CENTER")
    challengeDescriptionText:SetWordWrap(true)

    announcementFrame:Hide()
end

function AnnouncementUI:ShowAnnouncement(playerName, level, challengeID, reason)
    local challenge = addonTable.Roulette:GetChallenge(challengeID)
    if not challenge then
        return
    end
    
    local announcementMessage
    if reason == "death" then
        announcementMessage = playerName .. " ist mit Level " .. tostring(level) .. " gestorben."
    elseif reason == "levelup" then
        announcementMessage = "Ding, Level Up! " .. playerName .. " ist jetzt Level " .. tostring(level)
    else
        return
    end
    
    playerAnnouncementText:SetText(announcementMessage)
    challengeTitleText:SetText("Challenge: " .. challenge.title)
    challengeDescriptionText:SetText(challenge.description)
    announcementFrame:Show()
    PlaySound(8959)

    C_Timer.After(7, function()
        announcementFrame:Hide()
    end)
end