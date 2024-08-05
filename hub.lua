local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()

local p = game:GetService('Players').LocalPlayer
local TitleHub = "Sun Hub"
local ImageHub = 4483362458

local Window = ArrayField:CreateWindow({
	Name = TitleHub,
	LoadingTitle = TitleHub,
	LoadingSubtitle = "Inicializando...",
	ConfigurationSaving = {
	   Enabled = true,
	   FolderName = nil, -- Create a custom folder for your hub/game
	   FileName = "Sun"
	},
	Discord = {
	   Enabled = false,
	   Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
	   RememberJoins = true -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
	   Title = TitleHub,
	   Subtitle = "Key system",
	   Note = "Sorry...",
	   FileName = "Key", -- It is recommended to use something unique as other scripts using ArrayField may overwrite your key file
	   SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
	   GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like ArrayField to get the key from
	   Actions = {
			 [1] = {
				 Text = 'Click here to copy the key link <--',
				 OnPress = function()
					 print('Pressed')
				 end,
				 }
			 },
	   Key = loadstring(game:HttpGet('https://raw.githubusercontent.com/guerreiroppp/sunn.github.io/main/media/keys-hub.txt'))() -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	}
 })
