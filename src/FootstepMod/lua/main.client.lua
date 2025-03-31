ScriptAttribute("RuntimeIntention", "Client")

return function()
    local character = GetCharacterAsync()

    print(character)
end