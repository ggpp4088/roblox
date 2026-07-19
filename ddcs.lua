local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

-- 数据
local PointList = {}
local LoopDelay = 0.5
local IsLooping = false

-- 主GUI
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "MultiPointTp"
MainGui.IgnoreGuiInset = true
MainGui.ResetOnSpawn = false
MainGui.DisplayOrder = 999
MainGui.Parent = PlayerGui

-- 右侧唤醒按钮
local WakeBtn = Instance.new("TextButton")
WakeBtn.Size = UDim2.new(0,35,0,35)
WakeBtn.Position = UDim2.new(0.93,0,0.5,0)
WakeBtn.BackgroundColor3 = Color3.fromRGB(90,50,170)
WakeBtn.Text = "开"
WakeBtn.TextColor3 = Color3.new(1,1,1)
WakeBtn.Parent = MainGui

-- 主面板
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,175,0,450)
MainFrame.Position = UDim2.new(0.02,0,0.12,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,40)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(130,90,230)
MainFrame.Parent = MainGui

-- ======================================
-- 【彻底修复】全局拖动（绝对不会拖不动）
-- ======================================
local Dragging = false
local DragStartPos = Vector2.new(0,0)
local FrameStartPos = UDim2.new(0,0,0,0)

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStartPos = UIS:GetMouseLocation()
        FrameStartPos = MainFrame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local NowPos = UIS:GetMouseLocation()
        local Delta = NowPos - DragStartPos
        MainFrame.Position = UDim2.new(0, FrameStartPos.X.Offset + Delta.X, 0, FrameStartPos.Y.Offset + Delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

-- XYZ输入框
local XBox = Instance.new("TextBox")
XBox.Size = UDim2.new(0.28,0,0,24)
XBox.Position = UDim2.new(0.05,0,0.04,0)
XBox.BackgroundColor3 = Color3.fromRGB(45,45,65)
XBox.TextColor3 = Color3.new(1,1,1)
XBox.PlaceholderText = "X"
XBox.Parent = MainFrame

local YBox = Instance.new("TextBox")
YBox.Size = UDim2.new(0.28,0,0,24)
YBox.Position = UDim2.new(0.37,0,0.04,0)
YBox.BackgroundColor3 = Color3.fromRGB(45,45,65)
YBox.TextColor3 = Color3.new(1,1,1)
YBox.PlaceholderText = "Y"
YBox.Parent = MainFrame

local ZBox = Instance.new("TextBox")
ZBox.Size = UDim2.new(0.28,0,0,24)
ZBox.Position = UDim2.new(0.69,0,0.04,0)
ZBox.BackgroundColor3 = Color3.fromRGB(45,45,65)
ZBox.TextColor3 = Color3.new(1,1,1)
ZBox.PlaceholderText = "Z"
ZBox.Parent = MainFrame

-- 填充当前坐标按钮
local FillPosBtn = Instance.new("TextButton")
FillPosBtn.Size = UDim2.new(0.9,0,0,24)
FillPosBtn.Position = UDim2.new(0.05,0,0.11,0)
FillPosBtn.BackgroundColor3 = Color3.fromRGB(25,110,85)
FillPosBtn.Text = "填充当前坐标"
FillPosBtn.TextColor3 = Color3.new(1,1,1)
FillPosBtn.Parent = MainFrame

-- 延迟输入
local DelayBox = Instance.new("TextBox")
DelayBox.Size = UDim2.new(0.9,0,0,24)
DelayBox.Position = UDim2.new(0.05,0,0.18,0)
DelayBox.BackgroundColor3 = Color3.fromRGB(45,45,65)
DelayBox.TextColor3 = Color3.new(1,1,1)
DelayBox.PlaceholderText = "循环延迟(秒)"
DelayBox.Text = "0.5"
DelayBox.Parent = MainFrame

-- 保存自定义坐标点位
local SavePointBtn = Instance.new("TextButton")
SavePointBtn.Size = UDim2.new(0.9,0,0,24)
SavePointBtn.Position = UDim2.new(0.05,0,0.25,0)
SavePointBtn.BackgroundColor3 = Color3.fromRGB(35,130,60)
SavePointBtn.Text = "保存坐标为点位"
SavePointBtn.TextColor3 = Color3.new(1,1,1)
SavePointBtn.Parent = MainFrame

-- 循环控制按钮
local StartLoopBtn = Instance.new("TextButton")
StartLoopBtn.Size = UDim2.new(0.9,0,0,24)
StartLoopBtn.Position = UDim2.new(0.05,0,0.32,0)
StartLoopBtn.BackgroundColor3 = Color3.fromRGB(35,85,160)
StartLoopBtn.Text = "开始循环传送"
StartLoopBtn.TextColor3 = Color3.new(1,1,1)
StartLoopBtn.Parent = MainFrame

local StopLoopBtn = Instance.new("TextButton")
StopLoopBtn.Size = UDim2.new(0.9,0,0,24)
StopLoopBtn.Position = UDim2.new(0.05,0,0.39,0)
StopLoopBtn.BackgroundColor3 = Color3.fromRGB(160,35,35)
StopLoopBtn.Text = "停止循环传送"
StopLoopBtn.TextColor3 = Color3.new(1,1,1)
StopLoopBtn.Parent = MainFrame

local HideUiBtn = Instance.new("TextButton")
HideUiBtn.Size = UDim2.new(0.9,0,0,24)
HideUiBtn.Position = UDim2.new(0.05,0,0.46,0)
HideUiBtn.BackgroundColor3 = Color3.fromRGB(55,55,55)
HideUiBtn.Text = "隐藏面板"
HideUiBtn.TextColor3 = Color3.new(1,1,1)
HideUiBtn.Parent = MainFrame

-- 滚动容器
local PointScroll = Instance.new("ScrollingFrame")
PointScroll.Size = UDim2.new(0.95,0,0.42,0)
PointScroll.Position = UDim2.new(0.025,0,0.54,0)
PointScroll.BackgroundTransparency = 1
PointScroll.ScrollBarThickness = 5
PointScroll.CanvasSize = UDim2.new(0,0,0,0)
PointScroll.Parent = MainFrame

local PointListFrame = Instance.new("Frame")
PointListFrame.Size = UDim2.new(1,0,0,0)
PointListFrame.BackgroundTransparency = 1
PointListFrame.Parent = PointScroll

-- 刷新点位UI
local function RefreshPointUI()
    for _,child in pairs(PointListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for idx,pos in ipairs(PointList) do
        local PointBtn = Instance.new("TextButton")
        PointBtn.Size = UDim2.new(1,0,0,26)
        PointBtn.Position = UDim2.new(0,0,0, (idx-1)*28)
        PointBtn.BackgroundColor3 = Color3.fromRGB(50,50,80)
        PointBtn.Text = "点位"..idx.." 单击传送｜长按删除"
        PointBtn.TextColor3 = Color3.new(1,1,1)
        PointBtn.Parent = PointListFrame

        -- 单击传送
        PointBtn.MouseButton1Click:Connect(function()
            local Char = LocalPlayer.Character
            if not Char then return end
            local Hrp = Char:FindFirstChild("HumanoidRootPart")
            if Hrp then
                Hrp.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
            end
        end)

        -- ======================================
        -- 【终极修复】只有按住 0.4 秒才删，放着不动绝对不删
        -- ======================================
        local IsHolding = false
        local HoldTask = nil

        PointBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                IsHolding = true
                HoldTask = task.delay(0.4, function()
                    if IsHolding then
                        table.remove(PointList, idx)
                        RefreshPointUI()
                    end
                end)
            end
        end)

        PointBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                IsHolding = false
                if HoldTask then
                    task.cancel(HoldTask)
                end
            end
        end)
    end

    local totalHeight = #PointList * 28
    PointListFrame.Size = UDim2.new(1,0,0,totalHeight)
    PointScroll.CanvasSize = UDim2.new(0,0,0,totalHeight)
end

-- 填充当前坐标
FillPosBtn.MouseButton1Click:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end
    local Hrp = Char:FindFirstChild("HumanoidRootPart")
    if not Hrp then return end
    XBox.Text = math.floor(Hrp.Position.X)
    YBox.Text = math.floor(Hrp.Position.Y)
    ZBox.Text = math.floor(Hrp.Position.Z)
end)

-- 保存点位
SavePointBtn.MouseButton1Click:Connect(function()
    local x = tonumber(XBox.Text) or 0
    local y = tonumber(YBox.Text) or 10
    local z = tonumber(ZBox.Text) or 0
    table.insert(PointList, {X = x, Y = y, Z = z})
    RefreshPointUI()
end)

-- 延迟设置
DelayBox.FocusLost:Connect(function()
    LoopDelay = tonumber(DelayBox.Text) or 0.5
end)

-- 开始循环
StartLoopBtn.MouseButton1Click:Connect(function()
    if IsLooping or #PointList < 1 then return end
    IsLooping = true
    coroutine.wrap(function()
        while IsLooping do
            for _,pos in ipairs(PointList) do
                if not IsLooping then break end
                local Char = LocalPlayer.Character
                if not Char then task.wait(LoopDelay) continue end
                local Hrp = Char:FindFirstChild("HumanoidRootPart")
                if Hrp then
                    Hrp.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
                end
                task.wait(LoopDelay)
            end
        end
    end)()
end)

-- 停止循环
StopLoopBtn.MouseButton1Click:Connect(function()
    IsLooping = false
end)

-- 隐藏/唤醒
HideUiBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    WakeBtn.Visible = true
end)

WakeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    WakeBtn.Visible = false
end)

RefreshPointUI()
