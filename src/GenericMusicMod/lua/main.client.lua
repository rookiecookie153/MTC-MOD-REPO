ScriptAttribute("RuntimeIntention", "Client")

return function()
    local SoundService = game:GetService("SoundService")

    local SongsById = {
        ["rbxassetid://96517817351544"] = {
            Name = "LEASE";
            Author = "Takeshi Abo";
            Properties = {
                PlaybackSpeed = 0.25;
                Volume = .2;
            };
        };
    }

    local MusicSoundGroup = Instance.new("SoundGroup")
    MusicSoundGroup.Name = "MusicSoundGroup"

    local SongExport = {}

    for id, data in pairs(SongsById) do
        local sound = Instance.new("Sound")
        for name, prop in pairs(data.Properties) do
            sound[name] = prop
        end
        sound.SoundId = id
        sound.Parent = MusicSoundGroup
        table.insert(SongExport, {sound=sound, author=(data.Author or "Unknown Author"), name=(data.Name or "Untitled Song")})
    end

    do -- shuffle with Random.new in do statement to collect the object after
        local RNG = Random.new()
        RNG:Shuffle(SongExport)
    end

    MusicSoundGroup.Parent = SoundService

    for _, song in pairs(SongExport) do
        Notify {
            Title = "Now playing";
            Text = string.format("%s (by %s)", song.name, song.author);
        }
        song.sound:Play()
        song.sound.Ended:Wait()
    end
end