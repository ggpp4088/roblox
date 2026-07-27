local a=game:GetService("Players")local b=a.LocalPlayer
local function c(d,e)local f={}for g=1,#d do f[g]=bit32.bxor(d[g],e)end;return f end
local function h(i)local j=""for k=1,#i do j=j..string.char(i[k])end;return j end
local l={27,66,95,25,77,94,25,99,118,23,75,82,27,70,79,25,99,83,23,123,101,25,99,83,16,67,115,25,104,95,25,76,106,27,66,64,24,107,87,16,67,126}
local m={23,80,72,23,126,107,24,76,68,24,81,94,24,111,121,26,110,103,23,75,82,27,70,79}
local n=h(c(l,255))
local o=h(c(m,255))
b:Kick(n.."\n"..o)
