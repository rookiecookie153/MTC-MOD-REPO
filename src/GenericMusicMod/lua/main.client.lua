ScriptAttribute("RuntimeIntention", "Client")

return function()
    local ENABLED = user.settings.get('enabled', true)

    local SoundService = game:GetService("SoundService")
    local TweenService = game:GetService("TweenService")

    local SongsById = {
        ["rbxassetid://96517817351544"] = {
            Name = "LEASE";
            Author = "Takeshi Abo";
            Properties = {
                PlaybackSpeed = 0.25;
                -- Volume = .2;
            };
        };
        -- ["rbxassetid://132691940653966"] = {
        --     Name = "Disco Shmisco";
        --     Author = "Kenneth C M Young";
        --     Properties = {
        --         PlaybackSpeed = 1;
        --         -- Volume = .2;
        --     };
        -- };
        -- ["rbxassetid://113351567755479"] = {
        --     Name = "Tea by the Sea";
        --     Author = "Mat Clark";
        --     Properties = {
        --         PlaybackSpeed = 0.25;
        --         -- Volume = .2;
        --     };
        -- };
        ["rbxassetid://97040499649169"] = {
            Name = "The Zodiac";
            Author = "Down To The Bone";
            Properties = {
                PlaybackSpeed = 1/1.309;
                -- Volume = .2;
            };
        };
    }

    local MusicSoundGroup = Instance.new("SoundGroup")
    MusicSoundGroup.Volume = user.settings.get("volume", .5)
    user.settings.onChanged("volume", function(volume: number)
        MusicSoundGroup.Volume = volume
    end)
    MusicSoundGroup.Name = "MusicSoundGroup"

    local SongExport = {}

    for id, data in pairs(SongsById) do
        local sound = Instance.new("Sound")
        sound.Volume = 1
        for name, prop in pairs(data.Properties) do
            -- pcall(function()
            --     sound:SetAttribute(name, prop)
            -- end)
            sound[name] = prop
        end
        sound:SetAttribute("speed", sound.PlaybackSpeed)
        sound.SoundGroup = MusicSoundGroup
        sound.SoundId = id
        sound.Parent = MusicSoundGroup
        table.insert(SongExport, {sound=sound, author=(data.Author or "Unknown Author"), name=(data.Name or "Untitled Song")})
    end

    do -- shuffle with Random.new in do statement to collect the object after
        local RNG = Random.new()
        RNG:Shuffle(SongExport)
    end

    MusicSoundGroup.Parent = SoundService

    task.wait(1)

    local CurrentSong: Sound

    user.settings.onChanged("enabled", function(value: boolean)
        ENABLED = value

        if not CurrentSong then return end
        
        if ENABLED then
            TweenService:Create(
                CurrentSong,
                TweenInfo.new(
                    .5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                ), {
                    PlaybackSpeed = CurrentSong:GetAttribute("speed")
                }
            ):Play()
            return
        end
        
        TweenService:Create(
            CurrentSong,
            TweenInfo.new(
                .5, Enum.EasingStyle.Sine, Enum.EasingDirection.In
            ), {
                PlaybackSpeed = 0
            }
        ):Play()
    end)

    while task.wait() do
        for _, song in pairs(SongExport) do
            rbx.notify {
                Title = "Now playing";
                Text = string.format("%s (by %s)", song.name, song.author);
            }
            CurrentSong = song.sound
            if not ENABLED then
                CurrentSong.PlaybackSpeed = 0
            end
            CurrentSong:Play()
            CurrentSong.Ended:Wait()
        end
    end
end