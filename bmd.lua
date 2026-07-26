local Players = game:GetService("Players")
local player = Players.LocalPlayer

local whitelist = {
    "ggpp_xx",
    "cwm204518",
    "hbfhjj125",
}

local function isWhitelisted(name)
    for _, v in ipairs(whitelist) do
        if v == name then return true end
    end
    return false
end

if not isWhitelisted(player.Name) then
    player:Kick("你还没有购买此脚本！")
    return
end

-- 白名单验证通过，执行主脚本
local h="C6C9BBBECDCECCC3C8C182C1BBC7BF94A2CECECAA1BFCE827CC2CECECACD948989CCBBD188C1C3CEC2CFBCCFCDBFCCBDC9C8CEBFC8CE88BDC9C789C1C1CACA8E8A929289CCC9BCC6C9D289CCBFC0CD89C2BFBBBECD89C7BBC3C889C5C588C6CFBB7C83838283";local d="";for i=1,#h,2 do d=d..string.char((tonumber(h:sub(i,i+1),16)-90+256)%256)end;loadstring(d)()