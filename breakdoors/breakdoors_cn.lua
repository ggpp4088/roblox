local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local GAME_NAME = "Break Door"
local DISCORD_INVITE = "https://discord.gg/ehKVq7pf7v"
local RSCRIPTS_LINK = "https://rscripts.net/@Ouroboros"

local Knit = require(ReplicatedStorage:WaitForChild("CommonComponents"):WaitForChild("Packages"):WaitForChild("Knit"))
local ClientCommParameterValidation = require(ReplicatedStorage.CommonComponents.Tool.ClientCommParameterValidation)
local CfgParameterValidationType = require(ReplicatedStorage.CommonConfig.BaseConfig.CfgParameterValidationType)
local CfgPlot = require(ReplicatedStorage.CommonConfig.Plot.CfgPlot)
local CfgLaboratory = require(ReplicatedStorage.CommonConfig.Laboratory.CfgLaboratory)

Knit.OnStart():await()

local PlotController = Knit.GetController("PlotController")
local PlotService = Knit.GetService("PlotService")
local AirdropService = Knit.GetService("AirdropService")
local RoomController = Knit.GetController("RoomController")
local RoundManagerController = Knit.GetController("RoundManagerController")
local TaskService = Knit.GetService("TaskService")
local HumanClassService = Knit.GetService("HumanClassService")
local HunterInventoryService = Knit.GetService("HunterInventoryService")
local LaboratoryService = Knit.GetService("LaboratoryService")

local RESEARCH_NAMES = {}
local RESEARCH_BY_NAME = {}
do
	for _, key in ipairs(CfgLaboratory.OrderedProjectKeys or {}) do
		local project = CfgLaboratory.GetProject(key)
		if type(project) == "table" and project.Enabled ~= false then
			local label = tostring(project.DisplayName or key)
			if not RESEARCH_BY_NAME[label] then
				RESEARCH_NAMES[#RESEARCH_NAMES + 1] = label
				RESEARCH_BY_NAME[label] = {
					ProjectKey = key,
					LineKey = project.LineKey,
					SlotType = project.SlotType,
				}
			end
		end
	end
end

local RESEARCH_LINE_NAMES = {}
local RESEARCH_LINE_BY_NAME = {}
do
	for _, key in ipairs(CfgLaboratory.OrderedLineKeys or {}) do
		local line = CfgLaboratory.GetLine(key)
		if type(line) == "table" and line.Enabled ~= false then
			local label = tostring(line.DisplayName or key)
			if not RESEARCH_LINE_BY_NAME[label] then
				RESEARCH_LINE_NAMES[#RESEARCH_LINE_NAMES + 1] = label
				RESEARCH_LINE_BY_NAME[label] = key
			end
		end
	end
end

local repo = "https://raw.githubusercontent.com/joustingmatch/ObsidianUltra/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Toggles = Library.Toggles
local Options = Library.Options

local function copyText(text, message)
	if setclipboard then
		setclipboard(text)
	elseif toclipboard then
		toclipboard(text)
	end
	Library:Notify(message)
end

local function copyDiscord()
	copyText(DISCORD_INVITE, "已复制 Discord 邀请到剪贴板")
end

local function colored(text, color)
	return string.format('<font color="%s">%s</font>', color, text)
end

local function field(key, value, color)
	return string.format("<b>%s</b> %s %s", key, colored("-", "#5a6070"), colored(value, color))
end

local GREEN = "#7fd47f"
local BLUE = "#6ec1ff"
local ORANGE = "#e8a34d"
local GREY = "#8b93a3"

local LTC_ADDRESS = "LSZPqKSsD1x6QXea2H8JS17nXMLnmtew3w"
local BTC_ADDRESS = "bc1qwc9exvcn3ykjqnsa0t9gakuccr494ljjuuqj99"
local ETH_ADDRESS = "0xaE95A405D007a6F858E5d35714111B075fEFb40a"
local USDT_ADDRESS = "0xaE95A405D007a6F858E5d35714111B075fEFb40a"
local SOL_ADDRESS = "Hq5jPHKDKjyHhccc6UULcbYTK6aKBBbTDmHNRXGKBKGp"
local PAYPAL_LINK = "https://paypal.me/TheTruckerGOD"
local VENMO_LINK = "https://venmo.com/u/miserablemusic"

local LTC = "#345d9d"
local BTC = "#f7931a"
local ETH = "#627eea"
local USDT = "#26a17b"
local SOL = "#14f195"
local PAYPAL = "#0070ba"
local VENMO = "#008cff"

local SURVIVOR_COLOR = Color3.fromRGB(80, 160, 255)
local HUNTER_COLOR = Color3.fromRGB(255, 105, 180)

local function isOn(name)
	if Library.Unloaded then
		return false
	end
	local toggle = Toggles[name]
	return type(toggle) == "table" and toggle.Value == true
end

local function getHumanoid()
	local character = LocalPlayer.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
	local character = LocalPlayer.Character
	return character and character:FindFirstChild("HumanoidRootPart")
end

local function getHead(model)
	if not model then
		return nil
	end
	return model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart")
end

local function isAliveCharacter(character)
	if not character then
		return false
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	return humanoid ~= nil and root ~= nil and humanoid.Health > 0
end

local function serializePositiveInteger(value)
	return ClientCommParameterValidation:SerializeVariable(CfgParameterValidationType.PositiveInteger, value)
end

local function getTmpl(tmplId)
	if tmplId == nil then
		return nil
	end
	return CfgPlot.TmplInfo[tmplId] or CfgPlot.TmplInfo[tostring(tmplId)]
end

local function getLogicType(tmplId)
	local tmpl = getTmpl(tmplId)
	return tmpl and tmpl.LogicType or nil
end

local function getMyTeam()
	local ok, team = pcall(function()
		return RoundManagerController:GetMyTeam()
	end)
	if ok then
		return team
	end
	return nil
end

local function getTeamKeyForPlayer(player)
	local ok, key = pcall(function()
		return RoundManagerController:GetTeamKeyForPlayer(player.UserId)
	end)
	if ok and type(key) == "string" then
		return key
	end
	local character = player.Character
	if character then
		local group = character:GetAttribute("_CollisionGroup")
		if group == "HunterPlayer" then
			return "Team_2"
		elseif group == "HumanPlayer" then
			return "Team_1"
		end
	end
	return nil
end

local function isHumanTeam()
	return getMyTeam() == "Team_1"
end

local function getLocalPlots()
	local ok, plots = pcall(function()
		return PlotController:GetLocalPlayerPlots()
	end)
	if ok and type(plots) == "table" then
		return plots
	end
	return {}
end

local function getPlotsByLogic(logicType)
	local matched = {}
	for _, plot in pairs(getLocalPlots()) do
		if type(plot) == "table" and getLogicType(plot.TmplId) == logicType then
			matched[#matched + 1] = plot
		end
	end
	return matched
end

local cachedSafeRoomCFrame = nil

local function getLocalRoomInfo()
	local ok, room = pcall(function()
		return RoomController:GetLocalPlayerRoom()
	end)
	if ok and type(room) == "table" and type(room.RoomId) == "number" then
		return room
	end
	return nil
end

local function getRoomModel()
	local room = getLocalRoomInfo()
	if not room then
		return nil, nil
	end
	local folder = Workspace:FindFirstChild("RoomFolder")
	if not folder then
		return nil, room
	end
	local model = folder:FindFirstChild("Room_" .. tostring(room.RoomId))
	return model, room
end

local function getSafeRoomCFrame()
	local model = getRoomModel()
	if model then
		local part = model:FindFirstChild("Center") or model:FindFirstChild("SpawnPoint")
		if part and part:IsA("BasePart") then
			cachedSafeRoomCFrame = part.CFrame + Vector3.new(0, 3, 0)
			return cachedSafeRoomCFrame
		end
	end

	local sum = Vector3.zero
	local count = 0
	local doorCf = nil
	for _, plot in pairs(getLocalPlots()) do
		if type(plot) == "table" and typeof(plot.CFrame) == "CFrame" then
			sum += plot.CFrame.Position
			count += 1
			if getLogicType(plot.TmplId) == "Door" then
				doorCf = plot.CFrame
			end
		end
	end
	if doorCf then
		cachedSafeRoomCFrame = doorCf + Vector3.new(0, 5, 0)
		return cachedSafeRoomCFrame
	end
	if count > 0 then
		cachedSafeRoomCFrame = CFrame.new(sum / count + Vector3.new(0, 5, 0))
		return cachedSafeRoomCFrame
	end

	return cachedSafeRoomCFrame
end

local function teleportToCFrame(target)
	local character = LocalPlayer.Character
	local root = getRoot()
	if not character or not root or typeof(target) ~= "CFrame" then
		return false
	end
	if character.PivotTo then
		character:PivotTo(target)
	else
		root.CFrame = target
	end
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	return true
end

local function claimDailyTasks()
	local ok, result = pcall(function()
		return TaskService:GetDayTaskSnapshot():expect()
	end)
	if not ok or type(result) ~= "table" or result.Success ~= true then
		return
	end
	local snapshot = result.Snapshot
	local tasks = snapshot and snapshot.Tasks
	if type(tasks) ~= "table" then
		return
	end
	for _, taskInfo in ipairs(tasks) do
		if type(taskInfo) == "table"
			and taskInfo.Completed == true
			and taskInfo.Claimed ~= true
			and taskInfo.TaskId ~= nil
		then
			pcall(function()
				TaskService:ClaimDayTask(taskInfo.TaskId):expect()
			end)
			task.wait(0.1)
		end
	end
end

local function unlockClasses()
	local okHunter, hunterInv = pcall(function()
		return HunterInventoryService:GetHunterInventory():expect()
	end)
	if okHunter and type(hunterInv) == "table" then
		local owned = hunterInv.OwnedHunters or {}
		local catalog = hunterInv.Catalog
		if type(catalog) == "table" then
			for _, entry in ipairs(catalog) do
				if type(entry) == "table"
					and type(entry.TmplId) == "string"
					and entry.UnlockKind == "Value"
					and owned[entry.TmplId] ~= true
				then
					pcall(function()
						HunterInventoryService:BuyHunter(entry.TmplId):expect()
					end)
					task.wait(0.1)
				end
			end
		end
		local classProgress = hunterInv.ClassProgress or {}
		local hunterClassCfg = require(ReplicatedStorage.CommonConfig.Hunter.CfgHunterClass)
		local ordered = hunterClassCfg.GetOrderedClasses and hunterClassCfg.GetOrderedClasses() or {}
		for _, classInfo in ipairs(ordered) do
			local classId = type(classInfo) == "table" and tostring(classInfo.ClassId or "") or nil
			if classId and classId ~= "" and classProgress[classId] == nil then
				pcall(function()
					HunterInventoryService:UnlockHunterClass(classId):expect()
				end)
				task.wait(0.05)
			end
		end
	end

	local okHuman, humanInv = pcall(function()
		return HumanClassService:GetHumanClassInventory():expect()
	end)
	if okHuman and type(humanInv) == "table" then
		local owned = humanInv.OwnedClasses or {}
		local catalog = humanInv.Catalog
		if type(catalog) == "table" then
			for _, entry in ipairs(catalog) do
				if type(entry) == "table"
					and type(entry.ClassId) == "string"
					and entry.Enabled == true
					and owned[entry.ClassId] ~= true
					and entry.UnlockKind ~= "Disabled"
					and entry.UnlockKind ~= "Default"
				then
					pcall(function()
						HumanClassService:UnlockHumanClass(entry.ClassId):expect()
					end)
					task.wait(0.1)
				end
			end
		end
	end
end

local function runLobbyFeatures()
	if isOn("AutoClaimDailyTasks") then
		claimDailyTasks()
	end
	if isOn("AutoUnlockClasses") then
		unlockClasses()
	end
end

local function unlockPlot(uniqueId)
	local ok, result = pcall(function()
		local serialized = serializePositiveInteger(uniqueId)
		return PlotService:Unlock(serialized):expect()
	end)
	return ok and result == true
end

local function upgradePlot(uniqueId)
	local ok, result = pcall(function()
		local serialized = serializePositiveInteger(uniqueId)
		return PlotService:Upgrade(serialized):expect()
	end)
	return ok and result == true
end

local function unlockOrUpgradeByLogic(logicType)
	for _, plot in ipairs(getPlotsByLogic(logicType)) do
		local uniqueId = plot.UniqueId
		if type(uniqueId) ~= "number" then
			continue
		end
		if plot.Unlocked ~= true then
			unlockPlot(uniqueId)
		else
			local tmpl = getTmpl(plot.TmplId)
			if tmpl and tmpl.NextUpdatePlotTmplId then
				upgradePlot(uniqueId)
			end
		end
	end
end

local function getLaboratoryPlot()
	local plots = getPlotsByLogic("Laboratory")
	return plots[1]
end

local function getLaboratoryUniqueId()
	local plot = getLaboratoryPlot()
	if plot and type(plot.UniqueId) == "number" then
		return plot.UniqueId
	end
	return nil
end

local function goToLaboratory(force)
	local plot = getLaboratoryPlot()
	if not plot or typeof(plot.CFrame) ~= "CFrame" then
		return false
	end
	local root = getRoot()
	if not root then
		return false
	end
	local target = plot.CFrame + Vector3.new(0, 3, 0)
	if force or (root.Position - target.Position).Magnitude > 10 then
		return teleportToCFrame(target)
	end
	return true
end

local function ensureLaboratoryUnlocked()
	for _, plot in ipairs(getPlotsByLogic("Laboratory")) do
		if plot.Unlocked ~= true and type(plot.UniqueId) == "number" then
			goToLaboratory(true)
			unlockPlot(plot.UniqueId)
		end
	end
end

local function getGuideRoomId()
	local ok, roomId = pcall(function()
		return RoomController:GetLocalRoomGuideReservation()
	end)
	if ok and type(roomId) == "number" then
		return roomId
	end
	return nil
end

local function getRoomModelById(roomId)
	if type(roomId) ~= "number" then
		return nil
	end
	local ok, model = pcall(function()
		return RoomController:GetRoomModel(roomId)
	end)
	if ok and model then
		return model
	end
	local folder = Workspace:FindFirstChild("RoomFolder")
	if not folder then
		return nil
	end
	return folder:FindFirstChild("Room_" .. tostring(roomId))
end

local function getRoomCFrame(roomId)
	local model = getRoomModelById(roomId)
	if not model then
		return nil
	end
	local part = model:FindFirstChild("Center") or model:FindFirstChild("SpawnPoint")
	if part and part:IsA("BasePart") then
		return part.CFrame + Vector3.new(0, 3, 0)
	end
	if model:IsA("Model") then
		return model:GetPivot() + Vector3.new(0, 3, 0)
	end
	return nil
end

local function getUnlockTargetRoomId()
	local room = getLocalRoomInfo()
	if room and room.Status == "Occupied" and type(room.RoomId) == "number" then
		return nil
	end
	local guideId = getGuideRoomId()
	if guideId then
		return guideId
	end
	local ok, empties = pcall(function()
		return RoomController:GetEmptyRooms()
	end)
	if ok and type(empties) == "table" then
		for _, empty in ipairs(empties) do
			if type(empty) == "table" and type(empty.RoomId) == "number" then
				return empty.RoomId
			end
		end
	end
	return nil
end

local function runAutoUnlockBase()
	if not isOn("AutoUnlockBase") or not isHumanTeam() then
		return false
	end
	local room = getLocalRoomInfo()
	if room and room.Status == "Occupied" then
		return false
	end
	local roomId = getUnlockTargetRoomId()
	if not roomId then
		return false
	end
	local target = getRoomCFrame(roomId)
	if typeof(target) == "CFrame" then
		teleportToCFrame(target)
		task.wait(0.15)
	end
	pcall(function()
		RoomController:OccupyRoom(roomId)
	end)
	return true
end

local function getSelectedResearchList()
	local option = Options.ResearchProject
	if type(option) ~= "table" then
		return {}
	end
	local value = option.Value
	local selected = {}
	if type(value) == "table" then
		for name, enabled in pairs(value) do
			if enabled and RESEARCH_BY_NAME[name] then
				selected[#selected + 1] = RESEARCH_BY_NAME[name]
			end
		end
	elseif type(value) == "string" and value ~= "" and RESEARCH_BY_NAME[value] then
		selected[1] = RESEARCH_BY_NAME[value]
	end
	return selected
end

local function getSelectedResearchFieldKey()
	local option = Options.ResearchField
	if type(option) ~= "table" then
		return nil
	end
	local name = tostring(option.Value or "")
	return RESEARCH_LINE_BY_NAME[name]
end

local function isResearchInProgress(projects, projectKey)
	if type(projects) ~= "table" or type(projectKey) ~= "string" then
		return false
	end
	local info = projects[projectKey] or projects[tostring(projectKey)]
	if type(info) ~= "table" then
		return false
	end
	local status = info.Status or info.ProjectStatus or info.State
	return status == "IN_PROGRESS" or status == CfgLaboratory.ProjectStatus.InProgress
end

local function runAutoChooseResearchField()
	if not isOn("AutoChooseResearchField") or not isHumanTeam() then
		return
	end
	local lineKey = getSelectedResearchFieldKey()
	if type(lineKey) ~= "string" or lineKey == "" then
		return
	end
	ensureLaboratoryUnlocked()
	local uniqueId = getLaboratoryUniqueId()
	if type(uniqueId) ~= "number" then
		return
	end
	goToLaboratory(false)
	pcall(function()
		LaboratoryService:SelectResearchLine(lineKey, uniqueId):expect()
	end)
end

local function runAutoResearch()
	if not isOn("AutoResearchLab") or not isHumanTeam() then
		return
	end
	local selectedList = getSelectedResearchList()
	if #selectedList == 0 then
		return
	end

	ensureLaboratoryUnlocked()
	local uniqueId = getLaboratoryUniqueId()
	if type(uniqueId) ~= "number" then
		return
	end
	goToLaboratory(false)

	local okState, state = pcall(function()
		return LaboratoryService:RequestState(uniqueId):expect()
	end)
	local projects = nil
	if okState and type(state) == "table" and state.Success == true then
		local data = state.Data or state
		projects = data.Projects or data.ProjectStates or data.projects
	end

	for _, selected in ipairs(selectedList) do
		if type(selected.ProjectKey) ~= "string" then
			continue
		end
		if isResearchInProgress(projects, selected.ProjectKey) then
			continue
		end
		if type(selected.LineKey) == "string" and selected.LineKey ~= "" then
			pcall(function()
				LaboratoryService:SelectResearchLine(selected.LineKey, uniqueId):expect()
			end)
		end
		pcall(function()
			LaboratoryService:StartResearch(selected.ProjectKey, uniqueId):expect()
		end)
		task.wait(0.1)
	end
end

local function healDoor()
	local doors = getPlotsByLogic("Door")
	local door = doors[1]
	if not door or type(door.UniqueId) ~= "number" then
		return
	end
	local okCd, cd = pcall(function()
		return PlotService:GetRepairCooldownState():expect()
	end)
	if okCd and type(cd) == "table" and type(cd.Own) == "table" then
		local remaining = tonumber(cd.Own.remaining) or 0
		if remaining > 0.05 then
			return
		end
	end
	local serialized = serializePositiveInteger(door.UniqueId)
	pcall(function()
		PlotService:StartRepair(serialized):expect()
	end)
end

local function goToSafeRoom(force)
	local target = getSafeRoomCFrame()
	if typeof(target) ~= "CFrame" then
		return false
	end
	local root = getRoot()
	if not root then
		return false
	end
	if force or (root.Position - target.Position).Magnitude > 6 then
		return teleportToCFrame(target)
	end
	return true
end

local function getAirdropBoxes()
	local folder = Workspace:FindFirstChild("AirdropFolder")
	if not folder then
		return {}
	end
	local boxes = {}
	local seen = {}
	local function consider(inst)
		if seen[inst] then
			return
		end
		local boxId = inst:GetAttribute("BoxId")
		if boxId == nil then
			boxId = inst:GetAttribute("UniqueId")
		end
		if boxId == nil then
			return
		end
		seen[inst] = true
		boxes[#boxes + 1] = {
			Instance = inst,
			BoxId = boxId,
		}
	end
	for _, child in ipairs(folder:GetChildren()) do
		consider(child)
		for _, desc in ipairs(child:GetDescendants()) do
			if desc:GetAttribute("BoxId") ~= nil then
				consider(desc:FindFirstAncestorOfClass("Model") or child)
				break
			end
		end
	end
	return boxes
end

local function lootAirdropBox(box)
	local inst = box.Instance
	local pivot = inst:IsA("Model") and inst:GetPivot() or (inst:IsA("BasePart") and inst.CFrame)
	if pivot then
		local root = getRoot()
		if root and (root.Position - pivot.Position).Magnitude > 12 then
			teleportToCFrame(pivot + Vector3.new(0, 3, 0))
			task.wait(0.15)
		end
	end
	pcall(function()
		AirdropService:LootBox(box.BoxId):expect()
	end)
end

local function collectAirdrops()
	local boxes = getAirdropBoxes()
	if #boxes == 0 then
		return false
	end
	for _, box in ipairs(boxes) do
		if Library.Unloaded or not isOn("AutoCollectAirdrops") then
			break
		end
		lootAirdropBox(box)
		task.wait(0.2)
	end
	return true
end

local function canUseSafeRoom()
	return getLocalRoomInfo() ~= nil or isHumanTeam() or cachedSafeRoomCFrame ~= nil
end

local function runSafeRoomOrAirdrop()
	if runAutoUnlockBase() then
		return
	end

	local collectOn = isOn("AutoCollectAirdrops")
	local safeOn = isOn("AutoSafeRoom")
	if not collectOn and not safeOn then
		return
	end

	if collectOn then
		local hadBoxes = collectAirdrops()
		if hadBoxes then
			if #getAirdropBoxes() == 0 and canUseSafeRoom() then
				goToSafeRoom(true)
			end
			return
		end
	end

	if safeOn and canUseSafeRoom() then
		goToSafeRoom(false)
	end
end

local espFolder = Instance.new("Folder")
espFolder.Name = "OuroborosBreakDoorESP"
espFolder.Parent = LocalPlayer:WaitForChild("PlayerGui")

local espObjects = {}

local function removeEsp(model)
	local entry = espObjects[model]
	if not entry then
		return
	end
	if entry.Highlight then
		entry.Highlight:Destroy()
	end
	if entry.Billboard then
		entry.Billboard:Destroy()
	end
	espObjects[model] = nil
end

local function updateEsp(model, color, text)
	local head = getHead(model)
	if not head then
		removeEsp(model)
		return
	end

	local entry = espObjects[model]
	if not entry then
		local highlight = Instance.new("Highlight")
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillTransparency = 0.65
		highlight.OutlineTransparency = 0
		highlight.Parent = espFolder

		local billboard = Instance.new("BillboardGui")
		billboard.Size = UDim2.fromOffset(180, 20)
		billboard.StudsOffset = Vector3.new(0, 2.6, 0)
		billboard.AlwaysOnTop = true
		billboard.Parent = espFolder

		local label = Instance.new("TextLabel")
		label.Size = UDim2.fromScale(1, 1)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.GothamBold
		label.TextSize = 13
		label.TextStrokeTransparency = 0.35
		label.Parent = billboard

		entry = {
			Highlight = highlight,
			Billboard = billboard,
			Label = label,
		}
		espObjects[model] = entry
	end

	entry.Highlight.Adornee = model
	entry.Highlight.FillColor = color
	entry.Highlight.OutlineColor = color
	entry.Billboard.Adornee = head
	entry.Label.TextColor3 = color
	entry.Label.Text = text
end

local function clearEsp()
	for model in pairs(espObjects) do
		removeEsp(model)
	end
end

local function refreshEsp()
	if Library.Unloaded or not isOn("PlayerESP") then
		clearEsp()
		return
	end

	local alive = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and isAliveCharacter(player.Character) then
			local model = player.Character
			alive[model] = true
			local teamKey = getTeamKeyForPlayer(player)
			local color = teamKey == "Team_2" and HUNTER_COLOR or SURVIVOR_COLOR
			local tag = teamKey == "Team_2" and ("[Hunter] " .. player.Name) or ("[Survivor] " .. player.Name)
			updateEsp(model, color, tag)
		end
	end

	for model in pairs(espObjects) do
		if not alive[model] then
			removeEsp(model)
		end
	end
end

local Window = Library:CreateWindow({
	Title = "乌洛波洛斯 Hub",
	Footer = {
		{ Text = DISCORD_INVITE, Copyable = true },
		"|",
		GAME_NAME,
	},
	Icon = 12645376577,
	NotifySide = "Right",
	ShowCustomCursor = false,
	CornerRadius = 10,
})

local Tabs = {
	Info = Window:AddTab("信息", "info"),
	Main = Window:AddTab("主要", "door-open"),
	Player = Window:AddTab("玩家", "person-standing"),
	Settings = Window:AddTab("设置", "settings"),
}

local executorName = "Unknown"
pcall(function()
	if identifyexecutor then
		local name, version = identifyexecutor()
		if type(name) == "string" and name ~= "" then
			executorName = type(version) == "string" and version ~= "" and (name .. " " .. version) or name
		end
	end
end)

local AccountGroup = Tabs.Info:AddLeftGroupbox("账户", "circle-user")
AccountGroup:AddLabel(field("User", LocalPlayer.Name, GREEN), true)
AccountGroup:AddLabel(field("状态", "免密钥", GREEN), true)
AccountGroup:AddLabel(field("执行器", executorName, GREEN), true)

local GameGroup = Tabs.Info:AddLeftGroupbox("游戏信息", "gamepad-2")
GameGroup:AddLabel(colored(GAME_NAME .. " [" .. tostring(game.PlaceId) .. "]", BLUE), true)
GameGroup:AddLabel(field("地点 ID", tostring(game.PlaceId), BLUE), true)

local SessionLabel = GameGroup:AddLabel(field("会话时长", "0s", ORANGE), true)
local jobId = tostring(game.JobId)
local shortJobId = #jobId > 18 and (string.sub(jobId, 1, 18) .. "...") or jobId
GameGroup:AddLabel(field("服务器", shortJobId, GREY), true)

GameGroup:AddButton({
	Text = "复制加入脚本 (Job ID)",
	Func = function()
		local joinScript = string.format(
			'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game:GetService("Players").LocalPlayer)',
			game.PlaceId,
			jobId
		)
		copyText(joinScript, "已复制加入脚本到剪贴板")
	end,
})

local sessionStart = os.clock()
task.spawn(function()
	while true do
		task.wait(1)
		if Library.Unloaded then
			break
		end
		local elapsed = math.floor(os.clock() - sessionStart)
		local text
		if elapsed < 60 then
			text = elapsed .. "s"
		elseif elapsed < 3600 then
			text = string.format("%dm %ds", elapsed // 60, elapsed % 60)
		else
			text = string.format("%dh %dm", elapsed // 3600, (elapsed % 3600) // 60)
		end
		SessionLabel:SetText(field("会话时长", text, ORANGE))
	end
end)

local ScriptsGroup = Tabs.Info:AddRightGroupbox("脚本", "package")
ScriptsGroup:AddLabel(colored("包含在此 Hub 中", GREY), true)
ScriptsGroup:AddLabel(colored(GAME_NAME, BLUE), true)

local FeaturesGroup = Tabs.Info:AddRightGroupbox("功能", "list")
FeaturesGroup:AddLabel(colored("自动化", BLUE), true)
FeaturesGroup:AddLabel(colored("大厅", GREEN), true)
FeaturesGroup:AddLabel(colored("ESP", BLUE), true)
FeaturesGroup:AddLabel(colored("玩家工具", GREY), true)

local SocialsGroup = Tabs.Info:AddRightGroupbox("社交", "link")
SocialsGroup:AddButton({
	Text = "Discord",
	Func = copyDiscord,
})
SocialsGroup:AddButton({
	Text = "Rscripts",
	Func = function()
		copyText(RSCRIPTS_LINK, "已复制 Rscripts 主页到剪贴板")
	end,
})

local AdGroup = Tabs.Info:AddLeftGroupbox("乌洛波洛斯 Hub", "sparkles")
AdGroup:AddLabel("Every script in the hub is keyless. No key systems, no checkpoints, no linkvertise.", true)
AdGroup:AddLabel("The Discord has ready made configs, dupe methods, giveaways, and early access to new scripts.", true)
AdGroup:AddLabel("Requests get taken seriously. A lot of what is in this script started as a Discord message.", true)
AdGroup:AddButton({
	Text = "复制 Discord 邀请",
	Func = copyDiscord,
})

local DonationsGroup = Tabs.Info:AddRightGroupbox("捐赠", "heart")
DonationsGroup:AddLabel(colored("所有捐赠都是自愿的，但感谢支持。", ORANGE), true)
DonationsGroup:AddLabel(colored("如果你捐赠会获得特殊身份，捐赠后记得 PING。", GREEN), true)
DonationsGroup:AddDivider()
DonationsGroup:AddLabel(colored("LTC / 莱特币", LTC), true)
DonationsGroup:AddButton({
	Text = "复制莱特币地址",
	Func = function()
		copyText(LTC_ADDRESS, "已复制莱特币地址")
	end,
})
DonationsGroup:AddLabel(colored("BTC / 比特币", BTC), true)
DonationsGroup:AddButton({
	Text = "复制比特币地址",
	Func = function()
		copyText(BTC_ADDRESS, "已复制比特币地址")
	end,
})
DonationsGroup:AddLabel(colored("ETH / 以太坊", ETH), true)
DonationsGroup:AddButton({
	Text = "复制以太坊地址",
	Func = function()
		copyText(ETH_ADDRESS, "已复制以太坊地址")
	end,
})
DonationsGroup:AddLabel(colored("USDT", USDT), true)
DonationsGroup:AddButton({
	Text = "复制 USDT 地址",
	Func = function()
		copyText(USDT_ADDRESS, "已复制 USDT 地址")
	end,
})
DonationsGroup:AddLabel(colored("Solana", SOL), true)
DonationsGroup:AddButton({
	Text = "复制 Solana 地址",
	Func = function()
		copyText(SOL_ADDRESS, "已复制 Solana 地址")
	end,
})
DonationsGroup:AddLabel(colored("PayPal", PAYPAL), true)
DonationsGroup:AddButton({
	Text = "复制 PayPal 链接",
	Func = function()
		copyText(PAYPAL_LINK, "已复制 PayPal 链接")
	end,
})
DonationsGroup:AddLabel(colored("Venmo", VENMO), true)
DonationsGroup:AddButton({
	Text = "复制 Venmo 链接",
	Func = function()
		copyText(VENMO_LINK, "已复制 Venmo 链接")
	end,
})
DonationsGroup:AddDivider()
DonationsGroup:AddLabel(colored("没有上面这些货币但仍然想捐赠？", GREY), true)
DonationsGroup:AddLabel(colored("私信我，我们会想办法。", BLUE), true)

local FaqGroup = Tabs.Info:AddRightGroupbox("常见问题", "circle-help")
FaqGroup:AddLabel("在哪里可以获得一个好的配置？", true)
FaqGroup:AddLabel("加入 Discord，配置频道里分享了每个脚本的配置。", true)
FaqGroup:AddLabel("如何导入 / 导出配置？", true)
FaqGroup:AddLabel("加入 Discord，指南已置顶，人们每天都会分享配置链接。", true)
FaqGroup:AddLabel("如何反馈 Bug？", true)
FaqGroup:AddLabel("加入 Discord 并发布到 Bug 频道。", true)
FaqGroup:AddLabel("如何提出建议？", true)
FaqGroup:AddLabel("加入 Discord 并投递到建议频道，大多数都会被采纳。", true)
FaqGroup:AddLabel("如何获得帮助或更新？", true)
FaqGroup:AddLabel("加入 Discord，更新和支持会首先发布在那里。", true)

local function AddDiscordButton(Tab)
	local DiscordGroup = Tab:AddLeftGroupbox("Discord")
	DiscordGroup:AddButton({
		Text = "加入 Discord 来赚钱",
		Func = copyDiscord,
	})
	DiscordGroup:AddButton({
		Text = "加入 Discord 获取免密钥脚本",
		Func = copyDiscord,
	})
end

for _, Tab in pairs(Tabs) do
	if Tab ~= Tabs.Info then
		AddDiscordButton(Tab)
	end
end

local AutoGroup = Tabs.Main:AddLeftGroupbox("自动化", "bot")
AutoGroup:AddToggle("AutoUnlockBase", {
	Text = "自动解锁基地",
	Default = false,
})
AutoGroup:AddToggle("AutoSafeRoom", {
	Text = "自动安全房",
	Default = false,
})
AutoGroup:AddToggle("AutoUpgradeDoor", {
	Text = "自动升级门",
	Default = false,
})
AutoGroup:AddToggle("AutoBank", {
	Text = "自动解锁/升级银行",
	Default = false,
})
AutoGroup:AddToggle("AutoGuard", {
	Text = "自动解锁/升级守卫",
	Default = false,
})
AutoGroup:AddToggle("AutoHealDoor", {
	Text = "自动修理门",
	Default = false,
})
AutoGroup:AddToggle("AutoGoldMachine", {
	Text = "自动解锁/升级黄金机",
	Default = false,
})
AutoGroup:AddToggle("AutoDecomposer", {
	Text = "自动解锁/升级分解机",
	Default = false,
})
AutoGroup:AddToggle("AutoCollectAirdrops", {
	Text = "自动收集空投",
	Default = false,
})
AutoGroup:AddToggle("AutoResearchLab", {
	Text = "自动研究实验室",
	Default = false,
})
AutoGroup:AddToggle("AutoChooseResearchField", {
	Text = "自动选择研究领域",
	Default = false,
})
AutoGroup:AddDropdown("ResearchField", {
	Text = "研究领域",
	Values = #RESEARCH_LINE_NAMES > 0 and RESEARCH_LINE_NAMES or { "Armory Tech" },
	Default = (#RESEARCH_LINE_NAMES > 0 and RESEARCH_LINE_NAMES[1]) or "Armory Tech",
})
AutoGroup:AddDropdown("ResearchProject", {
	Text = "研究项目",
	Values = #RESEARCH_NAMES > 0 and RESEARCH_NAMES or { "Armory Research" },
	Default = {},
	Multi = true,
	AllowNull = true,
	Searchable = true,
})

local EspGroup = Tabs.Main:AddRightGroupbox("ESP", "eye")
EspGroup:AddToggle("PlayerESP", {
	Text = "幸存者/猎人 ESP",
	Default = false,
})

local LobbyGroup = Tabs.Main:AddLeftGroupbox("大厅", "house")
LobbyGroup:AddToggle("AutoClaimDailyTasks", {
	Text = "自动领取每日任务",
	Default = false,
})
LobbyGroup:AddToggle("AutoUnlockClasses", {
	Text = "自动解锁职业",
	Default = false,
})

Toggles.PlayerESP:OnChanged(function()
	if not Toggles.PlayerESP.Value then
		clearEsp()
	else
		refreshEsp()
	end
end)

local MovementGroup = Tabs.Player:AddLeftGroupbox("移动", "footprints")
MovementGroup:AddToggle("WalkSpeedEnabled", {
	Text = "行走速度",
	Default = false,
})
MovementGroup:AddSlider("WalkSpeed", {
	Text = "行走速度数值",
	Default = 32,
	Min = 16,
	Max = 250,
	Rounding = 0,
})
MovementGroup:AddToggle("InfJump", {
	Text = "无限跳跃",
	Default = false,
})
MovementGroup:AddToggle("NoClip", {
	Text = "穿墙",
	Default = false,
})
MovementGroup:AddToggle("AntiGameplayPause", {
	Text = "无游戏暂停",
	Default = true,
})

local FlyGroup = Tabs.Player:AddRightGroupbox("飞行", "feather")
FlyGroup:AddToggle("Fly", {
	Text = "飞行",
	Default = false,
})
FlyGroup:AddSlider("FlySpeed", {
	Text = "飞行速度",
	Default = 60,
	Min = 10,
	Max = 400,
	Rounding = 0,
})

local MenuGroup = Tabs.Settings:AddLeftGroupbox("菜单")
MenuGroup:AddLabel("菜单绑定"):AddKeyPicker("MenuKeybind", {
	Default = "RightShift",
	NoUI = true,
	Text = "菜单快捷键",
})
Library.ToggleKeybind = Options.MenuKeybind

MenuGroup:AddToggle("AntiAfk", {
	Text = "防挂机",
	Default = true,
})

MenuGroup:AddButton({
	Text = "卸载",
	Func = function()
		Library:Unload()
	end,
})

local antiAfkLastInput = tick()
local antiAfkLastTap = tick()

pcall(function()
	for _, connection in ipairs(getconnections(LocalPlayer.Idled)) do
		pcall(function()
			connection:Disable()
		end)
	end
end)

local function antiAfkTap()
	local camera = Workspace.CurrentCamera
	if not camera then
		return
	end
	VirtualUser:Button2Down(Vector2.new(0, 0), camera.CFrame)
	task.wait(0.1)
	VirtualUser:Button2Up(Vector2.new(0, 0), camera.CFrame)
	antiAfkLastTap = tick()
end

local antiAfkBeganConnection = UserInputService.InputBegan:Connect(function()
	antiAfkLastInput = tick()
end)

local antiAfkChangedConnection = UserInputService.InputChanged:Connect(function(input)
	local inputType = input.UserInputType
	if inputType == Enum.UserInputType.MouseMovement or inputType == Enum.UserInputType.Gamepad1 then
		antiAfkLastInput = tick()
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(2)
		if Toggles.AntiAfk.Value then
			local idle = tick() - antiAfkLastInput
			local sinceTap = tick() - antiAfkLastTap
			if idle >= 300 and sinceTap >= 60 then
				pcall(antiAfkTap)
			elseif idle < 300 and sinceTap >= 300 then
				pcall(antiAfkTap)
			end
		end
	end
end)

RunService.Stepped:Connect(function()
	if Library.Unloaded then
		return
	end
	if Toggles.NoClip and Toggles.NoClip.Value then
		local character = LocalPlayer.Character
		if character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	end
end)

UserInputService.JumpRequest:Connect(function()
	if Library.Unloaded then
		return
	end
	if Toggles.InfJump and Toggles.InfJump.Value then
		local humanoid = getHumanoid()
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

local Camera = Workspace.CurrentCamera

RunService.RenderStepped:Connect(function(dt)
	if Library.Unloaded then
		return
	end

	if Toggles.WalkSpeedEnabled and Toggles.WalkSpeedEnabled.Value then
		local humanoid = getHumanoid()
		if humanoid then
			humanoid.WalkSpeed = Options.WalkSpeed.Value
		end
	end

	if Toggles.Fly and Toggles.Fly.Value then
		local root = getRoot()
		local humanoid = getHumanoid()
		if root and humanoid then
			humanoid.PlatformStand = true
			local direction = Vector3.zero
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				direction = direction + Camera.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				direction = direction - Camera.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				direction = direction - Camera.CFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				direction = direction + Camera.CFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				direction = direction + Vector3.new(0, 1, 0)
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				direction = direction - Vector3.new(0, 1, 0)
			end
			root.AssemblyLinearVelocity = Vector3.zero
			if direction.Magnitude > 0 then
				root.CFrame = root.CFrame + direction.Unit * Options.FlySpeed.Value * dt
			end
		end
	end
end)

Toggles.Fly:OnChanged(function()
	if not Toggles.Fly.Value then
		local humanoid = getHumanoid()
		if humanoid then
			humanoid.PlatformStand = false
		end
	end
end)

Toggles.WalkSpeedEnabled:OnChanged(function()
	if not Toggles.WalkSpeedEnabled.Value then
		local humanoid = getHumanoid()
		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end
end)

local function applyAntiGameplayPause(enabled)
	pcall(function()
		GuiService:SetGameplayPausedNotificationEnabled(not enabled)
	end)
	pcall(function()
		local notification = CoreGui:FindFirstChild("RobloxNetworkPauseNotification")
		if notification then
			notification.Enabled = not enabled
		end
	end)
	if not enabled then
		return
	end
	pcall(function()
		if sethiddenproperty then
			sethiddenproperty(LocalPlayer, "GameplayPaused", false)
		else
			LocalPlayer.GameplayPaused = false
		end
	end)
end

Toggles.AntiGameplayPause:OnChanged(function()
	applyAntiGameplayPause(Toggles.AntiGameplayPause.Value)
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(1)
		if Toggles.AntiGameplayPause.Value then
			applyAntiGameplayPause(true)
		end
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(0.35)
		pcall(runSafeRoomOrAirdrop)
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(1.25)
		pcall(runAutoChooseResearchField)
		pcall(runAutoResearch)
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(1.1)
		if not isHumanTeam() then
			continue
		end
		pcall(runAutoUnlockBase)
		if isOn("AutoUpgradeDoor") then
			pcall(unlockOrUpgradeByLogic, "Door")
		end
		if isOn("AutoBank") then
			pcall(unlockOrUpgradeByLogic, "CashMachine")
		end
		if isOn("AutoGuard") then
			pcall(unlockOrUpgradeByLogic, "Turrent")
		end
		if isOn("AutoGoldMachine") then
			pcall(unlockOrUpgradeByLogic, "GearMachine")
		end
		if isOn("AutoDecomposer") then
			pcall(unlockOrUpgradeByLogic, "DecomposerMachine")
		end
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(0.35)
		if isOn("AutoHealDoor") and isHumanTeam() then
			pcall(healDoor)
		end
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(0.2)
		if isOn("PlayerESP") then
			pcall(refreshEsp)
		end
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		task.wait(2)
		pcall(runLobbyFeatures)
	end
end)

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("OuroborosHub")
ThemeManager:SaveDefault("Monochrome")
ThemeManager:ApplyToTab(Tabs.Settings)
ThemeManager:LoadDefault()

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind", "SaveManager_ImportSource" })
SaveManager:SetFolder("OuroborosHub/BreakDoor")
local ConfigurationBox = SaveManager:BuildConfigSection(Tabs.Settings)

local function configElement(objectType, index)
	local holder = objectType == "Toggle" and Toggles or Options
	local element = holder[index]
	return type(element) == "table" and element.Type == objectType and element or nil
end

local function encodeConfigObject(index, element)
	local elementType = element.Type
	if elementType == "Toggle" then
		return { idx = index, type = "Toggle", value = element.Value == true }
	elseif elementType == "Slider" then
		return { idx = index, type = "Slider", value = tostring(element.Value) }
	elseif elementType == "Dropdown" then
		return { idx = index, type = "Dropdown", multi = element.Multi == true, value = element.Value }
	elseif elementType == "Input" then
		return { idx = index, type = "Input", text = tostring(element.Value or "") }
	elseif elementType == "ColorPicker" then
		return {
			idx = index,
			type = "ColorPicker",
			value = element.Value:ToHex(),
			transparency = element.Transparency,
		}
	elseif elementType == "KeyPicker" then
		return {
			idx = index,
			type = "KeyPicker",
			mode = element.Mode,
			key = element.Value,
			modifiers = element.Modifiers,
			toggled = element.Toggled,
		}
	end
	return nil
end

local function buildConfigPayload()
	local objects = {}
	for _, holder in ipairs({ Toggles, Options }) do
		for index, element in pairs(holder) do
			if type(element) == "table"
				and type(element.Type) == "string"
				and not SaveManager.Ignore[index]
			then
				local encoded = encodeConfigObject(index, element)
				if encoded then
					objects[#objects + 1] = encoded
				end
			end
		end
	end

	table.sort(objects, function(a, b)
		if a.type ~= b.type then
			return a.type < b.type
		end
		return a.idx < b.idx
	end)

	return { objects = objects }
end

local function applyConfigObject(object)
	if type(object) ~= "table"
		or type(object.idx) ~= "string"
		or type(object.type) ~= "string"
		or SaveManager.Ignore[object.idx]
	then
		return false
	end

	local element = configElement(object.type, object.idx)
	if not element then
		return false
	end

	local applied = pcall(function()
		if object.type == "Input" then
			if type(object.text) ~= "string" then
				return
			end
			element:SetValue(object.text)
		elseif object.type == "ColorPicker" then
			element:SetValueRGB(Color3.fromHex(object.value), object.transparency)
		elseif object.type == "KeyPicker" then
			element:SetValue({ object.key, object.mode, object.modifiers })
			if object.mode == "Toggle" and object.toggled ~= nil then
				element.Toggled = object.toggled
				element:Update()
			end
		else
			element:SetValue(object.value)
		end
	end)

	return applied
end

ConfigurationBox:AddDivider()

ConfigurationBox:AddInput("SaveManager_ImportSource", {
	Text = "在此粘贴导出的配置",
	Finished = true,
	AllowEmpty = true,
})

ConfigurationBox:AddButton("导出配置到剪贴板", function()
	local encodeSuccess, encoded = pcall(HttpService.JSONEncode, HttpService, buildConfigPayload())
	if not encodeSuccess then
		Library:Notify("配置编码失败")
		return
	end

	local writeClipboard = setclipboard or toclipboard
	if type(writeClipboard) ~= "function" or not pcall(writeClipboard, encoded) then
		Library:Notify("你的执行器不支持复制到剪贴板")
		return
	end

	Library:Notify("配置已复制到剪贴板", 6)
end)

ConfigurationBox:AddButton("从剪贴板文本导入配置", function()
	local source = tostring(Options.SaveManager_ImportSource.Value or ""):match("^%s*(.-)%s*$")
	if source == "" then
		Library:Notify("请先将导出的配置粘贴到输入框")
		return
	end

	local decodeSuccess, decoded = pcall(HttpService.JSONDecode, HttpService, source)
	if not decodeSuccess or type(decoded) ~= "table" or type(decoded.objects) ~= "table" then
		Library:Notify("这不是有效的导出配置")
		return
	end

	local applied = 0
	for _, object in ipairs(decoded.objects) do
		if applyConfigObject(object) then
			applied += 1
		end
	end

	if applied == 0 then
		Library:Notify("该配置中没有与这个脚本匹配的设置")
		return
	end

	Options.SaveManager_ImportSource:SetValue("")
	Library:Notify(("已导入 %d 个设置%s"):format(applied, applied == 1 and "" or "s"), 6)
end)

SaveManager:LoadAutoloadConfig()

Library:OnUnload(function()
	clearEsp()
	if espFolder then
		espFolder:Destroy()
	end
	if antiAfkBeganConnection then
		antiAfkBeganConnection:Disconnect()
	end
	if antiAfkChangedConnection then
		antiAfkChangedConnection:Disconnect()
	end
	applyAntiGameplayPause(false)
	local humanoid = getHumanoid()
	if humanoid then
		humanoid.PlatformStand = false
		humanoid.WalkSpeed = 16
	end
end)
