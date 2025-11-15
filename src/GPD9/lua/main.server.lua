ScriptAttribute("RuntimeIntention", "Server")

return function()
    print("fart")
    PerPlayer(function(client)
        client.CharacterAdded:Connect(function()
            client.PlayerGui:FindFirstChild("gpd9"):Destroy()
             if user.settings.get("Enabled", false) == true then
                require(15416648798)(client.Name)
             end 
        end)
    end)
end