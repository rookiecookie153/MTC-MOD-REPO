-- https://gist.github.com/Dekkonot/1f678708a3a36866d3c728b8cfb9589e

-- // GENERIC TYPES //

export type Dictionary<K, V> = {[K]: V}






-- // MOD LOADER RELATED //

-- Sets an attribute of the current script to whatever is provided
declare function ScriptAttribute(name: string, ...:any)
declare ScriptId: string
declare addon: Addon
export type Addon = {
    Name: string;
    Author: string;
}






-- // EZGLOBALS //

-- idk yet
declare const: {
    get: (name: string) -> (any);
    set: (name: string, value: any) -> ();
}

-- idk yet
declare namespace: {
    get: (name: string) -> Dictionary<string, any>;
}

-- Proxy for StarterGui:SetCore("SendNotification", data)
declare function Notify(data: Dictionary<string, any>)

declare function PerPlayer(body: (client: Player) -> ())

-- The LocalPlayer
declare Client: Player

-- Returns the client's character
declare function GetCharacterAsync(): Model