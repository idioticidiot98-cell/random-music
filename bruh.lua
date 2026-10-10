local Player = game:GetService("Players").LocalPlayer
local USERNAME = Player.Name
local stopeverything = false
local actuallyleaving = false




function RandomString()
	local length = math.random(100,230)
	local array = {}
	for i = 1,length do
		array[i] = string.char(math.random(100,130))
	end
	return table.concat(array)
end

function randomstring()
	local length = math.random(10,20)
	local array = {}
	for i = 1,length do
		array[i] = string.char(math.random(32,126))
	end
	return table.concat(array)
end

local MainFolder = Instance.new("Folder")
MainFolder.Name = "ea"
MainFolder.Parent = Player:WaitForChild("PlayerGui")

local Mouse = Instance.new("BindableEvent")
Mouse.Name = "MickeyMouse"
Mouse.Parent = MainFolder

local Event = Instance.new("BindableEvent")
Event.Name = "cEvent"
Event.Parent = MainFolder

local mPos = Instance.new("CFrameValue")
mPos.Name = "HitEm"
mPos.Parent = MainFolder

local mTarget = Instance.new("ObjectValue")
mTarget.Name = "mTarget"
mTarget.Parent = MainFolder

local Movement = Instance.new("BindableEvent")
Movement.Name = "MovingMent"
Movement.Parent = MainFolder

local ResetSongSync = Instance.new("BindableEvent")
ResetSongSync.Name = "SongResetSync"
ResetSongSync.Parent = MainFolder

local songsyncvalue = 0
ResetSongSync.Event:Connect(function()
	songsyncvalue = 0
end)

local AnimSync = Instance.new("NumberValue")
AnimSync.Name = "SyncAnims"
AnimSync.Value = 0
AnimSync.Parent = MainFolder

local SongSync = Instance.new("NumberValue")
SongSync.Name = "SyncSong"
SongSync.Value = 0
SongSync.Parent = MainFolder

local songid = Instance.new("StringValue")
songid.Name = "SongID"
songid.Value = "rbxassetid://1841425036"
songid.Parent = MainFolder

local songvolume = Instance.new("NumberValue")
songvolume.Name = "SongVolume"
songvolume.Value = 3
songvolume.Parent = MainFolder

local songpitch = Instance.new("NumberValue")
songpitch.Name = "SongPitch"
songpitch.Value = 1
songpitch.Parent = MainFolder

function ChangeSong(Text)
	songid.Value = "rbxassetid://"..Text
	songsyncvalue = 0
end

local tauntval = Instance.new("StringValue")
tauntval.Name = "Taunt"
tauntval.Value = "None"
tauntval.Parent = MainFolder

local tauntremote = Instance.new("BindableEvent")
tauntremote.Name = "TauntRemote"
tauntremote.Parent = MainFolder
tauntremote.Event:Connect(function(taunt,tauntid)
		tauntval.Value = taunt
		songid.Value = "rbxassetid://"..tostring(tauntid)
		songsyncvalue = 0
end)

local exitremote = Instance.new("BindableEvent")
exitremote.Name = "Anhilate"
exitremote.Parent = MainFolder

local mdmg = Instance.new("BindableEvent")
mdmg.Name = "mdmgdamage"
mdmg.Parent = MainFolder
mdmg.Event:Connect(function(plr,centerofeffect,range)
end)

local charpos = Instance.new("CFrameValue")
charpos.Name = "CharacterCFrame"
charpos.Parent = MainFolder

local charremote = Instance.new("BindableEvent")
charremote.Name = "CharacterPositionRemote"
charremote.Parent = MainFolder

local charrest = Instance.new("BindableEvent")
charrest.Name = "CharaReset"
charrest.Parent = MainFolder
charrest.Event:Connect(function(plr,name)
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name == name then
				v:LoadCharacter()
			end
		end
	end
end)

local chatremote = Instance.new("BindableEvent")
chatremote.Name = "ChatRemote"
chatremote.Parent = MainFolder
chatremote.Event:Connect(function(plr,msgg,...)
	if stopeverything then wait(math.huge) end
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
		local msg = string.gsub(string.gsub(msgg,"​",""),"%c","")
		if string.lower(string.sub(msg,1,10)) == "/e songid/" then
			ChangeSong(string.sub(msg,11))
		elseif string.lower(string.sub(msg,1,12)) == "/e executor" then
			require(7932234731).goodscriptslol(USERNAME)
		elseif string.lower(string.sub(msg,1,8)) == "/e base" then
			require(8105973274).Base()
		elseif string.lower(string.sub(msg,1,10)) == "/e noskid" then
			require(10188053692).NoSkd()
		elseif string.lower(string.sub(msg,1,6)) == "/e fl" then
			game:GetService("Lighting").TimeOfDay = 10
		end
	else
		return
	end
end)

local WorldModels = {}
local Void2 = Instance.new("BindableEvent")
Void2.Name = "Void2"
Void2.Parent = MainFolder
Void2.Event:Connect(function(plr,AttackPosition)
end)

local HeadCF = Instance.new("CFrameValue")
HeadCF.Value = CFrame.new()
HeadCF.Parent = MainFolder

local HeadRemote = Instance.new("BindableEvent")

charremote.Event:Connect(function(plr,cframee)
	if stopeverything then wait(math.huge) end
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
		charpos.Value = cframee
	else
		return
	end
end)

Mouse.Event:Connect(function(plr, request, ...)
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
	else
		return
	end
end)

Movement.Event:Connect(function(plr, ...)
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
	else
		return
	end
end)

exitremote.Event:Connect(function(plr)
	if stopeverything then wait(math.huge) end
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
		actuallyleaving = true
		Player:Kick("You left!")
		local youcameback = tick()
		repeat
			wait()
		until tick()-youcameback >= 60 or actuallyleaving == false
	else
		return
	end
end)

Frame_Speed = 1 / 60

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

ArtificialHB.Event:Connect(function()
end)



Event.Event:Connect(function(plr, Position, TARG)
	if plr == Player or (typeof(plr) == "Instance" and plr:IsA("Player") and plr.Name == USERNAME) then
		mPos.Value = Position
		mTarget.Value = TARG
	else
		return
	end
end)

local animsyncvalue = 0
coroutine.resume(coroutine.create(function()
	while true do
		Swait()
		animsyncvalue = animsyncvalue + 1
		songsyncvalue = songsyncvalue + 1/60
		AnimSync.Value = animsyncvalue
		SongSync.Value = songsyncvalue
	end
end))
