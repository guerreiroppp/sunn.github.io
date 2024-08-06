local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local TitleHub = "Sun Hub"
local ImageHub = 4483362458

-- AIMBOT CONFIGS VALUES --

local aimbotEnabled1 = false
local aimbotEnabled = false
local aimKey  = "E"
local aimAssistLevel = 0.3 
local maxDistance = 100 
local smoothness = 0.2
local TEAM_IGNORE = false

-- AIMBOT FUNCTIONS --

local function getClosestVisiblePlayer()
    local closestPlayer
    local shortestDistance = maxDistance

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not TEAM_IGNORE or player.Team ~= LocalPlayer.Team then
                local targetPos = player.Character.HumanoidRootPart.Position
                local distance = (targetPos - LocalPlayer.Character.HumanoidRootPart.Position).magnitude

                if distance < shortestDistance then
                    local ray = Ray.new(Camera.CFrame.Position, (targetPos - Camera.CFrame.Position).unit * maxDistance)
                    local part, position = workspace:FindPartOnRay(ray, LocalPlayer.Character, false, true)
                    
                    if part and part:IsDescendantOf(player.Character) then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end

    return closestPlayer
end

local Window = ArrayField:CreateWindow({
	Name = TitleHub,
	LoadingTitle = TitleHub,
	LoadingSubtitle = "Inicializando...",
	ConfigurationSaving = {
	   Enabled = true,
	   FolderName = 'Sun', 
	   FileName = "SunHun"
	},
	Discord = {
	   Enabled = false,
	   Invite = "noinvitelink",
	   RememberJoins = true
	},
	KeySystem = false,
	KeySettings = {
	   Title = TitleHub,
	   Subtitle = "Key system",
	   Note = "Sorry",
	   FileName = "Key",
	   SaveKey = false,
	   GrabKeyFromSite = true,
	   Actions = {
			 [1] = {
				 Text = 'Click here to copy the key link <--',
				 OnPress = function()
					 print('Pressed')
				 end,
				 }
			 },
	   Key = {"none"}
	}
 })

Window:Prompt({
    Title = 'INFORMAÇÕES!',
    SubTitle = 'IMPORTANTE',
    Content = "O uso deste exploit é de sua total responsabilidade. Não nos responsabilizamos por qualquer punição, incluindo bans, que possa resultar do seu uso. Utilize por sua conta e risco.",
    Actions = {
        Recusar = {
            Name = 'Recusar',
            Callback = function()
                print('Termos recusados.')
				ArrayField:Notify({Title = "Termos recusados!", Content = "O "..TitleHub.. " está fechando..."})
				task.wait(2)
				ArrayField:Destroy()
            end,
        },
		Aceitar = {
			Name = 'Aceitar',
			Callback = function ()
				print("Termos recusados.")
				ArrayField:Notify({Title = "Termos aceitos!", Content = LocalPlayer.DisplayName.. " bom proveito!"})
			
			end
		}
    }
})

local TAB_AIMBOT_CONFIG = Window:CreateTab("AimBot Config", ImageHub)


local SEC_AIMBOT = TAB_AIMBOT_CONFIG:CreateSection("Aimbot",true)



local ENABLE_AIMBOT = TAB_AIMBOT_CONFIG:CreateToggle({
	Name = "Aimbot Enabled",
	CurrentValue = false,
	Flag = "AIM_ENABLED",
	Callback = function(Value)
		if Value == true then
			aimbotEnabled1 = true
			ArrayField:Notify({Title = "AimBot ativado!", Content = "A tecla para ativar e desativar é: " ..tostring(aimKey)})
		else
			aimbotEnabled1 = false
			ArrayField:Notify({Title = "AimBot desativado!", Content = "O AimBot está completamente desativado."})

		end
	end,
 })


 local label_aimbot = TAB_AIMBOT_CONFIG:CreateLabel("Aimbot Configs")

 local TEAM_IG = TAB_AIMBOT_CONFIG:CreateToggle({
	Name = "Team Ignore",
	CurrentValue = false,
	Flag = "TIME_IGNORADO",
	Callback = function(Value)
		if Value == true then
			TEAM_IGNORE = true
			ArrayField:Notify({Title = "Time sendo ignorado.", Content = ""})
		else
			TEAM_IGNORE = false
			ArrayField:Notify({Title = "Time designorado!", Content = "O aimbot está completamente ativado para todos."})

		end
	end,
 })

 local KEY_AIMBOT = TAB_AIMBOT_CONFIG:CreateDropdown({
	Name = "Tecla de ativação/deisativação",
	Options = {"A","B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"},
	CurrentOption = "E",
	MultiSelection = false,
	Flag = "KEY_AIMBOT",
	Callback = function(Option)
		aimKey = tostring(Option)
		ArrayField:Notify({Title = "AimBot alteração!", Content = "A nova tecla de ativação/desativação é: " ..tostring(aimKey)})
	end,
 })

 local ASSISTENCIA_AIM = TAB_AIMBOT_CONFIG:CreateSlider({
	Name = "AimLevel",
	Range = {0, 1},
	Increment = 0.1,
	Suffix = "",
	CurrentValue = 0.3,
	Flag = "ASSISTENCIA",
	Callback = function(Value)
		local OriginalValue = aimAssistLevel
		if Value ~= OriginalValue then
			aimAssistLevel = Value
			ArrayField:Notify({Title = "AimBot!", Content = "O aimLevel foi configurado para: "..tostring(aimAssistLevel)})
		end
	end,
 })

 local DISTANCIA_AIM = TAB_AIMBOT_CONFIG:CreateSlider({
	Name = "Detection limit",
	Range = {0, 200},
	Increment = 1,
	Suffix = "",
	CurrentValue = 100,
	Flag = "DISTANCIA_AIM",
	Callback = function(Value)
		local OriginalValue = maxDistance
		if Value ~= OriginalValue then
			maxDistance = Value
			ArrayField:Notify({Title = "AimBot!", Content = "O Detection limit foi configurado para: "..tostring(maxDistance)})
		end
	end,
 })

 local SUAVIDADE_AIM = TAB_AIMBOT_CONFIG:CreateSlider({
	Name = "Smoothness",
	Range = {0, 1},
	Increment = 0.1,
	Suffix = "(Quanto mais baixo mais suave)",
	CurrentValue = 0.2,
	Flag = "SMOOTH_AIM",
	Callback = function(Value)
		local OriginalValue = smoothness
		if Value ~= OriginalValue then
			smoothness = Value
			ArrayField:Notify({Title = "AimBot!", Content = "O smoothness foi configurado para: "..tostring(smoothness)})
		end
	end,
 })


UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode[aimKey] then
		if aimbotEnabled1 == false then
			print("O aimbot está desativado.")
			ArrayField:Notify({Title = "AimBot Desativado!", Content = "O Aimbot está desativado, por favor ative para utilizar o atalho..."})
		else
			aimbotEnabled = not aimbotEnabled
		end
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local targetPlayer = getClosestVisiblePlayer()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") and targetPlayer.Character.Humanoid.Health ~= 0 then
            local targetPos = targetPlayer.Character.Head.Position
            local cameraPos = Camera.CFrame.Position
            local direction = (targetPos - cameraPos).unit

            local currentLookVector = Camera.CFrame.LookVector
            local newLookVector = currentLookVector:Lerp(direction, aimAssistLevel * smoothness).unit

            Camera.CFrame = CFrame.new(cameraPos, cameraPos + newLookVector)
        end
    end
end)
