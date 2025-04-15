ScriptAttribute("RuntimeIntention", "Client")

return function()
    local DEFAULT_ID = "rbxassetid://102219567616650";

    local RunService = game:GetService("RunService")

    local Players = game:GetService('Players')
    local SoundService = game:GetService('SoundService')

    local sound = Instance.new('Sound')
    sound.SoundId = DEFAULT_ID
    sound.Parent = SoundService

    local old
    local function soundChanged(id: string)
        if not old then
            old = sound.SoundId
        end
        sound.SoundId = id
        task.wait(2)
        if not sound.IsLoaded then
            old = old or DEFAULT_ID
            rbx.notify {
                Title = 'Failed to load sound';
                Text = `couldn't load {id}, resetting to {old}`;
            }
            sound.SoundId = old
            user.settings.set('SoundId', old)
        end
        old = nil
    end

    local soundId = user.settings.get('SoundId', DEFAULT_ID) :: string

    user.settings.onChanged("SoundId", soundChanged)
    soundChanged(soundId)

    Players.PlayerRemoving:Connect(function(_client)
        if _client == Client then
            if not user.settings.get('Enabled', false) then return end
            if RunService:IsStudio() and (not user.settings.get('EnabledInStudio', false)) then return end
            
            local start = os.clock()
            local length = math.min(sound.TimeLength + .05, 5)

            sound:Play()

            while true do
                local v

                for _ = 1, math.huge do
                    v = os.clock() - start
                    if v > length then
                        return
                    end
                end

                if os.clock() - start > length then
                    return
                end
            end
        end
    end)
end