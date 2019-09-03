local DMW = DMW
DMW.Rotations.HUNTER = {}
local Hunter = DMW.Rotations.HUNTER
local UI = DMW.UI

function Hunter.Settings()
    -- UI.HUD.Options = {
    --     [1] = {
    --         Test = {
    --             [1] = {Text = "HUD Test |cFF00FF00On", Tooltip = ""},
    --             [2] = {Text = "HUD Test |cFFFFFF00Sort Of On", Tooltip = ""},
    --             [3] = {Text = "HUD Test |cffff0000Disabled", Tooltip = ""}
    --         }
    --     }
    -- }
 --   UI.AddHeader("General")


 --   UI.AddHeader("DPS")


 --   UI.AddHeader("Defensive")

--    UI.AddHeader("Utility")
	UI.AddHeader("Pet Stuff")
	UI.AddToggle("Auto Pet Attack", "Auto cast pet attack on target", true)
	UI.AddToggle("Call Pet", "Call active pet ", true)
	--UI.AddToggle("Revive Pet", "Call active pet ", true)
	UI.AddRange("Mend Pet", "Pet HP to cast Mend Pet", 0, 100, 20)
end