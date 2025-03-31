ScriptAttribute("RuntimeIntention", "Server")

return function()
    PerPlayer(function(client: Player)
        print(client)
    end)
end