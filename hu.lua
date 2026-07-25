local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

StarterGui:SetCore("SendNotification", {
    Title = "欢迎使用",
    Text = player.Name .. "：欢迎使用黑猫汉化！",
    Duration = 3
})
