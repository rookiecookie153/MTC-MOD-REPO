ScriptAttribute("RuntimeIntention", "Server")

return function()
    local StarterPlayer = game:GetService("StarterPlayer")

    warn("Hello from Server! This is the", addon.Name, "mod!")

    local modelImport = mdl.import(addon.Id, "avatar.coft")

    modelImport.Name = "StarterCharacter"
    modelImport.Parent = StarterPlayer

    PerPlayer(function(client)
        client:LoadCharacter()
    end)
end