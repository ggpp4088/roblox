local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- [[ 1. CREATION SCREEN GUI ]]
local mountainGui = Instance.new("ScreenGui")
mountainGui.Name = "XhiinnGIOMountainOreSystemV73"
mountainGui.ResetOnSpawn = false
mountainGui.Parent = playerGui

-- [[ 2. FRAME UTAMA PANEL (ARMY THEME ORIGINAL) ]]
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 360)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 55, 40)
mainFrame.BackgroundTransparency = 0.35 
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true 
mainFrame.Parent = mountainGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = mainFrame

-- [[ 3. JUDUL PANEL ]]
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "MINE A MOUNTAIN ESP v7.3"
titleLabel.TextColor3 = Color3.fromRGB(245, 245, 235)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 17
titleLabel.Parent = mainFrame

-- [[ 4. TOMBOL UTAMA TOGGLE ESP ]]
local toggleEspBtn = Instance.new("TextButton")
toggleEspBtn.Size = UDim2.new(0, 240, 0, 35)
toggleEspBtn.Position = UDim2.new(0.5, -120, 0, 50)
toggleEspBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
toggleEspBtn.BackgroundTransparency = 0.1
toggleEspBtn.Text = "AUTO ESP: OFF"
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

-- [[ 5. TOMBOL TELEPORT KE KRISTAL MAHAL ]]
local tpRarestBtn = Instance.new("TextButton")
tpRarestBtn.Size = UDim2.new(0, 240, 0, 35)
tpRarestBtn.Position = UDim2.new(0.5, -120, 0, 95)
tpRarestBtn.BackgroundColor3 = Color3.fromRGB(70, 90, 65)
tpRarestBtn.BackgroundTransparency = 0.1
tpRarestBtn.Text = "TP TO RAREST CRYSTAL"
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

-- [[ 6. TOMBOL AUTO COLLECT KRISTAL ]]
local toggleCollectBtn = Instance.new("TextButton")
toggleCollectBtn.Size = UDim2.new(0, 240, 0, 35)
toggleCollectBtn.Position = UDim2.new(0.5, -120, 0, 140)
toggleCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
toggleCollectBtn.BackgroundTransparency = 0.1
toggleCollectBtn.Text = "AUTO COLLECT: OFF"
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

-- [[ 7. DROPDOWN PLAYER LIST SYSTEM ]]
local selectedPlayer = nil

local dropdownMainBtn = Instance.new("TextButton")
dropdownMainBtn.Size = UDim2.new(0, 240, 0, 35)
dropdownMainBtn.Position = UDim2.new(0.5, -120, 0, 190)
dropdownMainBtn.BackgroundColor3 = Color3.fromRGB(35, 40, 30)
dropdownMainBtn.BackgroundTransparency = 0.1
dropdownMainBtn.Text = "PILIH PLAYER [KLIK DI SINI]"
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
dropdownScroll.Position = UDim2.new(0.5, -120, 0, 226)
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
tpPlayerBtn.Position = UDim2.new(0.5, -120, 0, 235)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(90, 110, 85)
tpPlayerBtn.BackgroundTransparency = 0.1
tpPlayerBtn.Text = "TP TO PLAYER"
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
		tpPlayerBtn.Position = UDim2.new(0.5, -120, 0, 330)
		mainFrame.Size = UDim2.new(0, 300, 0, 440)
	else
		tpPlayerBtn.Position = UDim2.new(0.5, -120, 0, 235)
		mainFrame.Size = UDim2.new(0, 300, 0, 360)
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
				dropdownMainBtn.Text = "TARGET: " .. p.Name
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

-- [[ 8. STATUS LABEL KECIL ]]
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 1, -30)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Menunggu Aktivasi"
statusLabel.TextColor3 = Color3.fromRGB(180, 190, 175)
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.TextSize = 13
statusLabel.Parent = mainFrame

-- [[ 9. TOMBOL HIDE / SHOW PANEL ]]
local toggleGuiBtn = Instance.new("TextButton")
toggleGuiBtn.Size = UDim2.new(0, 120, 0, 35)
toggleGuiBtn.Position = UDim2.new(1, -135, 0, 15)
toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(35, 43, 32)
toggleGuiBtn.BackgroundTransparency = 0.2
toggleGuiBtn.Text = "Sembunyikan UI"
toggleGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleGuiBtn.Font = Enum.Font.SourceSansBold
toggleGuiBtn.TextSize = 13
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
		toggleGuiBtn.Text = "Sembunyikan UI"
		toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(35, 43, 32)
	else
		toggleGuiBtn.Text = "Tampilkan UI"
		toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(70, 90, 65)
	end
end)

-- [[ 10. COLOR CODES DYNAMIC ]]
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

-- [[ 11. DEEP DATA EXTRACTOR ENGINE ]]
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

-- [[ 12. STRICT MOUNTAIN-ONLY FILTER (DETEKSI ANTI BASE TOTAL) ]]
local function isInsideMountain(part)
	if not part or not part.Parent then return false end
	
	-- A. Filter Struktur Hirarki Kontainer
	local ancestryStr = ""
	local current = part.Parent
	while current and current ~= Workspace do
		ancestryStr = ancestryStr .. "_" .. current.Name:lower()
		current = current.Parent
	end
	
	-- Jika objek ada di dalam model bertuliskan tycoon, base, pangkalan, atau conveyor pangkalan, abaikan.
	if ancestryStr:find("base") or ancestryStr:find("tycoon") or ancestryStr:find("player") or ancestryStr:find("plot") or ancestryStr:find("claim") or ancestryStr:find("conveyor") or ancestryStr:find("dropper") then
		return false
	end
	if part.Parent:FindFirstChild("Owner") or part.Parent:FindFirstChild("Claimed") or part.Position.Y < 18 then
		return false
	end

	-- B. Filter Multi-Base Radius Fleksibel terhadap objek dasar atau pemain lain di pangkalan mereka
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local distToPlayer = (part.Position - p.Character.HumanoidRootPart.Position).Magnitude
			if distToPlayer < 45 then 
				return false -- Batu nempel dekat tubuh orang lain di basenya
			end
		end
	end

	-- C. Filter Deteksi Pusat Gunung Tambang:
	-- Secara struktural, koordinat pangkalan berada di sisi luar map. Pengecekan area aman dilakukan di sini.
	for _, obj in ipairs(Workspace:GetChildren()) do
		if obj:IsA("Model") and (obj.Name:lower():find("tycoon") or obj.Name:lower():find("base") or obj.Name:lower():find("plot")) then
			local root = obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")
			if root then
				if (part.Position - root.Position).Magnitude < 85 then 
					return false -- Terlalu dekat dengan pusat bangunan pangkalan
				end
			end
		end
	end

	return true
end

-- [[ 13. LIVE LISTENER ESP ENGINE ]]
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
						
						label.Text = string.format("TIER: %s\n\nHARGA: $%s\n\nBERAT: %s kg", rawTier:upper(), tostring(rawPrice), rawWeight)
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

-- [[ 14. LOGIKA BACKGROUND SEARCH ]]
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

-- [[ 15. LOGIKA MENCARI KRISTAL MAHAL (DENGAN FILTER GUNUNG KETAT) ]]
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

-- [[ 16. ENGINE TWEEN BYPASS ANTI-RUBBERBAND ]]
local function safeTweenTeleport(targetCFrame)
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp or not targetCFrame then return end
	
	local distance = (hrp.Position - targetCFrame.Position).Magnitude
	local speed = 350
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

-- [[ 17. AUTO COLLECT PENAMBANG HUB ]]
local isCollectActive = false
task.spawn(function()
	while true do
		if isCollectActive then
			local crystal, price = getRarestActiveCrystal()
			local character = player.Character
			local hrp = character and character:FindFirstChild("HumanoidRootPart")

			if crystal and hrp then
				statusLabel.Text = "Auto Collect: Traveling to $" .. price
				statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
				safeTweenTeleport(crystal.CFrame * CFrame.new(0, 3, 0))
				
				statusLabel.Text = "Auto Collect: Mining $" .. price
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
				statusLabel.Text = "Auto Collect: Mencari Kristal..."
				statusLabel.TextColor3 = Color3.fromRGB(180, 190, 175)
			end
		end
		task.wait(0.5)
	end
end)

-- [[ 18. EXECUTE TELEPORT TO PLAYER ]]
tpPlayerBtn.MouseButton1Click:Connect(function()
	if not selectedPlayer or not selectedPlayer.Parent then
		statusLabel.Text = "❌ Silakan Pilih Nama Player di Menu!"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
		return
	end

	if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "⚡ Traveling to: " .. selectedPlayer.Name
		statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
		
		task.spawn(function()
			safeTweenTeleport(selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0))
			statusLabel.Text = "Sukses TP ke Lokasi " .. selectedPlayer.Name
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		end)
	else
		statusLabel.Text = "❌ Karakter Player Tersebut Tidak Aktif!"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

-- [[ 19. INTERACTION SYSTEM CONNECTIONS ]]
tpRarestBtn.MouseButton1Click:Connect(function()
	local target, price = getRarestActiveCrystal()
	if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		statusLabel.Text = "⚡ Teleporting Smoothly..."
		statusLabel.TextColor3 = Color3.fromRGB(90, 200, 250)
		task.spawn(function()
			safeTweenTeleport(target.CFrame * CFrame.new(0, 3, 0))
			statusLabel.Text = "Sukses Mendarat di Gunung ($" .. price .. ")"
			statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
		end)
	else
		statusLabel.Text = "Batu berharga gunung belum masuk radar!"
		statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
	end
end)

toggleCollectBtn.MouseButton1Click:Connect(function()
	isCollectActive = not isCollectActive
	if isCollectActive then
		toggleCollectBtn.Text = "AUTO COLLECT: ON"
		toggleCollectBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
	else
		toggleCollectBtn.Text = "AUTO COLLECT: OFF"
		toggleCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
		statusLabel.Text = "Status: Auto Collect Berhenti"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
	end
end)

toggleEspBtn.MouseButton1Click:Connect(function()
	isEspActive = not isEspActive
	if isEspActive then
		toggleEspBtn.Text = "AUTO ESP: ON"
		toggleEspBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
		statusLabel.Text = "Status: Radar Dekat Aktif"
		statusLabel.TextColor3 = Color3.fromRGB(100, 240, 120)
		
		for _, descendant in ipairs(Workspace:GetDescendants()) do
			task.spawn(applyESP, descendant)
		end
		
		listenerConnection = Workspace.DescendantAdded:Connect(function(descendant)
			applyESP(descendant)
		end)
	else
		toggleEspBtn.Text = "AUTO ESP: OFF"
		toggleEspBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 50)
		statusLabel.Text = "Status: ESP Dinonaktifkan"
		statusLabel.TextColor3 = Color3.fromRGB(240, 100, 90)
		cleanOldESP()
	end
end)

-- [[ 20. CHROMA RGB PELANGI EFFECT ]]
local rgbObjects = {mainStroke, btnStroke, tpStroke, collectStroke, dropMainStroke, tpPlayStroke, guiBtnStroke}
RunService.RenderStepped:Connect(function()
	local totalObjects = #rgbObjects
	local timeTick = tick() * 0.15
	for idx, strokeObject in ipairs(rgbObjects) do
		if strokeObject and strokeObject.Parent then
			local hueShift = timeTick + (idx / totalObjects * 0.5)
			strokeObject.Color = Color3.fromHSV(hueShift % 1, 0.85, 1)
		end
	end
end)