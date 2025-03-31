ScriptAttribute("RuntimeIntention", "Client")

return function()
    local UIS = game:GetService("UserInputService")
    local Char = GetCharacterAsync()
    local Hum = Char.Humanoid
    
    local ismidair = false
    local usedDoubleJump = false

    print("doing the maaaagiiicccc")

    Hum.StateChanged:Connect(function(old, new)
        if old == Enum.HumanoidStateType.Jumping and new == Enum.HumanoidStateType.Freefall then
            ismidair = true
        elseif new == Enum.HumanoidStateType.Landed then
            usedDoubleJump = false
            ismidair = false
        end
    end)

    UIS.InputBegan:Connect(function(input, gameProcessedEvent)
        if not gameProcessedEvent then
            if input.KeyCode == Enum.KeyCode.Space then
                if ismidair == true and usedDoubleJump == false then
                    usedDoubleJump = true
                    Hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end)
end