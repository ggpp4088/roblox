local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function HttpGet(url)
    local success, result

    -- Executor
    if request then
        success, result = pcall(function()
            local r = request({Url = url, Method = "GET"})
            return r and (r.Body or r.body or r)
        end)
        if success and type(result) == "string" and #result > 0 then return result end
    end

    if syn and syn.request then
        success, result = pcall(function()
            local r = syn.request({Url = url, Method = "GET"})
            return r and (r.Body or r.body or r)
        end)
        if success and type(result) == "string" and #result > 0 then return result end
    end

    -- Roblox HttpService
    success, result = pcall(function()
        return HttpService:GetAsync(url, false)
    end)
    if success and type(result) == "string" and #result > 0 then return result end

    return nil
end

-- ===== Base64 解码（兼容 GitHub）=====
local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function base64decode(str)
    str = str:gsub("%s+", "") 
    str = str:gsub("=", "")
    local out, n = {}, 1
    for i = 1, #str, 4 do
        local a = (b64chars:find(str:sub(i, i)) or 1) - 1
        local b = (b64chars:find(str:sub(i + 1, i + 1)) or 1) - 1
        local c = (b64chars:find(str:sub(i + 2, i + 2)) or 65) - 1
        local d = (b64chars:find(str:sub(i + 3, i + 3)) or 65) - 1

        out[n] = string.char(a * 4 + math.floor(b / 16))
        n = n + 1

        if c < 64 then
            out[n] = string.char((b % 16) * 16 + math.floor(c / 4))
            n = n + 1
            if d < 64 then
                out[n] = string.char((c % 4) * 64 + d)
                n = n + 1
            end
        end
    end
    return table.concat(out)
end

local function FetchFromGitHub(path)
    local rawURL = "https://raw.githubusercontent.com/ggpp4088/roblox/main/" .. path
    local content = HttpGet(rawURL)
    if content then return content end

    local apiURL = "https://api.github.com/repos/ggpp4088/roblox/contents/" .. path
    local json = HttpGet(apiURL)
    if not json then return nil end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(json)
    end)

    if ok and data and data.content then
        return base64decode(data.content)
    end

    return nil
end

local WhitelistCache = nil
local function IsWhitelisted()
    if WhitelistCache ~= nil then return WhitelistCache end

    local plr = Players.LocalPlayer
    if not plr then return false end

    local name = plr.Name
    local raw = FetchFromGitHub("yhm")

    if raw then
        for line in raw:gmatch("[^\r\n]+") do
            local trimmed = line:match("^%s*(.-)%s*$")
            if trimmed ~= "" and trimmed == name then
                WhitelistCache = true
                return true
            end
        end
    end

    WhitelistCache = false
    return false
end

if IsWhitelisted() then
    local code = FetchFromGitHub("bmd.lua")
    if code then
        pcall(loadstring(code))
    end
else
    local code = FetchFromGitHub("kk.lua")
    if code then
        pcall(loadstring(code))
    end
end
