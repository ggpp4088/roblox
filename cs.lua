-- ============================================
-- 清除之前执行的相同脚本
-- ============================================

-- 1. 清除旧UI
local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
if playerGui then
    local oldUI = playerGui:FindFirstChild("AimbotUI")
    if oldUI then oldUI:Destroy() end
end

-- 2. 清除旧Drawing
for _, v in pairs(getgenv()) do
    if type(v) == "table" and v.Destroy then
        pcall(v.Destroy, v)
    end
end

getgenv()._drawings = getgenv()._drawings or {}
for _, drawing in ipairs(getgenv()._drawings) do
    pcall(function() drawing:Remove() end)
end
getgenv()._drawings = {}

-- 3. 清除旧ESP
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game:GetService("Players").LocalPlayer and player.Character then
        local h = player.Character:FindFirstChild("Totally NOT Esp")
        local i = player.Character:FindFirstChild("Icon")
        local hb = player.Character:FindFirstChild("HealthBar")
        if h then pcall(h.Destroy, h) end
        if i then pcall(i.Destroy, i) end
        if hb then pcall(hb.Destroy, hb) end
    end
end

-- 4. 重置全局变量
getgenv().Toggle = true
getgenv().TC = false

-- 5. 清除旧连接
if getgenv()._connections then
    for _, conn in ipairs(getgenv()._connections) do
        pcall(conn.Disconnect, conn)
    end
end
getgenv()._connections = {}

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
-- 全局设置
-- ============================================
local PlayerName = "DisplayName"

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
-- 检测是否为手机设备
-- ============================================
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- ============================================
-- 高亮指定玩家
-- ============================================
local highlightedPlayerName = nil
local HIGHLIGHT_COLOR = Color3.fromRGB(255, 215, 0)
local HIGHLIGHT_TRANSPARENCY = 0.2

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
table.insert(getgenv()._drawings, FOVCircle)

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
    table.insert(getgenv()._drawings, crosshairLines[i])
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
-- 人物透视（ESP）
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

    if highlightedPlayerName and player.Name == highlightedPlayerName then
        ESPText.Text = "⭐ " .. player[PlayerName] .. " | 距离: " .. distance
        ESPText.TextColor3 = HIGHLIGHT_COLOR
    else
        ESPText.Text = player[PlayerName] .. " | 距离: " .. distance
        ESPText.TextColor3 = player.TeamColor.Color
    end

    ESPText.TextSize = 10.800
    ESPText.TextWrapped = true
end

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
                    if highlightedPlayerName and player.Name == highlightedPlayerName then
                        espText.Text = "⭐ " .. player[PlayerName] .. " | 距离: " .. distance
                        espText.TextColor3 = HIGHLIGHT_COLOR
                    else
                        espText.Text = player[PlayerName] .. " | 距离: " .. distance
                        espText.TextColor3 = player.TeamColor.Color
                    end
                end
            end

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
            end
        end
    end
end

-- ============================================
-- UI 组件
-- ============================================
function createSlider(parent, labelText, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 200, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local slider = Instance.new("TextBox")
    slider.Size = UDim2.new(1, 0, 0.4, 0)
    slider.Position = UDim2.new(0, 0, 0.5, 0)
    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.Font = Enum.Font.GothamSemibold
    slider.TextSize = 11
    slider.Text = tostring(default)
    slider.ClearTextOnFocus = false
    slider.Parent = frame

    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
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
    dropdown.TextSize = 12
    dropdown.Text = default
    dropdown.Parent = parent

    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 5)
    dropdownCorner.Parent = dropdown

    local currentIndex = 1
    for i, v in ipairs(options) do
        if v == default then
            currentIndex = i
            break
        end
    end

    dropdown.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then
            currentIndex = 1
        end
        dropdown.Text = options[currentIndex]
        callback(options[currentIndex])
    end)

    return dropdown
end

function createToggle(parent, label, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.3, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, -4, 1, -4)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(80, 40, 40)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.GothamSemibold
    toggleButton.TextSize = 11
    toggleButton.Text = label
    toggleButton.Parent = frame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 5)
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
-- 创建主 UI（手机适配版）
-- ============================================
local screenGui
local mainFrame
local highlightInput

-- 手机端按钮引用
local lockBtn
local hideBtn

local function createUI()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimbotUI"
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    -- 缩小UI尺寸，适合手机屏幕
    mainFrame.Size = UDim2.new(0, 180, 0, 320)
    -- 位置固定在右上角
    mainFrame.Position = UDim2.new(1, -190, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(60, 60, 255)
    uiStroke.Thickness = 1.5
    uiStroke.Parent = mainFrame

    -- 标题栏缩小
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 28)
    titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, 0, 1, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "🎯 辅助 + ESP"
    titleText.TextColor3 = Color3.fromRGB(200, 200, 255)
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 13
    titleText.TextScaled = true
    titleText.Parent = titleBar

    -- 内容区域缩小
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -10, 1, -32)
    contentFrame.Position = UDim2.new(0, 5, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 3)
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.Parent = contentFrame

    -- 高亮玩家输入框
    local highlightFrame = Instance.new("Frame")
    highlightFrame.Size = UDim2.new(1, 0, 0, 28)
    highlightFrame.BackgroundTransparency = 1
    highlightFrame.Parent = contentFrame

    local highlightLabel = Instance.new("TextLabel")
    highlightLabel.Size = UDim2.new(0.4, 0, 0.5, 0)
    highlightLabel.Position = UDim2.new(0, 0, 0, 0)
    highlightLabel.BackgroundTransparency = 1
    highlightLabel.Text = "🔍 高亮:"
    highlightLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    highlightLabel.Font = Enum.Font.GothamSemibold
    highlightLabel.TextSize = 11
    highlightLabel.TextXAlignment = Enum.TextXAlignment.Left
    highlightLabel.Parent = highlightFrame

    highlightInput = Instance.new("TextBox")
    highlightInput.Size = UDim2.new(0.55, 0, 0.5, 0)
    highlightInput.Position = UDim2.new(0.45, 0, 0, 0)
    highlightInput.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    highlightInput.TextColor3 = Color3.fromRGB(255, 215, 0)
    highlightInput.Font = Enum.Font.GothamSemibold
    highlightInput.TextSize = 11
    highlightInput.Text = ""
    highlightInput.PlaceholderText = "玩家名字..."
    highlightInput.ClearTextOnFocus = true
    highlightInput.Parent = highlightFrame

    local highlightInputCorner = Instance.new("UICorner")
    highlightInputCorner.CornerRadius = UDim.new(0, 5)
    highlightInputCorner.Parent = highlightInput

    local clearHighlightBtn = Instance.new("TextButton")
    clearHighlightBtn.Size = UDim2.new(0.3, 0, 0.4, 0)
    clearHighlightBtn.Position = UDim2.new(0.7, 0, 0.55, 0)
    clearHighlightBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    clearHighlightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearHighlightBtn.Font = Enum.Font.GothamSemibold
    clearHighlightBtn.TextSize = 10
    clearHighlightBtn.Text = "清除"
    clearHighlightBtn.Parent = highlightFrame

    local clearBtnCorner = Instance.new("UICorner")
    clearBtnCorner.CornerRadius = UDim.new(0, 5)
    clearBtnCorner.Parent = clearHighlightBtn

    highlightInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local name = highlightInput.Text:gsub("^%s+", ""):gsub("%s+$", "")
            if name and name ~= "" then
                highlightSpecificPlayer(name)
            else
                highlightedPlayerName = nil
            end
            highlightInput.Text = ""
        end
    end)

    clearHighlightBtn.MouseButton1Click:Connect(function()
        highlightedPlayerName = nil
        highlightInput.Text = ""
    end)

    -- 开关按钮
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 0, 28)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.GothamSemibold
    toggleButton.TextSize = 13
    toggleButton.Text = "🔴 瞄准: 关闭"
    toggleButton.Parent = contentFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton

    toggleButton.MouseButton1Click:Connect(function()
        Settings.Enabled = not Settings.Enabled
        if Settings.Enabled then
            toggleButton.Text = "🟢 瞄准: 开启"
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
            FOVCircle.Visible = Settings.ShowFOV
        else
            toggleButton.Text = "🔴 瞄准: 关闭"
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
    modeRow.Size = UDim2.new(1, 0, 0, 24)
    modeRow.BackgroundTransparency = 1
    modeRow.Parent = contentFrame

    local modeLabel = Instance.new("TextLabel")
    modeLabel.Size = UDim2.new(0.5, 0, 1, 0)
    modeLabel.BackgroundTransparency = 1
    modeLabel.Text = "锁定模式:"
    modeLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    modeLabel.Font = Enum.Font.GothamSemibold
    modeLabel.TextSize = 11
    modeLabel.TextXAlignment = Enum.TextXAlignment.Left
    modeLabel.Parent = modeRow

    local modeButton = Instance.new("TextButton")
    modeButton.Size = UDim2.new(0.45, 0, 1, -4)
    modeButton.Position = UDim2.new(0.55, 0, 0, 2)
    modeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    modeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    modeButton.Font = Enum.Font.GothamSemibold
    modeButton.TextSize = 12
    modeButton.Text = "切换(E)"
    modeButton.Parent = modeRow

    local modeCorner = Instance.new("UICorner")
    modeCorner.CornerRadius = UDim.new(0, 5)
    modeCorner.Parent = modeButton

    modeButton.MouseButton1Click:Connect(function()
        Settings.HoldToLock = not Settings.HoldToLock
        if Settings.HoldToLock then
            modeButton.Text = "按住(右键)"
        else
            modeButton.Text = "切换(E)"
        end
        if isLocking then
            isLocking = false
            lockedTarget = nil
        end
        holdLocking = false
    end)

    -- FOV 滑块
    local fovSliderFrame = createSlider(contentFrame, "视野: " .. Settings.FOV, 10, 300, Settings.FOV, function(value)
        Settings.FOV = value
        fovSliderFrame.label.Text = "视野: " .. value
    end)

    -- 平滑度滑块
    local smoothSliderFrame = createSlider(contentFrame, "平滑: " .. string.format("%.2f", Settings.Smoothness), 0.01, 1, Settings.Smoothness, function(value)
        Settings.Smoothness = value
        smoothSliderFrame.label.Text = "平滑: " .. string.format("%.2f", value)
    end)

    -- 部位下拉菜单
    local partFrame = Instance.new("Frame")
    partFrame.Size = UDim2.new(1, 0, 0, 24)
    partFrame.BackgroundTransparency = 1
    partFrame.Parent = contentFrame

    local partLabel = Instance.new("TextLabel")
    partLabel.Size = UDim2.new(0.4, 0, 1, 0)
    partLabel.BackgroundTransparency = 1
    partLabel.Text = "部位:"
    partLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    partLabel.Font = Enum.Font.GothamSemibold
    partLabel.TextSize = 11
    partLabel.TextXAlignment = Enum.TextXAlignment.Left
    partLabel.Parent = partFrame

    local parts = {"头部", "身体", "躯干"}
    local partDropdown = createDropdown(partFrame, UDim2.new(0.55, 0, 0, 0), parts, "头部", function(value)
        if value == "头部" then
            Settings.AimPart = "Head"
        elseif value == "身体" then
            Settings.AimPart = "HumanoidRootPart"
        elseif value == "躯干" then
            Settings.AimPart = "Torso"
        end
        print("部位已切换: " .. value .. " -> " .. Settings.AimPart)
    end)

    -- 按键绑定
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Size = UDim2.new(1, 0, 0, 24)
    keybindFrame.BackgroundTransparency = 1
    keybindFrame.Parent = contentFrame

    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Size = UDim2.new(0.4, 0, 1, 0)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = "按键:"
    keybindLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    keybindLabel.Font = Enum.Font.GothamSemibold
    keybindLabel.TextSize = 11
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindLabel.Parent = keybindFrame

    local keybindButton = Instance.new("TextButton")
    keybindButton.Size = UDim2.new(0.55, 0, 1, -4)
    keybindButton.Position = UDim2.new(0.45, 0, 0, 2)
    keybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.Font = Enum.Font.GothamSemibold
    keybindButton.TextSize = 12
    keybindButton.Text = "E"
    keybindButton.Parent = keybindFrame

    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 5)
    keybindCorner.Parent = keybindButton

    keybindButton.MouseButton1Click:Connect(function()
        keybindButton.Text = "..."
        local input = UserInputService.InputBegan:Wait()
        Settings.Keybind = input.KeyCode
        keybindButton.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
    end)

    -- 辅助开关
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(1, 0, 0, 24)
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.Parent = contentFrame

    local teamCheckToggle = createToggle(optionsFrame, "队伍", Settings.TeamCheck, function(value)
        Settings.TeamCheck = value
        getgenv().TC = value
        if isLocking then
            isLocking = false
            lockedTarget = nil
        end
    end)

    local wallCheckToggle = createToggle(optionsFrame, "墙体", Settings.WallCheck, function(value)
        Settings.WallCheck = value
    end)

    local showFOVToggle = createToggle(optionsFrame, "视野", Settings.ShowFOV, function(value)
        Settings.ShowFOV = value
        FOVCircle.Visible = value and Settings.Enabled
    end)

    -- ESP开关
    local espToggleFrame = Instance.new("Frame")
    espToggleFrame.Size = UDim2.new(1, 0, 0, 24)
    espToggleFrame.BackgroundTransparency = 1
    espToggleFrame.Parent = contentFrame

    local espToggleLabel = Instance.new("TextLabel")
    espToggleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    espToggleLabel.BackgroundTransparency = 1
    espToggleLabel.Text = "透视:"
    espToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    espToggleLabel.Font = Enum.Font.GothamSemibold
    espToggleLabel.TextSize = 11
    espToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    espToggleLabel.Parent = espToggleFrame

    local espToggleButton = Instance.new("TextButton")
    espToggleButton.Size = UDim2.new(0.3, 0, 1, -4)
    espToggleButton.Position = UDim2.new(0.55, 0, 0, 2)
    espToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    espToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    espToggleButton.Font = Enum.Font.GothamSemibold
    espToggleButton.TextSize = 12
    espToggleButton.Text = "开启"
    espToggleButton.Parent = espToggleFrame

    local espCorner = Instance.new("UICorner")
    espCorner.CornerRadius = UDim.new(0, 5)
    espCorner.Parent = espToggleButton

    espToggleButton.MouseButton1Click:Connect(function()
        getgenv().Toggle = not getgenv().Toggle
        if getgenv().Toggle then
            espToggleButton.Text = "开启"
            espToggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        else
            espToggleButton.Text = "关闭"
            espToggleButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        end
    end)

    -- 准星开关
    local crosshairRow = Instance.new("Frame")
    crosshairRow.Size = UDim2.new(1, 0, 0, 24)
    crosshairRow.BackgroundTransparency = 1
    crosshairRow.Parent = contentFrame

    local crosshairLabel = Instance.new("TextLabel")
    crosshairLabel.Size = UDim2.new(0.5, 0, 1, 0)
    crosshairLabel.BackgroundTransparency = 1
    crosshairLabel.Text = "准星:"
    crosshairLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    crosshairLabel.Font = Enum.Font.GothamSemibold
    crosshairLabel.TextSize = 11
    crosshairLabel.TextXAlignment = Enum.TextXAlignment.Left
    crosshairLabel.Parent = crosshairRow

    local crosshairButton = Instance.new("TextButton")
    crosshairButton.Size = UDim2.new(0.3, 0, 1, -4)
    crosshairButton.Position = UDim2.new(0.55, 0, 0, 2)
    crosshairButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    crosshairButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    crosshairButton.Font = Enum.Font.GothamSemibold
    crosshairButton.TextSize = 12
    crosshairButton.Text = "开启"
    crosshairButton.Parent = crosshairRow

    local crossCorner = Instance.new("UICorner")
    crossCorner.CornerRadius = UDim.new(0, 5)
    crossCorner.Parent = crosshairButton

    crosshairButton.MouseButton1Click:Connect(function()
        Settings.ShowCrosshair = not Settings.ShowCrosshair
        if Settings.ShowCrosshair then
            crosshairButton.Text = "开启"
            crosshairButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        else
            crosshairButton.Text = "关闭"
            crosshairButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        end
    end)

    -- ============================================
    -- 手机端专用按钮（仅在触摸设备上显示）
    -- ============================================
    if isMobile then
        -- 1. 锁定/解锁按钮 - 屏幕底部中间
        lockBtn = Instance.new("TextButton")
        lockBtn.Size = UDim2.new(0, 90, 0, 40)
        lockBtn.Position = UDim2.new(0.5, -45, 0.85, -20)
        lockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        lockBtn.Font = Enum.Font.GothamSemibold
        lockBtn.TextSize = 15
        lockBtn.Text = "🔒 锁定"
        lockBtn.Parent = screenGui

        local lockBtnCorner = Instance.new("UICorner")
        lockBtnCorner.CornerRadius = UDim.new(0, 8)
        lockBtnCorner.Parent = lockBtn

        lockBtn.MouseButton1Click:Connect(function()
            if isLocking then
                isLocking = false
                lockedTarget = nil
                holdLocking = false
                lockBtn.Text = "🔒 锁定"
                lockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            else
                lockedTarget = getClosestPlayer()
                if lockedTarget then
                    isLocking = true
                    lockBtn.Text = "🔓 解锁"
                    lockBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
                end
            end
        end)

        -- 2. 隐藏UI按钮 - 右上角
        hideBtn = Instance.new("TextButton")
        hideBtn.Size = UDim2.new(0, 36, 0, 36)
        hideBtn.Position = UDim2.new(1, -46, 0, 6)
        hideBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        hideBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
        hideBtn.Font = Enum.Font.GothamSemibold
        hideBtn.TextSize = 18
        hideBtn.Text = "✕"
        hideBtn.Parent = screenGui

        local hideBtnCorner = Instance.new("UICorner")
        hideBtnCorner.CornerRadius = UDim.new(0, 8)
        hideBtnCorner.Parent = hideBtn

        hideBtn.MouseButton1Click:Connect(function()
            Settings.UIVisible = not Settings.UIVisible
            mainFrame.Visible = Settings.UIVisible
            if Settings.UIVisible then
                hideBtn.Text = "✕"
            else
                hideBtn.Text = "☰"
            end
        end)

        -- 3. 切换模式按钮 - 锁定按钮旁边
        local modeMobileBtn = Instance.new("TextButton")
        modeMobileBtn.Size = UDim2.new(0, 80, 0, 36)
        modeMobileBtn.Position = UDim2.new(0.5, -135, 0.85, -18)
        modeMobileBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        modeMobileBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
        modeMobileBtn.Font = Enum.Font.GothamSemibold
        modeMobileBtn.TextSize = 12
        modeMobileBtn.Text = "切换模式"
        modeMobileBtn.Parent = screenGui

        local modeMobileCorner = Instance.new("UICorner")
        modeMobileCorner.CornerRadius = UDim.new(0, 6)
        modeMobileCorner.Parent = modeMobileBtn

        modeMobileBtn.MouseButton1Click:Connect(function()
            Settings.HoldToLock = not Settings.HoldToLock
            if Settings.HoldToLock then
                modeMobileBtn.Text = "按住模式"
                modeMobileBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 40)
            else
                modeMobileBtn.Text = "切换模式"
                modeMobileBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            end
            if isLocking then
                isLocking = false
                lockedTarget = nil
                holdLocking = false
                lockBtn.Text = "🔒 锁定"
                lockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            end
        end)

        -- 4. 高亮鼠标下的玩家按钮（替代Y键）
        local highlightMobileBtn = Instance.new("TextButton")
        highlightMobileBtn.Size = UDim2.new(0, 80, 0, 36)
        highlightMobileBtn.Position = UDim2.new(0.5, 55, 0.85, -18)
        highlightMobileBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 40)
        highlightMobileBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
        highlightMobileBtn.Font = Enum.Font.GothamSemibold
        highlightMobileBtn.TextSize = 12
        highlightMobileBtn.Text = "⭐ 高亮"
        highlightMobileBtn.Parent = screenGui

        local highlightMobileCorner = Instance.new("UICorner")
        highlightMobileCorner.CornerRadius = UDim.new(0, 6)
        highlightMobileCorner.Parent = highlightMobileBtn

        highlightMobileBtn.MouseButton1Click:Connect(function()
            -- 模拟Y键功能：高亮最近的玩家
            local closest = getClosestPlayer()
            if closest then
                highlightSpecificPlayer(closest.Name)
                if highlightInput then
                    highlightInput.Text = closest.Name
                end
            end
        end)
    end
end

-- ============================================
-- 启动 UI
-- ============================================
createUI()

-- ============================================
-- 按键监听（PC端保留键盘支持，手机端通过按钮操作）
-- ============================================
local connections = {}

table.insert(connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- 手机端不处理键盘事件
    if isMobile then return end

    -- 隐藏/显示 UI（按H键）
    if input.KeyCode == Settings.HideKey then
        Settings.UIVisible = not Settings.UIVisible
        if mainFrame then
            mainFrame.Visible = Settings.UIVisible
        end
        return
    end

    -- 按Y键高亮鼠标下的玩家
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
end))

table.insert(connections, UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- 手机端不处理键盘事件
    if isMobile then return end

    if Settings.HoldToLock and input.UserInputType == Enum.UserInputType.MouseButton2 then
        holdLocking = false
        if isLocking then
            isLocking = false
            lockedTarget = nil
        end
    end
end))

-- 存储连接以便清除
getgenv()._connections = getgenv()._connections or {}
for _, conn in ipairs(connections) do
    table.insert(getgenv()._connections, conn)
end

-- ============================================
-- 主循环（每帧更新）
-- ============================================
RunService.RenderStepped:Connect(function()
    -- 更新 FOV 圆圈
    if Settings.ShowFOV and Settings.Enabled then
        FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        FOVCircle.Radius = Settings.FOV
        FOVCircle.Visible = true
        
        local hasTarget = false
        
        if isLocking and lockedTarget then
            local char = lockedTarget.Character
            if char 
               and char:FindFirstChild(Settings.AimPart) 
               and char:FindFirstChild("Humanoid") 
               and char.Humanoid.Health > 0 
               and isEnemy(lockedTarget) then
                hasTarget = true
            else
                lockedTarget = nil
                isLocking = false
                holdLocking = false
                -- 手机端更新锁定按钮文字
                if isMobile and lockBtn then
                    lockBtn.Text = "🔒 锁定"
                    lockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                end
            end
        end
        
        if not hasTarget then
            local closestPlayer = getClosestPlayer()
            if closestPlayer then
                hasTarget = true
            end
        end
        
        if hasTarget then
            FOVCircle.Color = Color3.fromRGB(100, 255, 100)
        else
            FOVCircle.Color = Color3.fromRGB(255, 50, 50)
        end
    else
        FOVCircle.Visible = false
    end

    -- 更新准星
    updateCrosshair()

    -- 更新透视
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
                    -- 手机端更新锁定按钮文字
                    if isMobile and lockBtn then
                        lockBtn.Text = "🔒 锁定"
                        lockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                    end
                end
            elseif not lockedTarget and holdLocking then
                isLocking = false
                if isMobile and lockBtn then
                    lockBtn.Text = "🔒 锁定"
                    lockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                end
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