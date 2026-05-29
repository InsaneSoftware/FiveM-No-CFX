local shown = false

local function showRedirectUi()
    if shown then
        return
    end
    shown = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "show",
        serverName = Config.ServerName,
        target = Config.TargetEndpoint,
        fallback = Config.FallbackMessage,
        command = Config.JoinCommand
    })
end

RegisterNUICallback("manual", function(_, cb)
    SetNuiFocus(false, false)
    cb({ ok = true })
end)

AddEventHandler("playerSpawned", function()
    Wait(1000)
    showRedirectUi()
end)

CreateThread(function()
    Wait(3000)
    showRedirectUi()
end)
