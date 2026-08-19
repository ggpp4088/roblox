--[[
    小鸡农场 🐣 - 自动挂机
    作者: hidevin
    按 RIGHT SHIFT 打开/关闭菜单。
    防掉线始终开启。
]]

local repo = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/"

-- 清理之前运行的 UI（Obsidian 窗口存在于 gethui() 中，传送后仍保留，重复执行会堆叠第二个窗口）
pcall(function()
    local hui = gethui()
    for _, child in ipairs(hui:GetChildren()) do
        if child:IsA("ScreenGui") and child:GetAttribute("ChickenFarmGrinder") then
            child:Destroy()
        end
    end
end)

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Paper = require(ReplicatedStorage.Paper)
local Network = Paper.Network
local Chickens = require(ReplicatedStorage.Modules.Shared.Chickens)
local ChickenTable = require(ReplicatedStorage.Tables.Chickens)

local function stat(key)
    return Paper.Stats.GetValue(key)
end

local Window = Library:CreateWindow({
    Title = "[🌟更新] 小鸡农场 🐣",
    Icon = "egg",
    ToggleKeybind = Enum.KeyCode.RightShift,
    SearchbarSize = UDim2.fromScale(0.22, 1),
    Footer = "如果脚本正常工作请在 Rscripts 点赞。作者:hidevin",
    CopyableFooter = false,
})

-- 标记窗口，以便重复执行时找到并移除它
if Library.ScreenGui then
    Library.ScreenGui:SetAttribute("ChickenFarmGrinder", true)
end

-- ============================================================
--  防掉线（始终开启）
-- ============================================================
local running = true

VirtualUser:CaptureController()
local function antiAFK()
    pcall(function()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
end
local idleConnection = LocalPlayer.Idled:Connect(antiAFK)
task.spawn(function()
    while running do
        task.wait(60)
        antiAFK()
    end
end)

-- ============================================================
--  挂机动作
-- ============================================================
local function collectEggs()
    local collected = 0
    for _, egg in ipairs(workspace.Eggs:GetChildren()) do
        if egg:GetAttribute("LuckyBlock") == nil then
            Network.FireServer("Collect Egg", egg.Name)
            egg:Destroy()
            collected += 1
        end
    end
    return collected
end

local function collectLuckyBlocks()
    local collected = 0
    for _, block in ipairs(workspace.Eggs:GetChildren()) do
        if block:GetAttribute("LuckyBlock") ~= nil then
            if Network.InvokeServer("Collect Lucky Block", block.Name) then
                block:Destroy()
                collected += 1
            end
        end
    end
    return collected
end

local function canMerge()
    local chickens = stat("Chickens")
    if typeof(chickens) ~= "table" then
        return false
    end
    local max = #ChickenTable
    for i, count in ipairs(chickens) do
        if i < max and type(count) == "number" and count >= 3 then
            return true
        end
    end
    return false
end

-- ============================================================
--  UI 界面
-- ============================================================
local Tabs = {
    Farming = Window:AddTab({ Name = "挂机", Icon = "egg", Description = "鸡蛋、收入和小鸡" }),
    Upgrades = Window:AddTab({ Name = "升级", Icon = "trending-up", Description = "加工、等级和宝石升级" }),
    ["Lucky Blocks"] = Window:AddTab({ Name = "幸运方块", Icon = "package", Description = "解锁和丢弃方块" }),
    ["UI Settings"] = Window:AddTab({ Name = "设置", Icon = "settings", Description = "配置和主题" }),
}

-- 挂机
local FarmBox = Tabs.Farming:AddLeftGroupbox("鸡蛋 & 现金", "coins")
FarmBox:AddToggle("AutoCollectEggs", { Text = "自动收集鸡蛋", Default = true })
FarmBox:AddToggle("AutoCollectLuckyBlocks", { Text = "自动收集幸运方块", Default = true })
FarmBox:AddToggle("AutoDepositEggs", { Text = "自动存入鸡蛋", Default = true })
FarmBox:AddToggle("AutoCollectIncome", { Text = "自动收取收入", Default = true })

local ChickBox = Tabs.Farming:AddRightGroupbox("小鸡", "users")
ChickBox:AddToggle("AutoMerge", { Text = "自动合并", Default = true })
ChickBox:AddToggle("AutoBuyChickens", { Text = "自动购买小鸡（用于合并）", Default = true })
ChickBox:AddDropdown("BuyAmounts", {
    Values = { 1, 5, 25, 100 },
    Default = 1,
    Multi = true,
    Text = "购买数量",
    Tooltip = "选择批量购买的数量，支持多选。",
})

Tabs.Farming:AddLeftGroupbox("挂机设置", "timer"):AddSlider("AutoInterval", {
    Text = "自动间隔",
    Default = 1,
    Min = 0.1,
    Max = 30,
    Rounding = 1,
    Suffix = "秒",
    Tooltip = "自动循环运行的间隔时间。",
})

Tabs.Farming:AddLeftGroupbox("信息", "info"):AddLabel(
    "按 RIGHT SHIFT 打开/关闭此菜单。\n防掉线始终运行。",
    true
)

-- 升级
local UpgBox = Tabs.Upgrades:AddLeftGroupbox("升级", "trending-up")
UpgBox:AddToggle("AutoUpgradeProcess", { Text = "自动升级加工（卖鸡蛋）", Default = true })
UpgBox:AddToggle("AutoUpgradeBuyTier", { Text = "自动升级购买等级", Default = true })
UpgBox:AddDropdown("GemUpgrades", {
    Values = { "ProcessSpeedUpgrade", "DepositMultiUpgrade", "OfflineMultiUpgrade", "StartingCashUpgrade" },
    Default = 1,
    Multi = true,
    Text = "宝石升级",
    Tooltip = "选择自动购买的宝石升级项目，支持多选。",
})
Options.GemUpgrades:SetValue({})

local RebirthBox = Tabs.Upgrades:AddRightGroupbox("转生", "refresh-cw")
RebirthBox:AddToggle("AutoRebirth", { Text = "自动转生", Default = false })
RebirthBox:AddLabel(
    "能负担下一次转生时自动转生。\n这会重置你的现金、小鸡和鸡蛋！",
    true
)

-- 幸运方块
local LBBox = Tabs["Lucky Blocks"]:AddLeftGroupbox("幸运方块", "package")
LBBox:AddToggle("AutoUnlockLuckyBlock", { Text = "自动解锁（开启）幸运方块", Default = true })
LBBox:AddToggle("AutoDiscardLuckyBlock", { Text = "自动丢弃幸运方块", Default = false })
LBBox:AddLabel(
    "解锁会开启你装备的方块获得小鸡。\n丢弃会扔掉它，让新的方块可以掉落。",
    true
)

-- ============================================================
--  主循环
-- ============================================================
local cooldowns = {}
local function ready(key, interval)
    local t = tick()
    if not cooldowns[key] or t - cooldowns[key] >= interval then
        cooldowns[key] = t
        return true
    end
    return false
end

task.spawn(function()
    while running do
        task.wait(math.max(0.1, Options.AutoInterval.Value or 1))

        if Toggles.AutoCollectEggs.Value and ready("eggs", 1) then
            collectEggs()
        end

        if Toggles.AutoCollectLuckyBlocks.Value and ready("lbs", 1) then
            collectLuckyBlocks()
        end

        if Toggles.AutoDepositEggs.Value and ready("deposit", 10) then
            Network.InvokeServer("Deposit Eggs")
        end

        if Toggles.AutoCollectIncome.Value and ready("income", 15) then
            Network.InvokeServer("Collect Cash")
        end

        if Toggles.AutoUpgradeProcess.Value and ready("proc", 2) then
            local level = stat("ProcessingLevel") or 0
            local cost = Chickens.GetProcessCost(level)
            if cost <= (stat("Cash") or 0) then
                Network.InvokeServer("Upgrade Process Level")
            end
        end

        if Toggles.AutoUpgradeBuyTier.Value and ready("tier", 3) then
            local tier = stat("BuyTierLevel") or 0
            local cost = Chickens.GetUpgTierCost(tier)
            local req = Chickens.GetUpgTierReq(tier)
            local total = stat("TotalChickens") or 0
            if cost and req and total >= req and cost <= (stat("Cash") or 0) then
                Network.InvokeServer("Upgrade Buy Tier Level")
            end
        end

        if ready("gems", 3) then
            local active = Options.GemUpgrades:GetActiveValues()
            local gems = stat("Gems") or 0
            for _, name in ipairs(active) do
                local level = stat(name) or 0
                local cost = Chickens.GetUpgradeCost(name, level)
                if cost and cost <= gems then
                    Network.InvokeServer("Purchase Upgrade", name)
                end
            end
        end

        if Toggles.AutoMerge.Value and ready("merge", 2) and canMerge() then
            Network.InvokeServer("Merge Chickens")
        end

        if Toggles.AutoBuyChickens.Value and ready("buy", 2) then
            local active = Options.BuyAmounts:GetActiveValues()
            local cash = stat("Cash") or 0
            local total = stat("TotalChickens") or 0
            local tier = stat("BuyTierLevel") or 0
            for _, amount in ipairs(active) do
                local cost = Chickens.GetBuyChickenCost(total, tier, amount)
                if cost <= cash then
                    Network.InvokeServer("Buy Chickens", amount)
                end
            end
        end

        if Toggles.AutoUnlockLuckyBlock.Value and ready("unlock", 5) then
            if (stat("EquippedLuckyBlock") or 0) ~= 0 then
                local ok = Network.InvokeServer("Open Lucky Block")
                if ok then
                    task.delay(3, function()
                        Network.FireServer("Claim Opened Chicken")
                    end)
                end
            end
        end

        if Toggles.AutoDiscardLuckyBlock.Value and ready("discard", 5) then
            if (stat("EquippedLuckyBlock") or 0) ~= 0 then
                Network.FireServer("Discard Lucky Block")
            end
        end

        if Toggles.AutoRebirth.Value and ready("rebirth", 10) then
            local rb = stat("Rebirth") or 0
            local req = Chickens.GetRebirthReq(rb + 1)
            if req and (stat("Cash") or 0) >= req then
                Network.InvokeServer("Rebirth")
            end
        end
    end
end)

-- ============================================================
--  配置 / 主题
-- ============================================================
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("ChickenFarm")
SaveManager:SetFolder("ChickenFarm")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()

-- ============================================================
--  清理（热重载）+ 重复执行保护
-- ============================================================
local stateOk, stateTbl = pcall(function()
    return STATE
end)
if stateOk and stateTbl and stateTbl.onCleanup then
    stateTbl.onCleanup(function()
        running = false
        idleConnection:Disconnect()
        pcall(function()
            Library:Unload()
        end)
    end)
end

Library:Notify({
    Title = "小鸡农场 🐣 已加载",
    Description = "按 RIGHT SHIFT 打开/关闭菜单。",
    Type = "Success",
    Time = 5,
})