
local InsertService = game:GetService("InsertService")

local asset = game:GetObjects("rbxassetid://110159298326492")[1]

local player = game.Players.LocalPlayer
local character = player.Character


local animationsFolder = asset:WaitForChild("Animations"):Clone()
animationsFolder.Parent = character



for _,v in pairs(asset:GetChildren()) do
	if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
		v:Clone().Parent = character
	end
end

local hum = character:WaitForChild("Humanoid")
local animator = {}
animator.__index = animator

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

animator.Animations = {}

function animator.LoadAnimation(rig: Model, keyframeSequence: KeyframeSequence)
	local self = setmetatable({}, animator)
	self.name = keyframeSequence.Name
	self.looped = keyframeSequence.Loop
	self.speed = 1
	self.isPlaying = false
	self.timePosition = 0
	self.weight = Instance.new("NumberValue")
	self.fadeTime = 0.1
	
	self.priority = keyframeSequence.Priority
	self.keyframes = keyframeSequence:GetChildren()
	table.sort(self.keyframes, function(a, b)
		return a.Time < b.Time
	end)
	
	self.length = self.keyframes[#self.keyframes].Time
	
	self.joints = {}
	for _, v in pairs(rig:GetDescendants()) do
		if v:IsA("Motor6D") and v.Part1 then
			self.joints[v.Part1.Name] = v
		end
	end
	
	task.spawn(function()
		while true do
			local dt = RunService.PreSimulation:Wait()
			if not self.isPlaying then
				continue
			end
			self.timePosition += dt * self.speed
			if self.timePosition >= self.length then
				if not self.looped then
					self.timePosition = self.length
					self:Stop()
				else
					self.timePosition = self.timePosition%self.length
				end
			end
		end
	end)
	
	if not animator.Animations[rig] then
		animator.Animations[rig] = {}
		
		task.spawn(function()
			while rig.Parent do
				RunService.PreSimulation:Wait()
				
				if animator.Animations[rig].stopped then
					continue
				end
				
				table.sort(animator.Animations[rig], function(a, b)
					return a.priority.Value < b.priority.Value
				end)
				
				for _, anim in pairs(animator.Animations[rig]) do
					if typeof(anim) ~= "table" then
						continue
					end
					
					for jointName, joint in pairs(anim.joints) do
						local thethingthingything = math.clamp(anim.timePosition, anim.keyframes[1].Time, anim.keyframes[#anim.keyframes].Time)
						
						local selected: Keyframe
						local selectedIndex = 1
						for index, keyframe: Keyframe in pairs(anim.keyframes) do
							if keyframe.Time < thethingthingything and keyframe:FindFirstChild(jointName, true) then
								selected = keyframe
								selectedIndex = index
							end
						end
						if not selected then
							selected = anim.keyframes[1]
						end
						
						if selected then
							local pose = selected:FindFirstChild(jointName, true)
							if not pose or not pose:IsA("Pose") then
								continue
							end
							
							local nextKeyframe: Keyframe
							local nextPose: Pose
							local counter = 1
							repeat
								nextKeyframe = anim.keyframes[(selectedIndex+counter)%(#anim.keyframes+1)]
								if not nextKeyframe then
									break
								end
								
								nextPose = nextKeyframe:FindFirstChild(jointName, true)
								
								counter += 1
							until nextPose and nextPose:IsA("Pose")
							
							if not nextPose then
								continue
							end
							
							local alpha = 1
							if pose.EasingStyle ~= Enum.PoseEasingStyle.Constant then
								local old = pose.EasingStyle
								local easingStyle: Enum.EasingStyle
								if pose.EasingStyle == Enum.PoseEasingStyle.CubicV2 then
									easingStyle = Enum.EasingStyle.Cubic
								else
									easingStyle = Enum.EasingStyle:FromName(pose.EasingStyle.Name)
								end
								
								alpha = TweenService:GetValue(
									math.clamp((anim.timePosition-nextKeyframe.Time)/(selected.Time-nextKeyframe.Time), 0, 1),
									easingStyle,
									Enum.EasingDirection:FromName(pose.EasingDirection.Name)
								)
							end
							
							joint.Transform = joint.Transform:Lerp(pose.CFrame:Lerp(nextPose.CFrame, alpha), anim.weight.Value)
						end
					end
				end
			end
		end)
	end
	table.insert(animator.Animations[rig], self)
	
	return self
end

function animator:Play(fadeTime: number)
	self.fadeTime = fadeTime or self.fadeTime
	
	if not self.looped then
		self.timePosition = 0
	end
	self.isPlaying = true
	game:GetService("TweenService"):Create(self.weight, TweenInfo.new(self.fadeTime, Enum.EasingStyle.Linear), {Value = 1}):Play()
end

function animator:Stop(fadeTime: number)
	self.fadeTime = fadeTime or self.fadeTime
	
	self.isPlaying = false
	game:GetService("TweenService"):Create(self.weight, TweenInfo.new(self.fadeTime, Enum.EasingStyle.Linear), {Value = 0}):Play()
end




local animations = {}

for _, v in pairs(animationsFolder:GetChildren()) do
	if v:IsA("KeyframeSequence") then
		animations[v.Name] = animator.LoadAnimation(character, v)
	end
end

animationsFolder.ChildAdded:Connect(function(v)
	if v:IsA("KeyframeSequence") then
		animations[v.Name] = animator.LoadAnimation(character, v)
	end
end)

animations.Idle:Play()

hum.Running:Connect(function(speed)
	local walkSpeed = character:GetAttribute("WalkSpeed") or 8
	local sprintSpeed = character:GetAttribute("SprintSpeed") or 26

	if animations.Walk then
		animations.Walk.speed = speed / walkSpeed
	end

	if animations.Sprint then
		animations.Sprint.speed = speed / sprintSpeed
	end

	if speed > 0 then
		if speed > sprintSpeed - walkSpeed then
			if animations.Walk then
				animations.Walk:Stop()
			end

			if animations.Sprint then
				animations.Sprint:Play()
			end
		else
			if animations.Sprint then
				animations.Sprint:Stop()
			end

			if animations.Walk then
				animations.Walk:Play()
			end
		end

		if animations.Idle then
			animations.Idle:Stop()
		end
	else
		if animations.Idle then
			animations.Idle.timePosition = 0
			animations.Idle:Play()
		end

		if animations.Walk then
			animations.Walk:Stop()
		end

		if animations.Sprint then
			animations.Sprint:Stop()
		end
	end
end)

local stalkWalk = false

local playAnim = character:FindFirstChild("PlayAnim")
local stopAnim = character:FindFirstChild("StopAnim")

if playAnim then
	playAnim.OnClientEvent:Connect(function(animName)
		if animName == "StalkWalk" then
			animator.Animations[character].stopped = true
			stalkWalk = true
		end

		if animations[animName] then
			animations[animName]:Play()
		end
	end)
end

if stopAnim then
	stopAnim.OnClientEvent:Connect(function(animName)
		if animName == "StalkWalk" then
			animator.Animations[character].stopped = false
			stalkWalk = false
		end

		if animations[animName] then
			animations[animName]:Stop()
		end
	end)
end

game:GetService("RunService").PreSimulation:Connect(function()
	if not stalkWalk then
		return
	end

	local torso = character:FindFirstChild("Torso")

	local ls = torso and torso:FindFirstChild("Left Shoulder")
	local rs = torso and torso:FindFirstChild("Right Shoulder")
	local lh = torso and torso:FindFirstChild("Left Hip")
	local rh = torso and torso:FindFirstChild("Right Hip")
	local neck = torso and torso:FindFirstChild("Neck")

	if ls then
		ls.Transform = CFrame.Angles(0, 0, -math.pi / 2)
	end

	if rs then
		rs.Transform = CFrame.Angles(0, 0, math.pi / 2)
	end

	if lh then
		lh.Transform = CFrame.identity
	end

	if rh then
		rh.Transform = CFrame.identity
	end

	if neck then
		neck.Transform = CFrame.identity
	end
end)


local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Torso = character:WaitForChild("Torso") 

local Sick =  Instance.new("Sound",Torso)
Sick.Archivable = false
Sick.Volume = 3
Sick.SoundId = "rbxassetid://85741102771968"
Sick.PlaybackSpeed = 1
Sick:Play()
Sick.Name = "fart"
Sick.Looped = true
Sick.PlayOnRemove = false
Sick.TimePosition = 0

RunService.Heartbeat:Connect(function()
	local speedmod = 0
	local isSprinting = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
	if hum.MoveDirection.Magnitude == 0 then
		isSprinting = false
	end
	
	local walkSpeed = 8
	local sprintSpeed = 26
	
	if isSprinting then
		hum.WalkSpeed = sprintSpeed + speedmod
		TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = 80}):Play()
	else
		hum.WalkSpeed = walkSpeed + speedmod
		TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = 70}):Play()
	end
end)

game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")
	:WaitForChild("CameraModule")
	:WaitForChild("MouseLockController")
	:WaitForChild("BoundKeys").Value = "LeftControl,RightControl"



local UserInputService = game:GetService("UserInputService")

local cooldown = false
local COOLDOWN_TIME = 1

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		
		if cooldown then return end
		if not animations.Swing then return end

		cooldown = true

		animations.Swing:Stop()
		animations.Swing.timePosition = 0
		animations.Swing:Play()

		task.delay(COOLDOWN_TIME, function()
			cooldown = false
		end)
	end
end)

local UserInputService = game:GetService("UserInputService")

local cleaveCooldown = false
local CleaveCooldownTime = 20

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.Q then
		if cleaveCooldown then return end
		if not animations.Cleave then return end

		cleaveCooldown = true


		animations.Cleave:Stop()
		animations.Cleave.timePosition = 0
		animations.Cleave:Play()


		task.delay(animations.Cleave.length or 1, function()
			if animations.CleaveEnd then
				animations.CleaveEnd:Stop()
				animations.CleaveEnd.timePosition = 0
				animations.CleaveEnd:Play()
			end
		end)


		task.delay(CleaveCooldownTime, function()
			cleaveCooldown = false
		end)
	end
end)

