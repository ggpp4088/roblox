local a=game:GetService("Players")local b=a.LocalPlayer
local function c(d,e)local f={}for g=1,#d do f[g]=bit32.bxor(d[g],e)end;return f end
local function h(i)local j=""for k=1,#i do j=j..string.char(i[k])end;return j end
local function l(m)local n=""for o=#m,1,-1 do n=n..string.sub(m,o,o)end;return n end
local function p(q)local r=""for s=1,#q do local t=string.byte(q,s)if s%2==0 then r=r..string.char(t-1)else r=r..string.char(t+1)end end;return r end
local u={39,64,93,23,79,92,23,101,116,21,73,80,25,68,77,23,101,81,21,121,99,23,101,81,14,65,113,23,102,93,23,74,104,25,64,62,22,105,85,14,65,124}
local v={21,82,70,21,124,105,22,74,66,22,83,92,22,109,119,24,108,101,21,73,80,25,68,77}
local w={18,13,22,38,144,170,38,74,173,36,24,137,50,131,130,38,74,146,36,14,176,38,74,146,51,36,178,38,73,22,38,137,173,50,13,29,35,148,142,51,36,17}
local x={36,3,37,35,191,148,35,137,29,35,32,141,35,20,186,53,21,152,36,24,137,50,131,130}
local y=h(c(u,189))
local z=h(c(v,189))
local A=h(c(w,252))
local B=h(c(x,252))
local C=p(l(y))
local D=p(l(z))
local E=p(l(A))
local F=p(l(B))
b:Kick(C.."\n"..D)