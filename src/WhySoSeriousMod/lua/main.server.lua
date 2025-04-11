ScriptAttribute("RuntimeIntention", "Server")
---Hey, it's me, Those Who Know! 💀
return function()
	local Debris = game:GetService("Debris")
	
	PerPlayer(function(client)
		client.CharacterAdded:Connect(function(char)
			local msg = Instance.new("Message")
			msg.Text = "Why So Serious?"
			msg.Parent = client.PlayerGui
			Debris:AddItem(msg, 2)
			task.wait(1)
			char:WaitForChild("Head"):WaitForChild("face").Texture = "rbxassetid://17093215656"
		end)
		if client.Character then client:LoadCharacter() end
	end)

	-- SoundService.loorp2.SoundId = "rbxassetid://106662914917582"
	-- SoundService.loorp2.PlaybackSpeed = 1
end