-- 滑板模拟器 - ez.ggs - V2（紫色发光主题）
-- RightAlt 切换 | 清晰开关动画 | 优化速度

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- 设置
local autoPowerOn = false
local autoWinOn = false
local autoRebirthOn = false
local turboMode = false
local antiAFK = true

-- 颜色
local purpleDark = Color3.fromRGB(18, 10, 32)
local purpleMid = Color3.fromRGB(35, 18, 60)
local purpleAccent = Color3.fromRGB(120, 50, 210)
local purpleLight = Color3.fromRGB(170, 90, 255)
local purpleGlow = Color3.fromRGB(100, 40, 200)
local textWhite = Color3.fromRGB(235, 235, 255)
local textDim = Color3.fromRGB(140, 120, 180)
local switchOn = Color3.fromRGB(130, 55, 220)
local switchOff = Color3.fromRGB(50, 40, 70)

-- 界面
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ez_ggs_V2"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

-- 发光层
local glowLayers = {}
local glowSizes = {40, 30, 20, 12, 6}
local glowTransparency = {0.92, 0.88, 0.82, 0.75, 0.65}

for i = 1, #glowSizes do
    local layer = Instance.new("Frame")
    layer.Size = UDim2.new(0, 260 + glowSizes[i], 0, 380 + glowSizes[i])
    layer.Position = UDim2.new(0.5, -(130 + glowSizes[i]/2), 0.5, -(190 + glowSizes[i]/2))
    layer.BackgroundColor3 = purpleGlow
    layer.BackgroundTransparency = glowTransparency[i]
    layer.BorderSizePixel = 0
    layer.ZIndex = 0
    layer.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16 + glowSizes[i]/2)
    corner.Parent = layer

    table.insert(glowLayers, layer)
end

-- 主框架
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 380)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -190)
mainFrame.BackgroundColor3 = purpleDark
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 10
mainFrame.Visible = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local innerStroke = Instance.new("UIStroke")
innerStroke.Color = purpleAccent
innerStroke.Thickness = 1
innerStroke.Transparency = 0.5
innerStroke.Parent = mainFrame

-- 标题栏
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 52)
titleBar.BackgroundColor3 = purpleMid
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 11
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 12)
titleFix.Position = UDim2.new(0, 0, 1, -12)
titleFix.BackgroundColor3 = purpleMid
titleFix.BorderSizePixel = 0
titleFix.ZIndex = 11
titleFix.Parent = titleBar

-- 标题文字
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -70, 0, 24)
titleLabel.Position = UDim2.new(0, 14, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "ez.ggs - V2"
titleLabel.TextColor3 = textWhite
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 12
titleLabel.Parent = titleBar

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(1, -70, 0, 16)
subtitleLabel.Position = UDim2.new(0, 14, 0, 30)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "滑板模拟器"
subtitleLabel.TextColor3 = textDim
subtitleLabel.TextSize = 10
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.ZIndex = 12
subtitleLabel.Parent = titleBar

-- 按键提示标签
local keybindLabel = Instance.new("TextLabel")
keybindLabel.Size = UDim2.new(0, 55, 0, 22)
keybindLabel.Position = UDim2.new(1, -63, 0, 15)
keybindLabel.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
keybindLabel.Text = "R.Alt"
keybindLabel.TextColor3 = purpleLight
keybindLabel.TextSize = 10
keybindLabel.Font = Enum.Font.GothamBold
keybindLabel.ZIndex = 12
keybindLabel.Parent = titleBar

local keybindCorner = Instance.new("UICorner")
keybindCorner.CornerRadius = UDim.new(0, 6)
keybindCorner.Parent = keybindLabel

local keybindStroke = Instance.new("UIStroke")
keybindStroke.Color = purpleAccent
keybindStroke.Thickness = 0.5
keybindStroke.Transparency = 0.5
keybindStroke.Parent = keybindLabel

-- 滚动区域
local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -20, 1, -65)
scrolling.Position = UDim2.new(0, 10, 0, 58)
scrolling.BackgroundTransparency = 1
scrolling.ScrollBarThickness = 3
scrolling.ScrollBarImageColor3 = purpleAccent
scrolling.ScrollBarImageTransparency = 0.4
scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrolling.ZIndex = 11
scrolling.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = scrolling

local listPadding = Instance.new("UIPadding")
listPadding.PaddingBottom = UDim.new(0, 10)
listPadding.Parent = scrolling

-- 开关按钮创建器
local function createSwitchToggle(txt, desc, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 52)
    container.BackgroundColor3 = Color3.fromRGB(30, 18, 50)
    container.BorderSizePixel = 0
    container.ZIndex = 12
    container.Parent = scrolling

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 10)
    containerCorner.Parent = container

    local containerStroke = Instance.new("UIStroke")
    containerStroke.Color = purpleAccent
    containerStroke.Thickness = 0.5
    containerStroke.Transparency = 0.8
    containerStroke.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -65, 0, 22)
    label.Position = UDim2.new(0, 12, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = txt
    label.TextColor3 = textWhite
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = container

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -65, 0, 14)
    descLabel.Position = UDim2.new(0, 12, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = textDim
    descLabel.TextSize = 9
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.ZIndex = 13
    descLabel.Parent = container

    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 40, 0, 20)
    switchBg.Position = UDim2.new(1, -50, 0.5, -10)
    switchBg.BackgroundColor3 = default and switchOn or switchOff
    switchBg.BorderSizePixel = 0
    switchBg.ZIndex = 13
    switchBg.Parent = container

    local switchBgCorner = Instance.new("UICorner")
    switchBgCorner.CornerRadius = UDim.new(1, 0)
    switchBgCorner.Parent = switchBg

    local switchCircle = Instance.new("Frame")
    local circleOffset = default and 18 or 2
    switchCircle.Size = UDim2.new(0, 16, 0, 16)
    switchCircle.Position = UDim2.new(0, circleOffset, 0, 2)
    switchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchCircle.BorderSizePixel = 0
    switchCircle.ZIndex = 14
    switchCircle.Parent = switchBg

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = switchCircle

    local switchGlow = Instance.new("Frame")
    switchGlow.Size = UDim2.new(1, 6, 1, 6)
    switchGlow.Position = UDim2.new(0, -3, 0, -3)
    switchGlow.BackgroundColor3 = purpleLight
    switchGlow.BackgroundTransparency = default and 0.7 or 1
    switchGlow.BorderSizePixel = 0
    switchGlow.ZIndex = 12
    switchGlow.Parent = switchBg

    local switchGlowCorner = Instance.new("UICorner")
    switchGlowCorner.CornerRadius = UDim.new(1, 0)
    switchGlowCorner.Parent = switchGlow

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 15
    clickBtn.Parent = container

    local isOn = default

    local function updateSwitch()
        local targetPos = isOn and 18 or 2
        local targetColor = isOn and switchOn or switchOff
        local targetGlow = isOn and 0.7 or 1

        TweenService:Create(switchCircle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, targetPos, 0, 2)
        }):Play()

        TweenService:Create(switchBg, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundColor3 = targetColor
        }):Play()

        TweenService:Create(switchGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundTransparency = targetGlow
        }):Play()
    end

    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn
        updateSwitch()
        if callback then callback(isOn) end
    end)

    return container
end

-- 分区标题创建器
local function createSectionLabel(txt)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = txt
    label.TextColor3 = purpleLight
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 12
    label.Parent = scrolling
    return label
end

-- 获取远程函数引用（缓存加速）
local remoteEvent = nil
local remoteFunction = nil

local function getRemotes()
    if not remoteEvent or not remoteFunction then
        local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
        if events then
            remoteEvent = events:FindFirstChild("RequestServerAction")
            remoteFunction = events:FindFirstChild("InvokeServerAction")
        end
    end
    return remoteEvent, remoteFunction
end

-- 创建开关
createSectionLabel("⚡ 主要功能")

createSwitchToggle("自动加速", "疯狂训练获取最高速度", false, function(v)
    autoPowerOn = v
end)

createSwitchToggle("自动胜利", "瞬间完成比赛", false, function(v)
    autoWinOn = v
end)

createSwitchToggle("自动转生", "条件满足时自动转生", false, function(v)
    autoRebirthOn = v
end)

createSectionLabel("🚀 加速")

createSwitchToggle("涡轮模式", "3倍更快的触发速度", false, function(v)
    turboMode = v
end)

createSectionLabel("⚙️ 其他")

createSwitchToggle("防掉线", "防止被踢出游戏", true, function(v)
    antiAFK = v
end)

-- 分隔线
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -16, 0, 1)
divider.BackgroundColor3 = purpleAccent
divider.BackgroundTransparency = 0.7
divider.BorderSizePixel = 0
divider.ZIndex = 12
divider.Parent = scrolling

-- 底部提示
local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 20)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "按 RightAlt 切换显示"
footerLabel.TextColor3 = textDim
footerLabel.TextSize = 9
footerLabel.Font = Enum.Font.Gotham
footerLabel.ZIndex = 12
footerLabel.Parent = scrolling

-- ==================== 优化循环 ====================

-- 自动加速循环
task.spawn(function()
    while task.wait(0.05) do
        if autoPowerOn then
            local evt, _ = getRemotes()
            if evt then
                local fires = turboMode and 5 or 2
                for _ = 1, fires do
                    pcall(function()
                        evt:FireServer("Gameplay", "Train", {1, 1})
                    end)
                end
            end
        end
    end
end)

-- 自动胜利循环
task.spawn(function()
    while task.wait(0.05) do
        if autoWinOn then
            local _, func = getRemotes()
            if func then
                pcall(function()
                    func:InvokeServer("Gameplay", "Win", 1, 124.79301738739014)
                end)
                if turboMode then
                    pcall(function()
                        func:InvokeServer("Gameplay", "Win", 1, 124.79301738739014)
                    end)
                end
            end
        end
    end
end)

-- 自动转生循环
task.spawn(function()
    while task.wait(0.1) do
        if autoRebirthOn then
            local _, func = getRemotes()
            if func then
                pcall(function()
                    func:InvokeServer("Rebirths", "Request")
                end)
            end
        end
    end
end)

-- 防掉线
if antiAFK then
    local VirtualUser = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- 切换界面显示
local function toggleVisibility()
    local isVisible = mainFrame.Visible
    mainFrame.Visible = not isVisible
    for _, layer in ipairs(glowLayers) do
        layer.Visible = not isVisible
    end
end

-- RightAlt 快捷键
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightAlt then
        toggleVisibility()
    end
end)

-- 可拖拽
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        mainFrame.Position = newPos
        
        for i, layer in ipairs(glowLayers) do
            local offset = glowSizes[i] / 2
            layer.Position = UDim2.new(newPos.X.Scale, newPos.X.Offset - offset, newPos.Y.Scale, newPos.Y.Offset - offset)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("ez.ggs - V2 | 滑板模拟器 已加载！")
print("按 RightAlt 切换界面。")