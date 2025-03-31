-- -- This represents a type.
-- -- It isn't exported into the global environment unless it has `export` before the name.
-- export type ExampleType = {
--     example_field: string,
--     example_method: (any) -> string
-- }

-- -- This represents a global table, rather than a type
-- declare ExampleLibrary: {
--     function_name: (any) -> string
-- }

-- -- This represents a global variable.
-- declare ExampleGlobal: ExampleType

-- -- This represents a global function.
-- -- The entirety of Luau's type system can be used, but a generic is used to demonstrate that.
-- declare function ExampleGlobalFunction<T>(param_name: T): T

-- -- This represents a 'class'. It can be inherited from.
-- declare class ExampleClass
--     -- For reasons known only to Roblox, there are no commas after class entries.
--     example_class_field: ExampleType
--     example_class_function: (any) -> ()
--     example_class_method: (ExampleClass) -> ()
-- end

-- -- Classes can be extended.
-- declare class ExampleExtension extends ExampleClass
--     example_extension: ExampleClass
-- end