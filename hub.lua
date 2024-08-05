local Rayfield = loadstring(game:HttpGet('https://sunn.cloud/r.lua'))()

local p = game:GetService('Players').LocalPlayer
local TitleHub = "Sun Hub"
local ImageHub = 4483362458

if game.PlaceId == 10449761463 then
   print("Oi")
else
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
end



local Window = Rayfield:CreateWindow({
   Name = TitleHub,
   LoadingTitle = "Sun Hub Interface Suite",
   LoadingSubtitle = "by Sunlool",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, 
      FileName = "Sun Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", 
      RememberJoins = true
   },
   KeySystem = false, 
   KeySettings = {
      Title = TitleHub,
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Hello"}
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
