-- https://gist.github.com/Dekkonot/1f678708a3a36866d3c728b8cfb9589e






-- // MOD LOADER RELATED //

-- Sets an attribute of the current script to whatever is provided
declare function ScriptAttribute(name: string, ...:any)
declare ScriptId: string






-- // EZGLOBALS //

-- idk yet
declare const: {
    get: (name: string) -> (any);
    set: (name: string, value: any) -> ();
}

-- Proxy for StarterGui:SetCore("SendNotification", data)
declare function Notify(data: {[string]: any})

declare function PerPlayer(body: (client: Player) -> ())

-- The LocalPlayer
declare Client: Player

-- Returns the client's character
declare function GetCharacterAsync(): Model