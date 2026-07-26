local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

if _G.XhiinnGIO_Cleanup then _G.XhiinnGIO_Cleanup() end

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local uiScale = isMobile and 0.7 or 1

-- [[ 1. 创建屏幕界面 ]]
local mountainGui = Instance.new("ScreenGui")
mountainGui.Name = "XhiinnGIOMountainOreSystemV73"
mountainGui.ResetOnSpawn = false
mountainGui.Parent = playerGui

-- [[ 2. 主面板框架 ]]
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 472)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 55, 40)
mainFrame.BackgroundTransparency = 0.35
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = mountainGui

if isMobile then
	local mfScale = Instance.new("UIScale")
	mfScale.Scale = uiScale
	mfScale.Parent = mainFrame
end

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = mainFrame

-- [[ 3. 面板标题 ]]
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "挖矿山透视 v7.3"
titleLabel.TextColor3 = Color3.fromRGB(245, 245, 235)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 17
titleLabel.Parent = mainFrame

-- [[ 4. 开关透视按钮 ]]
local toggleEspBtn = Instance.new("TextButton")
toggleEspBtn.Size = UDim2.new(0, 115, 0, 35)
toggleEspBtn.Position = UDim2.new(0.5, -120, 0, 50)
toggleEspBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
toggleEspBtn.BackgroundTransparency = 0.1
toggleEspBtn.Text = "自动透视"
toggleEspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleEspBtn.Font = Enum.Font.SourceSansBold
toggleEspBtn.TextSize = 15
toggleEspBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleEspBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Thickness = 1.5
btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
btnStroke.Parent = toggleEspBtn

local noctEspBtn = Instance.new("TextButton")
noctEspBtn.Size = UDim2.new(0, 115, 0, 35)
noctEspBtn.Position = UDim2.new(0.5, 5, 0, 50)
noctEspBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 140)
noctEspBtn.BackgroundTransparency = 0.1
noctEspBtn.Text = "透视Nocturnite"
noctEspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noctEspBtn.Font = Enum.Font.SourceSansBold
noctEspBtn.TextSize = 12
noctEspBtn.Parent = mainFrame

local noctEspBtnCorner = Instance.new("UICorner")
noctEspBtnCorner.CornerRadius = UDim.new(0, 8)
noctEspBtnCorner.Parent = noctEspBtn

local noctEspBtnStroke = Instance.new("UIStroke")
noctEspBtnStroke.Thickness = 1.5
noctEspBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
noctEspBtnStroke.Parent = noctEspBtn

-- [[ 5. 传送至最稀有水晶按钮 ]]
local tpRarestBtn = Instance.new("TextButton")
tpRarestBtn.Size = UDim2.new(0, 240, 0, 35)
tpRarestBtn.Position = UDim2.new(0.5, -120, 0, 95)
tpRarestBtn.BackgroundColor3 = Color3.fromRGB(70, 90, 65)
tpRarestBtn.BackgroundTransparency = 0.1
tpRarestBtn.Text = "传送至最稀有水晶"
tpRarestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpRarestBtn.Font = Enum.Font.SourceSansBold
tpRarestBtn.TextSize = 14
tpRarestBtn.Parent = mainFrame

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 8)
tpCorner.Parent = tpRarestBtn

local tpStroke = Instance.new("UIStroke")
tpStroke.Thickness = 1.5
tpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tpStroke.Parent = tpRarestBtn

-- [[ 6. 自动收集水晶按钮 ]]
local toggleCollectBtn = Instance.new("TextButton")
toggleCollectBtn.Size = UDim2.new(0, 240, 0, 35)
toggleCollectBtn.Position = UDim2.new(0.5, -120, 0, 140)
toggleCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
toggleCollectBtn.BackgroundTransparency = 0.1
toggleCollectBtn.Text = "自动收集: 关"
toggleCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleCollectBtn.Font = Enum.Font.SourceSansBold
toggleCollectBtn.TextSize = 14
toggleCollectBtn.Parent = mainFrame

local collectCorner = Instance.new("UICorner")
collectCorner.CornerRadius = UDim.new(0, 8)
collectCorner.Parent = toggleCollectBtn

local collectStroke = Instance.new("UIStroke")
collectStroke.Thickness = 1.5
collectStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
collectStroke.Parent = toggleCollectBtn

-- [[ 7. 矿物搜索与点选 ]]
local searchInput = Instance.new("TextBox")
searchInput.Size = UDim2.new(0, 240, 0, 30)
searchInput.Position = UDim2.new(0.5, -120, 0, 190)
searchInput.BackgroundColor3 = Color3.fromRGB(25, 30, 20)
searchInput.BackgroundTransparency = 0.1
searchInput.PlaceholderText = "输入矿物名称..."
searchInput.PlaceholderColor3 = Color3.fromRGB(140, 150, 135)
searchInput.Text = ""
searchInput.TextColor3 = Color3.fromRGB(240, 240, 240)
searchInput.Font = Enum.Font.SourceSans
searchInput.TextSize = 14
searchInput.ClearTextOnFocus = false
searchInput.Parent = mainFrame

local searchInputCorner = Instance.new("UICorner")
searchInputCorner.CornerRadius = UDim.new(0, 6)
searchInputCorner.Parent = searchInput

local searchInputStroke = Instance.new("UIStroke")
searchInputStroke.Thickness = 1.2
searchInputStroke.Color = Color3.fromRGB(120, 140, 110)
searchInputStroke.Parent = searchInput

local isPickMode = false
local isModelPickMode = false

local pickBtn = Instance.new("TextButton")
pickBtn.Size = UDim2.new(0, 115, 0, 30)
pickBtn.Position = UDim2.new(0.5, -120, 0, 224)
pickBtn.BackgroundColor3 = Color3.fromRGB(90, 110, 85)
pickBtn.BackgroundTransparency = 0.1
pickBtn.Text = "点选矿物"
pickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
pickBtn.Font = Enum.Font.SourceSansBold
pickBtn.TextSize = 13
pickBtn.Parent = mainFrame

local pickBtnCorner = Instance.new("UICorner")
pickBtnCorner.CornerRadius = UDim.new(0, 8)
pickBtnCorner.Parent = pickBtn

local pickBtnStroke = Instance.new("UIStroke")
pickBtnStroke.Thickness = 1.5
pickBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
pickBtnStroke.Parent = pickBtn

local tpSearchBtn = Instance.new("TextButton")
tpSearchBtn.Size = UDim2.new(0, 115, 0, 30)
tpSearchBtn.Position = UDim2.new(0.5, 5, 0, 224)
tpSearchBtn.BackgroundColor3 = Color3.fromRGB(70, 90, 65)
tpSearchBtn.BackgroundTransparency = 0.1
tpSearchBtn.Text = "传送至指定矿物"
tpSearchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpSearchBtn.Font = Enum.Font.SourceSansBold
tpSearchBtn.TextSize = 11
tpSearchBtn.Parent = mainFrame

local tpSearchCorner = Instance.new("UICorner")
tpSearchCorner.CornerRadius = UDim.new(0, 8)
tpSearchCorner.Parent = tpSearchBtn

local tpSearchStroke = Instance.new("UIStroke")
tpSearchStroke.Thickness = 1.5
tpSearchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tpSearchStroke.Parent = tpSearchBtn

local modelSearchInput = Instance.new("TextBox")
modelSearchInput.Size = UDim2.new(0, 240, 0, 30)
modelSearchInput.Position = UDim2.new(0.5, -120, 0, 258)
modelSearchInput.BackgroundColor3 = Color3.fromRGB(25, 30, 20)
modelSearchInput.BackgroundTransparency = 0.1
modelSearchInput.PlaceholderText = "输入模型名称..."
modelSearchInput.PlaceholderColor3 = Color3.fromRGB(140, 150, 135)
modelSearchInput.Text = ""
modelSearchInput.TextColor3 = Color3.fromRGB(240, 240, 240)
modelSearchInput.Font = Enum.Font.SourceSans
modelSearchInput.TextSize = 14
modelSearchInput.ClearTextOnFocus = false
modelSearchInput.Parent = mainFrame

local modelSearchInputCorner = Instance.new("UICorner")
modelSearchInputCorner.CornerRadius = UDim.new(0, 6)
modelSearchInputCorner.Parent = modelSearchInput

local modelSearchInputStroke = Instance.new("UIStroke")
modelSearchInputStroke.Thickness = 1.2
modelSearchInputStroke.Color = Color3.fromRGB(120, 140, 110)
modelSearchInputStroke.Parent = modelSearchInput

local modelPickBtn = Instance.new("TextButton")
modelPickBtn.Size = UDim2.new(0, 115, 0, 30)
modelPickBtn.Position = UDim2.new(0.5, -120, 0, 292)
modelPickBtn.BackgroundColor3 = Color3.fromRGB(80, 70, 50)
modelPickBtn.BackgroundTransparency = 0.1
modelPickBtn.Text = "点选模型"
modelPickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
modelPickBtn.Font = Enum.Font.SourceSansBold
modelPickBtn.TextSize = 13
modelPickBtn.Parent = mainFrame

local modelPickBtnCorner = Instance.new("UICorner")
modelPickBtnCorner.CornerRadius = UDim.new(0, 8)
modelPickBtnCorner.Parent = modelPickBtn

local modelPickBtnStroke = Instance.new("UIStroke")
modelPickBtnStroke.Thickness = 1.5
modelPickBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
modelPickBtnStroke.Parent = modelPickBtn

local tpModelBtn = Instance.new("TextButton")
tpModelBtn.Size = UDim2.new(0, 115, 0, 30)
tpModelBtn.Position = UDim2.new(0.5, 5, 0, 292)
tpModelBtn.BackgroundColor3 = Color3.fromRGB(80, 70, 50)
tpModelBtn.BackgroundTransparency = 0.1
tpModelBtn.Text = "传送至指定模型"
tpModelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpModelBtn.Font = Enum.Font.SourceSansBold
tpModelBtn.TextSize = 11
tpModelBtn.Parent = mainFrame

local tpModelBtnCorner = Instance.new("UICorner")
tpModelBtnCorner.CornerRadius = UDim.new(0, 8)
tpModelBtnCorner.Parent = tpModelBtn

local tpModelBtnStroke = Instance.new("UIStroke")
tpModelBtnStroke.Thickness = 1.5
tpModelBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tpModelBtnStroke.Parent = tpModelBtn

-- [[ 8. 玩家列表下拉菜单系统 ]]
local selectedPlayer = nil

local dropdownMainBtn = Instance.new("TextButton")
dropdownMainBtn.Size = UDim2.new(0, 240, 0, 35)
dropdownMainBtn.Position = UDim2.new(0.5, -120, 0, 340)
dropdownMainBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 30)
dropdownMainBtn.BackgroundTransparency = 0.1
dropdownMainBtn.Text = "选择玩家 [点击此处]"
dropdownMainBtn.TextColor3 = Color3.fromRGB(220, 230, 210)
dropdownMainBtn.Font = Enum.Font.SourceSansBold
dropdownMainBtn.TextSize = 14
dropdownMainBtn.Parent = mainFrame

local dropCorner = Instance.new("UICorner")
dropCorner.CornerRadius = UDim.new(0, 6)
dropCorner.Parent = dropdownMainBtn

local dropMainStroke = Instance.new("UIStroke")
dropMainStroke.Thickness = 1.2
dropMainStroke.Color = Color3.fromRGB(120, 140, 110)
dropMainStroke.Parent = dropdownMainBtn

local dropdownScroll = Instance.new("ScrollingFrame")
dropdownScroll.Size = UDim2.new(0, 240, 0, 100)
dropdownScroll.Position = UDim2.new(0.5, -120, 0, 376)
dropdownScroll.BackgroundColor3 = Color3.fromRGB(25, 30, 20)
dropdownScroll.BackgroundTransparency = 0.1
dropdownScroll.BorderSizePixel = 0
dropdownScroll.Visible = false
dropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
dropdownScroll.ScrollBarThickness = 5
dropdownScroll.ZIndex = 5
dropdownScroll.Parent = mainFrame

local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 6)
scrollCorner.Parent = dropdownScroll

local scrollListLayout = Instance.new("UIListLayout")
scrollListLayout.Padding = UDim.new(0, 3)
scrollListLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollListLayout.Parent = dropdownScroll

local tpPlayerBtn = Instance.new("TextButton")
tpPlayerBtn.Size = UDim2.new(0, 240, 0, 35)
tpPlayerBtn.Position = UDim2.new(0.5, -120, 0, 385)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(90, 110, 85)
tpPlayerBtn.BackgroundTransparency = 0.1
tpPlayerBtn.Text = "传送至玩家"
tpPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpPlayerBtn.Font = Enum.Font.SourceSansBold
tpPlayerBtn.TextSize = 14
tpPlayerBtn.Parent = mainFrame

local tpPlayCorner = Instance.new("UICorner")
tpPlayCorner.CornerRadius = UDim.new(0, 8)
tpPlayCorner.Parent = tpPlayerBtn

local tpPlayStroke = Instance.new("UIStroke")
tpPlayStroke.Thickness = 1.2
tpPlayStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
tpPlayStroke.Parent = tpPlayerBtn

local function updateLayoutPositions()
	if dropdownScroll.Visible then
		tpPlayerBtn.Position = UDim2.new(0.5, -120, 0, 480)
		mainFrame.Size = UDim2.new(0, 300, 0, 567)
	else
		tpPlayerBtn.Position = UDim2.new(0.5, -120, 0, 385)
		mainFrame.Size = UDim2.new(0, 300, 0, 472)
	end
end

local function refreshDropdownList()
	for _, item in ipairs(dropdownScroll:GetChildren()) do
		if item:IsA("TextButton") then item:Destroy() end
	end

	local count = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			count = count + 1
			local pBtn = Instance.new("TextButton")
			pBtn.Size = UDim2.new(1, -6, 0, 25)
			pBtn.BackgroundColor3 = Color3.fromRGB(45, 50, 40)
			pBtn.BackgroundTransparency = 0.2
			pBtn.Text = p.Name
			pBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
			pBtn.Font = Enum.Font.SourceSans
			pBtn.TextSize = 13
			pBtn.ZIndex = 6
			pBtn.Parent = dropdownScroll

			local pBtnCorner = Instance.new("UICorner")
			pBtnCorner.CornerRadius = UDim.new(0, 4)
			pBtnCorner.Parent = pBtn

			pBtn.MouseButton1Click:Connect(function()
				selectedPlayer = p
				dropdownMainBtn.Text = "目标: " .. p.Name
				dropdownScroll.Visible = false
				updateLayoutPositions()
			end)
		end
	end
	dropdownScroll.CanvasSize = UDim2.new(0, 0, 0, count * 28)
end

dropdownMainBtn.MouseButton1Click:Connect(function()
	dropdownScroll.Visible = not dropdownScroll.Visible
	if dropdownScroll.Visible then refreshDropdownList() end
	updateLayoutPositions()
end)

-- [[ 8. 状态标签 ]]
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 1, -30)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "状态: 等待激活"
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 175)
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.TextSize = 13
statusLabel.Parent = mainFrame

-- [[ 9. 隐藏/显示界面按钮 ]]
local toggleGuiBtn = Instance.new("TextButton")
toggleGuiBtn.Size = UDim2.new(0, isMobile and 90 or 120, 0, isMobile and 28 or 35)
toggleGuiBtn.Position = UDim2.new(1, isMobile and -100 or -135, 0, isMobile and 10 or 15)
toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(35, 43, 32)
toggleGuiBtn.BackgroundTransparency = 0.2
toggleGuiBtn.Text = "隐藏界面"
toggleGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleGuiBtn.Font = Enum.Font.SourceSansBold
toggleGuiBtn.TextSize = isMobile and 11 or 13
toggleGuiBtn.Parent = mountainGui

local guiBtnCorner = Instance.new("UICorner")
guiBtnCorner.CornerRadius = UDim.new(0, 6)
guiBtnCorner.Parent = toggleGuiBtn

local guiBtnStroke = Instance.new("UIStroke")
guiBtnStroke.Thickness = 1.2
guiBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
guiBtnStroke.Parent = toggleGuiBtn

toggleGuiBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	if mainFrame.Visible then
		toggleGuiBtn.Text = "隐藏界面"
		toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(35, 43, 32)
	else
		toggleGuiBtn.Text = "显示界面"
		toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(70, 90, 65)
	end
end)

-- [[ 10. 稀有度颜色编码 ]]
local tierColors = {
	["common"] = Color3.fromRGB(220, 220, 220),
	["uncommon"] = Color3.fromRGB(90, 200, 250),
	["rare"] = Color3.fromRGB(52, 152, 219),
	["epic"] = Color3.fromRGB(155, 89, 182),
	["legendary"] = Color3.fromRGB(241, 196, 15),
	["mythic"] = Color3.fromRGB(231, 76, 60),
	["exotic"] = Color3.fromRGB(26, 188, 156),
	["divine"] = Color3.fromRGB(230, 126, 34)
}

-- [[ 11. 深度数据提取引擎 ]]
local lastScannedCrystals = {}

local function extractCrystalData(object)
	local tier = "Unknown"
	local weight = "Auto"
	local price = 0
	local classStr = ""

	pcall(function()
		local parent = object.Parent
		local function scanSource(src)
			if not src then return end
			tier = src:GetAttribute("Tier") or src:GetAttribute("Rarity") or tier
			local wAttr = src:GetAttribute("Weight") or src:GetAttribute("Mass")
			if wAttr then weight = tostring(wAttr) end
			price = tonumber(src:GetAttribute("Price")) or tonumber(src:GetAttribute("Value")) or price
			classStr = src:GetAttribute("Class") or classStr

			local cfg = src:FindFirstChild("Configuration") or src:FindFirstChild("Data")
			if cfg then
				tier = cfg:FindFirstChild("Tier") and tostring(cfg.Tier.Value) or tier
				weight = cfg:FindFirstChild("Weight") and tostring(cfg.Weight.Value) or weight
				price = cfg:FindFirstChild("Price") and tonumber(cfg.Price.Value) or price
				classStr = cfg:FindFirstChild("Class") and tostring(cfg.Class.Value) or classStr
			end
		end

		scanSource(object)
		scanSource(parent)

		if tostring(tier) == "Unknown" then
			local combined = (object.Name .. "_" .. (parent and parent.Name or "")):lower()
			for tName, _ in pairs(tierColors) do
				if combined:find(tName) then tier = tName:sub(1,1):upper() .. tName:sub(2) break end
			end
		end
	end)
	return tostring(tier), tostring(weight), price, tostring(classStr)
end

-- [[ 12. 严格山脉过滤器（完全排除基地） ]]
local function isInsideMountain(part)
	if not part or not part.Parent then return false end

	-- A. 结构层级过滤
	local ancestryStr = ""
	local current = part.Parent
	while current and current ~= Workspace do
		ancestryStr = ancestryStr .. "_" .. current.Name:lower()
		current = current.Parent
	end

	if ancestryStr:find("base") or ancestryStr:find("tycoon") or ancestryStr:find("player") or ancestryStr:find("plot") or ancestryStr:find("claim") or ancestryStr:find("conveyor") or ancestryStr:find("dropper") then
		return false
	end
	if part.Parent:FindFirstChild("Owner") or part.Parent:FindFirstChild("Claimed") or part.Position.Y < 18 then
		return false
	end

	-- B. 多基地半径灵活过滤
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local distToPlayer = (part.Position - p.Character.HumanoidRootPart.Position).Magnitude
			if distToPlayer < 45 then
				return false
			end
		end
	end

	-- C. 山脉中心检测过滤
	for _, obj in ipairs(Workspace:GetChildren()) do
		if obj:IsA("Model") and (obj.Name:lower():find("tycoon") or obj.Name:lower():find("base") or obj.Name:lower():find("plot")) then
			local root = obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")
			if root then
				if (part.Position - root.Position).Magnitude < 85 then
					return false
				end
			end
		end
	end

	return true
end

-- [[ 13. 实时监听透视引擎 ]]
local isEspActive = false
local trackedBillboards = {}
local listenerConnection = nil
local maxRenderDistance = 120

local function applyESP(part)
	if not part:IsA("BasePart") then return end
	if part:IsDescendantOf(player.Character or Workspace) and part.Name == "HumanoidRootPart" then return end

	local nameLower = part.Name:lower()

	if nameLower:find("crystal") or nameLower:find("ore") or part:GetAttribute("Tier") or (part.Parent and part.Parent:GetAttribute("Tier")) or part:FindFirstChild("Tier") then

		task.wait(0.05)
		if not part or not part.Parent then return end

		local rawTier, rawWeight, rawPrice, rawClass = extractCrystalData(part)
		if rawTier == "Unknown" and rawWeight == "Auto" and rawPrice == 0 then return end

		lastScannedCrystals[part] = rawPrice

		local function handleVisualESP()
			while isEspActive and part and part.Parent do
				local char = player.Character
				local myHrp = char and char:FindFirstChild("HumanoidRootPart")
				local distance = myHrp and (myHrp.Position - part.Position).Magnitude or 9999

				if distance <= maxRenderDistance then
					local billboard = part:FindFirstChild("XhiinnGIO_OriginalESP")
					if not billboard then
						billboard = Instance.new("BillboardGui")
						billboard.Name = "XhiinnGIO_OriginalESP"
						billboard.Size = UDim2.new(0, 180, 0, 70)
						billboard.AlwaysOnTop = true
						billboard.ExtentsOffset = Vector3.new(0, 3, 0)
						billboard.Adornee = part

						local label = Instance.new("TextLabel")
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.TextStrokeTransparency = 0
						label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
						label.Font = Enum.Font.SourceSansBold
						label.TextSize = 14

						local textColor = Color3.fromRGB(255, 255, 255)
						local lowerTier = rawTier:lower()
						for k, col in pairs(tierColors) do if lowerTier:find(k) then textColor = col break end end
						label.TextColor3 = textColor

						label.Text = string.format("稀有度: %s\n\n价格: $%s\n\n重量: %s 千克", rawTier:upper(), tostring(rawPrice), rawWeight)
						label.Parent = billboard
						billboard.Parent = part
						table.insert(trackedBillboards, billboard)
					end
				else
					local billboard = part:FindFirstChild("XhiinnGIO_OriginalESP")
					if billboard then billboard:Destroy() end
				end
				task.wait(0.5)
			end
			local billboard = part:FindFirstChild("XhiinnGIO_OriginalESP")
			if billboard then billboard:Destroy() end
		end
		task.spawn(handleVisualESP)
	end
end

local function cleanOldESP()
	if listenerConnection then listenerConnection:Disconnect() listenerConnection = nil end
	for _, esp in pairs(trackedBillboards) do if esp then esp:Destroy() end end
	trackedBillboards = {}
	lastScannedCrystals = {}
end

local isNoctEspActive = false
local noctTrackedBillboards = {}
local noctListenerConnection = nil

local function applyNoctESP(obj)
	if not obj or not obj.Parent then return end
	if not (obj:IsA("Model") and obj.Name:lower():find("nocturnite")) then return end

	local function handleNoctVisual()
		while isNoctEspActive and obj and obj.Parent do
			for _, part in ipairs(obj:GetDescendants()) do
				if part:IsA("BasePart") then
					local espName = "NocturniteESP"
					if not part:FindFirstChild(espName) then
						local bb = Instance.new("BillboardGui")
						bb.Name = espName
						bb.Size = UDim2.new(0, 160, 0, 40)
						bb.AlwaysOnTop = true
						bb.ExtentsOffset = Vector3.new(0, 2, 0)
						bb.Adornee = part

						local label = Instance.new("TextLabel")
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.TextStrokeTransparency = 0
						label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
						label.Font = Enum.Font.SourceSansBold
						label.TextSize = 13
						label.TextColor3 = Color3.fromRGB(180, 130, 255)
						label.Text = "Nocturnite"
						label.Parent = bb
						bb.Parent = part
						table.insert(noctTrackedBillboards, bb)
					end
				end
			end
			task.wait(0.5)
		end
		for _, part in ipairs(obj:GetDescendants()) do
			if part:IsA("BasePart") then
				local bb = part:FindFirstChild("NocturniteESP")
				if bb then bb:Destroy() end
			end
		end
	end
	task.spawn(handleNoctVisual)
end

local function cleanNoctESP()
	if noctListenerConnection then noctListenerConnection:Disconnect() noctListenerConnection = nil end
	for _, esp in pairs(noctTrackedBillboards) do if esp then esp:Destroy() end end
	noctTrackedBillboards = {}
end

-- [[ 14. 后台搜索逻辑 ]]
local function runBackgroundScanner()
	for _, descendant in ipairs(Workspace:GetDescendants()) do
		task.spawn(function()
			if descendant:IsA("BasePart") then
				local nameLower = descendant.Name:lower()
				if nameLower:find("crystal") or nameLower:find("ore") or descendant:GetAttribute("Tier") or descendant:FindFirstChild("Tier") then
					local _, _, rawPrice, _ = extractCrystalData(descendant)
					if rawPrice > 0 then lastScannedCrystals[descendant] = rawPrice end
				end
			end
		end)
	end
end

task.spawn(runBackgroundScanner)
Workspace.DescendantAdded:Connect(function(desc)
	if desc:IsA("BasePart") then
		task.wait(0.05)
		local nameLower = desc.Name:lower()
		if nameLower:find("crystal") or nameLower:find("ore") or desc:GetAttribute("Tier") then
			local _, _, rawPrice, _ = extractCrystalData(desc)
			if rawPrice > 0 then lastScannedCrystals[desc] = rawPrice end
		end
	end
end)

-- [[ 15. 查找最贵水晶逻辑（带严格山脉过滤） ]]
local function getRarestActiveCrystal()
	local highestPrice = -1
	local chosenPart = nil
	for part, price in pairs(lastScannedCrystals) do
		if part and part.Parent and part:IsA("BasePart") and isInsideMountain(part) then
			if price > highestPrice then
				highestPrice = price
				chosenPart = part
			end
		else
			lastScannedCrystals[part] = nil
		end
	end
	return chosenPart, highestPrice
end

-- [[ 16. 补偿弹跳绕过传送引擎 ]]
local function safeTweenTeleport(targetCFrame)
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp or not targetCFrame then return end

	local distance = (hrp.Position - targetCFrame.Position).Magnitude
	local speed = 200
	local duration = distance / speed
	if duration < 0.1 then duration = 0.1 end

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Velocity = Vector3.new(0, 0, 0)
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Parent = hrp

	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})

	tween:Play()
	tween.Completed:Wait()

	if bodyVelocity then bodyVelocity:Destroy() end
	pcall(function() hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end)
end

-- [[ 17. 自动收集矿工中心 ]]

-- [[ 16.5 传送至指定矿物逻辑 ]]
local function findMineralByName(searchName)
	local lowerName = searchName:lower()
	local bestPart = nil
	local bestPrice = -1
	for part, price in pairs(lastScannedCrystals) do
		if part and part.Parent and part:IsA("BasePart") and isInsideMountain(part) then
			local nameLower = part.Name:lower()
			if nameLower:find(lowerName) then
				if price > bestPrice then
					bestPrice = price
					bestPart = part
				end
			end
		end
	end
	return bestPart, bestPrice
end

tpSearchBtn.MouseButton1Click:Connect(function()
	local searchText = searchInput.Text
	if searchText == "" then
		statusLabel.Text = "请先输入矿物名称！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		return
	end

	local target, price = findMineralByName(searchText)
	if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "正在传送到: " .. target.Name .. " ($" .. price .. ")"
		statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
		task.spawn(function()
			safeTweenTeleport(target.CFrame * CFrame.new(0, 3, 0))
			statusLabel.Text = "已成功传送到 " .. target.Name
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		end)
	else
		statusLabel.Text = "未找到包含 \"" .. searchText .. "\" 的矿物！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

local function findModelByName(searchName)
	local lowerName = searchName:lower()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") or obj:IsA("BasePart") then
			if obj.Name:lower():find(lowerName) then
				local targetPart = nil
				if obj:IsA("BasePart") then
					targetPart = obj
				elseif obj:IsA("Model") then
					targetPart = obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")
				end
				if targetPart then
					return obj, targetPart
				end
			end
		end
	end
	return nil, nil
end

tpModelBtn.MouseButton1Click:Connect(function()
	local searchText = modelSearchInput.Text
	if searchText == "" then
		statusLabel.Text = "请先输入模型名称！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		return
	end

	local model, targetPart = findModelByName(searchText)
	if model and targetPart and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "正在传送到: " .. model.Name
		statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
		task.spawn(function()
			safeTweenTeleport(targetPart.CFrame * CFrame.new(0, 3, 0))
			statusLabel.Text = "已成功传送到 " .. model.Name
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		end)
	else
		statusLabel.Text = "未找到包含 \"" .. searchText .. "\" 的模型！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

pickBtn.MouseButton1Click:Connect(function()
	isPickMode = not isPickMode
	if isPickMode then
		pickBtn.Text = "点选矿物 ●"
		pickBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
		isModelPickMode = false
		modelPickBtn.Text = "点选模型"
		modelPickBtn.BackgroundColor3 = Color3.fromRGB(80, 70, 50)
		statusLabel.Text = "状态: 点击矿石自动填入名称"
		statusLabel.TextColor3 = Color3.fromRGB(100, 240, 120)
	else
		pickBtn.Text = "点选矿物"
		pickBtn.BackgroundColor3 = Color3.fromRGB(90, 110, 85)
		statusLabel.Text = "状态: 点选模式已关闭"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
	end
end)

modelPickBtn.MouseButton1Click:Connect(function()
	isModelPickMode = not isModelPickMode
	if isModelPickMode then
		modelPickBtn.Text = "点选模型 ●"
		modelPickBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
		isPickMode = false
		pickBtn.Text = "点选矿物"
		pickBtn.BackgroundColor3 = Color3.fromRGB(90, 110, 85)
		statusLabel.Text = "状态: 点击物体填入模型名称"
		statusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
	else
		modelPickBtn.Text = "点选模型"
		modelPickBtn.BackgroundColor3 = Color3.fromRGB(80, 70, 50)
		statusLabel.Text = "状态: 点选模式已关闭"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
	end
end)

local mouse = player:GetMouse()
mouse.Button1Down:Connect(function()
	if isPickMode then
		local target = mouse.Target
		if target then
			local nameLower = target.Name:lower()
			if nameLower:find("crystal") or nameLower:find("ore") or target:GetAttribute("Tier") or target:FindFirstChild("Tier") then
				searchInput.Text = target.Name
				statusLabel.Text = "已填入: " .. target.Name
				statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
			isPickMode = false
			pickBtn.Text = "点选矿物"
			pickBtn.BackgroundColor3 = Color3.fromRGB(90, 110, 85)
			end
		end
	elseif isModelPickMode then
		local target = mouse.Target
		if target then
			local modelName = target.Name
			local parent = target.Parent
			while parent and parent ~= Workspace do
				if parent:IsA("Model") then
					modelName = parent.Name
					break
				end
				parent = parent.Parent
			end
			modelSearchInput.Text = modelName
			statusLabel.Text = "已填入模型: " .. modelName
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
			isModelPickMode = false
			modelPickBtn.Text = "点选模型"
			modelPickBtn.BackgroundColor3 = Color3.fromRGB(80, 70, 50)
		end
	end
end)

local isCollectActive = false
local isScriptAlive = true
task.spawn(function()
	while isScriptAlive do
		if isCollectActive then
			local crystal, price = getRarestActiveCrystal()
			local character = player.Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")

			if crystal and hrp then
				statusLabel.Text = "自动收集: 前往 $" .. price
				statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
				safeTweenTeleport(crystal.CFrame * CFrame.new(0, 3, 0))

				statusLabel.Text = "自动收集: 开采 $" .. price
				statusLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
				task.wait(0.1)

				local tool = character:FindFirstChildOfClass("Tool")
				if tool then tool:Activate() end
				for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
					if remote:IsA("RemoteEvent") and (remote.Name:lower():find("mine") or remote.Name:lower():find("collect")) then
						remote:FireServer(crystal)
					end
				end
				task.wait(0.3)
			else
				statusLabel.Text = "自动收集: 搜索水晶中..."
				statusLabel.TextColor3 = Color3.fromRGB(180, 190, 175)
			end
		end
		task.wait(0.5)
	end
end)

-- [[ 18. 执行传送至玩家 ]]
tpPlayerBtn.MouseButton1Click:Connect(function()
	if not selectedPlayer or not selectedPlayer.Parent then
		statusLabel.Text = "请先在菜单中选择玩家！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		return
	end

	if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "正在传送到: " .. selectedPlayer.Name
		statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)

		task.spawn(function()
			safeTweenTeleport(selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
			statusLabel.Text = "已成功传送到 " .. selectedPlayer.Name
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		end)
	else
		statusLabel.Text = "该玩家角色不在线！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

-- [[ 19. 交互系统连接 ]]
tpRarestBtn.MouseButton1Click:Connect(function()
	local target, price = getRarestActiveCrystal()
	if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "正在平滑传送中..."
		statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
		task.spawn(function()
			safeTweenTeleport(target.CFrame * CFrame.new(0, 3, 0))
			statusLabel.Text = "已成功降落山脉 ($" .. price .. ")"
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		end)
	else
		statusLabel.Text = "山脉宝石尚未进入雷达范围！"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

toggleCollectBtn.MouseButton1Click:Connect(function()
	isCollectActive = not isCollectActive
	if isCollectActive then
		toggleCollectBtn.Text = "自动收集: 开"
		toggleCollectBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
	else
		toggleCollectBtn.Text = "自动收集: 关"
		toggleCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
		statusLabel.Text = "状态: 自动收集已停止"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
	end
end)

toggleEspBtn.MouseButton1Click:Connect(function()
	isEspActive = not isEspActive
	if isEspActive then
		toggleEspBtn.Text = "自动透视: 开"
		toggleEspBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
		statusLabel.Text = "状态: 近距离雷达已激活"
		statusLabel.TextColor3 = Color3.fromRGB(100, 240, 120)

		for _, descendant in ipairs(Workspace:GetDescendants()) do
			task.spawn(applyESP, descendant)
		end

		listenerConnection = Workspace.DescendantAdded:Connect(function(descendant)
			applyESP(descendant)
		end)
	else
		toggleEspBtn.Text = "自动透视: 关"
		toggleEspBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
		statusLabel.Text = "状态: 透视已关闭"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
		cleanOldESP()
	end
end)

noctEspBtn.MouseButton1Click:Connect(function()
	isNoctEspActive = not isNoctEspActive
	if isNoctEspActive then
		noctEspBtn.Text = "Nocturnite: 开"
		noctEspBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
		statusLabel.Text = "状态: Nocturnite透视已激活"
		statusLabel.TextColor3 = Color3.fromRGB(180, 130, 255)

		for _, descendant in ipairs(Workspace:GetDescendants()) do
			task.spawn(applyNoctESP, descendant)
		end

		noctListenerConnection = Workspace.DescendantAdded:Connect(function(desc)
			applyNoctESP(desc)
		end)
	else
		noctEspBtn.Text = "透视Nocturnite"
		noctEspBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 140)
		statusLabel.Text = "状态: Nocturnite透视已关闭"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
		cleanNoctESP()
	end
end)

-- [[ 20. 彩虹RGB特效 ]]
local rgbObjects = {mainStroke, btnStroke, noctEspBtnStroke, tpStroke, collectStroke, tpSearchStroke, pickBtnStroke, modelPickBtnStroke, tpModelBtnStroke, dropMainStroke, tpPlayStroke, guiBtnStroke}
local rgbConnection = RunService.RenderStepped:Connect(function()
	local totalObjects = #rgbObjects
	local timeTick = tick() * 0.15
	for idx, strokeObject in ipairs(rgbObjects) do
		if strokeObject and strokeObject.Parent then
			local hueShift = timeTick + (idx / totalObjects * 0.5)
			strokeObject.Color = Color3.fromHSV(hueShift % 1, 0.85, 1)
		end
	end
end)

local bgScannerConnection = Workspace.DescendantAdded:Connect(function(desc)
	if desc:IsA("BasePart") then
		task.wait(0.05)
		local nameLower = desc.Name:lower()
		if nameLower:find("crystal") or nameLower:find("ore") or desc:GetAttribute("Tier") then
			local _, _, rawPrice, _ = extractCrystalData(desc)
			if rawPrice > 0 then lastScannedCrystals[desc] = rawPrice end
		end
	end
end)

-- [[ 21. 全局清理函数 ]]
_G.XhiinnGIO_Cleanup = function()
	isScriptAlive = false
	isEspActive = false
	isNoctEspActive = false
	isCollectActive = false
	if listenerConnection then listenerConnection:Disconnect() end
	if noctListenerConnection then noctListenerConnection:Disconnect() end
	if rgbConnection then rgbConnection:Disconnect() end
	if bgScannerConnection then bgScannerConnection:Disconnect() end
	cleanOldESP()
	cleanNoctESP()
	if mountainGui then mountainGui:Destroy() end
end
