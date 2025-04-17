ScriptAttribute("RuntimeIntention", "Server")

return function()
	-- humanoidAnimatePlayEmote.lua

	local char, mdlerror = mdl.import(addon.Id, "hood.coft")

	if not char then
		print(mdlerror)
		return
	end

    char.Parent = workspace
    char:PivotTo(CFrame.new(100,100,0))

	-- local hum = char:WaitForChild("Humanoid")

	-- local RunAnim = Instance.new('Animation')
	-- RunAnim.AnimationId = 'http://www.roblox.com/asset/?id=180426354'

	-- hum:LoadAnimation(RunAnim):Play()

	-- local TweenService = game:GetService("TweenService")
	-- local Players = game:GetService("Players")
	-- local Chat = game:GetService("Chat")

	-- local lines = {
	-- 	{"rbxassetid://72057266742568","🎵"};
	-- 	{"rbxassetid://72057266742568","🎶"};
	-- }

	-- for i, line in lines do
	-- 	local t = {}
	-- 	t.sound = Instance.new("Sound")
	-- 	t.sound.SoundId = line[1]
	-- 	t.sound.Volume = .3
	-- 	t.sound.Parent = char.HumanoidRootPart
	-- 	t.caption = line[2]
	-- 	lines[i]=t
	-- end

	-- local lastLine
	-- local rng = Random.new()
	-- local function playRandomLine()
	-- 	local lineIndex = 0
	-- 	repeat
	-- 		lineIndex = rng:NextInteger(1, #lines)
	-- 	until lineIndex ~= lastLine
	-- 	lastLine = lineIndex

	-- 	local line = lines[lineIndex]

	-- 	Chat:Chat(char.Head, line.caption)

	-- 	line.sound:Play()
	-- 	task.wait(line.sound.TimeLength)
	-- end

	-- local start = char:GetPivot().Position
	-- local states = {
	-- 	function() -- talk
	-- 		if rng:NextInteger(1,2) == 1 then
	-- 			for _, p in Players:GetPlayers() do
	-- 				if p:DistanceFromCharacter(char:GetPivot().Position) < 10 then
	-- 					local pchar = p.Character
	-- 					if not pchar then return end
	-- 					local proot = pchar:FindFirstChild("HumanoidRootPart") :: BasePart?
	-- 					if not proot then return end
	-- 					TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	-- 						CFrame = CFrame.lookAlong(
	-- 							char.HumanoidRootPart.Position,
	-- 							(proot.Position-char.HumanoidRootPart.Position)*Vector3.new(1,0,1),
	-- 							Vector3.yAxis
	-- 						)
	-- 					}):Play()
	-- 					playRandomLine()
	-- 				end
	-- 			end
	-- 		end
	-- 		return true
	-- 	end,
	-- 	function() -- wander
	-- 		hum:MoveTo(start+Vector3.new(rng:NextNumber(-10,10),0,rng:NextNumber(-10,10)))
	-- 		hum.MoveToFinished:Wait()
	-- 		return false
	-- 	end
	-- }

	-- while task.wait() do
	-- 	for i = 1, #states do
	-- 		local state = states[i]
	-- 		if not	state() then break end
	-- 	end
	-- end
end