--from mlcv6 because it ran out of local registers and no im not giving mlcv6 because its not even finished
script=game:GetObjects("rbxassetid://102732578273511")[1]
local Player = game:GetService("Players").LocalPlayer
if Player ~= nil then else pcall(function() game:GetService("Debris"):AddItem(script,0);script.Enabled = false end) return end
local Backpack = Player.Backpack
local LettersString = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM_"
function MakeFunction(FuncA)
	local huh;huh=coroutine.create(function()
		FuncA()
		coroutine.yield(huh)
		coroutine.close(huh)
		huh=nil
	end)
	coroutine.resume(huh)
end
function RandomString(Length)
	local NewText = ""
	if typeof(Length) == "number" then
		for i=1,Length do
			local Selected = math.random(1,string.len(LettersString))
			NewText..=string.sub(LettersString,Selected,Selected)
		end
	else
		for i=1,math.random(50,100) do
			local Selected = math.random(1,string.len(LettersString))
			NewText..=string.sub(LettersString,Selected,Selected)
		end
	end
	return NewText
end
local ScriptEnded = false
local UserId = Player.UserId
local ClientInstances,Remote = {},nil
pcall(function()script.Client:Destroy()end)
local Physics = game:GetService("PhysicsService")
local CollisionName = RandomString()
local Character,Avatar = Player.Character,script.USERAVATAR
local Humanoid = Character:FindFirstChild("Humanoid")
local Torso,Head,RightArm,LeftArm,RightLeg,LeftLeg = Character.Torso,Character.Head,Character["Right Arm"],Character["Left Arm"],Character["Right Leg"],Character["Left Leg"]
local SkinType = 1
local Hats = {}
local Attachments = {
	Torso = {
		"RightCollarAttachment",
		"WaistCenterAttachment",
		"BodyBackAttachment",
		"WaistBackAttachment",
		"BodyFrontAttachment",
		"LeftCollarAttachment",
		"WaistFrontAttachment",
		"NeckAttachment"
	},
	Head = {
		"HairAttachment",
		"HatAttachment",
		"FaceFrontAttachment",
		"FaceCenterAttachment"
	},
	RightArm = {
		"RightShoulderAttachment",
		"RightGripAttachment"
	},
	LeftArm = {
		"LeftGripAttachment",
		"LeftShoulderAttachment"
	},
	RightLeg = {
		"RightFootAttachment"
	},
	LeftLeg = {
		"LeftFootAttachment"
	}
}
for i,v in pairs(Character:GetChildren()) do
	if v:IsA("Accessory") then
		pcall(function()
			local Handle = v.Handle:Clone()
			Handle.Anchored = true
			local Attachment = Handle:FindFirstChildOfClass("Attachment")
			if table.find(Attachments.Head,Attachment.Name) then
				Handle:SetAttribute("WeldTo","Head")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*Head.CFrame)
			elseif table.find(Attachments.Torso,Attachment.Name) then
				Handle:SetAttribute("WeldTo","Torso")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*Torso.CFrame)
			elseif table.find(Attachments.RightArm,Attachment.Name) then
				Handle:SetAttribute("WeldTo","RightArm")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*RightArm.CFrame)
			elseif table.find(Attachments.LeftArm,Attachment.Name) then
				Handle:SetAttribute("WeldTo","LeftArm")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*LeftArm.CFrame)
			elseif table.find(Attachments.RightLeg,Attachment.Name) then
				Handle:SetAttribute("WeldTo","RightLeg")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*RightLeg.CFrame)
			elseif table.find(Attachments.LeftLeg,Attachment.Name) then
				Handle:SetAttribute("WeldTo","LeftLeg")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*LeftLeg.CFrame)
			else
				Handle:SetAttribute("WeldTo","Head")
				Handle:SetAttribute("HatOffset",Handle.CFrame:Inverse()*Head.CFrame)
			end
			Handle.Name = "Accessory"
			Handle.Parent = Avatar
		end)
	elseif v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
		pcall(function()v:Clone().Parent = Avatar;end)
	end
end
pcall(function()Head.face:Clone().Parent=Avatar.Head;end)
pcall(function()Head.Mesh:Clone().Parent=Avatar.Head;end)

pcall(function()
	for i,v in pairs(Backpack:GetChildren()) do
		if v then
			pcall(function()v:Destroy()end)
		end
	end
end)
function NewRemote()
	local New = Instance.new("BindableEvent",game:GetService("ReplicatedStorage"))
	New.Name = Player.Name.."sMLCv6Remote"
	New.Parent = game:GetService("ReplicatedStorage")
	New.Archivable = false
	return New
end
function DestroyOnTime(Inst,Time)
	MakeFunction(function()
		if Time >= 0 then wait(Time) end
		Inst:Destroy()
	end)
end
local ModeDetector,TauntDetector = 1,nil
local SongTable = {
	"LostConnection",
	"Insanity",
	"Glitch",
	"LostInLand",
	"CREDITS",
	"WarWithoutReason",
	"Order",
	"BossBattleKSS",
	"FoundUnderwater",
	"ActionWinterJourney",
	"CrazyB",
	"MacintoshPlus",
	"Rage",
	"OSecrets",
	"4morant_s",
	"MC7",
	"ThePainter",
	"RunningInThe90s",
	"MC8",
	"LunarPillars",
	"Plasma",
	"Alice",
	"Null"
}
local TauntTable = {
	"None",
	"None",
	"None",
	"None",
	"None",
	"None",
	"None",
	"StardustSpeedway",
	"TheKingofSpeedDaytonaUSA",
	"BarbieRestoBarGrill",
	"RippleFieldOne",
	"poni",
	"OAB",
	"potoraemon",
	"RolandStyle",
	"CaramellDansen",
	"Club"
}
local ShieldSizeVal = 25
local Removing,Added,RemoteF,Chatted,CharAdded,ToolAdded,Loop,DAdded
local KillType,Damage,DamageType,VoidTable,VoidTable2,SoundId,Volume,EnableVis,EnableScarf,EnableCrown,EnableMask,ClassicStyle,TurnVisColor,PSX = "Server",true,"Ray",{},{ClassName = {},Locked = {},Size = {},Anchored = {},CanCollide = {},CanQuery = {},CanTouch = {},Massless = {},CastShadow = {}},print("beans"),5,false,false,false,false,false,false,0
local MousePos,MouseHold = Vector3.new(0,100,0),false
local ReColor,FirstColor,SkinColor,Material,Reflectance,WingBaseColor = Color3.new(),nil,Color3.new(),Enum.Material.Plastic,0,false
local Platform,LastPlatform,PlatformOffset,PlatformIsSeat = nil,nil,CFrame.new(),false
local TweenService = game:GetService("TweenService")
function ChangeCFrame(Part,To)
	MakeFunction(function()
		local PartT,PosT = {Part},{To}
		workspace:BulkMoveTo(PartT,PosT,Enum.BulkMoveMode.FireCFrameChanged)
		Part:PivotTo(To)
		TweenService:Create(Part,TweenInfo.new(0,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0),{CFrame = To}):Play()
	end)
end
function Void(v)
end
function CheckP(_)
	local Bool = false
	if _:IsA("BasePart") then
		local v,Num=_,0
		if table.find(VoidTable2.ClassName,v.ClassName) then Num=Num+1;end
		if table.find(VoidTable2.Locked,v.Locked) then Num=Num+1;end
		if table.find(VoidTable2.Size,v.Size) then Num=Num+1;end
		if table.find(VoidTable2.Anchored,v.Anchored) then Num=Num+1;end
		if table.find(VoidTable2.CanCollide,v.CanCollide) then Num=Num+1;end
		if table.find(VoidTable2.CanQuery,v.CanQuery) then Num=Num+1;end
		if table.find(VoidTable2.CanTouch,v.CanTouch) then Num=Num+1;end
		if table.find(VoidTable2.CastShadow,v.CastShadow) then Num=Num+1;end
		if Num >= 8 then
			Bool = true
		end
	end
	return Bool
end
function InsertP(v)
	if v:IsA("BasePart") then
		if table.find(VoidTable2.ClassName,v.ClassName) == nil then table.insert(VoidTable2.ClassName,v.ClassName);end
		if table.find(VoidTable2.Locked,v.Locked) == nil then table.insert(VoidTable2.Locked,v.Locked);end
		if table.find(VoidTable2.Size,v.Size) == nil then table.insert(VoidTable2.Size,v.Size);end
		if table.find(VoidTable2.Anchored,v.Anchored) == nil then table.insert(VoidTable2.Anchored,v.Anchored);end
		if table.find(VoidTable2.CanCollide,v.CanCollide) == nil then table.insert(VoidTable2.CanCollide,v.CanCollide);end
		if table.find(VoidTable2.CanQuery,v.CanQuery) == nil then table.insert(VoidTable2.CanQuery,v.CanQuery);end
		if table.find(VoidTable2.CanTouch,v.CanTouch) == nil then table.insert(VoidTable2.CanTouch,v.CanTouch);end
		if table.find(VoidTable2.CastShadow,v.CastShadow) == nil then table.insert(VoidTable2.CastShadow,v.CastShadow);end
	end
end
local Terrain = workspace.Terrain

local KillMode = 1
local InvalidValues = {""," "}
function RemoteFunc(plr,typ,thing)
	if plr == Player then
		if typ == "SOURCEV5PROPTABLE" then
			Remote:Fire("SOURCEV5PROPTABLE",{Speed = thing.Speed,HipHeight = thing.HipHeight,Flying = thing.Flying,Pos = thing.Pos,PosRot = thing.PosRot,Sine = thing.Sine,VisSine = thing.VisSine,VisSine2 = thing.VisSine2,Moving = thing.Moving,Falling = thing.Falling,Fall = thing.Fall,TouchingFloor = thing.TouchingFloor,MousePos = thing.MousePos,CameraShakes = thing.CameraShakes,OwnerCameraCFrame = thing.OwnerCameraCFrame,CameraAngles = thing.CameraAngles,MoveVal = thing.MoveVal,LookAtCamera = thing.LookAtCamera,Hold = thing.Hold,LookAt = thing.LookAt,Attacking = thing.Attacking,VisVal = thing.VisVal,Mode = thing.Mode,DoGlitch = thing.DoGlitch,GlitchBoolean = thing.GlitchBoolean,Taunt = thing.Taunt,WingsEnabled = thing.WingsEnabled,GunDetail = thing.GunDetail,UseServerEvent = thing.UseServerEvent,ShieldEnabled = thing.ShieldEnabled,StallLevel = thing.StallLevel,FastRefit = thing.FastRefit,ClassicStyle = ClassicStyle,SkinType = SkinType,Damage = Damage,DamageType = DamageType,KillType = KillType,SoundId = SoundId,Volume = Volume,CollisionName = CollisionName,ReColor = ReColor,TurnVisColor = TurnVisColor,Material = Material,Reflectance = Reflectance,WingBaseColor = WingBaseColor,EnableVis = EnableVis,EnableScarf = EnableScarf,EnableMask = EnableMask,EnableCrown = EnableCrown,FirstColor = FirstColor,SkinColor = SkinColor,ShieldSizeVal = ShieldSizeVal,PSX = PSX,Platform = Platform,PlatformOffset = PlatformOffset,PlatformIsSeat = PlatformIsSeat})
			if TauntDetector == thing.Taunt then else
				TauntDetector = thing.Taunt
				ModeDetector = -1
				if typeof(thing.Taunt) == "number" then
					if thing.Taunt > 7 then
						SoundId = CheckId(TauntTable[tonumber(thing.Taunt)],true)
					else
						SoundId = CheckId(SongTable[tonumber(thing.Mode)],false)
					end
				end
			end
			if ModeDetector == tonumber(thing.Mode) then else
				ModeDetector = tonumber(thing.Mode)
				if typeof(thing.Taunt) ~= "number" then
					SoundId = CheckId(SongTable[tonumber(thing.Mode)],false)
				end
			end
		elseif typ == "DoFunctionIdk" then
			Remote:Fire("DoFunctionIdk",thing)
		elseif typ == "KillType" then
			if KillType == "Server" then
				KillType = "Client"
				Remote:Fire("MakeText",{Text = "Changed to Client Kill",ClientSide = true})
			elseif KillType == "Client" then
				KillType = "Server"
				Remote:Fire("MakeText",{Text = "Changed to Server Kill",ClientSide = true})
			else
				KillType = "Server"
				Remote:Fire("MakeText",{Text = "Changed to Server Kill",ClientSide = true})
			end
		elseif typ == "DamageType" then
			if DamageType == "Ray" then
				DamageType = "Distance"
				Remote:Fire("MakeText",{Text = "DamageType Changed to Distance",ClientSide = true})
			elseif DamageType == "Distance" then
				DamageType = "Ray"
				Remote:Fire("MakeText",{Text = "DamageType Changed to Ray",ClientSide = true})
			else
				DamageType = "Ray"
				Remote:Fire("MakeText",{Text = "DamageType Changed to Ray",ClientSide = true})
			end
		elseif typ == "DamageBoolean" then
			Damage = not Damage
			if Damage == true then
				Remote:Fire("MakeText",{Text = "Damage Changed to true",ClientSide = true})
			elseif Damage == false then
				Remote:Fire("MakeText",{Text = "Damage Changed to false",ClientSide = true})
			end
		elseif typ == "KillMode" then
			local Add = KillMode + 1
			if Add > 3 then
				Add = 1
			end
			KillMode = Add
			if KillMode == 1 then
				Remote:Fire("MakeText",{Text = "KillMode Changed to Parts",ClientSide = true})
			elseif KillMode == 2 then
				Remote:Fire("MakeText",{Text = "KillMode Changed to Health",ClientSide = true})
			elseif KillMode == 3 then
				Remote:Fire("MakeText",{Text = "KillMode Changed to Void",ClientSide = true})
			end
		elseif typ == "Kill" then
			print("bang")
		elseif typ == "ClearTable" then
			MakeFunction(function()table.clear(VoidTable)end)
			MakeFunction(function()table.clear(VoidTable2.ClassName)end)
			MakeFunction(function()table.clear(VoidTable2.Locked)end)
			MakeFunction(function()table.clear(VoidTable2.Anchored)end)
			MakeFunction(function()table.clear(VoidTable2.CanCollide)end)
			MakeFunction(function()table.clear(VoidTable2.CanQuery)end)
			MakeFunction(function()table.clear(VoidTable2.CanTouch)end)
			MakeFunction(function()table.clear(VoidTable2.Massless)end)
			Remote:Fire("ClearTable",{})
		elseif typ == "Reset" then
			Remote:Fire("Reset",{})
			Physics:UnregisterCollisionGroup(CollisionName)
			CollisionName = RandomString()
			Physics:RegisterCollisionGroup(CollisionName)
			MakeFunction(function()
				repeat game:GetService("RunService").Heartbeat:Wait() until Physics:IsCollisionGroupRegistered(CollisionName) == true
				Physics:CollisionGroupSetCollidable(CollisionName,CollisionName,false)
			end)
		elseif typ == "CheckPlatform" then
			if thing.Remove then
				Platform,PlatformOffset,PlatformIsSeat = nil,CFrame.new(),false
				pcall(function()
					if LastPlatform:IsA("Seat") or LastPlatform:IsA("VehicleSeat") then
						LastPlatform.Disabled = false
					end
				end)
				LastPlatform = nil
			elseif thing.Part then
				local Part = thing.Part
				if typeof(Part) == "Instance" and Part:IsA("BasePart") then
					pcall(function()
						if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
							PlatformIsSeat = true
							Part.Disabled = true
						end
					end)
					Platform,LastPlatform,PlatformOffset = Part,Part,thing.Offset
				end
			end
		end
	end
end
function FixTheRemoteNOW()
	MakeFunction(function()
		MakeFunction(function()Remote:Destroy();end)
		MakeFunction(function()RemoteF:Disconnect()end)
		Remote = NewRemote()
		RemoteF = Remote.Event:Connect(function(_,a,b)
			RemoteFunc(_,a,b)
		end)
	end)
end
Remote = NewRemote()
RemoteF = Remote.Event:Connect(function(_,a,b)
	RemoteFunc(_,a,b)
end)
pcall(function()
	Player.Character = nil
end)
CharAdded = Player.CharacterAdded:Connect(function()
	local w = Player.Character
	Player.Character = nil
end)
ToolAdded = Backpack.ChildAdded:Connect(function(v)
	v:Destroy()
end)
function BooleanConv(String)
	local Bool = false
	if string.lower(String) == "true" then
		Bool = true
	elseif string.lower(String) == "false" then
		Bool = false
	end
	return Bool
end
Chatted = Player.Chatted:Connect(function(Msg_)
	local Msg,SendMessage = Msg_,true
	if string.sub(Msg,1,3)=="/e "then Msg,SendMessage=string.sub(Msg,4),false;end
	MakeFunction(function()
		if string.sub(Msg,1,11) == "setid/" then
		elseif string.sub(Msg,1,7) == "fixrem/" then
			SendMessage = false
			MakeFunction(function()
				Remote:Destroy()
			end)
		elseif string.lower(string.sub(Msg,1,3)) == "id/" then
			SendMessage = false
			SoundId = string.sub(Msg,4)
			Remote:Fire("MakeText",{Text = "SoundId Changed to: "..SoundId,ClientSide = false})
		elseif string.lower(string.sub(Msg,1,4)) == "vol/" then
			SendMessage = false
			Volume = tonumber(string.sub(Msg,5)) or 0
			Remote:Fire("MakeText",{Text = "Volume Set to: "..tostring(Volume),ClientSide = false})
		elseif string.lower(string.sub(Msg,1,11)) == "mainfolder/" then
			SendMessage = false
			SoundId = CheckId(string.sub(Msg,12),false)
			Remote:Fire("MakeText",{Text = "SoundId Changed to: "..SoundId,ClientSide = false})
		elseif string.lower(string.sub(Msg,1,8)) == "timepos/" then
			SendMessage = false
			Remote:Fire("TimePosition",{TimePos = tonumber(string.sub(Msg,9)) or 0})
		elseif string.lower(string.sub(Msg,1,4)) == "vis/" then
			SendMessage = false
			local Boolean = BooleanConv(string.sub(Msg,5)) or false
			EnableVis = Boolean
			if EnableVis == true then
				Remote:Fire("MakeText",{Text = "Visualizer Enabled",ClientSide = false})
			elseif EnableVis == false then
				Remote:Fire("MakeText",{Text = "Visualizer Disabled",ClientSide = false})
			else
				Remote:Fire("MakeText",{Text = "Invalid Value or Error",ClientSide = false})
			end
		elseif string.lower(string.sub(Msg,1,6)) == "scarf/" then
			SendMessage = false
			local Boolean = BooleanConv(string.sub(Msg,7)) or false
			EnableScarf = Boolean
			if EnableScarf == true then
				Remote:Fire("MakeText",{Text = "Scarf Enabled",ClientSide = false})
			elseif EnableScarf == false then
				Remote:Fire("MakeText",{Text = "Scarf Disabled",ClientSide = false})
			else
				Remote:Fire("MakeText",{Text = "Invalid Value or Error",ClientSide = false})
			end
		elseif string.lower(string.sub(Msg,1,5)) == "skin/" then
			SendMessage = false
			ClassicStyle = true
			local NumVal = math.clamp(tonumber(string.sub(Msg,6) or "a") or 1,1,4)
			SkinType = NumVal
			--
			if SkinType == 1 then
				ReColor,SkinColor,Material,Reflectance = Color3.fromRGB(248,248,248),Color3.fromRGB(127,127,127),Enum.Material.SmoothPlastic,0
			elseif SkinType == 2 then
				ReColor,SkinColor,Material,Reflectance = Color3.fromRGB(100,100,100),Color3.fromRGB(127,127,127),Enum.Material.Granite,0
			elseif SkinType == 3 then
				ReColor,SkinColor,Material,Reflectance = Color3.new(),Color3.new(),Enum.Material.Glass,0
			elseif SkinType == 4 then
				ReColor,SkinColor,Material,Reflectance = Color3.fromRGB(248,248,248),Color3.fromRGB(127,127,127),Enum.Material.SmoothPlastic,0
			end
			MakeFunction(function()
				task.wait(.25)
				Remote:Fire("MakeText",{Text = "Changed SkinType to: "..tostring(NumVal),ClientSide = false})
			end)
		elseif string.lower(string.sub(Msg,1,7)) == "warpcf/" then
			PSX = tonumber(string.sub(Msg,8)) or 0
			Remote:Fire("MakeText",{Text = "CFrame Warping Set to: "..tostring(PSX),ClientSide = false})
		elseif string.lower(string.sub(Msg,1,6)) == "v4ify/" then
			SendMessage = false
			ClassicStyle,SkinType = true,3
			ReColor,SkinColor,Material,Reflectance = Color3.new(),Color3.new(),Enum.Material.Neon,0
			EnableScarf,EnableCrown = true,true
			MakeFunction(function()
				task.wait(.25)
				Remote:Fire("MakeText",{Text = "omg mlcv4 appearance",ClientSide = false})
			end)
		elseif string.lower(string.sub(Msg,1,12)) == "shieldrange/" then
			ShieldSizeVal = tonumber(string.sub(Msg,13)) or 25
			Remote:Fire("MakeText",{Text = "Shield Range Changed to: "..tostring(ShieldSizeVal),ClientSide = false})
		elseif string.lower(string.sub(Msg,1,6)) == "crown/" then
			SendMessage = false
			local Boolean = BooleanConv(string.sub(Msg,7)) or false
			EnableCrown = Boolean
			if EnableCrown == true then
				Remote:Fire("MakeText",{Text = "Crown Enabled",ClientSide = false})
			elseif EnableCrown == false then
				Remote:Fire("MakeText",{Text = "Crown Disabled",ClientSide = false})
			else
				Remote:Fire("MakeText",{Text = "Invalid Value or Error",ClientSide = false})
			end
		elseif string.lower(string.sub(Msg,1,5)) == "mask/" then
			SendMessage = false
			local Boolean = BooleanConv(string.sub(Msg,6)) or false
			EnableMask = Boolean
			if EnableMask == true then
				Remote:Fire("MakeText",{Text = "Mask Enabled",ClientSide = false})
			elseif EnableMask == false then
				Remote:Fire("MakeText",{Text = "Mask Disabled",ClientSide = false})
			else
				Remote:Fire("MakeText",{Text = "Invalid Value or Error",ClientSide = false})
			end
		elseif string.lower(string.sub(Msg,1,8)) == "classic/" then
			SendMessage = false
			local Boolean = BooleanConv(string.sub(Msg,9) or "a") or false
			ClassicStyle = Boolean
			if ClassicStyle == true then
				SkinType = 1
				MakeFunction(function()
					task.wait(.25)
					Remote:Fire("MakeText",{Text = "Classic Appearance Enabled",ClientSide = false})
				end)
				ReColor,SkinColor,Material,Reflectance = Color3.fromRGB(248,248,248),Color3.fromRGB(127,127,127),Enum.Material.SmoothPlastic,0
			elseif ClassicStyle == false then
				SkinType = 1
				MakeFunction(function()
					task.wait(.25)
					Remote:Fire("MakeText",{Text = "Classic Appearance Disabled",ClientSide = false})
				end)
				ReColor,SkinColor,Material,Reflectance = Color3.new(),Color3.new(),Enum.Material.Plastic,0
			else
				Remote:Fire("MakeText",{Text = "Invalid Value or Error",ClientSide = false})
			end
		elseif string.lower(string.sub(Msg,1,4)) == [[say\]] then
			local Split = string.split(string.sub(Msg,5),[[\]])
			Remote:Fire("Say",{Text = Split[1] or "Invalid",TextSound = Split[2] or "rbxasset://"})
		elseif string.lower(string.sub(Msg,1,6)) == "color/" then
			local Split = string.split(string.sub(Msg,7),"/")
			if Split[1] == "hex" then
				local Color = Color3.fromHex(Split[2])
				if tonumber(Split[3] or 1) == 1 then
					ReColor = Color
				elseif tonumber(Split[3] or 1) == 2 then
					FirstColor = Color
				elseif tonumber(Split[3] or 1) == 3 then
					SkinColor = Color
				end
			elseif Split[1] == "rgb" then
				local Color = Color3.fromRGB(Split[2],Split[3],Split[4])
				if tonumber(Split[5] or 1) == 1 then
					ReColor = Color
				elseif tonumber(Split[5] or 1) == 2 then
					FirstColor = Color
				elseif tonumber(Split[5] or 1) == 3 then
					SkinColor = Color
				end
			elseif Split[1] == "brick" then
				local Color = BrickColor.new(Split[2] or "Medium stone grey").Color or BrickColor.new("Medium stone grey").Color
				if tonumber(Split[3] or 1) == 1 then
					ReColor = Color
				elseif tonumber(Split[3] or 1) == 2 then
					FirstColor = Color
				elseif tonumber(Split[3] or 1) == 3 then
					SkinColor = Color
				end
			elseif Split[1] == "def" then
				FirstColor = nil
				if ClassicStyle == true then
					if SkinType == 1 then
						ReColor,SkinColor,Material,Reflectance = Color3.fromRGB(248,248,248),Color3.fromRGB(127,127,127),Enum.Material.SmoothPlastic,0
					elseif SkinType == 2 then
						ReColor,SkinColor,Material,Reflectance = Color3.fromRGB(100,100,100),Color3.fromRGB(127,127,127),Enum.Material.Granite,0
					end
				else
					ReColor,SkinColor,Material,Reflectance = Color3.new(),Color3.new(),Enum.Material.Plastic,0
				end
			elseif Split[1] == "material" then
				local MaterialVal = Enum.Material[Split[2]]
				if typeof(MaterialVal) == "EnumItem" then
					Material = MaterialVal
				end
			elseif Split[1] == "reflectance" then
				local ReflctVal = tonumber(Split[2])
				if typeof(ReflctVal) == "number" then
					Reflectance = ReflctVal
				end
			elseif Split[1] == "wings" then
				local Boolean = BooleanConv(Split[2]) or false
				WingBaseColor = Boolean
			elseif Split[1] == "vis" then
				local Boolean = BooleanConv(Split[2]) or false
				TurnVisColor = Boolean
			end
		end
	end)
	if SendMessage == true then
		MakeFunction(function()Remote:Fire("MakeText",{Text = Msg_,ClientSide = false})end)
	end
end)


