AddEventHandler("playerConnecting", function(_, _, deferrals)
    deferrals.defer()
    Wait(0)

    local card = {
        ["type"] = "AdaptiveCard",
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["version"] = "1.2",
        ["body"] = {
            {
                ["type"] = "TextBlock",
                ["weight"] = "Bolder",
                ["size"] = "Large",
                ["text"] = "Insanely FiveM Redirector"
            },
            {
                ["type"] = "TextBlock",
                ["wrap"] = true,
                ["text"] = "Manual steps: Press F8, type the command below, then press Enter."
            },
            {
                ["type"] = "TextBlock",
                ["wrap"] = true,
                ["fontType"] = "Monospace",
                ["text"] = Config.JoinCommand
            }
        },
        ["actions"] = {
            {
                ["type"] = "Action.Submit",
                ["title"] = "I Connect Manually",
                ["data"] = { action = "manual" }
            }
        }
    }

    deferrals.presentCard(card, function()
        Wait(0)
        deferrals.done("Manual redirect only. " .. Config.FallbackMessage)
    end)
end)
