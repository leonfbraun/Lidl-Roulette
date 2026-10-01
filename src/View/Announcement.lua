local addonName, addonTable = ...

addonTable.AnnouncementUi = {}

local AnnouncementUI = addonTable.AnnouncementUi

local announcementFrame


function AnnouncementUI.Initialize()
    announcementFrame = CreateFrame("Frame", nil, UIParent)

    announcementFrame:SetSize(900, 150)
    announcementFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)

    announcementFrame.text = announcementFrame:CreateFontString(nil, "OVERLAY")
    announcementFrame.text:SetFont("Fonts\\FRIZQT__.TTF", 32, "OUTLINE")
    announcementFrame.text:SetPoint("CENTER")
    announcementFrame.text:SetJustifyH("CENTER")

    announcementFrame:Hide()
end

function AnnouncementUI.AnnouceChallenge(text)


    announcementFrame.text:SetText(text)
    announcementFrame:Show()

    C_Timer.After(5, function()
        announcementFrame:Hide()
    end)
end