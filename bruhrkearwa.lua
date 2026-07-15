local _VERSION = 2.3
local asset = game:GetObjects("rbxassetid://13194994429")[1]
local script = asset:WaitForChild("Jeremy"):WaitForChild("0.2.3")

--[[
//Fake Character client replicator template V2\\
                     
                   --JEREMY--      
                  
      
        
        
--please note this is a heavy script, low end pc's are not recommended

--Update support ended

\\____________________________________________//
]]


local LOADED = true
local plrr = game.Players.LocalPlayer
local Players = game:GetService("Players")
local Player = game.Players.LocalPlayer
local RunService,systemParent,JointsService,TweenService,Debris,gameID = game:GetService("RunService"),game:GetService("TextChatService"),game:GetService("JointsService"),game:GetService("TweenService"),game:GetService("Debris"),game.GameId
local CF,IT,ANGLE,RAD,VT,RNDM,BRICKC,TD,MC,MS,aSin,aTan,ABS,Insert,Find=CFrame.new,Instance.new,CFrame.Angles,math.rad,Vector3.new,math.random,BrickColor.new,task.defer,math.clamp,math.sin,math.asin,math.atan,math.abs,table.insert,table.find
local Stopped,USERID,PLRNAME,PLRCharacter = false,Player.UserId,Player.Name,Player.Character
local MainPosition,CameraCF,MouseHIT = CF(0,60,0),CF()
local TT = 1
local walking,falling,jumping,fallspeed,onground,Nilled,attacking,drinking=false,false,false,0,false,false,false,false
local csr = script local Folder = csr.Lightning local Tick = Folder.tick Tick.Value = TT local SavingFolder = Folder.tables
local FolderName,RemoteName,ServerValueName,MainPositionValueName,MouseHitValueName,AnimValueName,MusicValueName,VolumeValueName,ModeValueName,SteppedValueName=string.reverse(USERID).."3957-92I73.9879-872.698-79I06.089-3216-379"..string.reverse(-gameID-5)..TT,"R1","R2","R3","R4","R5","R6","R7","R8","R9"
local MainFolderBackUp,RemoteBackUp,ServerValueBackUp,MainPositionValueBackUp,MouseHitValueBackUp,MusicValueBackUp,VolumeValueBackUp,ModeValueBackUp,SteppedValueBackUp
local MainFolder,Remote,ServerValue,MainPositionValue,MouseHitValue,MusicValue,ModeValue,SteppedValue
local W,A,S,D=false,false,false,false
local Run,Stepped = RunService.Heartbeat,RunService.Stepped
local WarnMessage,warning="low server frames",false
local CLIENTPART = IT("Part")
local wthMessages = {
	"yep",
	"Another day another dollar, just to suffer",
	"Jeremy is my name",
	"Sometimes its just all about the mets",
	"what you saw the other day was a guy dealing with pests",
	string.reverse("commit no breath"),
	"bogus",
	"currently doing the funni",
	"💀",
	"no.",
	"yes.",
	"currently having a identity crisis",
	"lemon",
	"Catchphrase"
}
local SoundTracks = {0,1837008684,1838857104,1837070127,1842652230,9048375035,7023635858,5410082879,1843497734,5410082534,1842892836}
local SoundTrack2 = {}  -- keep this empty
local FIGURE=nil
local Fixing=false
local CurrentTarget = nil
local CurrentColor = 1
local antilagMode,BREAK,ShiftLocked=false,false,false
local KilledParts = {}
local MainTaunt,CurrentSong,TIME,VOLUME = "1",2,0,3
local CurrentId = SoundTracks[CurrentSong]
local MoveSpeed = 0.1
local CurrentMoveSpeed = MoveSpeed
local MoveDirector = VT()

local CHTCOMMANDS = {
	"ID";  --1
	"Clear";  --2
	"Play" --3
}
function Serv(s0)
	return game:GetService(s0)
end
local CurrentService = 2
local Services = {
	Serv("Chat");
	Serv("TextChatService");
	Serv("ReplicatedStorage");
	Serv("JointsService");
	Serv("Workspace");
	Serv("SoundService");
	Serv("Lighting");
	Serv("Players");
	Serv("MaterialService");
}

function SwitchService()
	CurrentService = CurrentService + 1
	if CurrentService>tonumber(#Services) then
		CurrentService = 1
	end
	systemParent = Services[CurrentService]
	return systemParent
end


local FPSLIMIT = 60



if PLRCharacter~=nil then
	local Pos = PLRCharacter:FindFirstChildOfClass("MeshPart") or PLRCharacter:FindFirstChildOfClass("Part")
	if Pos~=nil then
		MainPosition=Pos.CFrame*ANGLE(0,RAD(180),0)
	end
end



function WAIT(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end 

ArtificialHB = IT("BindableEvent")


function bart(Variable,PARENT,NAME)
	if Variable.Parent~=PARENT then
		Variable.Parent=PARENT
	else
		if Variable.Archivable~=false then
			Variable.Archivable=false
		end
		if Variable.Name~=NAME then
			Variable.Name=NAME
		end
	end
end

function FIX()
end



function WaitFor(PARENT,NAME,CLASSNAME)
	local Prox
	while true do
		if Stopped then return nil end
		if PARENT.Parent==nil then return nil end
		Prox = PARENT:FindFirstChild(NAME)
		if Prox~=nil then
			if Prox.ClassName==CLASSNAME then
				return Prox
			else
				Prox.Parent=nil
				task.wait()
			end
		else
			task.wait()
		end
	end
end

function NILWaitFor(PARENT,NAME,CLASSNAME)
	local Prox
	while true do
		if Stopped then return nil end
		Prox = PARENT:FindFirstChild(NAME)
		if Prox~=nil then
			if Prox.ClassName==CLASSNAME then
				return Prox
			else
				Prox.Parent=nil
				task.wait()
			end
		else
			task.wait()
		end
	end
end


function CLIENT(PLRR)
	local SaveFolder = script.Lightning.tables
	local sus,sy = pcall(function()
		for h = 1,#KilledParts do
			Instance.new("ObjectValue",SaveFolder).Value=KilledParts[h]
		end
	end)
	if not sus then
		FireClient(nil,nil,"warn",nil,sy)
	end
end



function an()
	local spown = nil
	for o,b in pairs(workspace:GetDescendants()) do
		if b:IsA("SpawnLocation") then
			spown = b 
		end
	end

	if spown~=nil then
		MainPosition = CF(spown.Position.X,spown.Position.Y+(spown.Size.Y/2)+3,spown.Position.Z)
	else
		MainPosition = CF(0,200,0) fallspeed=0
	end
	print(MainPosition)
end


-------------Creating function value's

MainFolderBackUp = Instance.new("Folder") MainFolderBackUp.Name=FolderName
RemoteBackUp = Instance.new("BindableEvent") RemoteBackUp.Name=RemoteName
ServerValueBackUp = Instance.new("NumberValue") ServerValueBackUp.Name=ServerValueName
MainPositionValueBackUp = Instance.new("CFrameValue") MainPositionValueBackUp.Name=MainPositionValueName MainPositionValueBackUp.Value=MainPosition
MouseHitValueBackUp = Instance.new("CFrameValue") MouseHitValueBackUp.Name=MouseHitValueName
AnimationValueBackUp = Instance.new("NumberValue") AnimationValueBackUp.Name=AnimValueName
MusicValueBackUp = Instance.new("NumberValue") MusicValueBackUp.Name=MusicValueName MusicValueBackUp.Value=CurrentId
VolumeValueBackUp = Instance.new("NumberValue") VolumeValueBackUp.Name=VolumeValueName VolumeValueBackUp.Value=VOLUME
ModeValueBackUp = Instance.new("NumberValue") ModeValueBackUp.Name=ModeValueName ModeValueBackUp.Value=MainTaunt
SteppedValueBackUp = Instance.new("Vector3Value") SteppedValueBackUp.Name=SteppedValueName SteppedValueBackUp.Value=MoveDirector

---------------------------

function FireClient(KEY,KEYDOWN,MSGG,PRTT,CHATMSS,mous)
	coroutine.resume(coroutine.create(function()
		if not Remote:IsDescendantOf(game) then
			repeat WAIT() until Remote:IsDescendantOf(game) end	
		Remote:Fire(USERID,KEY,KEYDOWN,MSGG,PRTT,CHATMSS,mous)
	end))
end










function spambreak(fatty)
	coroutine.resume(coroutine.create(function()
		while true do
			if Stopped then break end
			if (fatty:IsDescendantOf(workspace) or fatty:IsDescendantOf(JointsService)) and not BREAK then
				local sou = fatty:FindFirstChildOfClass'Sound' if sou then sou:Destroy() end
				fatty.Transparency=1 
			else
				break
			end
			WAIT()
		end
	end))

end


function tween(host,frame,smoothness)
	local info=TweenInfo.new(smoothness)local goal={}goal.CFrame=frame goal.Size = Vector3.new(0,0,0) goal.Transparency=1 local tw=TweenService:Create(host,info,goal)tw:Play()
end

function VOID(v)
	local dd
	coroutine.resume(coroutine.create(function()
		pcall(function()

			v.Anchored=true
			tween(v,CF(9e9,9e9,9e9),0.7)
			dd = v:GetPropertyChangedSignal("CFrame"):Connect(function()
				tween(v,CF(9e9,9e9,9e9),0.7)
			end)
			coroutine.resume(coroutine.create(function()
				pcall(function()
					spambreak(v)
				end)
			end))
			while v:IsDescendantOf(game) and not BREAK do WAIT()
			end
			FireClient(nil,nil,"break",nil)
			task.wait()
			dd:Disconnect() 
			v:Destroy()
		end)
	end))
	spawn(function()
		if antilagMode then
			warn("AutoCleared tables! -- {Jeremy the lightning Cannon V1}")
			table.clear(KilledParts)
			FireClient(nil,nil,"break")
			BREAK=true
			WAIT(20)
			BREAK=false
		end end)
end




function Break(P)
	pcall(function()
		for e,a in pairs(P:GetDescendants()) do
			local H
			if a.Parent~=nil then H = a.Parent:FindFirstChildOfClass("Humanoid")end
			if a:IsA("UnionOperation") then	a.UsePartColor=true end
			if a:IsA("Sound") then a:Destroy() end if a.Parent~=nil and a.Parent:IsA("Model") and H then H.MaxHealth=0	H.Health=0	H.WalkSpeed=0	H.PlatformStand=true  if a.Parent:FindFirstChildOfClass("Sound") then a.Parent:FindFirstChildOfClass("Sound"):Destroy() end end 
			if a:IsA("Weld") or a:IsA("WeldConstraint") or a:IsA("BallSocketConstraint") or a:IsA("Attachment") or a:IsA("Constraint") or a:IsA("HingeConstraint") or a:IsA("WrapTarget") or a:IsA("WrapLayer") or a:IsA("Decal") or a:IsA("Texture") then
				a:Destroy()
			end
			if a:IsA("BasePart") or a:IsA("FlagStand") or a:IsA("MeshPart") or a:IsA("TrussPart") or a:IsA("SpawnLocation") then
				a:BreakJoints()
			end
		end
		if P:IsA"MeshPart" then
			P.TextureID=""
		end	 end)
	--P:BreakJoints()
end

function BREAKJoints(P)
	pcall(function()
		for e,a in pairs(P:GetDescendants()) do
			local H
			if  a:IsA("Attachment") or a:IsA("WrapTarget") or a:IsA("WrapLayer") then
				a:Destroy()
			end
			if a:IsA("Weld") or a:IsA("Motor") or a:IsA("Motord6D") or a:IsA("ManualGlue") or a:IsA("ManualWeld") or a:IsA("Snap") or a:IsA("WeldContraint") or a:IsA("BallSocketConstraint") or a:IsA("HingeConstraint") then
				a.Enabled=false
			end
			if a:IsA("Humanoid") then
				a.RequiresNeck=false
			end
		end
	end)
end


function DestroyAndClear(tab)
	pcall(function()
		for k = 1,#tab do
			local kid = tab[k]
			if kid:IsA("BasePart") then
				kid:Destroy()
			end
		end end)
end

function OnServer(REMOTE)
	REMOTE.Event:Connect(function(PLR,ID,CMCFR,MPS,KEY,KEYDOWN,CLIENTPART,TABLE,USERR)

		if CMCFR~=nil then CameraCF=CMCFR end
		if CLIENTPART~=nil then
			if not Find(KilledParts,CLIENTPART) then
				Insert(KilledParts,CLIENTPART)

				FireClient(nil,nil,"SERVERPART",CLIENTPART)
				BREAKJoints(CLIENTPART)
				if USERR==true then
					CLIENTPART.Name=RNDM()
					Break(CLIENTPART) 
					--CLIENTPART.Position=VT(9e9,9e9,9e9)	
					CLIENTPART.Anchored=true	
					return
				else
					Break(CLIENTPART) 
					--CLIENTPART.Position=VT(9e9,9e9,9e9)	
					CLIENTPART.Anchored=true
					return
				end
			end
		end

		if TABLE=="system" and Nilled==false then
			ArtificialHB:Fire()
			if Nilled==false then
				system()end
			return
		end

		if TABLE=="check" and USERR~=nil and USERR~=CurrentTarget then
			CurrentTarget=USERR
			FireClient(nil,nil,"print",nil,"Connection terminated from "..tostring(USERR))
			local plrs = Players:GetChildren()
			for i = 1,#plrs do
				if plrs[i]:IsA"Player" then
					if plrs[i]==USERR and USERR:IsDescendantOf(game) and USERR~=Player then
						FireClient(nil,nil,"warn",nil,plrs[i].Name.." is fake nilled!")

						--plrs[i]:Kick"Do not client nil yourself"
						--plrs[i]:Destroy()
						--FireClient(nil,nil,"print",nil,"connection terminated from "..tostring(USERR))
						break
					end
				end
			end

			return 
		elseif TABLE=="SHIFTLOCKED" then
			ShiftLocked=true
			return
		elseif TABLE=="UNLOCKED" then
			ShiftLocked=false
			return
		elseif TABLE=="TELEPORT" then
			if attacking then repeat WAIT() until attacking==false  or Stopped
			end
			local D1 = CF(MainPosition.X,0,MainPosition.Z)
			local D2 = CF(MouseHIT.X,0,MouseHIT.Z)
			local Height = (MouseHIT.Y-MainPosition.Y)
			local Distance = (D1.p - D2.p).Magnitude	
			MainPosition = CF(MainPosition.Position,VT(MouseHIT.Position.x,MainPosition.Position.y,MouseHIT.Position.z))*ANGLE(0,RAD(180),0)*CF(0,Height,Distance)
			FireClient(KEY,KEYDOWN,"teleport2",nil,nil,{MouseHIT,MainPosition})
		elseif type(TABLE) == "table" then 
			--Modes
			if TABLE[1]=="CHANGE" and TABLE[2]~=nil and TABLE[3]~=nil then
				if MoveSpeed~=TABLE[2] then
					MoveSpeed=TABLE[2] 
				end
				if attacking~=TABLE[3] then
					attacking=TABLE[3] 
				end
				if attacking==true then
					FireClient(KEY,KEYDOWN,"yield",nil,nil,nil)
				end
			elseif TABLE[1]=="yield" and TABLE[2]~=nil and TABLE[3]~=nil then
				if TABLE[2]==true and attacking~=true then
					--FireClient(nil,nil,"print",nil,"Player "..TABLE[3].Name.." has replication delay")
					FireClient(KEY,KEYDOWN,"DELAYED",TABLE[3],nil,nil)
				end
			end


		end

		
		if KEY~=nil then
			if KEY~=nil then
				local OldTaunt = MainTaunt
				FireClient(KEY,KEYDOWN)
				if KEY=="w" and KEYDOWN then
					W=true
				elseif KEY=="w" and not KEYDOWN then
					W=false
				elseif KEY=="a" and KEYDOWN then
					A=true
				elseif KEY=="a" and not KEYDOWN then
					A=false
				elseif KEY=="s" and KEYDOWN then
					S=true
				elseif KEY=="s" and not KEYDOWN then
					S=false
				elseif KEY=="d" and KEYDOWN then
					D=true
				elseif KEY=="d" and not KEYDOWN then
					D=false
				elseif KEY=="g" and KEYDOWN then
					CurrentId=nil
				elseif KEY=="k" and KEYDOWN then
					CurrentSong=CurrentSong+1
					if CurrentSong>#SoundTracks then
						CurrentSong=1
					end					
					CurrentId=SoundTracks[CurrentSong]
				elseif KEY and typeof(KEY) == "string" and (KEY:byte()==32 or KEY=="j") and KEYDOWN then
					if onground == true then
						onground=false fallspeed=fallspeed-1 MainPosition=MainPosition*CF(0,2,0)
					end
				elseif KEY=="m" and KEYDOWN then
					an()
				elseif KEY=="p" and KEYDOWN then
					warn("Cleared tables")
					DestroyAndClear(KilledParts)
					table.clear(KilledParts)
					FireClient(nil,nil,"break")
					BREAK=true
					WAIT(20)
					BREAK=false
				elseif KEY=="z" and KEYDOWN and MainTaunt=="1" and not attacking then
					attacking=true
					FireClient(KEY,KEYDOWN,"teleport",nil,nil,MouseHIT)
				elseif KEY=="e" and KEYDOWN and not attacking then
					if MainTaunt=="1" then 
						attacking=true
						FireClient(KEY,KEYDOWN,"shoot",nil,nil,MouseHIT)
					elseif MainTaunt=="2" then
						drinking=true
						FireClient(KEY,KEYDOWN,"getting mugged",nil,nil,MouseHIT) --Totally did not re-use the shoot command as taunt
						WAIT(90)
						drinking=false
					end
				elseif KEY=="r" and KEYDOWN and not attacking then
					if MainTaunt=="1" then 
						attacking=true
						FireClient(KEY,KEYDOWN,"firearc",nil,nil,MouseHIT.p)
					end
				elseif KEY=="t" and KEYDOWN and not attacking then
					if MainTaunt=="1" then 
						attacking=true
						FireClient(KEY,KEYDOWN,"singularbeam",nil,nil,MouseHIT.p)
					end
				elseif KEY=="-" and KEYDOWN then
					FireClient(nil,nil,"say",nil,wthMessages[RNDM(1,#wthMessages)])
				elseif KEY=="q" and KEYDOWN then
					resetList()
				elseif KEY=="1" and KEYDOWN and not attacking then
					if MainTaunt~=KEY then
						MainTaunt=KEY end
				elseif KEY=="2" and KEYDOWN and not attacking then
					if MainTaunt~=KEY then
						MainTaunt=KEY end
				elseif KEY=="3" and KEYDOWN and not walking and not attacking then
					if MainTaunt~=KEY then
						MainTaunt=KEY end
				elseif KEY=="4" and KEYDOWN and not walking and not attacking then
					if MainTaunt~=KEY then
					end
				end	







			end
		end
	end)
end

function FixFolder()
	MainFolder = MainFolderBackUp:Clone() 
	Remote = RemoteBackUp:Clone() Remote.Parent=MainFolder
	ServerValue = ServerValueBackUp:Clone() ServerValue.Parent=MainFolder 
	MainPositionValue = MainPositionValueBackUp:Clone() MainPositionValue.Parent=MainFolder
	MouseHitValue = MouseHitValueBackUp:Clone() MouseHitValue.Parent=MainFolder 
	MoveValue = AnimationValueBackUp:Clone() MoveValue.Parent=MainFolder
	MusicValue = MusicValueBackUp:Clone() MusicValue.Parent=MainFolder
	VolumeValue = VolumeValueBackUp:Clone() VolumeValue.Parent=MainFolder
	ModeValue = ModeValueBackUp:Clone() ModeValue.Parent=MainFolder
	SteppedValue = SteppedValueBackUp:Clone() SteppedValue.Parent=MainFolder
	MainFolder.Parent=systemParent 
	OnServer(Remote) FIX()
end

function remt(obj)
	if Stopped then Removing:Disconnect() return end
	if (obj==MainFolder or obj==Remote or obj==ServerValue or obj==MainPositionValue or obj==MouseHitValue or obj==MusicValue) and not Fixing then
		Fixing=true
		SwitchService()
		MainFolder:Destroy()
		FixFolder() Fixing=false
		FireClient(nil,nil,"warn",nil,"folder was deleted")
	end
	if obj==Player and Nilled==false then
		W,A,S,D=false,false,false,false
		Nilled=true
	end
end

Removing = game.DescendantRemoving:Connect(function(obj)
	TD(remt,obj)
end)

-------------Other stuff




function GetID(ID,w)
	local num = nil
	for prox = 1,#SoundTracks do
		if ID-SoundTracks[prox]==0 then
			return true
		end
	end
	return ID

end

function TN1()
	Fixing=true
	SwitchService()
	MainFolder:Destroy()
	FixFolder() Fixing=false
	FireClient(nil,nil,"warn",nil,"folder was deleted")
end

function resetList()
	if SoundTrack2[1]==nil then 
		FireClient(nil,nil,"say",nil,"there are no soundtracks to remove.")
		return end
	for KK2 = 1,#SoundTrack2 do
		local ADDEDTRACK = SoundTrack2[KK2]

		for KK1 = 1,#SoundTracks do
			local OLDTRACK = SoundTracks[KK1]


			for gh = 1,#SoundTracks do
				local OLDTRACK = SoundTracks[gh]
				if OLDTRACK~=nil then
					if OLDTRACK-ADDEDTRACK==0 then
						print("Removed ID "..OLDTRACK.." from playlist")
						table.remove(SoundTracks,gh)
					end
				end
			end
		end		
	end

	FireClient(nil,nil,"say",nil,"Playlist has been reset")

	table.clear(SoundTrack2)
end

function ChatCommand()
	local Chatted
	Chatted = Player.Chatted:Connect(function(msg)
		if msg=="g/r" then
			Stopped=true
			DestroyAndClear(KilledParts)
			table.clear(KilledParts)
			FireClient(nil,nil,"STOP",nil)
			Chatted:Disconnect()
			wait()
			Player:LoadCharacter()
			MainFolder:Destroy()
			script:Destroy()
		end
		if msg=="/e fix" then
			TN1() return
		end
		if msg=="/e nil" then
			Player:Destroy() return
		end
		if msg=="/e dance" and not attacking then
			MainTaunt="3"
		end
		local MSG1 = msg:split(" ")
		if (MSG1[1]==CHTCOMMANDS[1] or MSG1[1]==CHTCOMMANDS[3]) then
			print(MSG1[1])
			local IDD = MSG1[2]
			if IDD~=nil then
				if tonumber(IDD)==nil then return end
				CurrentId=IDD
				print(CurrentId)
				if MSG1[1]==CHTCOMMANDS[1] then
					local saidID = GetID(IDD)
					if saidID~=true then
						Insert(SoundTrack2,saidID)
						Insert(SoundTracks,saidID)
					end
				end
			end
			return
		elseif MSG1[1]=="Vol" or MSG1[1]=="VOL" then
			local volume = MSG1[2]
			if volume~=nil then
				VOLUME=volume
				print("Set Volume to "..VOLUME)
			end
			return
		elseif MSG1[1]==CHTCOMMANDS[2] then
			resetList()
			return
		elseif MSG1[1]==";cmds" or MSG1[1]==";CMDS" or MSG1[1]=="!jeremy" then
			local mess = ""
			for b = 1,#CHTCOMMANDS do
				mess = mess.." "..b.."-"..tostring(CHTCOMMANDS[b])
			end
			FireClient(nil,nil,"say",nil,"Commands:")
			task.wait()
			FireClient(nil,nil,"say",nil,mess)
			return
		elseif MSG1[1]=="/e" or MSG1[1]=="/e " then
			return
		end


		FireClient(nil,nil,"say",nil,msg)
	end)
end


Added = Players.PlayerAdded:Connect(function(PLR)
	if Stopped then Added:Disconnect() return end
	if PLR.UserId-USERID==0 then
		wait()
		Nilled=false
		Player=PLR
		wait()
		CLIENT(Player)
		ChatCommand()
	else
		wait()
		CLIENT(PLR)
	end
	WAIT(5)
end)



---------------------------------------

function CreateTable(model1,model2)
	local MainTable = {}
	pcall(function()
		local Ign1 = model1:GetDescendants()
		local Ign2 = model2:GetDescendants()
		for k = 1,#Ign1 do
			local kid = Ign1[k]
			if kid:IsA("BasePart") then
				Insert(MainTable,kid)
			end
		end
		for k = 1,#Ign2 do
			local kid = Ign2[k]
			if kid:IsA("BasePart") then
				Insert(MainTable,kid)
			end
		end
	end)
	return MainTable
end

function cast(Start,End,Distance,Ignore)
	local Hit,Pos,Mag,Table = nil,nil,0,{}
	local B,V = workspace:FindPartOnRayWithIgnoreList(Ray.new(Start,((CF(Start,End).lookVector).unit) * Distance),(Ignore or {}))
	if B ~= nil then
		local BO = (Start - V).Magnitude
		Insert(Table,{Hit = B,Pos = V,Mag = BO})
	end
	for i,g in pairs(workspace:GetDescendants()) do
		if g:IsA("WorldModel") then
			local N,M = g:FindPartOnRayWithIgnoreList(Ray.new(Start,((CF(Start,End).lookVector).unit) * Distance),(Ignore or {}))
			if N ~= nil then
				local BO = (Start - M).Magnitude
				Insert(Table,{Hit = N,Pos = M,Mag = BO})
			end
		end
	end
	for i,g in pairs(Table) do
		if i == 1 then
			Mag = Table[i].Mag
		end
		if Table[i].Mag <= Mag then
			Mag = Table[i].Mag
			Hit = Table[i].Hit
			Pos = Table[i].Pos
		end
	end
	return Hit,Pos
end





function Raycast()
	pcall(function()
		local touchedground,hitpos = cast(MainPosition*CF(0,2,0).p,MainPosition*CF(0,-2,0).p,6.5,KilledParts)
		if touchedground~=nil then
			onground=true
			jumping=false falling=false
			fallspeed=0
			MainPosition=MainPosition*CF(0,hitpos.Y-MainPosition.Y+3,0)
		else
			onground=false
			if fallspeed<0 then
				jumping=true
				falling=false
			else
				jumping=false
				falling=true
			end
			MainPosition = MainPosition-Vector3.new(0,fallspeed,0)
			if fallspeed<3 then
				fallspeed=fallspeed+0.06
			end
			coroutine.resume(coroutine.create(function()
				pcall(function()
					local ant=MainPosition.Y
					if ant<-89 then
						MainPosition=MainPosition+Vector3.new(0,200,0) fallspeed=0
					end
				end)
			end))
		end  end)  
end

function MusicEvent()
	if MusicValue.Value~=CurrentId or VolumeValue.Value~=VOLUME then
		MusicValueBackUp.Value=CurrentId
		MusicValue.Value=CurrentId
		VolumeValueBackUp.Value=VOLUME
		VolumeValue.Value=VOLUME
	end
end

function ModeEvent()
	if ModeValue.Value~=MainTaunt then
		ModeValueBackUp.Value=MainTaunt ModeValue.Value=MainTaunt
	end
end

function Values()
	if MainPositionValue~=nil and MainPositionValue.Parent~=nil then
		pcall(function()
			MainPositionValueBackUp.Value=MainPosition
			MainPositionValue.Value=MainPosition
		end)
	end
	if SteppedValue~=nil and SteppedValue.Parent~=nil then
		SteppedValue.Value=MoveDirector SteppedValueBackUp.Value=MoveDirector
	end
	if ServerValue~=nil and ServerValue:IsDescendantOf(game) then
		TIME = TIME + 1
		ServerValue.Value=TIME
		if TIME>10000 then
			TIME=0
		end
	end
	if MoveValue.Parent~=nil then
		if onground and not walking then
			MoveValue.Value=1       	AnimationValueBackUp.Value=1
		elseif onground and walking and not jumping and not falling then
			MoveValue.Value=2			AnimationValueBackUp.Value=2
		elseif not onground and (walking or not walking) and jumping and not falling then
			MoveValue.Value=3			AnimationValueBackUp.Value=3
		elseif not onground and (walking or not walking) and not jumping and falling then
			MoveValue.Value=4			AnimationValueBackUp.Value=4
		end	

	end
end

function getObjectSpace(valid1,valid2)
	if typeof(valid1) ~= "CFrame" or typeof(valid2) ~= "CFrame" then
		warn("Bad MoveDirector values", valid1, valid2)
		return Vector3.zero
	end

	local TURN = valid1.Position - valid2.Position
	local almovedir = (valid1 * ANGLE(0,RAD(90),0)):VectorToObjectSpace(TURN)
	return almovedir
end

function MoveTo(Turn)
	MainPosition=MainPosition:Lerp(CF(MainPosition.p,VT(MainPosition.X-CameraCF.LookVector.X,MainPosition.Y,MainPosition.Z-CameraCF.LookVector.Z))*Turn,0.08) 
end



function system()
	FIX()Raycast()Values()MusicEvent()ModeEvent()	
	local Oldpos = MainPosition
	if ((W and not S) or (A and not D) or (S and not W) or (D and not A)) then
		if tonumber(MainTaunt)==3 then
			MainTaunt="1"
		end
		if MoveSpeed>0 then
			walking=true
		else
			walking=false
		end
		if (W and A) or (W and D) or (S and A) or (S and D) then
			CurrentMoveSpeed=MoveSpeed/1.4
		else
			CurrentMoveSpeed=MoveSpeed
		end
		if W  then MoveTo(CF(0,0,CurrentMoveSpeed)) end
		if S  then MoveTo(CF(0,0,-CurrentMoveSpeed)*ANGLE(0,RAD(-180),0))end
		if A  then MoveTo(CF(CurrentMoveSpeed,0,0)*ANGLE(0,RAD(90),0))end
		if D  then MoveTo(CF(-CurrentMoveSpeed,0,0)*ANGLE(0,RAD(-90),0))end

		if attacking==true then
			MainPosition = CF(MainPosition.Position,VT(MouseHIT.Position.x,MainPosition.Position.y,MouseHIT.Position.z))*ANGLE(0,RAD(180),0)
		end
	else walking=false if attacking then MainPosition = CF(MainPosition.Position,VT(MouseHIT.X,MainPosition.Y,MouseHIT.Z))*ANGLE(0,RAD(180),0) end end 
	if ShiftLocked==true and attacking~=true then
		MainPosition=CF(MainPosition.p,VT(MainPosition.X-CameraCF.LookVector.X,MainPosition.Y,MainPosition.Z-CameraCF.LookVector.Z))
	end
	MoveDirector = getObjectSpace(MainPosition,Oldpos)
end








FixFolder()
ChatCommand()


local fpsFrame

LOOP2 = Stepped:Connect(function()
	if Stopped then LOOP2:Disconnect()  return end
	if Player~=nil and Player.Parent~=nil then
		if Player.Character~=nil then Player.Character=nil end
	end
	if Nilled==true or LOADED==false or Fixing==true then
		system()end
end)


spawn(function()
	while not Stopped do task.wait(5)
		fpsFrame = 2/wait()
		if fpsFrame<FPSLIMIT then	
			if not warning then
				warning=false
				antilagMode=false
			end 
		elseif fpsFrame>FPSLIMIT then
			if warning==true then
				warning=false
			end
		end


	end 
end)

for i,g in pairs(Players:GetChildren()) do
	if g:IsA("Player") then
		CLIENT(g)
	end
end


FireClient(nil,nil,"say",nil,"Recreation made by Protofer_S")
FireClient(nil,nil,"warn",nil,"Template version ".._VERSION.." loaded")
