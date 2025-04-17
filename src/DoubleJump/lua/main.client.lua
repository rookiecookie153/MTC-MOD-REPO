ScriptAttribute("RuntimeIntention", "Client")

return function()
    local Players = game:GetService('Players')
    local UIS = game:GetService('UserInputService')

    local ENABLED = user.settings.get('enabled', true)
    user.settings.onChanged("enabled", function(value: boolean)
        ENABLED = value
    end)

    local CAMERA_PUSH_ENABLED = user.settings.get('camera_push', false)
    user.settings.onChanged("camera_push", function(value: boolean)
        CAMERA_PUSH_ENABLED = value
    end)

    local CAMERA_PUSH_SIZE = user.settings.get('camera_push_size', .2)
    user.settings.onChanged("camera_push_size", function(value: number)
        CAMERA_PUSH_SIZE = value
    end)

    local CAMERA_USE_SHAKE = user.settings.get('camera_use_shake', false)
    user.settings.onChanged("camera_use_shake", function(value: number)
        CAMERA_USE_SHAKE = value
    end)

    local clPushCamera: (size: number) -> () = lib.import("clPushCamera", 1) or function() end
    local clGenericShake: (sizePos: number, sizeRot: number) -> () = lib.import("clGenericShake", 1) or function() end

    local Char = GetCharacterAsync()
    local Hum = Char.Humanoid

    Client.CharacterAdded:Connect(function(char)
        Char = char
        Hum = char:WaitForChild("Humanoid")
    end)
    
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

        if not CAMERA_PUSH_ENABLED then return end

        local pushSize = math.clamp(CAMERA_PUSH_SIZE, .2, 10000000)

        if CAMERA_USE_SHAKE then
            clGenericShake(pushSize, pushSize)
            return
        end

        clPushCamera(pushSize)
    end)
end