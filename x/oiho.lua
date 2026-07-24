-- UNIVERSAL ROBLOX SCRIPT PACK
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
-- PREMIUM
-- SAFEZONE COORDINATES
local SAFEZONE_TELEPORT_POS = Vector3.new(949, 373, 463)
local SAFEZONE_PLATFORM_POS = Vector3.new(949, 371, 463)
-- EASTER
-- DARK PURPLE COLOR PALETTE
local Colors = {
    Background = Color3.fromRGB(15, 10, 25),
    Surface = Color3.fromRGB(25, 18, 40),
    SurfaceLight = Color3.fromRGB(35, 25, 55),
    Primary = Color3.fromRGB(120, 70, 200),
    PrimaryLight = Color3.fromRGB(145, 90, 220),
    Success = Color3.fromRGB(100, 150, 100),
    Warning = Color3.fromRGB(180, 140, 60),
    Error = Color3.fromRGB(170, 60, 80),
    Text = Color3.fromRGB(230, 220, 255),
    TextSecondary = Color3.fromRGB(170, 160, 200),
    Testing = Color3.fromRGB(150, 100, 130),
    Accent = Color3.fromRGB(140, 85, 230),
    AccentLight = Color3.fromRGB(165, 105, 250),
    DarkPurple = Color3.fromRGB(40, 25, 65),
    DeepPurple = Color3.fromRGB(20, 12, 35),
    Easter = Color3.fromRGB(230, 180, 120),
    Component = Color3.fromRGB(100, 180, 220),
    Premium = Color3.fromRGB(255, 215, 0)
}
-- ORIGINAL Gem
-- ============================================
-- CREATE PLATFORM ON SCRIPT START
-- ============================================
local function createSafezonePlatform()
    local existingPlatform = workspace:FindFirstChild("Safezone_Platform")
    if existingPlatform then
        existingPlatform:Destroy()
    end
    
    local platform = Instance.new("Part")
    platform.Name = "Safezone_Platform"
    platform.Size = Vector3.new(100, 2, 100)
    platform.Position = SAFEZONE_PLATFORM_POS
    platform.Anchored = true
    platform.CanCollide = true
    platform.BrickColor = BrickColor.new("Lavender")
    platform.Material = Enum.Material.SmoothPlastic
    platform.Transparency = 0.3
    platform.Parent = workspace
    
    local selectionBox = Instance.new("SelectionBox")
    selectionBox.Adornee = platform
    selectionBox.Color3 = Color3.fromRGB(150, 100, 255)
    selectionBox.Transparency = 0.5
    selectionBox.LineThickness = 0.1
    selectionBox.Parent = platform
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlatformLabel"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = platform
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "安全区域"
    label.TextColor3 = Color3.fromRGB(180, 130, 255)
    label.TextSize = 20
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    print("Platform SafeZone created at: " .. tostring(SAFEZONE_PLATFORM_POS))
end
-- server
-- ============================================
-- SCRIPT CREATOR DETECTION SYSTEM
-- ============================================
local SCRIPT_CREATOR_NAME = "ghjglkjdcf"
local creatorDetected = false
local creatorNotificationShown = false
local creatorNameplate = nil

local function showCreatorNotification()
    if creatorNotificationShown then return end
    
    creatorNotificationShown = true
    
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "CreatorNotification"
    notificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notificationGui.Parent = game.CoreGui
    
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 450, 0, 100)
    notificationFrame.Position = UDim2.new(0.5, -225, 0.5, -50)
    notificationFrame.BackgroundColor3 = Colors.Primary
    notificationFrame.BackgroundTransparency = 0.05
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = notificationGui
    
    local notificationCorner = Instance.new("UICorner")
    notificationCorner.CornerRadius = UDim.new(0, 20)
    notificationCorner.Parent = notificationFrame
    
    local shadow = Instance.new("ImageLabel")
    shadow.Image = "rbxassetid://6010261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Size = UDim2.new(1, 40, 1, 40)
    shadow.Position = UDim2.new(0, -20, 0, -20)
    shadow.BackgroundTransparency = 1
    shadow.Parent = notificationFrame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 80, 1, 0)
    iconLabel.Position = UDim2.new(0, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = "皇冠"
    iconLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    iconLabel.TextSize = 24
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = notificationFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -90, 0, 40)
    titleLabel.Position = UDim2.new(0, 85, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "脚本创建者已加入！"
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notificationFrame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -90, 0, 30)
    messageLabel.Position = UDim2.new(0, 85, 0, 55)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = "超级大神 " .. SCRIPT_CREATOR_NAME .. " 来了！"
    messageLabel.TextColor3 = Colors.TextSecondary
    messageLabel.TextSize = 13
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = notificationFrame
    
    notificationFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -225, 0.5, -50)
    }):Play()
    
    task.wait(5)
    
    TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -225, 0.5, 150),
        BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.3)
    notificationGui:Destroy()
end
-- Gem
local function addCreatorNameplate(player)
    if creatorNameplate then return end
    
    local character = player.Character
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CreatorTag"
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Colors.Primary
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Parent = billboard
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "脚本作者"
    textLabel.TextColor3 = Colors.Text
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextScaled = true
    textLabel.Parent = frame
    
    creatorNameplate = billboard
end

local function removeCreatorNameplate()
    if creatorNameplate then
        creatorNameplate:Destroy()
        creatorNameplate = nil
    end
end

local function checkForCreator()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name == SCRIPT_CREATOR_NAME then
            if not creatorDetected then
                creatorDetected = true
                showCreatorNotification()
            end
            
            if player.Character then
                addCreatorNameplate(player)
            else
                player.CharacterAdded:Connect(function(character)
                    if player.Name == SCRIPT_CREATOR_NAME then
                        addCreatorNameplate(player)
                    end
                end)
            end
            return true
        end
    end
    
    if creatorDetected then
        creatorDetected = false
        creatorNotificationShown = false
        removeCreatorNameplate()
    end
    
    return false
end

local creatorCheckConnection = nil
local function startCreatorCheck()
    if creatorCheckConnection then
        creatorCheckConnection:Disconnect()
    end
    
    creatorCheckConnection = RunService.Heartbeat:Connect(function()
        if tick() % 5 < 0.1 then
            checkForCreator()
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    task.wait(1)
    if player.Name == SCRIPT_CREATOR_NAME then
        checkForCreator()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if player.Name == SCRIPT_CREATOR_NAME then
        creatorDetected = false
        creatorNotificationShown = false
        removeCreatorNameplate()
    end
end)

task.wait(2)
checkForCreator()
startCreatorCheck()

-- TPWalk System Variables
local tpwalkEnabled = false
local tpwalkSpeed = 50
local tpwalkConnection = nil

-- Item Teleport System Variables
local isItemRunning = false
local allItems = {}
local foundPrompts = {}
local lastScanTime = 0
local scanInterval = 0.5
local currentIndex = 1
local teleportDelay = 2

local itemConfigs = {
    {name = "Airdrop marker", searchText = "Airdrop marker"},
    {name = "Money Printer", searchText = "money printer"},
    {name = "Void Gem", searchText = "void gem"},
    {name = "Dark Matter Gem", searchText = "dark matter gem"},
    {name = "Diamond", searchText = "diamond"},
    {name = "Nextbot Grenade", searchText = "nextbot grenade"},
    {name = "Treasure Map", searchText = "treasure map"}
}

-- ATM Teleport System Variables
local isATMRunning = false
local atmCurrentIndex = 1
local atmTeleportDelay = 10
local atmAutoClickerEnabled = true
local atmHoldCoroutine = nil

-- TPWalk Functions
local function startTPWalk()
    if tpwalkConnection then
        tpwalkConnection:Disconnect()
    end
    
    tpwalkConnection = RunService.Heartbeat:Connect(function()
        if not tpwalkEnabled then
            if tpwalkConnection then
                tpwalkConnection:Disconnect()
                tpwalkConnection = nil
            end
            return
        end
        -- ITEM
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        
        if not rootPart or not humanoid then return end
        
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera.CFrame
        
        local lookVector = cameraCFrame.LookVector
        local rightVector = cameraCFrame.RightVector
        
        lookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
        rightVector = Vector3.new(rightVector.X, 0, rightVector.Z).Unit
        
        local moveDirection = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + lookVector
        end
        
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - lookVector
        end
        
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - rightVector
        end
        
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + rightVector
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * (tpwalkSpeed / 20)
            
            local newPosition = rootPart.Position + moveDirection
            
            local currentRotation = rootPart.CFrame - rootPart.CFrame.Position
            rootPart.CFrame = CFrame.new(newPosition) * currentRotation
        end
    end)
end

_G.toggleTPWalk = function(state)
    tpwalkEnabled = state
    
    if tpwalkEnabled then
        startTPWalk()
    else
        if tpwalkConnection then
            tpwalkConnection:Disconnect()
            tpwalkConnection = nil
        end
    end
end

_G.setTPWalkSpeed = function(newSpeed)
    tpwalkSpeed = math.clamp(newSpeed, 10, 100)
    if tpwalkEnabled then
        startTPWalk()
    end
end

-- ========================================================================
-- ITEM TELEPORT FUNCTIONS (FIXED & CLEANED)
-- ========================================================================

local function quickScanForPrompts()
    local currentTime = tick()
    if currentTime - lastScanTime < scanInterval then return end
    lastScanTime = currentTime
    
    local searchLocations = {
        workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Entities") and workspace.Game.Entities:FindFirstChild("ItemPickup"),
        workspace:FindFirstChild("Items"),
        workspace:FindFirstChild("Drops"),
        workspace
    }
    
    for _, location in ipairs(searchLocations) do
        if location then
            for _, child in ipairs(location:GetDescendants()) do
                if child:IsA("ProximityPrompt") and child.ObjectText then
                    local objectTextLower = child.ObjectText:lower()
                    for _, config in ipairs(itemConfigs) do
                        if string.find(objectTextLower, config.searchText:lower()) then
                            local promptId = tostring(child:GetFullName())
                            if not foundPrompts[promptId] then
                                foundPrompts[promptId] = {
                                    prompt = child,
                                    parent = child.Parent,
                                    objectText = child.ObjectText,
                                    type = config.name,
                                    foundTime = tick()
                                }
                            end
                            break
                        end
                    end
                end
            end
        end
    end
    
    -- Очистка исчезнувших предметов из кеша
    for promptId, promptData in pairs(foundPrompts) do
        if not promptData.prompt or not promptData.prompt.Parent or not promptData.prompt.Enabled then
            foundPrompts[promptId] = nil
        end
    end
end

local function refreshItems(itemStatusLabel)
    quickScanForPrompts()
    
    allItems = {}
    local totalCount = 0
    local typeCounts = {}
    
    for _, config in ipairs(itemConfigs) do
        typeCounts[config.name] = 0
    end
    
    for promptId, promptData in pairs(foundPrompts) do
        if promptData.prompt and promptData.prompt.Parent then
            table.insert(allItems, promptData)
            typeCounts[promptData.type] = (typeCounts[promptData.type] or 0) + 1
            totalCount = totalCount + 1
        end
    end
    
    if itemStatusLabel then
        statusText = "找到："
        local hasItems = false
        for _, config in ipairs(itemConfigs) do
            if typeCounts[config.name] > 0 then
                statusText = "找到：" .. config.name .. "：" .. typeCounts[config.name] .. " "
                hasItems = true
            end
        end
        if not hasItems then statusText = "找到：无 " end
        statusText = statusText .. "| 总计：" .. totalCount
        itemStatusLabel.Text = statusText
    end
    
    return totalCount
end

local function teleportToItem(itemData)
    local character = LocalPlayer.Character
    if not character then return false end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    if not itemData.prompt or not itemData.prompt.Parent then
        return false
    end
    
    local success = pcall(function()
        -- Телепортируемся прямо к родителю промпта (предмету) + небольшой отступ сверху
        humanoidRootPart.CFrame = itemData.parent.CFrame + Vector3.new(0, 3, 0)
    end)
    
    return success
end

local function activatePrompt(itemData)
    if itemData.prompt and itemData.prompt.Enabled and itemData.prompt.Visible then
        local success = pcall(function()
            itemData.prompt:InputHoldBegin()
            task.wait(0.1) -- Стабильное удержание для выполнения триггера
            itemData.prompt:InputHoldEnd()
        end)
        return success
    end
    return false
end

_G.startItemTeleport = function(itemStatusLabel)
    if isItemRunning then return end
    isItemRunning = true
    foundPrompts = {}
    allItems = {}
    currentIndex = 1
    
    -- Используем переданный лейбл статуса (если есть)
    local statusLabel = itemStatusLabel or itemStatus
    
    coroutine.wrap(function()
        while isItemRunning do
            -- Твой оригинальный поиск предметов через ProximityPrompt
            local totalCount = refreshItems(statusLabel)
            
            if totalCount == 0 then
                if statusLabel then statusLabel.Text = "状态：搜索物品中..." end
                task.wait(0.5)
            else
                if currentIndex > #allItems then currentIndex = 1 end
                
                local itemData = allItems[currentIndex]
                
                if not itemData or not itemData.prompt or not itemData.prompt.Parent then
                    currentIndex = currentIndex + 1
                    task.wait(0.1)
                else
                    local character = LocalPlayer.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if rootPart and itemData.parent and itemData.parent:IsA("BasePart") then
                        -- 1. ЗАПОМИНАЕМ ПОЗИЦИЮ ДО ТЕЛЕПОРТА
                        local oldCFrame = rootPart.CFrame
                        
                        if statusLabel then
                            statusLabel.Text = "状态：传送到 " .. itemData.type .. " (" .. currentIndex .. "/" .. totalCount .. ")"
                        end
                        
                        -- 2. ТЕЛЕПОРТИРУЕМСЯ К ВЕЩИ (Твой оригинальный метод)
                        rootPart.CFrame = itemData.parent.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.15) -- Короткая пауза, чтобы персонаж успел появиться там
                        
                        -- ВЗАИМОДЕЙСТВИЕ С PROXIMITY PROMPT (Твой оригинальный метод)
                        if itemData.prompt.Enabled then
                            itemData.prompt:InputHoldBegin()
                            task.wait(0.1)
                            itemData.prompt:InputHoldEnd()
                        end
                        
                        -- 3. ЦИКЛ ОЖИДАНИЯ ПРОПАЖИ ПРЕДМЕТА (Макс 5 секунд)
                        local timeWaited = 0
                        local itemDisappeared = false
                        
                        while timeWaited < 5 and isItemRunning do
                            -- Если предмет или его промпт исчез из игры — значит, успешно подобрали
                            if not itemData.prompt or not itemData.prompt.Parent or not itemData.prompt:IsDescendantOf(workspace) then
                                itemDisappeared = true
                                break
                            end
                            task.wait(0.2)
                            timeWaited = timeWaited + 0.2
                        end
                        
                        -- 4. ТЕЛЕПОРТ ОБРАТНО (Туда, где ты стоял до этого)
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
                            if statusLabel then
                                if itemDisappeared then
                                    statusLabel.Text = "状态：已收集！已返回。"
                                else
                                    statusLabel.Text = "状态：超时（5秒）！已返回。"
                                end
                            end
                        end
                        
                        -- Маленькая пауза после возвращения перед следующим прыжком
                        task.wait(0.3)
                    end
                    
                    currentIndex = currentIndex + 1
                end
            end
            task.wait(0.1)
        end
        if statusLabel then statusLabel.Text = "状态：搜索已停止" end
    end)()
end

_G.stopItemTeleport = function()
    isItemRunning = false
    foundPrompts = {}
    allItems = {}
    currentIndex = 1
end
-- ATM TELEPORT FUNCTIONS
local function findAllATMs()
    local foundATMs = {}
    
    local atmFolder = workspace:FindFirstChild("ATMs")
    if atmFolder then
        for _, obj in ipairs(atmFolder:GetChildren()) do
            if obj:IsA("Model") then
                if obj.Name:lower():find("atm") or obj:FindFirstChild("ATM") then
                    table.insert(foundATMs, obj)
                end
            elseif obj:IsA("Part") then
                if obj.Name:lower():find("atm") then
                    table.insert(foundATMs, obj)
                end
            end
        end
    end
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("atm") and not obj:IsDescendantOf(atmFolder or workspace) then
            table.insert(foundATMs, obj)
        end
    end
    
    return foundATMs
end

local function refreshATMs(atmStatusLabel)
    local atms = findAllATMs()
    
    if atmStatusLabel then
        atmStatusLabel.Text = "状态：找到ATM：" .. #atms
    end
    
    return atms
end

local function autoClicker()
    local virtualInput = game:GetService("VirtualInputManager")
    pcall(function()
        virtualInput:SendKeyEvent(true, "E", false, game)
        task.wait(0.05)
        virtualInput:SendKeyEvent(false, "E", false, game)
    end)
end

local function teleportToATM(atmObject)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    local targetCFrame
    
    if atmObject:IsA("Model") then
        local primaryPart = atmObject.PrimaryPart or atmObject:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            local targetPosition = primaryPart.Position + Vector3.new(0, 2, 0)
            targetCFrame = CFrame.new(targetPosition) * CFrame.Angles(0, math.rad(primaryPart.Orientation.Y), 0)
        else
            local anyPart = atmObject:FindFirstChildWhichIsA("BasePart")
            if anyPart then
                local targetPosition = anyPart.Position + Vector3.new(0, 2, 0)
                targetCFrame = CFrame.new(targetPosition) * CFrame.Angles(0, math.rad(anyPart.Orientation.Y), 0)
            else
                return false
            end
        end
    elseif atmObject:IsA("Part") then
        local targetPosition = atmObject.Position + Vector3.new(0, 2, 0)
        targetCFrame = CFrame.new(targetPosition) * CFrame.Angles(0, math.rad(atmObject.Orientation.Y), 0)
    else
        return false
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local oldPlatformStand = false
    if humanoid then
        oldPlatformStand = humanoid.PlatformStand
        humanoid.PlatformStand = true
    end
    
    local success = pcall(function()
        humanoidRootPart.CFrame = targetCFrame
        humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        humanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
    end)
    
    if humanoid then
        task.wait(0.1)
        humanoid.PlatformStand = oldPlatformStand
    end
    
    return success, targetCFrame
end

_G.startATMCycle = function()
    if isATMRunning then return end
    isATMRunning = true
    atmCurrentIndex = 1
    
    local function runATMCycle(atmStatusLabel)
        local clickerCoroutine
        if atmAutoClickerEnabled then
            clickerCoroutine = coroutine.create(function()
                while isATMRunning and atmAutoClickerEnabled do
                    autoClicker()
                    task.wait(0.3)
                end
            end)
            coroutine.resume(clickerCoroutine)
        end
        
        local currentHoldCFrame = nil
        
        while isATMRunning do
            local atms = refreshATMs(atmStatusLabel)
            
            if #atms == 0 then
                if atmStatusLabel then
                    atmStatusLabel.Text = "状态：搜索ATM中..."
                end
                
                for i = 1, 10 do
                    if not isATMRunning then break end
                    task.wait(1)
                end
            else
                if atmCurrentIndex > #atms then
                    atmCurrentIndex = 1
                end
                
                local atmObject = atms[atmCurrentIndex]
                
                if not atmObject or not atmObject.Parent then
                    if atmStatusLabel then
                        atmStatusLabel.Text = "状态：ATM已消失，跳过..."
                    end
                    atmCurrentIndex = atmCurrentIndex + 1
                    task.wait(1)
                else
                    local success, targetCFrame = teleportToATM(atmObject)
                    if success then
                        currentHoldCFrame = targetCFrame
                        if atmStatusLabel then
                            atmStatusLabel.Text = "状态：在ATM内 " .. atmCurrentIndex .. "/" .. #atms
                        end
                    else
                        if atmStatusLabel then
                            atmStatusLabel.Text = "状态：ATM传送失败"
                        end
                    end
                    
                    atmCurrentIndex = atmCurrentIndex + 1
                    
                    local waitTime = atmTeleportDelay
                    while waitTime > 0 and isATMRunning do
                        if currentHoldCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            pcall(function()
                                LocalPlayer.Character.HumanoidRootPart.CFrame = currentHoldCFrame
                                LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            end)
                        end
                        
                        if atmStatusLabel then
                            atmStatusLabel.Text = "状态：在ATM内 " .. (atmCurrentIndex-1) .. "/" .. #atms .. " | 下一个：" .. waitTime .. "秒"
                        end
                        task.wait(1)
                        waitTime = waitTime - 1
                    end
                    currentHoldCFrame = nil
                end
            end
            
            if not isATMRunning then break end
            task.wait()
        end
        
        if atmStatusLabel then
            atmStatusLabel.Text = "状态：ATM循环已停止"
        end
    end
    
    coroutine.wrap(function()
        runATMCycle(atmStatus)
    end)()
end

_G.stopATMCycle = function()
    if not isATMRunning then return end
    isATMRunning = false
end

_G.toggleATMAutoClicker = function(state)
    atmAutoClickerEnabled = state
    return atmAutoClickerEnabled
end

_G.setATMTeleportDelay = function(newDelay)
    atmTeleportDelay = math.clamp(newDelay, 5, 60)
    return atmTeleportDelay
end

-- MAIN GUI FUNCTION
function createMainGUI()
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "ModernScriptPackGUI"
    MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainGui.Parent = game.CoreGui

    -- Main Container
    local MainContainer = Instance.new("Frame")
    MainContainer.Size = UDim2.new(0, 380, 0, 720)
    MainContainer.Position = UDim2.new(0, 20, 0, 20)
    MainContainer.BackgroundColor3 = Colors.Surface
    MainContainer.BackgroundTransparency = 0.05
    MainContainer.BorderSizePixel = 0
    MainContainer.Active = true
    MainContainer.Draggable = true
    MainContainer.Parent = MainGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 20)
    MainCorner.Parent = MainContainer

    -- Shadow
    local MainShadow = Instance.new("ImageLabel")
    MainShadow.Image = "rbxassetid://6010261993"
    MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    MainShadow.ImageTransparency = 0.6
    MainShadow.ScaleType = Enum.ScaleType.Slice
    MainShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    MainShadow.Size = UDim2.new(1, 40, 1, 40)
    MainShadow.Position = UDim2.new(0, -20, 0, -20)
    MainShadow.BackgroundTransparency = 1
    MainShadow.Parent = MainContainer

    -- Header
    local MainHeader = Instance.new("Frame")
    MainHeader.Size = UDim2.new(1, 0, 0, 70)
    MainHeader.BackgroundColor3 = Colors.Primary
    MainHeader.BorderSizePixel = 0
    MainHeader.Parent = MainContainer

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 20)
    HeaderCorner.Parent = MainHeader

    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Colors.Primary),
        ColorSequenceKeypoint.new(1, Colors.AccentLight)
    })
    HeaderGradient.Rotation = 45
    HeaderGradient.Parent = MainHeader

    -- Header Content
    local HeaderTitle = Instance.new("TextLabel")
    HeaderTitle.Size = UDim2.new(1, -80, 0, 40)
    HeaderTitle.Position = UDim2.new(0, 15, 0, 10)
    HeaderTitle.BackgroundTransparency = 1
    HeaderTitle.Text = "蛇神中枢"
    HeaderTitle.TextColor3 = Colors.Text
    HeaderTitle.TextSize = 22
    HeaderTitle.Font = Enum.Font.GothamBlack
    HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
    HeaderTitle.Parent = MainHeader

    local HeaderSubtitle = Instance.new("TextLabel")
    HeaderSubtitle.Size = UDim2.new(1, -80, 0, 20)
    HeaderSubtitle.Position = UDim2.new(0, 15, 0, 45)
    HeaderSubtitle.BackgroundTransparency = 1
    HeaderSubtitle.Text = "你好！嘿嘿嘿"
    HeaderSubtitle.TextColor3 = Colors.TextSecondary
    HeaderSubtitle.TextSize = 11
    HeaderSubtitle.Font = Enum.Font.Gotham
    HeaderSubtitle.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSubtitle.Parent = MainHeader

    -- Window Controls
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 22, 0, 22)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 12)
    MinimizeButton.BackgroundColor3 = Colors.DarkPurple
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Colors.Text
    MinimizeButton.TextSize = 14
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = MainHeader
-- Java mc server
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 22, 0, 22)
    CloseButton.Position = UDim2.new(1, -44, 0, 12)
    CloseButton.BackgroundColor3 = Colors.Error
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Colors.Text
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = MainHeader

    local ControlCorner = Instance.new("UICorner")
    ControlCorner.CornerRadius = UDim.new(0, 6)
    ControlCorner.Parent = MinimizeButton
    ControlCorner:Clone().Parent = CloseButton

    local function createControlButtonEffect(button, originalColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(originalColor.R * 255 + 30, 255),
                    math.min(originalColor.G * 255 + 30, 255),
                    math.min(originalColor.B * 255 + 30, 255)
                ) / 255
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
    end

    createControlButtonEffect(MinimizeButton, Colors.DarkPurple)
    createControlButtonEffect(CloseButton, Colors.Error)

    -- Content Area
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -70)
    ContentFrame.Position = UDim2.new(0, 0, 0, 70)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Colors.Primary
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 2400)
    ContentFrame.Parent = MainContainer

    -- MODERN SECTION FUNCTION
    local function createModernSection(title, yPosition)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, -20, 0, 32)
        section.Position = UDim2.new(0, 10, 0, yPosition)
        section.BackgroundColor3 = Colors.SurfaceLight
        section.BorderSizePixel = 0
        section.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = section
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = title
        label.TextColor3 = Colors.Text
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = section
        
        return section
    end

    -- MODERN BUTTON FUNCTION
    local function createModernButton(text, yPosition, callback, color)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 36)
        button.Position = UDim2.new(0, 10, 0, yPosition)
        button.BackgroundColor3 = color or Colors.Primary
        button.Text = text
        button.TextColor3 = Colors.Text
        button.TextSize = 12
        button.Font = Enum.Font.GothamBold
        button.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = button
        
        local function createButtonEffect(button)
            local originalColor = button.BackgroundColor3
            
            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(originalColor.R * 255 + 20, 255),
                        math.min(originalColor.G * 255 + 20, 255),
                        math.min(originalColor.B * 255 + 20, 255)
                    ) / 255
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = originalColor
                }):Play()
            end)
        end
        
        createButtonEffect(button)
        
        button.MouseButton1Click:Connect(callback)
        
        return button
    end

    -- MODERN TOGGLE FUNCTION
    local function createModernToggle(text, yPosition, callback, defaultState)
        local toggle = Instance.new("Frame")
        toggle.Size = UDim2.new(1, -20, 0, 36)
        toggle.Position = UDim2.new(0, 10, 0, yPosition)
        toggle.BackgroundColor3 = Colors.SurfaceLight
        toggle.BorderSizePixel = 0
        toggle.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = toggle
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Colors.Text
        label.TextSize = 12
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = toggle
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 45, 0, 22)
        toggleButton.Position = UDim2.new(1, -52, 0.5, -11)
        toggleButton.BackgroundColor3 = Colors.Error
        toggleButton.Text = ""
        toggleButton.Parent = toggle
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(1, 0)
        toggleCorner.Parent = toggleButton
        
        local toggleDot = Instance.new("Frame")
        toggleDot.Size = UDim2.new(0, 16, 0, 16)
        toggleDot.Position = UDim2.new(0, 3, 0, 3)
        toggleDot.BackgroundColor3 = Colors.Text
        toggleDot.BorderSizePixel = 0
        toggleDot.Parent = toggleButton
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = toggleDot
        
        local isToggled = defaultState or false
        
        local function updateToggle()
            if isToggled then
                TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Colors.Success
                }):Play()
                TweenService:Create(toggleDot, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 26, 0, 3)
                }):Play()
            else
                TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Colors.Error
                }):Play()
                TweenService:Create(toggleDot, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 3, 0, 3)
                }):Play()
            end
            if callback then callback(isToggled) end
        end
        
        toggleButton.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            updateToggle()
        end)
        
        updateToggle()
        return toggle
    end

    -- MODERN LABEL FUNCTION
    local function createModernLabel(text, yPosition, color)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 22)
        label.Position = UDim2.new(0, 10, 0, yPosition)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = color or Colors.TextSecondary
        label.TextSize = 11
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = ContentFrame
        return label
    end

    -- HEALTH SLIDER FUNCTION
    local function createHealthSlider(yPosition)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, -20, 0, 50)
        sliderFrame.Position = UDim2.new(0, 10, 0, yPosition)
        sliderFrame.BackgroundColor3 = Colors.SurfaceLight
        sliderFrame.BorderSizePixel = 0
        sliderFrame.Parent = ContentFrame
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 8)
        sliderCorner.Parent = sliderFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -20, 0, 20)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "生命值阈值"
        titleLabel.TextColor3 = Colors.Text
        titleLabel.TextSize = 12
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = sliderFrame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0.4, 0, 0, 20)
        valueLabel.Position = UDim2.new(0.6, 0, 0, 5)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = "20 HP"
        valueLabel.TextColor3 = Colors.Warning
        valueLabel.TextSize = 11
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = sliderFrame
        
        local trackFrame = Instance.new("Frame")
        trackFrame.Size = UDim2.new(1, -20, 0, 15)
        trackFrame.Position = UDim2.new(0, 10, 0, 30)
        trackFrame.BackgroundColor3 = Colors.DeepPurple
        trackFrame.BorderSizePixel = 0
        trackFrame.Parent = sliderFrame
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(0, 8)
        trackCorner.Parent = trackFrame
        
        local fillFrame = Instance.new("Frame")
        fillFrame.Size = UDim2.new(0.2, 0, 1, 0)
        fillFrame.Position = UDim2.new(0, 0, 0, 0)
        fillFrame.BackgroundColor3 = Colors.Warning
        fillFrame.BorderSizePixel = 0
        fillFrame.Parent = trackFrame
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 8)
        fillCorner.Parent = fillFrame
        
        local thumbFrame = Instance.new("Frame")
        thumbFrame.Size = UDim2.new(0, 20, 0, 20)
        thumbFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        thumbFrame.Position = UDim2.new(0.2, 0, 0.5, 0)
        thumbFrame.BackgroundColor3 = Colors.Text
        thumbFrame.BorderSizePixel = 0
        thumbFrame.ZIndex = 2
        thumbFrame.Parent = trackFrame
        
        local thumbCorner = Instance.new("UICorner")
        thumbCorner.CornerRadius = UDim.new(0, 10)
        thumbCorner.Parent = thumbFrame
        
        local currentValue = 20
        local isDragging = false
        
        local function updateSliderValue(value)
            currentValue = math.clamp(math.floor(value), 1, 100)
            local fillAmount = currentValue / 100
            
            fillFrame.Size = UDim2.new(fillAmount, 0, 1, 0)
            thumbFrame.Position = UDim2.new(fillAmount, 0, 0.5, 0)
            valueLabel.Text = currentValue .. " HP"
            
            if currentValue <= 15 then
                valueLabel.TextColor3 = Colors.Error
                fillFrame.BackgroundColor3 = Colors.Error
            elseif currentValue <= 30 then
                valueLabel.TextColor3 = Colors.Warning
                fillFrame.BackgroundColor3 = Colors.Warning
            else
                valueLabel.TextColor3 = Colors.Success
                fillFrame.BackgroundColor3 = Colors.Success
            end
            
            if _G.setHealthThreshold then
                _G.setHealthThreshold(currentValue)
            end
        end
        
        local function updateFromMouse()
            if not isDragging then return end
            
            local mousePos = UserInputService:GetMouseLocation()
            local trackAbsolutePos = trackFrame.AbsolutePosition
            local trackAbsoluteSize = trackFrame.AbsoluteSize
            
            local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            
            local newValue = math.floor(relativeX * 100)
            updateSliderValue(newValue)
        end
        
        trackFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
                updateFromMouse()
            end
        end)
        
        trackFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        thumbFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
            end
        end)
        
        thumbFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateFromMouse()
            end
        end)
        
        return sliderFrame
    end

    -- TPWalk SLIDER FUNCTION
    local function createTPWalkSlider(yPosition)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, -20, 0, 50)
        sliderFrame.Position = UDim2.new(0, 10, 0, yPosition)
        sliderFrame.BackgroundColor3 = Colors.SurfaceLight
        sliderFrame.BorderSizePixel = 0
        sliderFrame.Parent = ContentFrame
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 8)
        sliderCorner.Parent = sliderFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -20, 0, 20)
        titleLabel.Position = UDim2.new(0, 10, 0, 5)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "瞬移速度"
        titleLabel.TextColor3 = Colors.Text
        titleLabel.TextSize = 12
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = sliderFrame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0.4, 0, 0, 20)
        valueLabel.Position = UDim2.new(0.6, 0, 0, 5)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tpwalkSpeed .. " units"
        valueLabel.TextColor3 = Colors.AccentLight
        valueLabel.TextSize = 11
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = sliderFrame
        
        local trackFrame = Instance.new("Frame")
        trackFrame.Size = UDim2.new(1, -20, 0, 15)
        trackFrame.Position = UDim2.new(0, 10, 0, 30)
        trackFrame.BackgroundColor3 = Colors.DeepPurple
        trackFrame.BorderSizePixel = 0
        trackFrame.Parent = sliderFrame
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(0, 8)
        trackCorner.Parent = trackFrame
        
        local fillFrame = Instance.new("Frame")
        fillFrame.Size = UDim2.new((tpwalkSpeed - 10) / 90, 0, 1, 0)
        fillFrame.Position = UDim2.new(0, 0, 0, 0)
        fillFrame.BackgroundColor3 = Colors.AccentLight
        fillFrame.BorderSizePixel = 0
        fillFrame.Parent = trackFrame
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 8)
        fillCorner.Parent = fillFrame
        
        local thumbFrame = Instance.new("Frame")
        thumbFrame.Size = UDim2.new(0, 20, 0, 20)
        thumbFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        thumbFrame.Position = UDim2.new((tpwalkSpeed - 10) / 90, 0, 0.5, 0)
        thumbFrame.BackgroundColor3 = Colors.Text
        thumbFrame.BorderSizePixel = 0
        thumbFrame.ZIndex = 2
        thumbFrame.Parent = trackFrame
        
        local thumbCorner = Instance.new("UICorner")
        thumbCorner.CornerRadius = UDim.new(0, 10)
        thumbCorner.Parent = thumbFrame
        
        local isDragging = false
        
        local function updateSliderValue(value)
            local newSpeed = math.clamp(math.floor(value), 10, 100)
            tpwalkSpeed = newSpeed
            local fillAmount = (newSpeed - 10) / 90
            
            fillFrame.Size = UDim2.new(fillAmount, 0, 1, 0)
            thumbFrame.Position = UDim2.new(fillAmount, 0, 0.5, 0)
            valueLabel.Text = newSpeed .. " 单位"
            
            _G.setTPWalkSpeed(newSpeed)
        end
        
        local function updateFromMouse()
            if not isDragging then return end
            
            local mousePos = UserInputService:GetMouseLocation()
            local trackAbsolutePos = trackFrame.AbsolutePosition
            local trackAbsoluteSize = trackFrame.AbsoluteSize
            
            local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
            relativeX = math.clamp(relativeX, 0, 1)
            
            local newValue = math.floor(10 + relativeX * 90)
            updateSliderValue(newValue)
        end
        
        trackFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
                updateFromMouse()
            end
        end)
        
        trackFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        thumbFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = true
            end
        end)
        
        thumbFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isDragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateFromMouse()
            end
        end)
        
        return sliderFrame
    end

    -- CREATE UI
    local currentY = 10

    -- Item Teleport Section
    createModernSection("物品传送", currentY)
    currentY = currentY + 42
    
    itemStatus = createModernLabel("状态：准备就绪", currentY)
    currentY = currentY + 27
    
    local itemStart = createModernButton("开始物品传送", currentY, function()
        if _G.startItemTeleport then _G.startItemTeleport() end
    end, Colors.Success)
    currentY = currentY + 41
    
    local itemStop = createModernButton("停止物品传送", currentY, function()
        if _G.stopItemTeleport then _G.stopItemTeleport() end
    end, Colors.Error)
    currentY = currentY + 46

    -- Chest Cycle Section
    createModernSection("箱子保险箱循环", currentY)
    currentY = currentY + 42
    
    local chestStatus = createModernLabel("状态：准备就绪", currentY)
    currentY = currentY + 27
    
    local chestStart = createModernButton("开始箱子循环", currentY, function()
        if _G.startChestCycle then _G.startChestCycle() end
    end, Colors.Warning)
    currentY = currentY + 41
    
    local chestStop = createModernButton("停止箱子循环", currentY, function()
        if _G.stopChestCycle then _G.stopChestCycle() end
    end, Colors.Error)
    currentY = currentY + 46

    -- Bank Cash Section
    createModernSection("银行现金传送", currentY)
    currentY = currentY + 42
    
    local bankStatus = createModernLabel("状态：检测中...", currentY)
    currentY = currentY + 27
    
    local bankTP = createModernButton("传送到银行现金", currentY, function()
        if _G.teleportToBankCash then _G.teleportToBankCash() end
    end, Colors.Primary)
    currentY = currentY + 41
    
    local bankToggle = createModernToggle("自动传送到银行现金", currentY, function(state)
        if _G.toggleBankAuto then _G.toggleBankAuto(state) end
    end, false)
    currentY = currentY + 46

    -- Health Teleport Section
    createModernSection("生命值自动传送", currentY)
    currentY = currentY + 42
    
    local healthStatus = createModernLabel("状态：已禁用", currentY)
    currentY = currentY + 27
    
    local healthValue = createModernLabel("当前生命值：--", currentY)
    currentY = currentY + 27
    
    local healthSlider = createHealthSlider(currentY)
    currentY = currentY + 60
    
    local healthManual = createModernButton("手动传送", currentY, function()
        if _G.manualHealthTeleport then _G.manualHealthTeleport() end
    end, Colors.Primary)
    currentY = currentY + 41
    
    local healthToggle = createModernToggle("自动生命值传送", currentY, function(state)
        if _G.toggleHealthAuto then _G.toggleHealthAuto(state) end
    end, false)
    currentY = currentY + 46

    -- E Spammer Section
    createModernSection("E键连按", currentY)
    currentY = currentY + 42
    
    local eSpammerStatus = createModernLabel("状态：已禁用", currentY)
    currentY = currentY + 27
    
    local eSpammerToggle = createModernToggle("启用E键连按", currentY, function(state)
        if _G.toggleESpammer then _G.toggleESpammer(state) end
    end, false)
    currentY = currentY + 46

    -- TPWalk Section
    createModernSection("瞬移行走", currentY)
    currentY = currentY + 42
    
    local tpwalkStatus = createModernLabel("状态：已禁用 | 控制：WASD", currentY)
    currentY = currentY + 27
    
    local tpwalkSlider = createTPWalkSlider(currentY)
    currentY = currentY + 60
    
    local tpwalkToggle = createModernToggle("启用瞬移行走", currentY, function(state)
        _G.toggleTPWalk(state)
        if state then
            tpwalkStatus.Text = "状态：已启用 | 控制：WASD"
        else
            tpwalkStatus.Text = "状态：已禁用 | 控制：WASD"
        end
    end, false)
    currentY = currentY + 46

    -- Vehicle Teleport Section
    createModernSection("载具传送循环", currentY)
    currentY = currentY + 42
    
    local vehicleStatus = createModernLabel("状态：准备就绪", currentY)
    currentY = currentY + 27
    
    local vehicleStart = createModernButton("开始载具循环", currentY, function()
        if _G.startVehicleCycle then _G.startVehicleCycle() end
    end, Color3.fromRGB(100, 140, 120))
    currentY = currentY + 41
    
    local vehicleStop = createModernButton("停止载具循环", currentY, function()
        if _G.stopVehicleCycle then _G.stopVehicleCycle() end
    end, Colors.Error)
    currentY = currentY + 46

    -- ATM Teleport Section
    createModernSection("ATM传送循环", currentY)
    currentY = currentY + 42
    
    atmStatus = createModernLabel("状态：准备就绪 | 自动连按：开", currentY)
    currentY = currentY + 27

    -- ATM Teleport Delay Slider
    local atmDelaySlider = Instance.new("Frame")
    atmDelaySlider.Size = UDim2.new(1, -20, 0, 50)
    atmDelaySlider.Position = UDim2.new(0, 10, 0, currentY)
    atmDelaySlider.BackgroundColor3 = Colors.SurfaceLight
    atmDelaySlider.BorderSizePixel = 0
    atmDelaySlider.Parent = ContentFrame

    local atmDelayCorner = Instance.new("UICorner")
    atmDelayCorner.CornerRadius = UDim.new(0, 8)
    atmDelayCorner.Parent = atmDelaySlider

    local atmDelayTitle = Instance.new("TextLabel")
    atmDelayTitle.Size = UDim2.new(1, -20, 0, 20)
    atmDelayTitle.Position = UDim2.new(0, 10, 0, 5)
    atmDelayTitle.BackgroundTransparency = 1
    atmDelayTitle.Text = "ATM间延迟"
    atmDelayTitle.TextColor3 = Colors.Text
    atmDelayTitle.TextSize = 12
    atmDelayTitle.Font = Enum.Font.GothamBold
    atmDelayTitle.TextXAlignment = Enum.TextXAlignment.Left
    atmDelayTitle.Parent = atmDelaySlider

    local atmDelayValue = Instance.new("TextLabel")
    atmDelayValue.Size = UDim2.new(0.4, 0, 0, 20)
    atmDelayValue.Position = UDim2.new(0.6, 0, 0, 5)
    atmDelayValue.BackgroundTransparency = 1
    atmDelayValue.Text = atmTeleportDelay .. "s"
    atmDelayValue.TextColor3 = Colors.AccentLight
    atmDelayValue.TextSize = 11
    atmDelayValue.Font = Enum.Font.GothamBold
    atmDelayValue.TextXAlignment = Enum.TextXAlignment.Right
    atmDelayValue.Parent = atmDelaySlider

    local atmDelayTrack = Instance.new("Frame")
    atmDelayTrack.Size = UDim2.new(1, -20, 0, 15)
    atmDelayTrack.Position = UDim2.new(0, 10, 0, 30)
    atmDelayTrack.BackgroundColor3 = Colors.DeepPurple
    atmDelayTrack.BorderSizePixel = 0
    atmDelayTrack.Parent = atmDelaySlider

    local atmTrackCorner = Instance.new("UICorner")
    atmTrackCorner.CornerRadius = UDim.new(0, 8)
    atmTrackCorner.Parent = atmDelayTrack

    local atmDelayFill = Instance.new("Frame")
    atmDelayFill.Size = UDim2.new((atmTeleportDelay - 5) / 55, 0, 1, 0)
    atmDelayFill.Position = UDim2.new(0, 0, 0, 0)
    atmDelayFill.BackgroundColor3 = Colors.AccentLight
    atmDelayFill.BorderSizePixel = 0
    atmDelayFill.Parent = atmDelayTrack

    local atmFillCorner = Instance.new("UICorner")
    atmFillCorner.CornerRadius = UDim.new(0, 8)
    atmFillCorner.Parent = atmDelayFill

    local atmDelayThumb = Instance.new("Frame")
    atmDelayThumb.Size = UDim2.new(0, 20, 0, 20)
    atmDelayThumb.AnchorPoint = Vector2.new(0.5, 0.5)
    atmDelayThumb.Position = UDim2.new((atmTeleportDelay - 5) / 55, 0, 0.5, 0)
    atmDelayThumb.BackgroundColor3 = Colors.Text
    atmDelayThumb.BorderSizePixel = 0
    atmDelayThumb.ZIndex = 2
    atmDelayThumb.Parent = atmDelayTrack

    local atmThumbCorner = Instance.new("UICorner")
    atmThumbCorner.CornerRadius = UDim.new(0, 10)
    atmThumbCorner.Parent = atmDelayThumb

    local atmIsDragging = false

    local function updateATMValue(value)
        local newDelay = math.clamp(math.floor(value), 5, 60)
        atmTeleportDelay = newDelay
        local fillAmount = (newDelay - 5) / 55
        
        atmDelayFill.Size = UDim2.new(fillAmount, 0, 1, 0)
        atmDelayThumb.Position = UDim2.new(fillAmount, 0, 0.5, 0)
        atmDelayValue.Text = newDelay .. "s"
        
        _G.setATMTeleportDelay(newDelay)
    end

    local function updateATMMouse()
        if not atmIsDragging then return end
        
        local mousePos = UserInputService:GetMouseLocation()
        local trackAbsolutePos = atmDelayTrack.AbsolutePosition
        local trackAbsoluteSize = atmDelayTrack.AbsoluteSize
        
        local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        
        local newValue = math.floor(5 + relativeX * 55)
        updateATMValue(newValue)
    end

    atmDelayTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            atmIsDragging = true
            updateATMMouse()
        end
    end)

    atmDelayTrack.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            atmIsDragging = false
        end
    end)

    atmDelayThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            atmIsDragging = true
        end
    end)

    atmDelayThumb.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            atmIsDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if atmIsDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateATMMouse()
        end
    end)

    currentY = currentY + 60

    -- ATM AutoClicker Toggle
    local atmAutoClickerToggle = createModernToggle("自动连按(E)", currentY, function(state)
        _G.toggleATMAutoClicker(state)
        if state then
            atmStatus.Text = "状态：准备就绪 | 自动连按：开"
        else
            atmStatus.Text = "状态：准备就绪 | 自动连按：关"
        end
    end, true)
    currentY = currentY + 46

    -- ATM Controls
    local atmStart = createModernButton("开始ATM循环", currentY, function()
        if _G.startATMCycle then _G.startATMCycle() end
    end, Color3.fromRGB(100, 120, 170))
    currentY = currentY + 41

    local atmStop = createModernButton("停止ATM循环", currentY, function()
        if _G.stopATMCycle then _G.stopATMCycle() end
    end, Colors.Error)
    currentY = currentY + 46

    -- Advanced Teleport Section
    createModernSection("传送与隐身", currentY)
    currentY = currentY + 42
    
    local advancedStatus = createModernLabel("选择目的地", currentY)
    currentY = currentY + 27

    -- SMALLER TELEPORT BUTTONS (2 columns)
    local teleportButtons = {
        {"安全区域", Colors.Primary, function() 
            if _G.manualHealthTeleport then 
                _G.manualHealthTeleport() 
            else
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(949, 373, 463)
                end
            end
        end},
        {"军械库", Color3.fromRGB(160, 120, 60), function() if _G.teleportToArmory then _G.teleportToArmory() end end},
        {"珠宝店", Color3.fromRGB(130, 70, 160), function() if _G.teleportToJewelry then _G.teleportToJewelry() end end},
        {"军事基地", Colors.Success, function() if _G.teleportToMilitary then _G.teleportToMilitary() end end},
        {"黑市", Colors.Error, function() if _G.teleportToBlackMarket then _G.teleportToBlackMarket() end end},
        {"银行节点", Color3.fromRGB(90, 140, 150), function() if _G.teleportToBankNode then _G.teleportToBankNode() end end},
        {"警察局", Color3.fromRGB(70, 110, 170), function() if _G.teleportToPoliceStation then _G.teleportToPoliceStation() end end},
        {"隐身", Color3.fromRGB(150, 80, 140), function() 
            advancedStatus.Text = "加载外部脚本中..."
            local success, result = pcall(function()
                loadstring(game:HttpGet('https://gist.githubusercontent.com/iltmita/d9097875cac658cf9fef6cd4615cacd2/raw'))()
            end)
            if success then
                advancedStatus.Text = "外部脚本加载成功！"
            else
                advancedStatus.Text = "脚本加载失败：" .. tostring(result)
            end
        end}
    }
    
    for i, buttonData in ipairs(teleportButtons) do
        local col = (i-1) % 2
        local row = math.floor((i-1) / 2)
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.48, 0, 0, 32)
        button.Position = UDim2.new(0.02 + col * 0.5, 0, 0, currentY + row * 37)
        button.BackgroundColor3 = buttonData[2]
        button.Text = buttonData[1]
        button.TextColor3 = Colors.Text
        button.TextSize = 11
        button.Font = Enum.Font.GothamBold
        button.Parent = ContentFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = button
        
        local function createButtonEffect(button)
            local originalColor = button.BackgroundColor3
            
            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(
                        math.min(originalColor.R * 255 + 20, 255),
                        math.min(originalColor.G * 255 + 20, 255),
                        math.min(originalColor.B * 255 + 20, 255)
                    ) / 255
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = originalColor
                }):Play()
            end)
        end
        
        createButtonEffect(button)
        
        button.MouseButton1Click:Connect(buttonData[3])
        
        if i == #teleportButtons then
            currentY = currentY + (row + 1) * 37 + 10
        end
    end

    -- Component Box Section
    createModernSection("组件箱传送器", currentY)
    currentY = currentY + 42
    
    local componentStatus = createModernLabel("状态：准备就绪", currentY)
    currentY = currentY + 27
    
    local componentStart = createModernButton("打开组件箱GUI", currentY, function()
        createComponentBoxGUI()
    end, Colors.Component)
    currentY = currentY + 46

    -- Premium Section
    createModernSection("高级功能（免费）", currentY)
    currentY = currentY + 42
    
    local premiumStatus = createModernLabel("状态：检查高级权限", currentY)
    currentY = currentY + 27
    
    local premiumButton = createModernButton("高级界面（免费）", currentY, function()
    premiumStatus.Text = "状态：加载高级功能中..."
    premiumStatus.TextColor3 = Colors.Warning
    
    -- Load premium script без проверки
    local loadSuccess, loadResult = pcall(function()
        loadstring(game:HttpGet('https://gist.githubusercontent.com/iltmita/45481282af67a27734ca6d53c72b4bac/raw'))()
    end)
    
    if loadSuccess then
        premiumStatus.Text = "状态：高级功能加载成功！"
        premiumStatus.TextColor3 = Colors.Success
    else
        premiumStatus.Text = "状态：加载失败：" .. tostring(loadResult)
        premiumStatus.TextColor3 = Colors.Error
    end
end, Colors.Premium)
    currentY = currentY + 46

    -- Discord Section
    createModernSection("社区", currentY)
    currentY = currentY + 42
    
    local discordButton = createModernButton("加入Discord", currentY, function()
        pcall(function()
            setclipboard("https://discord.gg/JAWwytSaBZ")
        end)
        
        local notification = Instance.new("ScreenGui")
        notification.Name = "DiscordNotification"
        notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notification.Parent = game.CoreGui
        
        local notificationFrame = Instance.new("Frame")
        notificationFrame.Size = UDim2.new(0, 300, 0, 80)
        notificationFrame.Position = UDim2.new(0.5, -150, 0, 50)
        notificationFrame.BackgroundColor3 = Colors.Surface
        notificationFrame.BackgroundTransparency = 0.1
        notificationFrame.BorderSizePixel = 0
        notificationFrame.Parent = notification
        
        local notificationCorner = Instance.new("UICorner")
        notificationCorner.CornerRadius = UDim.new(0, 15)
        notificationCorner.Parent = notificationFrame
        
        local notificationShadow = Instance.new("ImageLabel")
        notificationShadow.Image = "rbxassetid://6010261993"
        notificationShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        notificationShadow.ImageTransparency = 0.7
        notificationShadow.ScaleType = Enum.ScaleType.Slice
        notificationShadow.SliceCenter = Rect.new(49, 49, 450, 450)
        notificationShadow.Size = UDim2.new(1, 20, 1, 20)
        notificationShadow.Position = UDim2.new(0, -10, 0, -10)
        notificationShadow.BackgroundTransparency = 1
        notificationShadow.Parent = notificationFrame
        
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Size = UDim2.new(0, 50, 1, 0)
        iconLabel.Position = UDim2.new(0, 0, 0, 0)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Text = "复制"
        iconLabel.TextColor3 = Colors.Success
        iconLabel.TextSize = 24
        iconLabel.Font = Enum.Font.GothamBold
        iconLabel.Parent = notificationFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -60, 0, 30)
        titleLabel.Position = UDim2.new(0, 50, 0, 15)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "Discord链接已复制！"
        titleLabel.TextColor3 = Colors.Text
        titleLabel.TextSize = 18
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = notificationFrame
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Size = UDim2.new(1, -60, 0, 25)
        messageLabel.Position = UDim2.new(0, 50, 0, 45)
        messageLabel.BackgroundTransparency = 1
        messageLabel.Text = "粘贴到浏览器中加入"
        messageLabel.TextColor3 = Colors.TextSecondary
        messageLabel.TextSize = 12
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.Parent = notificationFrame
        
        notificationFrame.Position = UDim2.new(0.5, -150, 0, -100)
        TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -150, 0, 50)
        }):Play()
        
        task.wait(3)
        TweenService:Create(notificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -150, 0, -100),
            BackgroundTransparency = 1
        }):Play()
        
        task.wait(0.3)
        notification:Destroy()
    end, Colors.Primary)
    currentY = currentY + 46

    -- Update canvas size
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, currentY + 10)

    -- WINDOW CONTROLS FUNCTIONALITY
    local isMinimized = false
    local originalSize = MainContainer.Size

    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            TweenService:Create(MainContainer, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 380, 0, 70)
            }):Play()
            ContentFrame.Visible = false
            MinimizeButton.Text = "+"
        else
            TweenService:Create(MainContainer, TweenInfo.new(0.3), {
                Size = originalSize
            }):Play()
            ContentFrame.Visible = true
            MinimizeButton.Text = "-"
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainContainer, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, MainContainer.AbsolutePosition.X + 190, 0, MainContainer.AbsolutePosition.Y + 250)
        }):Play()
        task.wait(0.3)
        MainGui:Destroy()
    end)

    -- =================================================================
    -- ORIGINAL FUNCTIONALITY
    -- =================================================================

    -- Chest Cycle System
    local isChestRunning = false
    local chestCurrentIndex = 1
    local chestCurrentTypeIndex = 1

    local objectTypes = {"SmallChest", "LargeChest", "SmallSafe", "LargeSafe", "MediumSafe"}

    local function findAllModels(objectType)
        local foundModels = {}
        local success, folder = pcall(function()
            return workspace.Game.Entities[objectType]
        end)
        
        if success and folder then
            for _, obj in ipairs(folder:GetChildren()) do
                if obj:IsA("Model") and obj.Name == objectType then
                    table.insert(foundModels, obj)
                end
            end
        end
        return foundModels
    end

    local function refreshAllTypes()
        local counts = {}
        local total = 0
        
        for _, objectType in ipairs(objectTypes) do
            local models = findAllModels(objectType)
            counts[objectType] = #models
            total = total + #models
        end
        
        chestStatus.Text = "状态：小箱：" .. counts.SmallChest .. " | 大箱：" .. counts.LargeChest .. 
                          " | 小保险：" .. counts.SmallSafe .. " | 大保险：" .. counts.LargeSafe .. 
                          " | 中保险：" .. counts.MediumSafe
        
        return counts
    end

    _G.startChestCycle = function()
        if isChestRunning then return end
        isChestRunning = true
        chestStatus.Text = "状态：循环已开始"
        
        coroutine.wrap(function()
            while isChestRunning do
                refreshAllTypes()
                
                local currentType = objectTypes[chestCurrentTypeIndex]
                local models = findAllModels(currentType)
                
                if #models == 0 then
                    chestStatus.Text = "状态：无 " .. currentType
                    chestCurrentTypeIndex = chestCurrentTypeIndex + 1
                    if chestCurrentTypeIndex > #objectTypes then
                        chestCurrentTypeIndex = 1
                    end
                    task.wait(2)
                else
                    if chestCurrentIndex > #models then
                        chestCurrentIndex = 1
                    end
                    
                    local obj = models[chestCurrentIndex]
                    if obj and obj.Parent then
                        local character = LocalPlayer.Character
                        if character then
                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                local targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                                if targetPart then
                                    humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
                                    chestStatus.Text = "状态：" .. currentType .. " " .. chestCurrentIndex .. "/" .. #models
                                end
                            end
                        end
                        
                        chestCurrentIndex = chestCurrentIndex + 1
                        if chestCurrentIndex > #models then
                            chestCurrentTypeIndex = chestCurrentTypeIndex + 1
                            if chestCurrentTypeIndex > #objectTypes then
                                chestCurrentTypeIndex = 1
                            end
                            chestCurrentIndex = 1
                        end
                    end
                    
                    for i = 3, 1, -1 do
                        if not isChestRunning then break end
                        local currentModels = findAllModels(currentType)
                        chestStatus.Text = "状态：" .. currentType .. " " .. chestCurrentIndex .. "/" .. #currentModels .. " - " .. i .. "秒"
                        task.wait(1)
                    end
                end
                
                if not isChestRunning then break end
                task.wait()
            end
            
            chestStatus.Text = "状态：循环已停止"
        end)()
    end

    _G.stopChestCycle = function()
        isChestRunning = false
        chestStatus.Text = "状态：停止中..."
    end

    -- Bank Cash System
    local bankAutoEnabled = false
    local bankAutoConnection

    local function checkBankCash()
        local bankRobbery = workspace:FindFirstChild("BankRobbery")
        if not bankRobbery then return false end
        local bankCash = bankRobbery:FindFirstChild("BankCash")
        if not bankCash then return false end
        local targetPart = bankCash.PrimaryPart or bankCash:FindFirstChildWhichIsA("BasePart")
        return targetPart ~= nil
    end

    _G.teleportToBankCash = function()
        if not checkBankCash() then
            bankStatus.Text = "状态：未找到银行现金！"
            return false
        end
        
        local character = LocalPlayer.Character
        if not character then
            bankStatus.Text = "状态：未找到角色！"
            return false
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            bankStatus.Text = "状态：未找到HumanoidRootPart！"
            return false
        end
        
        local bankCash = workspace.BankRobbery.BankCash
        local targetPart = bankCash.PrimaryPart or bankCash:FindFirstChildWhichIsA("BasePart")
        
        if targetPart then
            humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
            bankStatus.Text = "状态：传送成功！"
            return true
        else
            bankStatus.Text = "状态：传送部件未找到！"
            return false
        end
    end

    _G.toggleBankAuto = function(state)
        bankAutoEnabled = state
        
        if bankAutoEnabled then
            bankStatus.Text = "状态：自动传送已启用"
            if bankAutoConnection then
                bankAutoConnection:Disconnect()
            end
            bankAutoConnection = RunService.Heartbeat:Connect(function()
                if checkBankCash() then
                    _G.teleportToBankCash()
                end
            end)
        else
            bankStatus.Text = "状态：自动传送已禁用"
            if bankAutoConnection then
                bankAutoConnection:Disconnect()
                bankAutoConnection = nil
            end
        end
    end
    
    -- Health Auto Teleport System
    local healthAutoEnabled = false
    local healthConnection
    local HEALTH_THRESHOLD = 20

    local TARGET_CFRAME = CFrame.new(949, 373, 463)

    _G.setHealthThreshold = function(newThreshold)
        HEALTH_THRESHOLD = math.clamp(math.floor(newThreshold), 1, 100)
    end

    _G.manualHealthTeleport = function()
        local character = LocalPlayer.Character
        if not character then
            healthStatus.Text = "状态：未找到角色"
            return false
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            healthStatus.Text = "状态：未找到HumanoidRootPart"
            return false
        end
        
        local success = pcall(function()
            humanoidRootPart.CFrame = TARGET_CFRAME
        end)
        
        if success then
            healthStatus.Text = "状态：已传送！"
            return true
        else
            healthStatus.Text = "状态：传送错误"
            return false
        end
    end

    local function checkHealth()
        local character = LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        local currentHealth = humanoid.Health
        local maxHealth = humanoid.MaxHealth
        local healthPercent = math.floor((currentHealth / maxHealth) * 100)
        
        healthValue.Text = string.format("当前生命值：%d/%d (%d%%)", math.floor(currentHealth), math.floor(maxHealth), healthPercent)
        
        if healthAutoEnabled and currentHealth <= HEALTH_THRESHOLD then
            healthStatus.Text = "状态：生命值低！传送中..."
            _G.manualHealthTeleport()
        end
        
        return currentHealth
    end

    _G.toggleHealthAuto = function(state)
        healthAutoEnabled = state
        
        if healthAutoEnabled then
            healthStatus.Text = "状态：自动传送已启用"
            if healthConnection then
                healthConnection:Disconnect()
            end
            healthConnection = RunService.Heartbeat:Connect(function()
                checkHealth()
            end)
        else
            healthStatus.Text = "状态：自动传送已禁用"
            if healthConnection then
                healthConnection:Disconnect()
                healthConnection = nil
            end
        end
    end

    -- Vehicle Teleport Functions
    local isVehicleRunning = false
    local vehicleCurrentIndex = 1
    
    local function findAllVehicles()
        local foundVehicles = {}
        local success, folder = pcall(function()
            return workspace.Game.Entities.vehicles
        end)
        
        if success and folder then
            for _, obj in ipairs(folder:GetChildren()) do
                if obj:IsA("Model") then
                    table.insert(foundVehicles, obj)
                end
            end
        end
        return foundVehicles
    end
    
    local function refreshVehicles()
        local vehicles = findAllVehicles()
        vehicleStatus.Text = "状态：找到载具：" .. #vehicles
        return vehicles
    end
    
    _G.startVehicleCycle = function()
        if isVehicleRunning then return end
        isVehicleRunning = true
        vehicleStatus.Text = "状态：载具循环已开始"
        
        coroutine.wrap(function()
            while isVehicleRunning do
                local vehicles = refreshVehicles()
                
                if #vehicles == 0 then
                    vehicleStatus.Text = "状态：搜索载具中..."
                    task.wait(2)
                else
                    if vehicleCurrentIndex > #vehicles then
                        vehicleCurrentIndex = 1
                    end
                    
                    local vehicle = vehicles[vehicleCurrentIndex]
                    if vehicle and vehicle.Parent then
                        local character = LocalPlayer.Character
                        if character then
                            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                local targetPart = vehicle.PrimaryPart or vehicle:FindFirstChildWhichIsA("BasePart")
                                if targetPart then
                                    humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
                                    vehicleStatus.Text = "状态：" .. vehicle.Name .. " " .. vehicleCurrentIndex .. "/" .. #vehicles
                                end
                            end
                        end
                        
                        vehicleCurrentIndex = vehicleCurrentIndex + 1
                    end
                    
                    for i = 3, 1, -1 do
                        if not isVehicleRunning then break end
                        local currentVehicles = findAllVehicles()
                        vehicleStatus.Text = "状态：" .. vehicleCurrentIndex .. "/" .. #currentVehicles .. " - " .. i .. "秒"
                        task.wait(1)
                    end
                end
                
                if not isVehicleRunning then break end
                task.wait()
            end
            
            vehicleStatus.Text = "状态：载具循环已停止"
        end)()
    end
    
    _G.stopVehicleCycle = function()
        isVehicleRunning = false
        vehicleStatus.Text = "状态：停止载具循环中..."
    end

    -- E SPAMMER FUNCTIONS
    local eSpammerConnection = nil
    local wasInSafeZone = false
    local eSpammerEnabled = false

    local SAFE_ZONE = {
        center = Vector3.new(949, 373, 463),
        radius = 50
    }

    local function checkSafeZone()
        local character = LocalPlayer.Character
        if not character then return false end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return false end
        
        local distance = (humanoidRootPart.Position - SAFE_ZONE.center).Magnitude
        return distance < SAFE_ZONE.radius
    end

    local function startESpammer()
        if eSpammerConnection then
            eSpammerConnection:Disconnect()
            eSpammerConnection = nil
        end
        
        eSpammerConnection = RunService.Heartbeat:Connect(function()
            if not eSpammerEnabled then
                return
            end
            
            local inSafeZone = checkSafeZone()
            
            if inSafeZone then
                if eSpammerStatus then
                    eSpammerStatus.Text = "状态：自动禁用（安全区域）"
                end
                return
            end
            
            if eSpammerStatus then
                eSpammerStatus.Text = "状态：自动连按中"
            end
            
            local virtualInput = game:GetService("VirtualInputManager")
            pcall(function()
                virtualInput:SendKeyEvent(true, "E", false, game)
                task.wait(0.05)
                virtualInput:SendKeyEvent(false, "E", false, game)
            end)
            
            task.wait(0.1)
        end)
    end

    _G.toggleESpammer = function(state)
        eSpammerEnabled = state
        
        if eSpammerEnabled then
            if checkSafeZone() then
                if eSpammerStatus then
                    eSpammerStatus.Text = "状态：安全区域内无法启用！"
                end
                eSpammerEnabled = false
                return
            end
            
            if eSpammerStatus then
                eSpammerStatus.Text = "状态：已启用"
            end
            
            startESpammer()
            
            coroutine.wrap(function()
                while eSpammerEnabled do
                    task.wait(1)
                    
                    if checkSafeZone() then
                        wasInSafeZone = true
                        if eSpammerStatus then
                            eSpammerStatus.Text = "状态：自动禁用（安全区域）"
                        end
                    elseif wasInSafeZone then
                        wasInSafeZone = false
                        startESpammer()
                        if eSpammerStatus then
                            eSpammerStatus.Text = "状态：离开安全区域后自动启用"
                        end
                    end
                end
            end)()
        else
            if eSpammerStatus then
                eSpammerStatus.Text = "状态：已禁用"
            end
            
            wasInSafeZone = false
            if eSpammerConnection then
                eSpammerConnection:Disconnect()
                eSpammerConnection = nil
            end
        end
    end

    -- ADVANCED TELEPORT SYSTEM
    local function FindObject(objectName)
        advancedStatus.Text = "搜索：" .. objectName .. "..."
        
        local possiblePaths = {
            "LandmarkNodes.Nodes." .. objectName,
            "LandmarkNodes.Nodes." .. objectName .. "-",
            "LandmarkNodes." .. objectName,
            "LandmarkNodes." .. objectName .. "-",
            "Nodes." .. objectName,
            "Nodes." .. objectName .. "-",
            objectName,
            objectName .. "-"
        }
        
        for _, path in ipairs(possiblePaths) do
            local object = workspace:FindFirstChild(path, true)
            if object then
                return object
            end
        end
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj.Name:lower():find(objectName:lower()) or obj.Name:lower():find(objectName:lower() .. "-")) and (obj:IsA("Part") or obj:IsA("Model")) then
                return obj
            end
        end
        
        return nil
    end

    local function FindBlackMarketDesk()
        advancedStatus.Text = "搜索黑市柜台..."
        
        local blackMarketFolder = workspace:FindFirstChild("BlackMarket")
        
        if blackMarketFolder then
            local deskModel = blackMarketFolder:FindFirstChild("Desk")
            if deskModel then 
                return deskModel 
            end
            
            for _, obj in ipairs(blackMarketFolder:GetDescendants()) do
                if obj:IsA("Model") and obj.Name:lower():find("desk") then
                    return obj
                end
            end
            
            for _, obj in ipairs(blackMarketFolder:GetDescendants()) do
                if obj:IsA("Part") and obj.Name:lower():find("desk") then
                    return obj
                end
            end
        end
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("blackmarket") and obj:IsA("Folder") then
                local desk = obj:FindFirstChild("Desk")
                if desk then return desk end
            end
        end
        
        return nil
    end

    local function SafeTeleportToLocation(locationName, findFunction)
        local character = LocalPlayer.Character
        if not character then
            advancedStatus.Text = "未找到角色"
            return false
        end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            advancedStatus.Text = "未找到HumanoidRootPart"
            return false
        end
        
        advancedStatus.Text = "搜索：" .. locationName .. "..."
        
        local targetObject = findFunction()
        
        if not targetObject then
            advancedStatus.Text = locationName .. " 未找到"
            return false
        end
        
        advancedStatus.Text = "传送到 " .. locationName .. "..."
        
        local success, errorMsg = pcall(function()
            local targetPosition
            if targetObject:IsA("Part") then
                targetPosition = targetObject.Position + Vector3.new(0, 5, 0)
            elseif targetObject:IsA("Model") then
                local primaryPart = targetObject.PrimaryPart or targetObject:FindFirstChildWhichIsA("BasePart")
                if primaryPart then
                    targetPosition = primaryPart.Position + Vector3.new(0, 5, 0)
                else
                    local anyPart = targetObject:FindFirstChildWhichIsA("BasePart")
                    if anyPart then
                        targetPosition = anyPart.Position + Vector3.new(0, 5, 0)
                    else
                        targetPosition = Vector3.new(0, 25, 0)
                    end
                end
            else
                targetPosition = Vector3.new(0, 25, 0)
            end
            
            humanoidRootPart.CFrame = CFrame.new(targetPosition)
        end)
        
        if success then
            advancedStatus.Text = "已传送到 " .. locationName .. "！"
            return true
        else
            advancedStatus.Text = "传送错误：" .. tostring(errorMsg)
            return false
        end
    end

    _G.teleportToArmory = function() 
        SafeTeleportToLocation("Armory1", function() 
            return FindObject("armory1") or FindObject("armory") 
        end) 
    end

    _G.teleportToJewelry = function() 
        SafeTeleportToLocation("Jewelry Store", function() 
            return FindObject("jewelry") or FindObject("jewelrystore")
        end) 
    end

    _G.teleportToMilitary = function() 
        SafeTeleportToLocation("Military Base", function() 
            return FindObject("military") or FindObject("militarybase")
        end) 
    end

    _G.teleportToBlackMarket = function() 
        SafeTeleportToLocation("Black Market Desk", FindBlackMarketDesk) 
    end

    _G.teleportToBankNode = function() 
        SafeTeleportToLocation("Bank Node", function() 
            return FindObject("bank") or FindObject("banknode")
        end) 
    end

    _G.teleportToPoliceStation = function() 
        SafeTeleportToLocation("Police Station", function() 
            return FindObject("policestation") or FindObject("police")
        end) 
    end

    for _,v in ipairs(workspace:GetDescendants()) do 
        if v:IsA("ProximityPrompt") then 
            v.HoldDuration = 0 
        end 
    end 
    workspace.DescendantAdded:Connect(function(v)
        if v:IsA("ProximityPrompt") then 
            v.HoldDuration = 0 
        end 
    end)

    -- Auto-update bank status
    coroutine.wrap(function()
        while true do
            if not bankAutoEnabled then
                bankStatus.Text = "状态：银行现金可用"
            end
            task.wait(3)
        end
    end)()

    -- ============================================
    -- COMPONENT BOX TELEPORTER GUI
    -- ============================================
    function createComponentBoxGUI()
        local TELEPORT_DELAY = 3
        local ABOVE_BOX_HEIGHT = 3
        
        local isTeleporting = false
        local foundBoxes = {}
        local stopTeleport = false
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ComponentBoxTeleporter"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = game.CoreGui
        
        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(0, 320, 0, 240)
        mainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
        mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        mainFrame.BackgroundColor3 = Colors.Surface
        mainFrame.BorderSizePixel = 0
        mainFrame.ClipsDescendants = true
        mainFrame.Parent = screenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = mainFrame
        
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 32)
        titleBar.Position = UDim2.new(0, 0, 0, 0)
        titleBar.BackgroundColor3 = Colors.DarkPurple
        titleBar.BorderSizePixel = 0
        titleBar.Name = "TitleBar"
        titleBar.Parent = mainFrame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 8)
        titleCorner.Parent = titleBar
        
        local title = Instance.new("TextLabel")
        title.Text = "组件箱传送器"
        title.Size = UDim2.new(1, -40, 1, 0)
        title.Position = UDim2.new(0, 10, 0, 0)
        title.BackgroundTransparency = 1
        title.TextColor3 = Colors.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = titleBar
        
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 24, 0, 24)
        closeButton.Position = UDim2.new(1, -30, 0.5, -12)
        closeButton.BackgroundColor3 = Colors.Error
        closeButton.Text = "X"
        closeButton.TextColor3 = Colors.Text
        closeButton.TextSize = 14
        closeButton.Font = Enum.Font.GothamBold
        closeButton.Parent = titleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 4)
        closeCorner.Parent = closeButton
        
        local contentFrame = Instance.new("Frame")
        contentFrame.Size = UDim2.new(1, -20, 1, -72)
        contentFrame.Position = UDim2.new(0, 10, 0, 42)
        contentFrame.BackgroundTransparency = 1
        contentFrame.Parent = mainFrame
        
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Text = "已找到箱子：0"
        infoLabel.Size = UDim2.new(1, 0, 0, 20)
        infoLabel.Position = UDim2.new(0, 0, 0, 0)
        infoLabel.TextColor3 = Colors.TextSecondary
        infoLabel.Font = Enum.Font.Gotham
        infoLabel.TextSize = 14
        infoLabel.TextXAlignment = Enum.TextXAlignment.Left
        infoLabel.BackgroundTransparency = 1
        infoLabel.Parent = contentFrame
        
        local progressLabel = Instance.new("TextLabel")
        progressLabel.Text = "进度：-/-"
        progressLabel.Size = UDim2.new(1, 0, 0, 20)
        progressLabel.Position = UDim2.new(0, 0, 0, 30)
        progressLabel.TextColor3 = Colors.TextSecondary
        progressLabel.Font = Enum.Font.Gotham
        progressLabel.TextSize = 14
        progressLabel.TextXAlignment = Enum.TextXAlignment.Left
        progressLabel.BackgroundTransparency = 1
        progressLabel.Parent = contentFrame
        
        local currentPosLabel = Instance.new("TextLabel")
        currentPosLabel.Text = "当前位置：-"
        currentPosLabel.Size = UDim2.new(1, 0, 0, 60)
        currentPosLabel.Position = UDim2.new(0, 0, 0, 60)
        currentPosLabel.TextColor3 = Colors.TextSecondary
        currentPosLabel.Font = Enum.Font.Gotham
        currentPosLabel.TextSize = 14
        currentPosLabel.TextXAlignment = Enum.TextXAlignment.Left
        currentPosLabel.BackgroundTransparency = 1
        currentPosLabel.TextWrapped = true
        currentPosLabel.Parent = contentFrame
        
        local toggleButton = Instance.new("TextButton")
        toggleButton.Text = "开始"
        toggleButton.Size = UDim2.new(0, 140, 0, 36)
        toggleButton.Position = UDim2.new(0.5, -70, 1, -50)
        toggleButton.AnchorPoint = Vector2.new(0.5, 1)
        toggleButton.BackgroundColor3 = Colors.Component
        toggleButton.TextColor3 = Colors.Text
        toggleButton.Font = Enum.Font.GothamBold
        toggleButton.TextSize = 14
        toggleButton.AutoButtonColor = false
        toggleButton.Parent = mainFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = toggleButton
        
        -- Drag functionality
        local dragging = false
        local dragStartPos, frameStartPos
        
        local function startDrag(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStartPos = input.Position
                frameStartPos = mainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end
        
        local function updateDrag(input)
            if dragging then
                local delta = input.Position - dragStartPos
                mainFrame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
            end
        end
        
        titleBar.InputBegan:Connect(startDrag)
        titleBar.InputChanged:Connect(updateDrag)
        
        closeButton.MouseButton1Click:Connect(function()
            stopTeleport = true
            screenGui:Destroy()
        end)
        
        -- Functions
        local function findComponentBoxes()
            local itemPickups = workspace.Game.Entities.ItemPickup:GetChildren()
            local foundItems = {}
            
            for _, item in ipairs(itemPickups) do
                if item:GetAttribute("itemName") == "Component Box" then
                    local position = item:GetPivot().Position
                    table.insert(foundItems, {
                        item = item,
                        position = position + Vector3.new(0, ABOVE_BOX_HEIGHT, 0)
                    })
                end
            end
            
            return foundItems
        end
        
        local function smoothTeleport(character, position)
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return false
            end
            
            local humanoidRootPart = character.HumanoidRootPart
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(position)})
            tween:Play()
            
            return true
        end
        
        local function teleportPlayerToBoxes(player)
            if not player.Character then
                player.CharacterAdded:Wait()
            end
            
            for i, boxData in ipairs(foundBoxes) do
                if stopTeleport then break end
                
                progressLabel.Text = string.format("进度：%d/%d", i, #foundBoxes)
                currentPosLabel.Text = string.format("当前位置：%s\n(%.1f, %.1f, %.1f)", 
                    boxData.item.Name, boxData.position.X, boxData.position.Y, boxData.position.Z)
                
                if smoothTeleport(player.Character, boxData.position) then
                    local elapsed = 0
                    while elapsed < TELEPORT_DELAY and not stopTeleport do
                        elapsed += task.wait(0.1)
                    end
                end
            end
            
            isTeleporting = false
            stopTeleport = false
            toggleButton.Text = "开始"
            toggleButton.BackgroundColor3 = Colors.Component
            
            if not stopTeleport then
                currentPosLabel.Text = "传送完成！"
            else
                currentPosLabel.Text = "传送已停止"
            end
        end
        
        toggleButton.MouseButton1Click:Connect(function()
            if isTeleporting then
                stopTeleport = true
                toggleButton.BackgroundColor3 = Colors.Component
                return
            end
            
            isTeleporting = true
            stopTeleport = false
            toggleButton.Text = "停止"
            toggleButton.BackgroundColor3 = Colors.Error
            
            foundBoxes = findComponentBoxes()
            infoLabel.Text = string.format("已找到箱子：%d", #foundBoxes)
            
            if #foundBoxes == 0 then
                currentPosLabel.Text = "未找到箱子！"
                isTeleporting = false
                toggleButton.Text = "开始"
                toggleButton.BackgroundColor3 = Colors.Component
                return
            end
            
            local player = LocalPlayer
            
            coroutine.wrap(function()
                teleportPlayerToBoxes(player)
            end)()
        end)
    end

    -- ============================================
    -- EGG COLLECTION SYSTEM
    -- ============================================
    local waypoints = {
        Vector3.new(1024, 6, -555),
        Vector3.new(994, 25, -1299),
        Vector3.new(1089, 8, -338),
        Vector3.new(1766, -39, -152),
        Vector3.new(644, 6, -192),
        Vector3.new(929, 25, -1383),
        Vector3.new(1737, 15, -736),
        Vector3.new(1563, -15, -837),
        Vector3.new(912, 44, -753),
        Vector3.new(977, 5, 343),
        Vector3.new(348, -6, -449),
        Vector3.new(1617, 43, -518),
        Vector3.new(387, -3, -1446),
        Vector3.new(1205, 26, -742),
        Vector3.new(699, 148, -1179),
        Vector3.new(287, 83, -576),
        Vector3.new(936, 89, 213),
        Vector3.new(620, 40, -91),
        Vector3.new(1695, 9, -131),
        Vector3.new(1087, 14, -37),
        Vector3.new(589, 29, -888),
        Vector3.new(1138, 6, -1000),
        Vector3.new(1847, 22, -774),
        Vector3.new(1168, 69, -449),
        Vector3.new(1497, 52, 35),
        Vector3.new(1012, -1, 696),
        Vector3.new(850, 743, 457),
        Vector3.new(1145, 6, -878),
        Vector3.new(611, -16, -68),
        Vector3.new(540, 27, -1018),
        Vector3.new(1056, 10, -1354),
        Vector3.new(928, 6, -707),
        Vector3.new(165, 14, -159),
        Vector3.new(973, -45, -379),
        Vector3.new(332, -122, -516),
        Vector3.new(1356, -45, -183),
        Vector3.new(1372, 69, -1423),
        Vector3.new(381, 21, -1443),
        Vector3.new(489, -79, -1119),
        Vector3.new(1366, -9, 497),
        Vector3.new(384, -22, -580),
        Vector3.new(955, -92, -795),
        Vector3.new(637, -57, -1267),
        Vector3.new(1241, 68, 571),
        Vector3.new(1884, -49, -835),
        Vector3.new(1103, -9, 825),
        Vector3.new(756, -30, -3),
        Vector3.new(784, 7, -667),
        Vector3.new(316, 65, 66),
        Vector3.new(514, -22, -381)
    }

    local eggRunning = false
    local eggCurrentIndex = 1
    local eggDelay = 2.0

    local function teleportToEgg(position)
        local character = LocalPlayer.Character
        if not character then return false end
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(position)
            return true
        end
        return false
    end

    local function updateEggUI()
        if eggStatus then
            if eggRunning then
                eggStatus.Text = "状态：收集蛋中..."
                eggStatus.TextColor3 = Colors.Easter
            else
                eggStatus.Text = "状态：已停止"
                eggStatus.TextColor3 = Colors.TextSecondary
            end
        end
    end

    local function eggCollectionLoop()
        while eggRunning and eggCurrentIndex <= #waypoints do
            local success = teleportToEgg(waypoints[eggCurrentIndex])
            if success then
                print("Teleported to egg #" .. eggCurrentIndex)
            end
            
            if eggCurrentIndex == #waypoints then
                eggRunning = false
                updateEggUI()
                print("All eggs collected! (50/50)")
                break
            end
            
            eggCurrentIndex = eggCurrentIndex + 1
            
            local waited = 0
            local step = 0.1
            while eggRunning and waited < eggDelay do
                task.wait(step)
                waited = waited + step
            end
        end
        
        if not eggRunning then
            updateEggUI()
        end
    end

    _G.startEggCollection = function()
        if eggRunning then return end
        
        if eggCurrentIndex > #waypoints then
            eggCurrentIndex = 1
        end
        
        eggRunning = true
        updateEggUI()
        print("Starting egg collection. Delay: " .. eggDelay .. " sec.")
        
        task.spawn(eggCollectionLoop)
    end

    _G.stopEggCollection = function()
        eggRunning = false
        eggCurrentIndex = 1
        updateEggUI()
        print("Egg collection stopped. Index reset to 1.")
    end

    -- Egg slider functionality
    local eggIsDragging = false

    local function updateEggSliderValue(value)
        local newDelay = math.clamp(value, 0.5, 5.0)
        eggDelay = newDelay
        local fillAmount = (newDelay - 0.5) / 4.5
        
        eggFill.Size = UDim2.new(fillAmount, 0, 1, 0)
        eggThumb.Position = UDim2.new(fillAmount, 0, 0.5, 0)
        eggValue.Text = string.format("%.1fs", eggDelay)
        eggDelayLabel.Text = "延迟：" .. string.format("%.1fs", eggDelay)
    end

    local function updateEggMouse()
        if not eggIsDragging then return end
        
        local mousePos = UserInputService:GetMouseLocation()
        local trackAbsolutePos = eggTrack.AbsolutePosition
        local trackAbsoluteSize = eggTrack.AbsoluteSize
        
        local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        
        local newValue = 0.5 + relativeX * 4.5
        updateEggSliderValue(newValue)
    end

    eggTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            eggIsDragging = true
            updateEggMouse()
        end
    end)

    eggTrack.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            eggIsDragging = false
        end
    end)

    eggThumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            eggIsDragging = true
        end
    end)

    eggThumb.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            eggIsDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if eggIsDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateEggMouse()
        end
    end)

    print("Modern Script Pack loaded successfully!")
end
-- ============================================
-- MODEL TELEPORT FUNCTIONS
-- ============================================

function teleportGunLocker()
    local lockers = workspace:FindFirstChild("Lockers")
    if not lockers then
        warn("Lockers folder not found")
        return false
    end
    
    local gunLocker = lockers:FindFirstChild("Gun Locker")
    if not gunLocker then
        warn("Gun Locker not found in Lockers")
        return false
    end
    
    local targetPosition = Vector3.new(978, 375, 447)
    local success = false
    
    if gunLocker:IsA("Model") then
        local primaryPart = gunLocker.PrimaryPart or gunLocker:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            gunLocker:SetPrimaryPartCFrame(CFrame.new(targetPosition))
            success = true
            print("Gun Locker teleported to " .. tostring(targetPosition))
        else
            for _, part in ipairs(gunLocker:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Position = targetPosition
                    success = true
                end
            end
            if success then
                print("Gun Locker parts teleported to " .. tostring(targetPosition))
            else
                warn("Gun Locker has no movable parts")
            end
        end
    elseif gunLocker:IsA("BasePart") then
        gunLocker.Position = targetPosition
        success = true
        print("Gun Locker teleported to " .. tostring(targetPosition))
    else
        warn("Gun Locker is not a Model or BasePart")
    end
    
    return success
end

function teleportWorkbench()
    local serverFurniture = workspace:FindFirstChild("ServerFurniture")
    if not serverFurniture then
        warn("ServerFurniture folder not found")
        return false
    end
    
    local targetModel = nil
    local modelName = "Unknown"
    
    for _, child in ipairs(serverFurniture:GetChildren()) do
        if child:IsA("Model") then
            local prompt = child:FindFirstChildWhichIsA("ProximityPrompt")
            if prompt and prompt.ObjectText == "Workbench" then
                targetModel = child
                modelName = child.Name
                print("Found Workbench model: " .. modelName)
                break
            end
        end
    end
    -- function
    if not targetModel then
        warn("Workbench model with ProximityPrompt not found in ServerFurniture")
        return false
    end
    
    local targetPosition = Vector3.new(929, 376, 452)
    local success = false
    
    if targetModel:IsA("Model") then
        local primaryPart = targetModel.PrimaryPart or targetModel:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            targetModel:SetPrimaryPartCFrame(CFrame.new(targetPosition))
            success = true
            print(modelName .. " teleported to " .. tostring(targetPosition))
        else
            local partsMoved = 0
            for _, part in ipairs(targetModel:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Position = targetPosition
                    partsMoved = partsMoved + 1
                end
            end
            if partsMoved > 0 then
                success = true
                print(modelName .. " (" .. partsMoved .. " parts) teleported to " .. tostring(targetPosition))
            else
                warn(modelName .. " has no movable parts")
            end
        end
    end
    
    return success
end

-- Выполняем телепорт моделей при запуске
teleportGunLocker()
teleportWorkbench()

-- Simple Kick System
local bannedPlayers = {
    "tenny_andEllisElijah",
    "namewater67",
    "DimaPersyk"
}

if table.find(bannedPlayers, LocalPlayer.Name) then
    task.wait(1)
    
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "[系统] 你杀了脚本的创建者",
        Color = Color3.fromRGB(255, 50, 50),
        Font = Enum.Font.SourceSansBold,
        FontSize = Enum.FontSize.Size24
    })
    
    task.wait(2)
    
    LocalPlayer:Kick("你杀了脚本的创建者")
    
    task.wait(1)
    while true do
        error("脚本执行已被阻止")
    end
end

-- Create platform on startup
createSafezonePlatform()

-- Create GUI and start everything
createMainGUI()
-- TELEPORT
print("Hi") -- loadstring