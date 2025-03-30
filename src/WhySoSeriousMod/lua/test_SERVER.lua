ScriptAttribute("RuntimeIntention", "Server")
print(ScriptId)

local msg = Instance.new("Hint")
msg.Text = "Why So Serious?"
msg.Parent = workspace

local function PlayerAdded(plr)
    plr.CharacterAdded:Connect(function(char)
        task.wait(1)
        char:WaitForChild("Head"):WaitForChild("face").Texture = "rbxassetid://17093215656"
    end)
    plr:LoadCharacter()
end

game:GetService("Players").PlayerAdded:Connect(PlayerAdded)
for _, p in game:GetService("Players"):GetPlayers() do
    PlayerAdded(p)
end