ScriptAttribute("RuntimeIntention", "Client")

return function()
    local ENABLED = user.settings.get('enabled', true)
    user.settings.onChanged("enabled", function(value: boolean)
        ENABLED = value
    end)

    local UIS = game:GetService("UserInputService")
    local Char = GetCharacterAsync()
    local Hum = Char.Humanoid
    
    local ismidair = false
    local usedDoubleJump = false

    -- print("doing the maaaagiiicccc")

    Hum.StateChanged:Connect(function(old, new)
        if old == Enum.HumanoidStateType.Jumping and new == Enum.HumanoidStateType.Freefall then
            ismidair = true
        elseif new == Enum.HumanoidStateType.Landed then
            usedDoubleJump = false
            ismidair = false
        end
    end)

    UIS.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end
        if input.KeyCode ~= Enum.KeyCode.Space then return end
        if ismidair == false or usedDoubleJump == true then return end

        usedDoubleJump = true
        
        if not ENABLED then return end

        Hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
end