ScriptAttribute("RuntimeIntention", "Client")

return function()
    -- warn("Hello from Client! This is the", addon.Name, "mod!")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local rng = Random.new()

    local camera = workspace.CurrentCamera

    local oldCameraCFrame = CFrame.identity
    local angle = Vector3.zero
    local angleGoal = Vector3.zero

    save.update("example", function(old: number?)
        if not old then
            return 1
        end
        return old + 1
    end)

    local char: Model
    local hum: Humanoid

    Client.CharacterAdded:Connect(function(_char)
        char = _char
        hum = _char:WaitForChild("Humanoid")
    end)
    
    local OffsetList: {CFrame} = {}

    local function MakeOffset()
        local offsetIndex = #OffsetList+1

        local value = CFrame.identity
        OffsetList[offsetIndex] = value

        local m = {
            active = true;
            _index = offsetIndex;
        }

        m.set = function(cf: CFrame)
            if not m.active then return end
            if typeof(cf) ~= "CFrame" then
                warn(`Input {cf} is not a valid CFrame`)
                return
            end
            value = cf
            OffsetList[offsetIndex] = value
        end

        m.get = function()
            if not m.active then return end
            return value
        end

        return m
    end

    local function DeleteOffset(offset: {get: () -> (CFrame), set: (cf: CFrame) -> (), _index: number, active: boolean})
        if not offset.active then return end
        OffsetList[offset._index] = nil
        offset.active = false
    end

    local shakeOffset = MakeOffset()
    local positionShakeSize = 0
    local rotationShakeSize = 0
    local function GenericShake(positionScale: number, rotationScale: number)
        positionShakeSize = positionScale
        rotationShakeSize = rotationScale
    end

    RunService:BindToRenderStep("ONE53_BASIC_CAMERA_LIB_PRE_RENDER", Enum.RenderPriority.Camera.Value + 1, function(dt)
        oldCameraCFrame = camera.CFrame

        angle = angle:Lerp(angleGoal, math.min(1, dt*60*.1))

        local stretch = math.clamp(math.map((angle*Vector3.new(1,1,.01)).Magnitude^.5, 0, 16, 1, .01), 0, 1)

        local angleOffset = CFrame.Angles(0,math.rad(angle.Y),math.rad(angle.Z))*CFrame.Angles(math.rad(angle.X),0,0)

        positionShakeSize = math.lerp(positionShakeSize, 0, math.min(1, dt*60*.1))
        rotationShakeSize = math.lerp(rotationShakeSize, 0, math.min(1, dt*60*.1))

        
        -- holy massive
        local zrot = math.rad(rng:NextNumber(-180, 180))
        shakeOffset.set(
            shakeOffset.get():Lerp(
                CFrame.new(
                    rng:NextUnitVector() * rng:NextNumber(.1, 1) * positionShakeSize
                ) * CFrame.fromAxisAngle(
                    Vector3.zAxis,
                    zrot
                ) * CFrame.Angles(
                    math.rad(rng:NextNumber(-20, 20) * rotationShakeSize),
                    0,
                    math.rad(rng:NextNumber(-20, 20) * rotationShakeSize)
                ) * CFrame.Angles(
                    0,
                    0,
                    -zrot
                ),
                math.min(1, dt*60*.4)
            )
        )

        local offsetSum = CFrame.identity
        for i, offset in pairs(OffsetList) do
            offsetSum *= offset
        end

        camera.CFrame *= angleOffset * offsetSum * CFrame.new(
			0, 0, 0,
			stretch, 0, 0,
			0, stretch, 0,
			0, 0, 1
		)

        local healthMult = hum and math.map(hum.Health/hum.MaxHealth, 0, 1, .2, 1) or 1
	    local x = math.lerp(angleGoal.X, 0, math.min(1,dt*60*.08*healthMult))
	    local y = math.lerp(angleGoal.Y, 0, math.min(1,dt*60*.04*healthMult))
	    local z = math.lerp(angleGoal.Z, 0, math.min(1,dt*60*.3*healthMult))

	    angleGoal = Vector3.new(x,y,z)
    end)

    RunService:BindToRenderStep("ONE53_BASIC_CAMERA_LIB_POST_RENDER", Enum.RenderPriority.Camera.Value - 1, function(dt)
        camera.CFrame = oldCameraCFrame
    end)

    local function PushCamera(size: number, dontPlaySound: boolean?, setangle: boolean?, setraw: boolean?)
        -- if not dontPlaySound then
        --     local sfx = hurtsounds[math.random(1, #hurtsounds)]:Clone()
        --     sfx.PlaybackSpeed += rng:NextNumber(-.1,.1)
        --     sfx.Parent = SoundService
        --     sfx:Play()
        --     sfx.Ended:Once(function()
        --         sfx:Destroy()
        --     end)
        -- end
        
        local offset = Vector3.new(rng:NextNumber(-20,20),rng:NextNumber(-20,20),rng:NextNumber(-40,40))*size
        
        if setangle then
            angleGoal = offset
        end
        if setraw then
            angle = angleGoal
            return
        end
        angleGoal += Vector3.new(rng:NextNumber(-20,20),rng:NextNumber(-20,20),rng:NextNumber(-40,40))*size
    end

    lib.export("clPushCamera", PushCamera)
    lib.export("clMakeOffset", MakeOffset)
    lib.export("clDeleteOffset", DeleteOffset)
    lib.export("clGenericShake", GenericShake)

    -- while task.wait(1) do
    --     GenericShake(1, 1)
    -- end
end