local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local p = game:GetService('Players').LocalPlayer
local TitleHub = "Sun Hub"
local ImageHub = 4483362458

if game.PlaceId == 10449761463 then
   Rayfield:Notify({
      Title = TitleHub,
      Content = "Hello "..p.Name..", how are you! Ready to have fun?",
      Duration = 3,
      Image = ImageHub,
   })
   Rayfield:Notify({
      Title = TitleHub,
      Content = p.Name.." We are fully loaded!",
      Duration = 3,
      Image = ImageHub,
   })
else
   p:Kick("Not support")
   Rayfield:Destroy()
end



local Window = Rayfield:CreateWindow({
   Name = TitleHub,
   LoadingTitle = "Sun Hub Interface Suite",
   LoadingSubtitle = "by Sunlool",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Sun Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = TitleHub,
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local LocalPlayer_TAB = Window:CreateTab("LocalPlayer", ImageHub)

local LocalPlayer_SECTION = LocalPlayer_TAB:CreateSection("Teste")




local LocalPlayer_KILLGRAB = LocalPlayer_TAB:CreateButton({
   Name = "Kill Grab",
   Callback = function ()
      Rayfield:Notify({
         Title = TitleHub,
         Content = p.Name.." Movendo!",
         Duration = 3,
         Image = ImageHub,
      })
   end,
})
