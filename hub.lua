local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local TitleHub = "Sun Hub"
local ImageHub = 4483362458

-- AIMBOT CONFIGS VALUES --

local aimbotEnabled = false
local aimKey  = Enum.KeyCode.E
local aimAssistLevel = 0.3 
local maxDistance = 100 
local smoothness = 0.2
local TEAM_IGNORE = true

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
        Aceitar = {
            Name = 'Aceito',
            Callback = function()
                print('Termos aceitados.')
            end,
        },
		Recusar = {
			Name = 'Recusar',
			Callback = function ()
				print("Termos recusados.")
				ArrayField:Notify({Title = "Termos recusados!", Content = "O "..TitleHub.. " está fechando..."})
				task.wait(2)
				ArrayField:Destroy()
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
			aimbotEnabled = true
			ArrayField:Notify({Title = "Aimbot ativado!", Content = "A tecla para ativar e desativar é: " ..tostring(aimKey)})
		else
			aimbotEnabled = false
			ArrayField:Notify({Title = "Aimbot desativado!", Content = "O aimbot está completamente desativado."})

		end
	end,
 })

 local label_aimbot = TAB_AIMBOT_CONFIG:CreateLabel("Aimbot Configs")

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
	Suffix = "",
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
    if input.KeyCode == aimKey then
        aimbotEnabled = not aimbotEnabled
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local targetPlayer = getClosestVisiblePlayer()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            local targetPos = targetPlayer.Character.Head.Position
            local cameraPos = Camera.CFrame.Position
            local direction = (targetPos - cameraPos).unit

            local currentLookVector = Camera.CFrame.LookVector
            local newLookVector = currentLookVector:Lerp(direction, aimAssistLevel * smoothness).unit

            Camera.CFrame = CFrame.new(cameraPos, cameraPos + newLookVector)
        end
    end
end)
