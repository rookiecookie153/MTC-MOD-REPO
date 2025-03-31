ScriptAttribute("RuntimeIntention", "Server")

return function()
	print(script)

	local msg = Instance.new("Hint")
	msg.Text = "Why So Serious?"
	msg.Parent = workspace

	PerPlayer(function(client)
		client.CharacterAdded:Connect(function(char)
			task.wait(1)
			char:WaitForChild("Head"):WaitForChild("face").Texture = "rbxassetid://17093215656"
		end)
		client:LoadCharacter()
	end)

	-- SoundService.loorp2.SoundId = "rbxassetid://106662914917582"
	-- SoundService.loorp2.PlaybackSpeed = 1
end