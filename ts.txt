-- ============================================
-- 服务
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- ============================================
-- 本地玩家 / 相机 / 鼠标
-- ============================================
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ============================================
-- 全局设置（兼容原文档的 getgenv 方式）
-- ============================================
getgenv().Toggle = true      -- ESP总开关
getgenv().TC = false         -- 队伍检测开关
local PlayerName = "DisplayName"  -- "DisplayName" 或 "Name"

local Settings = {
    Enabled = false,
    AutoLock = true,
    FOV = 150,
    AimPart = "Head",
    Keybind = Enum.KeyCode.E,
    HideKey = Enum.KeyCode.H,
    Smoothness = 0.15,
    TeamCheck = false,
    WallCheck = false,
    ShowFOV = true,
    UIVisible = true,
    HoldToLock = false,
    ShowCrosshair = true,
    CrosshairColor = Color3.fromRGB(255, 255, 255)
}

local lockedTarget = nil
local isLocking = false
local holdLocking = false

-- ============================================
-- ⭐ 新增：高亮指定玩家（输入名字）
-- ============================================
local highlightedPlayerName = nil
local HIGHLIGHT_COLOR = Color3.fromRGB(255, 215, 0)  -- 金色
local HIGHLIGHT_TRANSPARENCY = 0.2

-- 高亮指定玩家
local function highlightSpecificPlayer(playerName)
    if not playerName or playerName == "" then
        highlightedPlayerName = nil
        print("🔍 已清除高亮")
        return false
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name:lower() == playerName:lower() or player.DisplayName:lower() == playerName:lower() then
            highlightedPlayerName = player.Name
            print("⭐ 已高亮玩家: " .. player.Name)
            return true
        end
    end
    
    print("❌ 未找到玩家: " .. playerName)
    return false
end

-- ============================================
-- 工具函数
-- ============================================

local function isEnemy(player)
    if not Settings.TeamCheck then return true end
    if LocalPlayer.Team == nil or player.Team == nil then return true end
    return player.Team ~= LocalPlayer.Team
end

local function hasLineOfSight(targetPart)
    if not Settings.WallCheck then return true end
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * (targetPart.Position - origin).Magnitude
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = Workspace:Raycast(origin, direction, rayParams)
    return not result or result.Instance:IsDescendantOf(targetPart.Parent)
end

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = Settings.FOV

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer 
           and player.Character 
           and player.Character:FindFirstChild("Humanoid") 
           and player.Character.Humanoid.Health > 0
           and player.Character:FindFirstChild(Settings.AimPart) 
           and isEnemy(player) then

            local targetPart = player.Character[Settings.AimPart]
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)

            if onScreen then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if distance < shortestDistance and hasLineOfSight(targetPart) then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

-- ============================================
-- FOV 圆圈绘制
-- ============================================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 2
FOVCircle.NumSides = 60
FOVCircle.Color = Color3.fromRGB(255, 50, 50)
FOVCircle.Transparency = 0.5
FOVCircle.Filled = false

-- ============================================
-- 中心准星线条
-- ============================================
local crosshairLines = {}
local CROSSHAIR_LENGTH = 12
local CROSSHAIR_GAP = 4
local CROSSHAIR_THICKNESS = 2

for i = 1, 4 do
    crosshairLines[i] = Drawing.new("Line")
    crosshairLines[i].Thickness = CROSSHAIR_THICKNESS
    crosshairLines[i].Color = Settings.CrosshairColor
    crosshairLines[i].Transparency = 1
    crosshairLines[i].Visible = true
end

local function updateCrosshair()
    if not Settings.ShowCrosshair then
        for _, line in ipairs(crosshairLines) do
            line.Visible = false
        end
        return
    end

    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    crosshairLines[1].From = Vector2.new(center.X, center.Y - CROSSHAIR_GAP)
    crosshairLines[1].To = Vector2.new(center.X, center.Y - CROSSHAIR_GAP - CROSSHAIR_LENGTH)

    crosshairLines[2].From = Vector2.new(center.X, center.Y + CROSSHAIR_GAP)
    crosshairLines[2].To = Vector2.new(center.X, center.Y + CROSSHAIR_GAP + CROSSHAIR_LENGTH)

    crosshairLines[3].From = Vector2.new(center.X - CROSSHAIR_GAP, center.Y)
    crosshairLines[3].To = Vector2.new(center.X - CROSSHAIR_GAP - CROSSHAIR_LENGTH, center.Y)

    crosshairLines[4].From = Vector2.new(center.X + CROSSHAIR_GAP, center.Y)
    crosshairLines[4].To = Vector2.new(center.X + CROSSHAIR_GAP + CROSSHAIR_LENGTH, center.Y)

    for _, line in ipairs(crosshairLines) do
        line.Visible = true
        line.Color = Settings.CrosshairColor
    end
end

-- ============================================
-- ⭐ 修改：人物透视（ESP）- 增加高亮功能
-- ============================================
local function createESP(player)
    if not player.Character then return end
    
    if player.Character:FindFirstChild("Totally NOT Esp") then
        return
    end

    local distance = 0
    local success, result = pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
           and player.Character:FindFirstChild("HumanoidRootPart") then
            distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
        end
        return distance
    end)
    if success then distance = result end

    local teamCheck = getgenv().TC
    local isEnemyCheck = true
    if teamCheck then
        isEnemyCheck = (player.Team ~= LocalPlayer.Team)
    end

    if not isEnemyCheck then return end

    local ESP = Instance.new("Highlight")
    ESP.Name = "Totally NOT Esp"
    ESP.Parent = player.Character
    ESP.Adornee = player.Character
    ESP.Archivable = true
    ESP.Enabled = true
    ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    -- ⭐ 判断是否是被高亮的玩家
    if highlightedPlayerName and player.Name == highlightedPlayerName then
        ESP.FillColor = HIGHLIGHT_COLOR
        ESP.FillTransparency = HIGHLIGHT_TRANSPARENCY
        ESP.OutlineColor = HIGHLIGHT_COLOR
        ESP.OutlineTransparency = 0
    else
        ESP.FillColor = player.TeamColor.Color
        ESP.FillTransparency = 0.5
        ESP.OutlineColor = Color3.fromRGB(255, 255, 255)
        ESP.OutlineTransparency = 0
    end

    local Icon = Instance.new("BillboardGui")
    Icon.Name = "Icon"
    Icon.Parent = player.Character
    Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Icon.Active = true
    Icon.AlwaysOnTop = true
    Icon.ExtentsOffset = Vector3.new(0, 1, 0)
    Icon.LightInfluence = 1.000
    Icon.Size = UDim2.new(0, 800, 0, 50)

    local ESPText = Instance.new("TextLabel")
    ESPText.Name = "ESP Text"
    ESPText.Parent = Icon
    ESPText.BackgroundColor3 = player.TeamColor.Color
    ESPText.BackgroundTransparency = 1.000
    ESPText.Size = UDim2.new(0, 800, 0, 50)
    ESPText.Font = Enum.Font.SciFi

    -- ⭐ 高亮玩家名字前加⭐符号
    if highlightedPlayerName and player.Name == highlightedPlayerName then
        ESPText.Text = "⭐ " .. player[PlayerName] .. " | Distance: " .. distance
        ESPText.TextColor3 = HIGHLIGHT_COLOR
    else
        ESPText.Text = player[PlayerName] .. " | Distance: " .. distance
        ESPText.TextColor3 = player.TeamColor.Color
    end

    ESPText.TextSize = 10.800
    ESPText.TextWrapped = true
end

-- ⭐ 修改：ESP 更新循环（每帧更新高亮状态）
local function updateESP()
    if not getgenv().Toggle then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = player.Character:FindFirstChild("Totally NOT Esp")
                local icon = player.Character:FindFirstChild("Icon")
                if highlight then highlight:Destroy() end
                if icon then icon:Destroy() end
            end
        end
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if not player.Character:FindFirstChild("Totally NOT Esp") then
                createESP(player)
            end

            local icon = player.Character:FindFirstChild("Icon")
            if icon then
                local distance = 0
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
                       and player.Character:FindFirstChild("HumanoidRootPart") then
                        distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                    end
                end)
                
                local espText = icon:FindFirstChild("ESP Text")
                if espText then
                    -- ⭐ 动态更新高亮标记
                    if highlightedPlayerName and player.Name == highlightedPlayerName then
                        espText.Text = "⭐ " .. player[PlayerName] .. " | Distance: " .. distance
                        espText.TextColor3 = HIGHLIGHT_COLOR
                    else
                        espText.Text = player[PlayerName] .. " | Distance: " .. distance
                        espText.TextColor3 = player.TeamColor.Color
                    end
                end
            end

            -- ⭐ 更新Highlight颜色
            local highlight = player.Character:FindFirstChild("Totally NOT Esp")
            if highlight then
                if highlightedPlayerName and player.Name == highlightedPlayerName then
                    highlight.FillColor = HIGHLIGHT_COLOR
                    highlight.FillTransparency = HIGHLIGHT_TRANSPARENCY
                    highlight.OutlineColor = HIGHLIGHT_COLOR
                else
                    highlight.FillColor = player.TeamColor.Color
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
                
                local icon = player.Character:FindFirstChild("Icon")
                if icon then
                    local espText = icon:FindFirstChild("ESP Text")
                    if espText then
                        if highlightedPlayerName and player.Name == highlightedPlayerName then
                            espText.TextColor3 = HIGHLIGHT_COLOR
                        else
                            espText.TextColor3 = player.TeamColor.Color
                        end
                    end
                end
            end
        end
    end
end

-- ============================================
-- UI 组件
-- ============================================

function createSlider(parent, labelText, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 200, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local slider = Instance.new("TextBox")
    slider.Size = UDim2.new(1, 0, 0.4, 0)
    slider.Position = UDim2.new(0, 0, 0.5, 0)
    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.Font = Enum.Font.GothamSemibold
    slider.TextSize = 14
    slider.Text = tostring(default)
    slider.ClearTextOnFocus = false
    slider.Parent = frame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 6)
    sliderCorner.Parent = slider

    slider.FocusLost:Connect(function()
        local value = tonumber(slider.Text)
        if value then
            value = math.clamp(value, min, max)
            slider.Text = tostring(value)
            callback(value)
        else
            slider.Text = tostring(default)
        end
    end)

    return {frame = frame, label = label, slider = slider}
end

function createDropdown(parent, size, options, default, callback)
    local dropdown = Instance.new("TextButton")
    dropdown.Size = size or UDim2.new(0.55, 0, 1, -4)
    dropdown.Position = UDim2.new(0.45, 0, 0, 2)
    dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.Font = Enum.Font.GothamSemibold
    dropdown.TextSize = 14
    dropdown.Text = default
    dropdown.Parent = parent

    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = dropdown

    local currentIndex = 1
    for i, v in ipairs(options) do
        if v == default then currentIndex = i; break end
    end

    dropdown.MouseButton1Click:Connect(function()
        currentIndex = currentIndex % #options + 1
        dropdown.Text = options[currentIndex]
        callback(options[currentIndex])
    end)

    return dropdown
end

function createToggle(parent, label, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.25, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, -4, 1, -4)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(80, 40, 40)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.GothamSemibold
    toggleButton.TextSize = 12
    toggleButton.Text = label
    toggleButton.Parent = frame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton

    local state = default
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.BackgroundColor3 = state and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(80, 40, 40)
        callback(state)
    end)

    return toggleButton
end

-- ============================================
-- 创建主 UI
-- ============================================
local screenGui
local mainFrame
local highlightInput  -- ⭐ 新增：高亮输入框引用

local function createUI()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimbotUI"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 520)  -- ⭐ 高度增加，容纳高亮输入框
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -260)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = mainFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(60, 60, 255)
    uiStroke.Thickness = 1.5
    uiStroke.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, 0, 1, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "🎯 Aimbot + ESP (H隐藏)"
    titleText.TextColor3 = Color3.fromRGB(200, 200, 255)
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 18
    titleText.TextScaled = true
    titleText.Parent = titleBar

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -50)
    contentFrame.Position = UDim2.new(0, 10, 0, 45)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 6)
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.Parent = contentFrame

    -- ============================================
    -- ⭐ 新增：玩家名字高亮输入框
    -- ============================================
    local highlightFrame = Instance.new("Frame")
    highlightFrame.Size = UDim2.new(1, 0, 0, 40)
    highlightFrame.BackgroundTransparency = 1
    highlightFrame.Parent = contentFrame

    local highlightLabel = Instance.new("TextLabel")
    highlightLabel.Size = UDim2.new(0.4, 0, 0.5, 0)
    highlightLabel.Position = UDim2.new(0, 0, 0, 0)
    highlightLabel.BackgroundTransparency = 1
    highlightLabel.Text = "🔍 高亮玩家:"
    highlightLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    highlightLabel.Font = Enum.Font.GothamSemibold
    highlightLabel.TextSize = 14
    highlightLabel.TextXAlignment = Enum.TextXAlignment.Left
    highlightLabel.Parent = highlightFrame

    highlightInput = Instance.new("TextBox")
    highlightInput.Size = UDim2.new(0.55, 0, 0.5, 0)
    highlightInput.Position = UDim2.new(0.45, 0, 0, 0)
    highlightInput.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    highlightInput.TextColor3 = Color3.fromRGB(255, 215, 0)
    highlightInput.Font = Enum.Font.GothamSemibold
    highlightInput.TextSize = 14
    highlightInput.Text = ""
    highlightInput.PlaceholderText = "输入玩家名字..."
    highlightInput.ClearTextOnFocus = true
    highlightInput.Parent = highlightFrame

    local highlightInputCorner = Instance.new("UICorner")
    highlightInputCorner.CornerRadius = UDim.new(0, 6)
    highlightInputCorner.Parent = highlightInput

    -- 清除高亮按钮
    local clearHighlightBtn = Instance.new("TextButton")
    clearHighlightBtn.Size = UDim2.new(0.3, 0, 0.4, 0)
    clearHighlightBtn.Position = UDim2.new(0.7, 0, 0.55, 0)
    clearHighlightBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    clearHighlightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearHighlightBtn.Font = Enum.Font.GothamSemibold
    clearHighlightBtn.TextSize = 12
    clearHighlightBtn.Text = "清除"
    clearHighlightBtn.Parent = highlightFrame

    local clearBtnCorner = Instance.new("UICorner")
    clearBtnCorner.CornerRadius = UDim.new(0, 6)
    clearBtnCorner.Parent = clearHighlightBtn

    -- 输入框回车事件
    highlightInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local name = highlightInput.Text:gsub("^%s+", ""):gsub("%s+$", "")
            if name and name ~= "" then
                highlightSpecificPlayer(name)
            else
                highlightedPlayerName = nil
                print("🔍 已清除高亮")
            end
            highlightInput.Text = ""
        end
    end)

    clearHighlightBtn.MouseButton1Click:Connect(function()
        highlightedPlayerName = nil
        print("🔍 已清除高亮")
        highlightInput.Text = ""
    end)

    -- ============================================
    -- 开关按钮
    -- ============================================
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 0, 35)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.GothamSemibold
    toggleButton.TextSize = 16
    toggleButton.Text = "🔴 Aimbot: OFF"
    toggleButton.Parent = contentFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleButton

    toggleButton.MouseButton1Click:Connect(function()
        Settings.Enabled = not Settings.Enabled
        if Settings.Enabled then
            toggleButton.Text = "🟢 Aimbot: ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
            FOVCircle.Visible = Settings.ShowFOV
        else
            toggleButton.Text = "🔴 Aimbot: OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            FOVCircle.Visible = false
            if isLocking then
                isLocking = false
                lockedTarget = nil
            end
            holdLocking = false
        end
    end)

    -- 锁定模式
    local modeRow = Instance.new("Frame")
    modeRow.Size = UDim2.new(1, 0, 0, 30)
    modeRow.BackgroundTransparency = 1
    modeRow.Parent = contentFrame

    local modeLabel = Instance.new("TextLabel")
    modeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "Lock Mode:"
    modeLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    modeLabel.Font = Enum.Font.GothamSemibold
    modeLabel.TextSize = 14
    modeLabel.TextXAlignment = Enum.TextXAlignment.Left
    modeLabel.Parent = modeRow

    local modeButton = Instance.new("TextButton")
    modeButton.Size = UDim2.new(0.45, 0, 1, -4)
    modeButton.Position = UDim2.new(0.55, 0, 0, 2)
    modeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    modeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    modeButton.Font = Enum.Font.GothamSemibold
    modeButton.TextSize = 14
    modeButton.Text = "Toggle (E)"
    modeButton.Parent = modeRow

    local modeCorner = Instance.new("UICorner")
    modeCorner.CornerRadius = UDim.new(0, 6)
    modeCorner.Parent = modeButton

    modeButton.MouseButton1Click:Connect(function()
        Settings.HoldToLock = not Settings.HoldToLock
        if Settings.HoldToLock then
            modeButton.Text = "Hold (RMB)"
        else
            modeButton.Text = "Toggle (E)"
        end
        if isLocking then
            isLocking = false
            lockedTarget = nil
        end
        holdLocking = false
    end)

    -- FOV 滑块
    local fovSliderFrame = createSlider(contentFrame, "FOV: " .. Settings.FOV, 10, 300, Settings.FOV, function(value)
        Settings.FOV = value
        fovSliderFrame.label.Text = "FOV: " .. value
    end)

    -- 平滑度滑块
    local smoothSliderFrame = createSlider(contentFrame, "Smooth: " .. string.format("%.2f", Settings.Smoothness), 0.01, 1, Settings.Smoothness, function(value)
        Settings.Smoothness = value
        smoothSliderFrame.label.Text = "Smooth: " .. string.format("%.2f", value)
    end)

    -- 部位下拉
    local partFrame = Instance.new("Frame")
    partFrame.Size = UDim2.new(1, 0, 0, 30)
    partFrame.BackgroundTransparency = 1
    partFrame.Parent = contentFrame

    local partLabel = Instance.new("TextLabel")
    partLabel.Size = UDim2.new(0.4, 0, 1, 0)
    partLabel.BackgroundTransparency = 1
    partLabel.Text = "Aim Part:"
    partLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    partLabel.Font = Enum.Font.GothamSemibold
    partLabel.TextSize = 14
    partLabel.TextXAlignment = Enum.TextXAlignment.Left
    partLabel.Parent = partFrame

    local parts = {"Head", "HumanoidRootPart", "Torso"}
    local partDropdown = createDropdown(partFrame, UDim2.new(0.55, 0, 0, 0), parts, Settings.AimPart, function(value)
        Settings.AimPart = value
    end)

    -- 按键绑定
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Size = UDim2.new(1, 0, 0, 30)
    keybindFrame.BackgroundTransparency = 1
    keybindFrame.Parent = contentFrame

    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Size = UDim2.new(0.4, 0, 1, 0)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = "Lock Key:"
    keybindLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    keybindLabel.Font = Enum.Font.GothamSemibold
    keybindLabel.TextSize = 14
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindLabel.Parent = keybindFrame

    local keybindButton = Instance.new("TextButton")
    keybindButton.Size = UDim2.new(0.55, 0, 1, -4)
    keybindButton.Position = UDim2.new(0.45, 0, 0, 2)
    keybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.Font = Enum.Font.GothamSemibold
    keybindButton.TextSize = 14
    keybindButton.Text = "E"
    keybindButton.Parent = keybindFrame

    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 6)
    keybindCorner.Parent = keybindButton

    keybindButton.MouseButton1Click:Connect(function()
        keybindButton.Text = "..."
        local input = UserInputService.InputBegan:Wait()
        Settings.Keybind = input.KeyCode
        keybindButton.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
    end)

    -- 辅助开关
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(1, 0, 0, 30)
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.Parent = contentFrame

    local teamCheckToggle = createToggle(optionsFrame, "Team", Settings.TeamCheck, function(value)
        Settings.TeamCheck = value
        getgenv().TC = value
        if isLocking then
            isLocking = false
            lockedTarget = nil
        end
    end)

    local wallCheckToggle = createToggle(optionsFrame, "Wall", Settings.WallCheck, function(value)
        Settings.WallCheck = value
    end)

    local showFOVToggle = createToggle(optionsFrame, "FOV", Settings.ShowFOV, function(value)
        Settings.ShowFOV = value
        FOVCircle.Visible = value and Settings.Enabled
    end)

    -- ESP开关
    local espToggleFrame = Instance.new("Frame")
    espToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    espToggleFrame.BackgroundTransparency = 1
    espToggleFrame.Parent = contentFrame

    local espToggleLabel = Instance.new("TextLabel")
    espToggleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    espToggleLabel.BackgroundTransparency = 1
    espToggleLabel.Text = "ESP:"
    espToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    espToggleLabel.Font = Enum.Font.GothamSemibold
    espToggleLabel.TextSize = 14
    espToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    espToggleLabel.Parent = espToggleFrame

    local espToggleButton = Instance.new("TextButton")
    espToggleButton.Size = UDim2.new(0.3, 0, 1, -4)
    espToggleButton.Position = UDim2.new(0.55, 0, 0, 2)
    espToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    espToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    espToggleButton.Font = Enum.Font.GothamSemibold
    espToggleButton.TextSize = 14
    espToggleButton.Text = "ON"
    espToggleButton.Parent = espToggleFrame

    local espCorner = Instance.new("UICorner")
    espCorner.CornerRadius = UDim.new(0, 6)
    espCorner.Parent = espToggleButton

    espToggleButton.MouseButton1Click:Connect(function()
        getgenv().Toggle = not getgenv().Toggle
        if getgenv().Toggle then
            espToggleButton.Text = "ON"
            espToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        else
            espToggleButton.Text = "OFF"
            espToggleButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        end
    end)

    -- 准星开关
    local crosshairRow = Instance.new("Frame")
    crosshairRow.Size = UDim2.new(1, 0, 0, 30)
    crosshairRow.BackgroundTransparency = 1
    crosshairRow.Parent = contentFrame

    local crosshairLabel = Instance.new("TextLabel")
    crosshairLabel.Size = UDim2.new(0.5, 0, 1, 0)
    crosshairLabel.BackgroundTransparency = 1
    crosshairLabel.Text = "Crosshair:"
    crosshairLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    crosshairLabel.Font = Enum.Font.GothamSemibold
    crosshairLabel.TextSize = 14
    crosshairLabel.TextXAlignment = Enum.TextXAlignment.Left
    crosshairLabel.Parent = crosshairRow

    local crosshairButton = Instance.new("TextButton")
    crosshairButton.Size = UDim2.new(0.3, 0, 1, -4)
    crosshairButton.Position = UDim2.new(0.55, 0, 0, 2)
    crosshairButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    crosshairButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    crosshairButton.Font = Enum.Font.GothamSemibold
    crosshairButton.TextSize = 14
    crosshairButton.Text = "ON"
    crosshairButton.Parent = crosshairRow

    local crossCorner = Instance.new("UICorner")
    crossCorner.CornerRadius = UDim.new(0, 6)
    crossCorner.Parent = crosshairButton

    crosshairButton.MouseButton1Click:Connect(function()
        Settings.ShowCrosshair = not Settings.ShowCrosshair
        if Settings.ShowCrosshair then
            crosshairButton.Text = "ON"
            crosshairButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        else
            crosshairButton.Text = "OFF"
            crosshairButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        end
    end)
end

-- ============================================
-- 启动 UI
-- ============================================
createUI()

-- ============================================
-- 按键监听
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- 隐藏/显示 UI
    if input.KeyCode == Settings.HideKey then
        Settings.UIVisible = not Settings.UIVisible
        if mainFrame then
            mainFrame.Visible = Settings.UIVisible
        end
        return
    end

    -- ⭐ 按Y键高亮鼠标下的玩家
    if input.KeyCode == Enum.KeyCode.Y then
        local mouse = LocalPlayer:GetMouse()
        local target = mouse.Target
        if target then
            local character = target:FindFirstAncestorOfClass("Model")
            if character then
                local player = Players:GetPlayerFromCharacter(character)
                if player then
                    highlightSpecificPlayer(player.Name)
                    if highlightInput then
                        highlightInput.Text = player.Name
                    end
                end
            end
        else
            highlightedPlayerName = nil
            print("🔍 已清除高亮")
        end
        return
    end

    if not Settings.Enabled then return end

    -- 切换模式
    if not Settings.HoldToLock and input.KeyCode == Settings.Keybind then
        if isLocking then
            isLocking = false
            lockedTarget = nil
        else
            lockedTarget = getClosestPlayer()
            if lockedTarget then
                isLocking = true
            end
        end
    end

    -- 按住模式
    if Settings.HoldToLock and input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdLocking = true
        lockedTarget = getClosestPlayer()
        if lockedTarget then
            isLocking = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if Settings.HoldToLock and input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdLocking = false
        if isLocking then
            isLocking = false
            lockedTarget = nil
        end
    end
end)

-- ============================================
-- 主循环（每帧更新）
-- ============================================
RunService.RenderStepped:Connect(function()
    -- 更新 FOV 圆圈
    if Settings.ShowFOV and Settings.Enabled then
        FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        FOVCircle.Radius = Settings.FOV
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end

    -- 更新准星
    updateCrosshair()

    -- 更新 ESP（包含高亮功能）
    updateESP()

    -- 自动锁定
    if isLocking and lockedTarget and Settings.Enabled then
        local char = lockedTarget.Character

        if char 
           and char:FindFirstChild(Settings.AimPart) 
           and char:FindFirstChild("Humanoid") 
           and char.Humanoid.Health > 0 
           and isEnemy(lockedTarget) then

            local targetPos = char[Settings.AimPart].Position

            local currentPos = Camera.CFrame.Position
            Camera.CFrame = Camera.CFrame:Lerp(
                CFrame.lookAt(currentPos, targetPos),
                Settings.Smoothness
            )
        else
            lockedTarget = getClosestPlayer()
            if not lockedTarget and not holdLocking then
                if not Settings.HoldToLock then
                    isLocking = false
                end
            elseif not lockedTarget and holdLocking then
                isLocking = false
            end
        end
    elseif Settings.Enabled and not isLocking and Settings.AutoLock and not Settings.HoldToLock then
        local target = getClosestPlayer()
        if target then
            FOVCircle.Color = Color3.fromRGB(100, 255, 100)
        else
            FOVCircle.Color = Color3.fromRGB(255, 50, 50)
        end
    end
end)