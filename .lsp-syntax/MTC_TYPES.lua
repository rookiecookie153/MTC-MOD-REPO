-- https://gist.github.com/Dekkonot/1f678708a3a36866d3c728b8cfb9589e

-- // GENERIC TYPES //

export type Dictionary<K, V> = {[K]: V}






-- // MOD LOADER RELATED //

-- Sets an attribute of the current script to whatever is provided
declare function ScriptAttribute(name: string, ...:any)
declare ScriptId: string
declare addon: Addon
export type Addon = {
    Id: string; -- name by directory
    Name: string; -- name specified by manifest
    Author: string; -- author specified by manifest
}

-- global libraries
type ValidSetting = string | number | boolean;
declare user: {
    settings: {
        get: (name: string, ifNil: ValidSetting) -> ValidSetting;
        set: (name: string, value: ValidSetting) -> ();
        onChanged: <T>(property: string, callback: (value: T) -> ()) -> RBXScriptConnection;
        changed: RBXScriptSignal;
    };
}

declare lib: {
    import: (name: string, retryduration: number?) -> any;
    export: (name: string, value: any) -> ();
}

declare mdl: {
    import: (id: string, name: string) -> (Instance?, string);
}

-- declare const: {
--     get: (name: string) -> (any);
--     set: (name: string, value: any) -> ();
-- }

-- declare namespace: {
--     get: (name: string) -> Dictionary<string, any>;
-- }

export type NotificationConfig = {
    Title: string;
    Text: string;
    Icon: string?;
    Duration: number?;
    Callback: BindableFunction?;
    Button1: string?;
    Button2: string?;
}
declare rbx: {
    notify: (data: NotificationConfig) -> ();
}

-- drsgiuohweasfuihbf
declare function PerPlayer(body: (client: Player) -> ())

-- The LocalPlayer
declare Client: Player

-- Returns the client's character
declare function GetCharacterAsync(): Model

-- Returns the client's humanoid
declare function GetHumanoidAsync(): Model

