ScriptAttribute("RuntimeIntention", "Client")

return function()
    -- warn("Hello from Client! This is the", addon.Name, "mod!")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local camera = workspace.CurrentCamera
    
    RunService:BindToRenderStep("ONE53_BASIC_CAMERA_TILT", Enum.RenderPriority.Camera.Value + 1, function(dt)
        
    end)
end