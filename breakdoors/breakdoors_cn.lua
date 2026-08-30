local V1=function(s,k,t)
    local r={};
    for i=0x0 + 0x1,#s do
        r[i]=string.char((string.byte(s,i) - k - (i - (0x1 + 0x0)) * t) % (0xE2D4A - 0xE2C4A));
    end
    return table.concat(r);
end;
local V2=game:GetService(V1("\128+\175V\209m\253",0x30,0x8F));
local V3=game:GetService(V1("\144\164\176\173\171\166\165\185\171\171\155\189\185\189\173\180\179",0x3E,0x1));
local V4=game:GetService(V1('\202J\160\226Q\187\028l\195\"',0x78,0x5D));
local V5=game:GetService(V1("\1758\149\rO\223L\188&p\237e\2122\151\004",0x5A,0x6B));
local V6=game:GetService(V1("\005\193s\030\200]\017\163j\005\187",0xAF,0xA9));
local V7=game:GetService(V1("\a\027\003\231\178\172\161\141hJ4",0xBF,0xE8));
local V8=game:GetService(V1("\018\204L\194`\249\137\b\142\028",0xCB,0x8C));
local V9=game:GetService(V1("\127\148\128\\\'>\027",0x3C,0xE9));
local V10=game:GetService(V1("\145\247H\143\2290o\191\015",0x3A,0x4E));
local V11=V2.LocalPlayer;
local V12=V1("7\2136\160\024;\205f\212E",0xF5,0x6E);
local V13=V1("7\225\127\025\186\031\178P#\198n\252\166G\215?\022\180\026\238\143\016\185r\214\173A\176\141",0xCF,0x9E);
local V14=V1("8\211b\237\127\213Y\232\186J\201g\237\131\022\164\238\189C\225+\203i\030\1706\184T\230r\005",0xD0,0x8F);
local V15=require(V3:WaitForChild(V1("1\217S\207M\200\025\193;\1865\176#\168*\165",0xEE,0x7C)):WaitForChild(V1("\171\142b<\004\220\172\140",0x5B,0xD2)):WaitForChild(V1("B\211<\181",0xF7,0x6E)));
local V16=require(V3.CommonComponents.Tool.ClientCommParameterValidation);
local V17=require(V3.CommonConfig.BaseConfig.CfgParameterValidationType);
local V18=require(V3.CommonConfig.Plot.CfgPlot);
local V19=require(V3.CommonConfig.Laboratory.CfgLaboratory);
V15.OnStart():await();
local V20=V15.GetController(V1("\245\021\028%\248(+5789=:K",0xA5,0x4));
local V21=V15.GetService(V1("\165\fZ\170\2121\137\216\022[\168",0x55,0x4B));
local V22=V15.GetService(V1("\218\211\173pO\029\239\163\134d9\253\200\155",0x99,0xD1));
local V23=V15.GetController(V1("7\224l\246X\016\155-\183@\201U\218s",0xE5,0x8C));
local V24=V15.GetController(V1("\255*>EI@b}~\146\158\185\152\210\223\243\255\n\021#*E",0xAD,0xE));
local V25=V15.GetService(V1("\195#\136\211\014s\211*p\189\018",0x6F,0x53));
local V26=V15.GetService(V1('\189\194\146^C\240\241\190\168\1288\"\a\227\174\128Z',0x75,0xD8));
local V27=V15.GetService(V1("\223h\189\031l\213\b\137\2378\157\255V\181\024N\188%\133\212*\136",0x97,0x5C));
local V28=V15.GetService(V1("6]p\143\164\165\202\215\236\005\241\0214JO[o",0xEA,0x12));
local V29={};
local V30={};
do
    for V148,V149 in ipairs(V19.OrderedProjectKeys or ({})) do
        local V150=V19.GetProject(V149);
        if type(V150) == V1("\a\203\163\132T",0x93,0xD7) and V150.Enabled ~= false then
            local V151=tostring(V150.DisplayName or V149);
            if not V30[V151] then
                V29[#V29 + (0x1 + 0x0)]=V151;
                V30[V151]={ProjectKey=V149, LineKey=V150.LineKey, SlotType=V150.SlotType};
            end
        end
    end
end
local V31={};
local V32={};
do
    for V152,V153 in ipairs(V19.OrderedLineKeys or ({})) do
        local V154=V19.GetLine(V153);
        if type(V154) == V1("\188\211\2542U",0x48,0x2A) and V154.Enabled ~= false then
            local V155=tostring(V154.DisplayName or V153);
            if not V32[V155] then
                V31[#V31 + (0x2CAD1 - 0x2CAD0)]=V155;
                V32[V155]=V153;
            end
        end
    end
end
local V33=V1("\031&!\024\022\216\200\195\001\235\252\174\226\223\229\212\220\196\210\203\184\192\172\179\173\174\154\158\159T\132\139\132Awwxqm]]QRAO99\251\022$0!\023\023\n\018\244\006\t\002\236\181\238\221\224\224\156",0xB7,0xFB);
local V34=loadstring(game:HttpGet(V33 .. V1("\196\134$\217m#\207)\f\186K",0x78,0xA5)))();
local V35=loadstring(game:HttpGet(V33 .. V1("\225\178\128Y&\249\131vX#\249\191uW2\243\199\147n\248\004\219\149",0x80,0xCE)))();
local V36=loadstring(game:HttpGet(V33 .. V1("\181\238$e\154\213\199!e\176\213\243=\128\169\229\025\\N\194\001#",0x54,0x36)))();
local V37=V34.Toggles;
local V38=V34.Options;
local function V39(V156,V157)
    if setclipboard then
        setclipboard(V156);
    elseif toclipboard then
        if V1("\'",0xDB,0x9E):byte() == 14884 then
            local V158=0x237D * 1;
        end
        toclipboard(V156);
    end
    V34:Notify(V157);
end
local function V40()
    V39(V13,V1("\201.\188\130\212P;q2/\230\158;\190]\243x\199#O\224\2195\208\145\199\130J\1295\006e\248\189\a\188",0xE4,0x93));
end
local function V41(V159,V160)
    return string.format(V1("\227\222\184\136_\220\240\205\155oC\223\149i\136\b\245\173\204f*2\f\220\179N",0xA7,0xD1),V160,V159);
end
local function V42(V161,V162,V163)
    if 0x3226BE + 0 == 0x32273B then
        local V164=-0x1516 * 1;
    end
    return string.format(V1("\016\164\238C\2556\1518\130\210E\001\028\143K",0xD4,0x6E),V161,V41(V1("&",0xF9,0x19),V1("i\216a\147\234N\164",0x46,0x5D)),V41(V162,V163));
end
local V43=V1("M\140\230\015\n8\146",0x2A,0x2B);
local V44=V1("\221\fWq[\172\200",0xBA,0x1C);
local V45=V1("\189\n\232\028\249\005@",0x9A,0xB);
local V46=V1("a\198@g\177/Q",0x3E,0x50);
local V47=V1("\236j\232U\237>\189T\156\000\190\243\133\003\135\250B\2076\191?\148\017\191 \140\002\155\017\143\247\128\179n",0xA0,0x77);
local V48=V1("%\226lh*\210dL\027\213~E\198\200v1\244\173n\024\163\163$\014\196\138P\250\182\129\255\192wk%\225\168d\028\209\\\024",0xC3,0xBC);
local V49=V1("\239\188*\147\f\141\030\150\023\1615\166+\183f\192U\204N\214h\221\145\229l\243r\250|\001\134\028\143\027\158T\184>\2236\183m",0xBF,0x85);
local V50=V1("\185\253\226\194\178\170\178\161\153\154\165\141\137\140\178\131\143}vu~j\149`^\\RQJFBO9<6c>;S!\025F",0x89,0xFC);
local V51=V1("\200_\1454\136\238_\198;\200E\130\016y\231U\150#\145\246{\232M\182\027t\re\2028\198&\132\027d\216J\190\027\141\242i\211j",0x80,0x6E);
local V52=V1('\198\018R\142\209\216\rM\206\255W\142\191\n\f\139\195\2052\134\195\242P\147\193\tC\144\165\237\"',0x5E,0x40);
local V53=V1("5\r\217\161p\003\196\144\163^3\254\204WX0\250\136\154 *\242\200\134_\026\231\189\130V*\244\182|",0xCD,0xCC);
local V54=V1("i\'\214\133b\229\190",0x46,0xAE);
local V55=V1("\162\1632\242\170fT",0x7F,0xBE);
local V56=V1("\255\212\146YI\v\201",0xDC,0xC2);
local V57=V1("R\255\161j\216|E",0x2F,0x9E);
local V58=V1("\190\209\217\016\224\237\238",0x9B,0x5);
local V59=V1("j\251\127\n\135=\192",0x47,0x84);
local V60=V1("\2088\147\246|\2185",0xAD,0x5B);
local V61=Color3.fromRGB(0x1 + 0x4F,0x5 * 0x20,0xFF + 0x0);
local V62=Color3.fromRGB(0x3 * 0x55,0x3 * 0x23,0x1 + 0xB3);
local function V63(V165)
    do
        local V166=nil;
        local V167=0x80804;
        while true do
            if V167 == 0x80804 then
                if 0x2618BF + 0 == 0x261996 then
                    local V168=0xEC * 1;
                    local V169=function()
                        return 0xEC + V168;
                    end;
                    local V170={0x35, 0xA};
                end
                V167=0x4FB08;
            elseif V167 == 0x79830 then
                return type(V166) == V1("P96<1",0xDC,0xFC) and V166.Value == true;
            elseif V167 == 0x4FB08 then
                if V34.Unloaded then
                    return false;
                end
                V166=V37[V165];
                V167=0x79830;
            else
                break
            end
        end
    end
end
local function V64()
    local V171=V11.Character;
    return V171 and V171:FindFirstChildOfClass(V1("}\141h?/\019\240\206",0x35,0xE3));
end
local function V65()
    local V172=V11.Character;
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V173=0x26F4 * 1;
        V173=V173 - 0xDE % 7;
    end
    return V172 and V172:FindFirstChild(V1("\144\rU\153\246G\145\220\026\135\215,X\185\026l",0x48,0x50));
end
local function V66(V174)
    if not V174 then
        if 0x334AE + 0 == 0x3356B then
            local V175=-0x1A71 * 1;
            V175=V175 - 0xA8 % 7;
            local V176={0x5A, 0x45};
        end
        return nil;
    end
    return V174:FindFirstChild(V1("\205$Z\151",0x85,0x3A)) or V174:FindFirstChild(V1("8(\227\154j.\235\169Z:\253\197d8\f\209",0xF0,0xC3));
end
local function V67(V177)
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V180=-0x1E88 * 1;
        local V181={0x48, 0x4B};
    end
    if not V177 then
        return false;
    end
    local V178=V177:FindFirstChildOfClass(V1("\202Y\179\tx\2197\148",0x82,0x62));
    local V179=V177:FindFirstChild(V1("\005\234\154F\v\196v)\207\164\\\025\173v?\249",0xBD,0xB8));
    return V178 ~= nil and V179 ~= nil and V178.Health > 0x0 + 0x0;
end
local function V68(V182)
    return V16:SerializeVariable(V17.PositiveInteger,V182);
end
local function V69(V183)
    if V1("\206",0x81,0x9B):byte() == 14884 then
        local V184=0x22A9 * 1;
        local V185={0x37, 0x45};
    end
    if V183 == nil then
        return nil;
    end
    return V18.TmplInfo[V183] or V18.TmplInfo[tostring(V183)];
end
local function V70(V186)
    if 0x2CB33D + 0 == 0x2CB604 then
        do
            local V188,V189,V190=nil,nil,nil;
            local V191=0x6D693;
            while true do
                if V191 == 0xCFAEB then
                    V188=V188 - 0x157 % 7;
                    V191=0xB7426;
                elseif V191 == 0x6D693 then
                    V188=-0x6E * 1;
                    V191=0xCFAEB;
                elseif V191 == 0xB7426 then
                    V189=function()
                        return -0x6E + V188;
                    end;
                    V190={0x9, 0x39, 0x4C, 0x19};
                    V191=0x6B7E8;
                else
                    break
                end
            end
        end
    end
    local V187=V69(V186);
    return V187 and V187.LogicType or nil;
end
local function V71()
    if 0xA105A + 0 == 0xA1152 then
        local V194=0x16C4 * 1;
        V194=V194 - 0x10C % 7;
    end
    local V192,V193=pcall(function()
        return V24:GetMyTeam();
    end);
    if V192 then
        if V1("\147",0x4F,0xD6):byte() == 14884 then
            local V195=-0x2596 * 1;
        end
        return V193;
    end
    return nil;
end
local function V72(V196)
    do
        local V197,V198,V199=nil,nil,nil;
        local V200=0x4E6F8;
        while true do
            if V200 == 0x552A4 then
                if V199 then
                    local V201=V199:GetAttribute(V1("\153!\241\1466\215\133\031\201l\233\184Y\003\162",0x3A,0xA4));
                    if V201 == V1("\023\023\227\188\128`\017\000\200\179rR",0xCF,0xD3) then
                        if math.floor(math.pi * 100000) % 2 == 0 then
                            local V202=0x10D5 * 1;
                            V202=V202 - 0xB0 % 7;
                        end
                        return V1("*p\161\226\t\017",0xD6,0x35);
                    elseif V201 == V1("\135s*\221\169J%\217\176[\'",0x3F,0xBF) then
                        if 0x34E80D + 0 == 0x34EB50 then
                            local V203=0x899 * 1;
                            local V204=function()
                                return 0x899 + V203;
                            end;
                        end
                        return V1("\014\024\r\018\253\200",0xBA,0xF9);
                    end
                end
                return nil;
            elseif V200 == 0xA9BD8 then
                V199=V196.Character;
                V200=0x552A4;
            elseif V200 == 0x4E6F8 then
                V197,V198=pcall(function()
                    return V24:GetTeamKeyForPlayer(V196.UserId);
                end);
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V205=-0x1E22 * 1;
                    V205=V205 - 0x188 % 7;
                end
                V200=0xBFC25;
            elseif V200 == 0xBFC25 then
                if V197 and type(V198) == V1("*\142\239I\177\r",0xB7,0x63) then
                    if V1("\185",0x6E,0xB7):byte() == 14884 then
                        local V206=0x225E * 1;
                    end
                    return V198;
                end
                V200=0xA9BD8;
            else
                break
            end
        end
    end
end
local function V73()
    return V71() == V1("\002\245\211\193\149I",0xAE,0xE2);
end
local function V74()
    do
        local V207,V208=nil,nil;
        local V209=0x8AE34;
        while true do
            if V209 == 0x8AE34 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V210=-0x24F1 * 1;
                end
                V207,V208=pcall(function()
                    return V20:GetLocalPlayerPlots();
                end);
                V209=0x58ABF;
            elseif V209 == 0x58ABF then
                if V207 and type(V208) == V1("A\149\253n\206",0xCD,0x67) then
                    return V208;
                end
                return {};
            else
                break
            end
        end
    end
end
local function V75(V211)
    do
        local V212=nil;
        local V213=0x639F;
        while true do
            if V213 == 0x639F then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V214=-0xE8 * 1;
                    local V215={0x20, 0x3, 0x3F};
                end
                V213=0x20B75;
            elseif V213 == 0x34500 then
                if 0xF63D4D + 0 == 0xF63EF4 then
                    local V216=-0x16C1 * 1;
                    V216=V216 - 0xE % 7;
                    local V217={0x16, 0xC};
                end
                return V212;
            elseif V213 == 0x20B75 then
                V212={};
                for V218,V219 in pairs(V74()) do
                    if type(V219) == V1("\a\253\a\026\028",0x93,0x9) and V70(V219.TmplId) == V211 then
                        V212[#V212 + (0x1 + 0x0)]=V219;
                    end
                end
                V213=0x34500;
            else
                break
            end
        end
    end
end
local V76=nil;
local function V77()
    local V220,V221=pcall(function()
        return V23:GetLocalPlayerRoom();
    end);
    if V220 and type(V221) == V1("bPR]W",0xEE,0x1) and type(V221.RoomId) == V1("\030\240\179sA\025",0xB0,0xCB) then
        return V221;
    end
    return nil;
end
local function V78()
    do
        local V222,V223,V224=nil,nil,nil;
        local V225=0x2A4FF;
        while true do
            if V225 == 0x9B29B then
                if V1("\196",0x70,0xA4):byte() == 14884 then
                    local V226=0x147 * 1;
                    V226=V226 - 0x1D4 % 7;
                end
                V225=0x59CEA;
            elseif V225 == 0x59CEA then
                V223=V10:FindFirstChild(V1("I\r\180Y\217\169M\236\148H",0xF7,0xA7));
                V225=0x569AD;
            elseif V225 == 0xA343 then
                V224=V223:FindFirstChild(V1("\v\154\f|\224",0xB9,0x72) .. tostring(V222.RoomId));
                V225=0x112EA;
            elseif V225 == 0x112EA then
                return V224,V222;
            elseif V225 == 0x45B9C then
                if 0x96A5FC + 0 == 0x96A865 then
                    local V227=-0x12BA * 1;
                    V227=V227 - 0x1A5 % 7;
                    local V228=function()
                        return -0x12BA + V227;
                    end;
                end
                if not V222 then
                    return nil,nil;
                end
                V225=0x9B29B;
            elseif V225 == 0x569AD then
                if not V223 then
                    return nil,V222;
                end
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V229=0x21D2 * 1;
                    V229=V229 - 0x10D % 7;
                    local V230=function()
                        return 0x21D2 + V229;
                    end;
                end
                V225=0xA343;
            elseif V225 == 0x2A4FF then
                V222=V77();
                V225=0x45B9C;
            else
                break
            end
        end
    end
end
local function V79()
    if 0xB8E57B + 0 == 0xB8E7CA then
        local V235=0x26C0 * 1;
        local V236={0x2E, 0x44};
    end
    local V231=V78();
    if 0x35BEF4 + 0 == 0x35C0BC then
        local V237=-0xC48 * 1;
        V237=V237 - 0x188 % 7;
    end
    if V231 then
        local V238=V231:FindFirstChild(V1("\180,\139\231.\145",0x71,0x56)) or V231:FindFirstChild(V1("\a\b\221\215\178x{YB,",0xB4,0xE4));
        if math.floor(math.pi * 100000) % 2 == 0 then
            local V239=-0xF02 * 1;
        end
        if V238 and V238:IsA(V1("\152\'\169\vf\231h\218",0x56,0x70)) then
            V76=V238.CFrame + Vector3.new(0x0 + 0x0,0x2 + 0x1,0x0 + 0x0);
            return V76;
        end
    end
    local V232=Vector3.zero;
    local V233=0x0 + 0x0;
    local V234=nil;
    for V240,V241 in pairs(V74()) do
        if type(V241) == V1("PSj\138\153",0xDC,0x16) and typeof(V241.CFrame) == V1("\028\015+\n\006\238",0xD9,0xF0) then
            do
                local V242=0x2A307;
                while true do
                    if V242 == 0x2A307 then
                        if 0xB866AB + 0 == 0xB867FC then
                            local V243=-0x1250 * 1;
                            local V244={0x3E, 0x4A, 0x44};
                        end
                        V232=V232 + V241.CFrame.Position;
                        V242=0x9C410;
                    elseif V242 == 0x60B47 then
                        if V1("\207",0x7B,0x8C):byte() == 14884 then
                            local V245=0x21A8 * 1;
                            V245=V245 - 0x4E % 7;
                            local V246={0xE, 0x3, 0x25, 0x1E};
                        end
                        V242=0xAA9DB;
                    elseif V242 == 0x9C410 then
                        if math.floor(math.pi * 100000) % 2 == 0 then
                            do
                                local V247,V248,V249=nil,nil,nil;
                                local V250=0x4D2C6;
                                while true do
                                    if V250 == 0x4D2C6 then
                                        V247=-0x767 * 1;
                                        V250=0x768BC;
                                    elseif V250 == 0xDE2CC then
                                        V248=function()
                                            return -0x767 + V247;
                                        end;
                                        V250=0x3F404;
                                    elseif V250 == 0x3F404 then
                                        V249={0x57, 0x49};
                                        V250=0xD3ECE;
                                    elseif V250 == 0x768BC then
                                        V247=V247 - 0x1D0 % 7;
                                        V250=0xDE2CC;
                                    else
                                        break
                                    end
                                end
                            end
                        end
                        V233=V233 + (0x4033A - 0x40339);
                        V242=0x60B47;
                    elseif V242 == 0xAA9DB then
                        if V70(V241.TmplId) == V1("\1405\1794",0x48,0x7E) then
                            if math.floor(math.pi * 100000) % 2 == 0 then
                                local V251=0x626 * 1;
                                V251=V251 - 0x132 % 7;
                            end
                            V234=V241.CFrame;
                        end
                        V242=0xA4628;
                    else
                        break
                    end
                end
            end
        end
    end
    if V234 then
        V76=V234 + Vector3.new(0x0 + 0x0,0x0 + 0x5,0x52A3D - 0x52A3D);
        return V76;
    end
    if V233 > 0x0 + 0x0 then
        if V1("\194",0x72,0xB4):byte() == 14884 then
            local V252=-0x25CE * 1;
        end
        V76=CFrame.new(V232 / V233 + Vector3.new(0x1563D - 0x1563D,0x4 + 0x1,0x3C2C - 0x3C2C));
        return V76;
    end
    if 0x51CB56 + 0 == 0x51CC25 then
        local V253=0xF77 * 1;
        V253=V253 - 0x1E1 % 7;
    end
    return V76;
end
local function V80(V254)
    do
        local V255,V256=nil,nil;
        local V257=0x45695;
        while true do
            if V257 == 0x7F502 then
                if V255.PivotTo then
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V258=-0xBE0 * 1;
                        V258=V258 - 0x1B3 % 7;
                    end
                    V255:PivotTo(V254);
                else
                    if V1("\158",0x4D,0xE7):byte() == 14884 then
                        local V259=-0x2BF * 1;
                        V259=V259 - 0x153 % 7;
                        local V260=function()
                            return -0x2BF + V259;
                        end;
                        local V261={0x20, 0x2F};
                    end
                    V256.CFrame=V254;
                end
                V256.AssemblyLinearVelocity=Vector3.zero;
                V257=0xEDE22;
            elseif V257 == 0x82F73 then
                return true;
            elseif V257 == 0x45695 then
                V255=V11.Character;
                V256=V65();
                V257=0xCF1E7;
            elseif V257 == 0x95E91 then
                V256.AssemblyAngularVelocity=Vector3.zero;
                V257=0x82F73;
            elseif V257 == 0xEDE22 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V262=-0x158F * 1;
                    V262=V262 - 0x1D8 % 7;
                    local V263={0x2, 0x59, 0x3A};
                end
                V257=0x95E91;
            elseif V257 == 0xCF1E7 then
                if 0x2E99CD + 0 == 0x2E9A12 then
                    local V264=-0x1527 * 1;
                    local V265={0x34, 0x5F, 0x42, 0x55};
                end
                if not V255 or not V256 or typeof(V254) ~= V1("\220`\r}\n\131",0x99,0x81) then
                    if 0x20AB3C + 0 == 0x20ADCD then
                        local V266=-0x25D5 * 1;
                        local V267=function()
                            return -0x25D5 + V266;
                        end;
                    end
                    return false;
                end
                V257=0x7F502;
            else
                break
            end
        end
    end
end
local function V81()
    if 0xCDC447 + 0 == 0xCDC73A then
        local V272=0x15DE * 1;
        V272=V272 - 0x1C9 % 7;
    end
    local V268,V269=pcall(function()
        return V25:GetDayTaskSnapshot():expect();
    end);
    if not V268 or type(V269) ~= V1("-\170;\213^",0xB9,0x90) or V269.Success ~= true then
        return
    end
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V273=0x1DBC * 1;
        V273=V273 - 0x1AF % 7;
        local V274=function()
            return 0x1DBC + V273;
        end;
    end
    local V270=V269.Snapshot;
    if 0x2684F6 + 0 == 0x268870 then
        local V275=-0x244E * 1;
        V275=V275 - 0x1AC % 7;
        local V276={0xD, 0x47, 0x46};
    end
    local V271=V270 and V270.Tasks;
    if type(V271) ~= V1("\190\191\212\242\255",0x4A,0x14) then
        return
    end
    for V277,V278 in ipairs(V271) do
        if type(V278) == V1("\172\144\136\137y",0x38,0xF7) and V278.Completed == true and V278.Claimed ~= true and V278.TaskId ~= nil then
            if 0x5451A7 + 0 == 0x5452AC then
                local V279=0x7CB * 1;
            end
            pcall(function()
                V25:ClaimDayTask(V278.TaskId):expect();
            end);
            task.wait(0.1);
        end
    end
end
local function V82()
    do
        local V280,V281,V282,V283=nil,nil,nil,nil;
        local V284=0x5513D;
        while true do
            if V284 == 0x5513D then
                if 0x76F771 + 0 == 0x76F89E then
                    local V285=-0x1126 * 1;
                    V285=V285 - 0xBE % 7;
                    local V286={0x3E, 0x42, 0x2D, 0x1D};
                end
                V280,V281=pcall(function()
                    return V27:GetHunterInventory():expect();
                end);
                V284=0xBB431;
            elseif V284 == 0xBB431 then
                if 0xDF06BF + 0 == 0xDF0A6A then
                    local V287=0x836 * 1;
                    local V288={0x55, 0x13, 0x46, 0x55};
                end
                if V280 and type(V281) == V1("\160D\252\189m",0x2C,0xB7) then
                    do
                        local V289,V290,V291,V292,V293=nil,nil,nil,nil,nil;
                        local V294=0x20F5F;
                        while true do
                            if V294 == 0x6631F then
                                if V1("\217",0x96,0xB2):byte() == 14884 then
                                    local V295=-0x251E * 1;
                                end
                                V294=0xDC7BB;
                            elseif V294 == 0x452A then
                                if type(V290) == V1("N\014\226\191\139",0xDA,0xD3) then
                                    if V1("\141",0x48,0xBD):byte() == 14884 then
                                        local V296=0x257 * 1;
                                        local V297={0x4E, 0x53, 0x38};
                                    end
                                    for V298,V299 in ipairs(V290) do
                                        if 0x294A2F + 0 == 0x294C90 then
                                            do
                                                local V300,V301,V302=nil,nil,nil;
                                                local V303=0x75004;
                                                while true do
                                                    if V303 == 0x18A11 then
                                                        V302={0x17, 0x36, 0x2B, 0xA};
                                                        V303=0x9F1FF;
                                                    elseif V303 == 0x75004 then
                                                        V300=0x441 * 1;
                                                        V300=V300 - 0x131 % 7;
                                                        V303=0x575EC;
                                                    elseif V303 == 0x575EC then
                                                        V301=function()
                                                            return 0x441 + V300;
                                                        end;
                                                        V303=0x18A11;
                                                    else
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                        if type(V299) == V1("f\022\218\167c",0xF2,0xC3) and type(V299.TmplId) == V1("\245\207\166vT&",0x82,0xD9) and V299.UnlockKind == V1("\254T\170\2549",0xA8,0x4B) and V289[V299.TmplId] ~= true then
                                            pcall(function()
                                                V27:BuyHunter(V299.TmplId):expect();
                                            end);
                                            task.wait(0.1);
                                        end
                                    end
                                end
                                V294=0x4A528;
                            elseif V294 == 0x7D68A then
                                for V304,V305 in ipairs(V293) do
                                    if 0xC83ABA + 0 == 0xC83D08 then
                                        local V307=0x12F * 1;
                                        local V308={0x3F, 0x27, 0x33, 0xA};
                                    end
                                    local V306=type(V305) == V1("\014\196\142a#",0x9A,0xC9) and tostring(V305.ClassId or "") or nil;
                                    if V306 and V306 ~= "" and V291[V306] == nil then
                                        do
                                            local V309=0xB8F8F;
                                            while true do
                                                if V309 == 0xB8F8F then
                                                    if math.floor(math.pi * 100000) % 2 == 0 then
                                                        local V310=-0x845 * 1;
                                                        V310=V310 - 0x12E % 7;
                                                    end
                                                    V309=0x8D2FE;
                                                elseif V309 == 0x505FB then
                                                    task.wait(0.05);
                                                    V309=0xC2650;
                                                elseif V309 == 0x8D2FE then
                                                    pcall(function()
                                                        V27:UnlockHunterClass(V306):expect();
                                                    end);
                                                    if 0x11F5F4 + 0 == 0x11F844 then
                                                        do
                                                            local V311,V312,V313=nil,nil,nil;
                                                            local V314=0xE793C;
                                                            while true do
                                                                if V314 == 0x760A9 then
                                                                    V313={0x58, 0x58, 0x2D, 0x57};
                                                                    V314=0x7AE05;
                                                                elseif V314 == 0xE0FA8 then
                                                                    V311=V311 - 0x1BB % 7;
                                                                    V314=0x8533D;
                                                                elseif V314 == 0xE793C then
                                                                    V311=0x1B0A * 1;
                                                                    V314=0xE0FA8;
                                                                elseif V314 == 0x8533D then
                                                                    V312=function()
                                                                        return 0x1B0A + V311;
                                                                    end;
                                                                    V314=0x760A9;
                                                                else
                                                                    break
                                                                end
                                                            end
                                                        end
                                                    end
                                                    V309=0x505FB;
                                                else
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                                V294=0xE31BD;
                            elseif V294 == 0x20F5F then
                                V289=V281.OwnedHunters or ({});
                                V294=0x6631F;
                            elseif V294 == 0x4A528 then
                                if V1("\168",0x51,0x39):byte() == 14884 then
                                    local V315=-0xEB1 * 1;
                                    V315=V315 - 0x15F % 7;
                                    local V316={0x14, 0x16};
                                end
                                V294=0xAFF0A;
                            elseif V294 == 0xCF656 then
                                V292=require(V3.CommonConfig.Hunter.CfgHunterClass);
                                V293=V292.GetOrderedClasses and V292.GetOrderedClasses() or ({});
                                V294=0x7D68A;
                            elseif V294 == 0xAFF0A then
                                V291=V281.ClassProgress or ({});
                                V294=0xCF656;
                            elseif V294 == 0xDC7BB then
                                V290=V281.Catalog;
                                V294=0x452A;
                            else
                                break
                            end
                        end
                    end
                end
                V284=0x800C;
            elseif V284 == 0x800C then
                V282,V283=pcall(function()
                    return V26:GetHumanClassInventory():expect();
                end);
                if V282 and type(V283) == V1("e\\g{~",0xF1,0xA) then
                    local V317=V283.OwnedClasses or ({});
                    local V318=V283.Catalog;
                    if type(V318) == V1("\2087\1786\169",0x5C,0x7A) then
                        for V319,V320 in ipairs(V318) do
                            if type(V320) == V1("\r\n\0275>",0x99,0x10) and type(V320.ClassId) == V1("Z\215Q\196E\186",0xE7,0x7C) and V320.Enabled == true and V317[V320.ClassId] ~= true and V320.UnlockKind ~= V1("\027\209l\235}\024\1622",0xD7,0x91) and V320.UnlockKind ~= V1("1\030\235\178\146U)",0xED,0xCC) then
                                pcall(function()
                                    V26:UnlockHumanClass(V320.ClassId):expect();
                                end);
                                task.wait(0.1);
                            end
                        end
                    end
                end
                V284=0x26006;
            else
                break
            end
        end
    end
end
local function V83()
    if V63(V1('\136R\231x\226\161,\202d\209\132\"\187^\207r\026\168F',0x47,0x96)) then
        if V1("\137",0x44,0xC6):byte() == 14884 then
            local V321=0xFBA * 1;
            V321=V321 - 0x5 % 7;
            local V322=function()
                return 0xFBA + V321;
            end;
            local V323={0x27, 0x36};
        end
        V81();
    end
    if V1("F",0xF1,0x5F):byte() == 14884 then
        local V324=-0x24E6 * 1;
        V324=V324 - 0x42 % 7;
        local V325=function()
            return -0x24E6 + V324;
        end;
    end
    if V63(V1("\014\128\189\246\026q\173\238 f|\227\022f\164\212 ",0xCD,0x3E)) then
        if 0xA23F84 + 0 == 0xA2434F then
            local V326=-0x16B6 * 1;
        end
        V82();
    end
end
local function V84(V327)
    local V328,V329=pcall(function()
        local serialized=V68(V327);
        return V21:Unlock(serialized):expect();
    end);
    return V328 and V329 == true;
end
local function V85(V330)
    local V331,V332=pcall(function()
        local serialized=V68(V330);
        return V21:Upgrade(serialized):expect();
    end);
    return V331 and V332 == true;
end
local function V86(V333)
    if 0x3EA0F2 + 0 == 0x3EA4A6 then
        local V334=-0xBF6 * 1;
        V334=V334 - 0xFA % 7;
    end
    for V335,V336 in ipairs(V75(V333)) do
        if 0xBB096C + 0 == 0xBB0C72 then
            local V337=0x1D0 * 1;
            V337=V337 - 0x14 % 7;
            local V338=function()
                return 0x1D0 + V337;
            end;
        end
        repeat
            local V339=V336.UniqueId;
            if math.floor(math.pi * 100000) % 2 == 0 then
                local V340=0x114 * 1;
            end
            if type(V339) ~= V1("\244\139\019\152+\200",0x86,0x90) then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V341=-0x1C8F * 1;
                    V341=V341 - 0x8C % 7;
                end
                break
            end
            if V336.Unlocked ~= true then
                V84(V339);
            else
                local V342=V69(V336.TmplId);
                if V342 and V342.NextUpdatePlotTmplId then
                    V85(V339);
                end
            end
        until true
    end
end
local function V87()
    local V343=V75(V1("/Te\130\149\148\183\194\213\236",0xE3,0x10));
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V344=-0x16A3 * 1;
        local V345={0x30, 0x41};
    end
    return V343[0x1 + 0x0];
end
local function V88()
    local V346=V87();
    if V1("\137",0x46,0x38):byte() == 14884 then
        local V347=0x41C * 1;
        V347=V347 - 0x192 % 7;
        local V348=function()
            return 0x41C + V347;
        end;
    end
    if V346 and type(V346.UniqueId) == V1("\246\163A\220\1338",0x88,0xA6) then
        if 0x9EB359 + 0 == 0x9EB442 then
            local V349=-0xA63 * 1;
            V349=V349 - 0x28 % 7;
        end
        return V346.UniqueId;
    end
    if V1("\127",0x29,0x74):byte() == 14884 then
        local V350=-0x2367 * 1;
        local V351={0x22, 0x1B, 0x2D};
    end
    return nil;
end
local function V89(V352)
    do
        local V353,V354,V355=nil,nil,nil;
        local V356=0x3F06F;
        while true do
            if V356 == 0x3F06F then
                V353=V87();
                if not V353 or typeof(V353.CFrame) ~= V1("\195D\238[\229[",0x80,0x7E) then
                    return false;
                end
                V356=0x4FA6C;
            elseif V356 == 0x4D5F2 then
                if V352 or (V354.Position - V355.Position).Magnitude > 0x9 + 0x1 then
                    return V80(V355);
                end
                return true;
            elseif V356 == 0x4FA6C then
                if V1("\143",0x4A,0xF2):byte() == 14884 then
                    local V357=-0x227D * 1;
                    local V358=function()
                        return -0x227D + V357;
                    end;
                end
                V356=0x7D689;
            elseif V356 == 0x7D689 then
                V354=V65();
                V356=0x8BBBD;
            elseif V356 == 0x19252 then
                if not V354 then
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V359=-0x13D7 * 1;
                        local V360=function()
                            return -0x13D7 + V359;
                        end;
                        local V361={0x62, 0x27};
                    end
                    return false;
                end
                V355=V353.CFrame + Vector3.new(0x0 + 0x0,0x3 * 0x1,0x74AA3 - 0x74AA3);
                V356=0x4D5F2;
            elseif V356 == 0x8BBBD then
                if V1("\133",0x30,0x86):byte() == 14884 then
                    local V362=-0x126F * 1;
                    V362=V362 - 0x1C0 % 7;
                    local V363=function()
                        return -0x126F + V362;
                    end;
                end
                V356=0x19252;
            else
                break
            end
        end
    end
end
local function V90()
    if V1("\173",0x60,0x17):byte() == 14884 then
        local V364=0x41C * 1;
        V364=V364 - 0x47 % 7;
    end
    for V365,V366 in ipairs(V75(V1("\218\214\190\178\156rlN8&",0x8E,0xE7))) do
        if 0x1742DB + 0 == 0x17441C then
            local V367=0x13D1 * 1;
            V367=V367 - 0xB7 % 7;
        end
        if V366.Unlocked ~= true and type(V366.UniqueId) == V1("\253\214\160g<\027",0x8F,0xD2) then
            V89(true);
            V84(V366.UniqueId);
        end
    end
end
local function V91()
    do
        local V368,V369=nil,nil;
        local V370=0xA37D8;
        while true do
            if V370 == 0xA37D8 then
                V368,V369=pcall(function()
                    return V23:GetLocalRoomGuideReservation();
                end);
                V370=0x4447A;
            elseif V370 == 0x4447A then
                if V368 and type(V369) == V1("\211\1406\221\146Q",0x65,0xB2) then
                    return V369;
                end
                V370=0x9B7CB;
            elseif V370 == 0x9B7CB then
                if 0x540151 + 0 == 0x54041C then
                    local V371=0x1855 * 1;
                    V371=V371 - 0x57 % 7;
                end
                V370=0xE9EDC;
            elseif V370 == 0xE9EDC then
                return nil;
            else
                break
            end
        end
    end
end
local function V92(V372)
    if 0x4BACEF + 0 == 0x4BAD90 then
        local V376=0x1756 * 1;
    end
    if type(V372) ~= V1("\169\233\026H\132\202",0x3B,0x39) then
        if 0x5C923A + 0 == 0x5C9397 then
            local V377=-0x826 * 1;
        end
        return nil;
    end
    local V373,V374=pcall(function()
        return V23:GetRoomModel(V372);
    end);
    if V373 and V374 then
        if 0x71A764 + 0 == 0x71A818 then
            local V378=-0x21F9 * 1;
            V378=V378 - 0x36 % 7;
            local V379=function()
                return -0x21F9 + V378;
            end;
        end
        return V374;
    end
    local V375=V10:FindFirstChild(V1("\001\235\184\131)\031\233\174|V",0xAF,0xCD));
    if not V375 then
        return nil;
    end
    return V375:FindFirstChild(V1("\237/Tw\142",0x9B,0x25) .. tostring(V372));
end
local function V93(V380)
    local V381=V92(V380);
    if not V381 then
        if math.floor(math.pi * 100000) % 2 == 0 then
            local V383=0x1866 * 1;
            local V384={0x41, 0x45, 0x5F};
        end
        return nil;
    end
    local V382=V381:FindFirstChild(V1("\197\226\230\231\211\219",0x82,0xFB)) or V381:FindFirstChild(V1("\208\020,i\135\144\214\247#P",0x7D,0x27));
    if V382 and V382:IsA(V1('\210\000!\"\028<\\m',0x90,0xF)) then
        return V382.CFrame + Vector3.new(0x0 + 0x0,0x3 * 0x1,0x0 + 0x0);
    end
    if V381:IsA(V1("\204J\155\248[",0x7F,0x5C)) then
        return V381:GetPivot() + Vector3.new(0x0 + 0x0,0x3 * 0x1,0x0 + 0x0);
    end
    return nil;
end
local function V94()
    do
        local V385,V386,V387,V388=nil,nil,nil,nil;
        local V389=0x3EA28;
        while true do
            if V389 == 0xC5125 then
                if V385 and V385.Status == V1("<Zd\128\133\136\142\151",0xED,0xA) and type(V385.RoomId) == V1("\245\1552\198h\020",0x87,0x9F) then
                    return nil;
                end
                V389=0x874B4;
            elseif V389 == 0x874B4 then
                V386=V91();
                V389=0xBE734;
            elseif V389 == 0x63828 then
                if V1("(",0xE0,0x67):byte() == 14884 then
                    local V390=-0x927 * 1;
                    V390=V390 - 0xF4 % 7;
                end
                return nil;
            elseif V389 == 0x3EA28 then
                V385=V77();
                V389=0x90711;
            elseif V389 == 0x90711 then
                if V1("{",0x2A,0x95):byte() == 14884 then
                    local V391=-0x23AC * 1;
                    V391=V391 - 0xCB % 7;
                    local V392=function()
                        return -0x23AC + V391;
                    end;
                end
                V389=0xC5125;
            elseif V389 == 0x8CDC4 then
                V387,V388=pcall(function()
                    return V23:GetEmptyRooms();
                end);
                if V387 and type(V388) == V1("\230\137@\000\175",0x72,0xB6) then
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V393=-0xD94 * 1;
                        V393=V393 - 0x1ED % 7;
                        local V394={0x2C, 0x13, 0x60, 0x4C};
                    end
                    for V395,V396 in ipairs(V388) do
                        if math.floor(math.pi * 100000) % 2 == 0 then
                            local V397=-0x14E * 1;
                            V397=V397 - 0xB6 % 7;
                        end
                        if type(V396) == V1("\192`\020\209}",0x4C,0xB3) and type(V396.RoomId) == V1("\251n\2103\162\027",0x8D,0x6C) then
                            if V1("\147",0x51,0xC6):byte() == 14884 then
                                local V398=0xAC * 1;
                            end
                            return V396.RoomId;
                        end
                    end
                end
                V389=0x63828;
            elseif V389 == 0xBE734 then
                if V386 then
                    if V1("\200",0x72,0x91):byte() == 14884 then
                        local V399=0x2420 * 1;
                        V399=V399 - 0xD6 % 7;
                    end
                    return V386;
                end
                V389=0x8CDC4;
            else
                break
            end
        end
    end
end
local function V95()
    if V1("\182",0x63,0x8D):byte() == 14884 then
        local V403=-0x22E8 * 1;
        V403=V403 - 0x18B % 7;
    end
    if not V63(V1("\1337\180-\145(\164%\151\029r\015\159\015",0x44,0x7E)) or not V73() then
        return false;
    end
    if V1("/",0xEA,0xBA):byte() == 14884 then
        local V404=0x1AA5 * 1;
        V404=V404 - 0xE0 % 7;
        local V405=function()
            return 0x1AA5 + V404;
        end;
    end
    local V400=V77();
    if V400 and V400.Status == V1("\185\aA\141\194\245+d",0x6A,0x3A) then
        return false;
    end
    local V401=V94();
    if not V401 then
        return false;
    end
    local V402=V93(V401);
    if typeof(V402) == V1("w\206N\145\241=",0x34,0x54) then
        if math.floor(math.pi * 100000) % 2 == 0 then
            local V406=0x18B0 * 1;
            V406=V406 - 0x1C % 7;
            local V407=function()
                return 0x18B0 + V406;
            end;
            local V408={0x10, 0x5D};
        end
        V80(V402);
        task.wait(0.15);
    end
    if 0x14453A + 0 == 0x1448AC then
        local V409=0x1E5B * 1;
        V409=V409 - 0x7A % 7;
        local V410={0x4B, 0x49, 0x5F};
    end
    pcall(function()
        V23:OccupyRoom(V401);
    end);
    return true;
end
local function V96()
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V414=-0x1839 * 1;
        V414=V414 - 0xFC % 7;
        local V415=function()
            return -0x1839 + V414;
        end;
    end
    local V411=V38.ResearchProject;
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V416=-0x104D * 1;
        V416=V416 - 0xE4 % 7;
    end
    if type(V411) ~= V1("\229g\253\156*",0x71,0x95) then
        return {};
    end
    local V412=V411.Value;
    local V413={};
    if type(V412) == V1("\186\234.{\183",0x46,0x43) then
        if 0xCADC8B + 0 == 0xCADF01 then
            local V417=-0x194F * 1;
            V417=V417 - 0xF % 7;
            local V418=function()
                return -0x194F + V417;
            end;
        end
        for V419,V420 in pairs(V412) do
            if V420 and V30[V419] then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V421=0x15E * 1;
                    local V422=function()
                        return 0x15E + V421;
                    end;
                end
                V413[#V413 + (0x0 + 0x1)]=V30[V419];
            end
        end
    elseif type(V412) == V1("\209\182\152s\\9",0x5E,0xE4) and V412 ~= "" and V30[V412] then
        V413[0x4689B - 0x4689A]=V30[V412];
    end
    return V413;
end
local function V97()
    local V423=V38.ResearchField;
    if type(V423) ~= V1("\247\212\197\191\168",0x83,0xF0) then
        return nil;
    end
    local V424=tostring(V423.Value or "");
    return V32[V424];
end
local function V98(V425,V426)
    do
        local V427,V428=nil,nil;
        local V429=0x31FBE;
        while true do
            if V429 == 0x5150E then
                return V428 == V1("\226u\020\147#\1744\205N\234x",0x99,0x8E) or V428 == V19.ProjectStatus.InProgress;
            elseif V429 == 0x34BE6 then
                if 0xB32F91 + 0 == 0xB332A6 then
                    local V430=-0x1187 * 1;
                    V430=V430 - 0xC3 % 7;
                    local V431=function()
                        return -0x1187 + V430;
                    end;
                end
                V429=0xC1410;
            elseif V429 == 0xE6FF then
                V428=V427.Status or V427.ProjectStatus or V427.State;
                if V1("\165",0x4D,0x81):byte() == 14884 then
                    local V432=0x1038 * 1;
                    V432=V432 - 0x1B0 % 7;
                    local V433=function()
                        return 0x1038 + V432;
                    end;
                end
                V429=0x5150E;
            elseif V429 == 0x31FBE then
                if type(V425) ~= V1("\021\215\173\140Z",0xA1,0xD5) or type(V426) ~= V1("4\151\247P\183\018",0xC1,0x62) then
                    if 0xE39305 + 0 == 0xE395DA then
                        local V434=0x5D9 * 1;
                        V434=V434 - 0xB9 % 7;
                    end
                    return false;
                end
                V429=0x34BE6;
            elseif V429 == 0xDFA14 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V435=0x1BE0 * 1;
                    V435=V435 - 0x189 % 7;
                    local V436={0x27, 0x8, 0x3};
                end
                V429=0xE6FF;
            elseif V429 == 0xC1410 then
                V427=V425[V426] or V425[tostring(V426)];
                if type(V427) ~= V1("\022\219\180\150g",0xA2,0xD8) then
                    return false;
                end
                V429=0xDFA14;
            else
                break
            end
        end
    end
end
local function V99()
    do
        local V437,V438=nil,nil;
        local V439=0x8AC9D;
        while true do
            if V439 == 0x67B69 then
                if type(V437) ~= V1("5\237\162P\f\188",0xC2,0xB7) or V437 == "" then
                    return
                end
                V439=0x99855;
            elseif V439 == 0xA73EA then
                V438=V88();
                if 0x6E85B4 + 0 == 0x6E8647 then
                    local V440=0xBA0 * 1;
                end
                V439=0x36DC4;
            elseif V439 == 0x36DC4 then
                if type(V438) ~= V1("\170\179\173\164\169\184",0x3C,0x2) then
                    if 0x92FA45 + 0 == 0x92FC35 then
                        local V441=-0x1960 * 1;
                        local V442=function()
                            return -0x1960 + V441;
                        end;
                    end
                    return
                end
                V439=0x3BBFB;
            elseif V439 == 0x99855 then
                V90();
                V439=0xA73EA;
            elseif V439 == 0x8AC9D then
                if 0x34DE8A + 0 == 0x34E01D then
                    local V443=0x505 * 1;
                    V443=V443 - 0x16C % 7;
                    local V444={0x44, 0x49, 0x39, 0x1B};
                end
                if not V63(V1("~y?\001\156\136V\029\232\161U/\004\189\128X\016\220\129k.\252\187",0x3D,0xC7)) or not V73() then
                    return
                end
                V439=0xE5456;
            elseif V439 == 0x3BBFB then
                V89(false);
                pcall(function()
                    V28:SelectResearchLine(V437,V438):expect();
                end);
                V439=0x884F;
            elseif V439 == 0x6497 then
                V437=V97();
                V439=0x67B69;
            elseif V439 == 0xE5456 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V445=0x23B2 * 1;
                    local V446={0x1C, 0x32, 0x4D, 0x39};
                end
                V439=0x6497;
            else
                break
            end
        end
    end
end
local function V100()
    do
        local V447,V448,V449,V450,V451=nil,nil,nil,nil,nil;
        local V452=0xEE594;
        while true do
            if V452 == 0x59AF1 then
                V447=V96();
                V452=0xBF776;
            elseif V452 == 0x9D6CB then
                if 0x19F209 + 0 == 0x19F3BC then
                    local V453=-0x1324 * 1;
                    V453=V453 - 0x21 % 7;
                end
                V452=0x59DD4;
            elseif V452 == 0x59DD4 then
                V90();
                V452=0xBC3CF;
            elseif V452 == 0xBC3CF then
                V448=V88();
                if V1("}",0x2F,0x8F):byte() == 14884 then
                    local V454=-0x22C * 1;
                    V454=V454 - 0x7E % 7;
                    local V455=function()
                        return -0x22C + V454;
                    end;
                end
                V452=0x420DB;
            elseif V452 == 0xD9E98 then
                V449,V450=pcall(function()
                    return V28:RequestState(V448):expect();
                end);
                V451=nil;
                V452=0x8F543;
            elseif V452 == 0xBF776 then
                if #V447 == 0xC7792 - 0xC7792 then
                    return
                end
                V452=0x9D6CB;
            elseif V452 == 0x420DB then
                if type(V448) ~= V1('g\204\"u\214A',0xF9,0x5E) then
                    return
                end
                V452=0x788B2;
            elseif V452 == 0xEE594 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V456=0x20F3 * 1;
                    local V457={0x46, 0x1A};
                end
                if not V63(V1("\142\000=v\151\2324d\158\237\028_\129\212\019",0x4D,0x3E)) or not V73() then
                    return
                end
                V452=0x59AF1;
            elseif V452 == 0x8F543 then
                if 0xE3114B + 0 == 0xE311E0 then
                    local V458=-0x2672 * 1;
                end
                V452=0x26A18;
            elseif V452 == 0x26A18 then
                if V449 and type(V450) == V1("\197\202\227\005\022",0x51,0x18) and V450.Success == true then
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V460=0x156E * 1;
                        V460=V460 - 0x15D % 7;
                        local V461=function()
                            return 0x156E + V460;
                        end;
                    end
                    local V459=V450.Data or V450;
                    V451=V459.Projects or V459.ProjectStates or V459.projects;
                end
                for V462,V463 in ipairs(V447) do
                    repeat
                        if type(V463.ProjectKey) ~= V1("\198\223\245\004!2",0x53,0x18) then
                            break
                        end
                        if V98(V451,V463.ProjectKey) then
                            break
                        end
                        if type(V463.LineKey) == V1("\228\245\003\n\031(",0x71,0x10) and V463.LineKey ~= "" then
                            pcall(function()
                                V28:SelectResearchLine(V463.LineKey,V448):expect();
                            end);
                        end
                        pcall(function()
                            V28:StartResearch(V463.ProjectKey,V448):expect();
                        end);
                        task.wait(0.1);
                    until true
                end
                V452=0x599EF;
            elseif V452 == 0x788B2 then
                V89(false);
                V452=0xD9E98;
            else
                break
            end
        end
    end
end
local function V101()
    do
        local V464,V465,V466,V467,V468=nil,nil,nil,nil,nil;
        local V469=0xBE303;
        while true do
            if V469 == 0x866C6 then
                pcall(function()
                    V21:StartRepair(V468):expect();
                end);
                V469=0x496E0;
            elseif V469 == 0xE1277 then
                if V466 and type(V467) == V1("\230\143L\018\199",0x72,0xBC) and type(V467.Own) == V1("\199\234!a\144",0x53,0x36) then
                    local V470=tonumber(V467.Own.remaining) or 0x4E844 - 0x4E844;
                    if V470 > 0.05 then
                        return
                    end
                end
                V469=0xC7FA8;
            elseif V469 == 0x4753D then
                if not V465 or type(V465.UniqueId) ~= V1("a^L703",0xF3,0xF6) then
                    if 0x1547B5 + 0 == 0x154A17 then
                        local V471=-0x205 * 1;
                        V471=V471 - 0x15E % 7;
                        local V472={0x1E, 0x5, 0x2D};
                    end
                    return
                end
                V466,V467=pcall(function()
                    return V21:GetRepairCooldownState():expect();
                end);
                V469=0xE1277;
            elseif V469 == 0x1BCEC then
                V465=V464[0x1 + 0x0];
                V469=0x4753D;
            elseif V469 == 0xC7FA8 then
                V468=V68(V465.UniqueId);
                V469=0x866C6;
            elseif V469 == 0xBE303 then
                V464=V75(V1("\234\247\217\190",0xA6,0xE2));
                V469=0x1BCEC;
            else
                break
            end
        end
    end
end
local function V102(V473)
    do
        local V474,V475=nil,nil;
        local V476=0x515A6;
        while true do
            if V476 == 0x515A6 then
                V474=V79();
                if typeof(V474) ~= V1("\191g8\204}\026",0x7C,0xA5) then
                    return false;
                end
                V476=0x2D358;
            elseif V476 == 0xB763B then
                if V473 or (V475.Position - V474.Position).Magnitude > 0x2 + 0x4 then
                    return V80(V474);
                end
                if V1("\148",0x4F,0x4B):byte() == 14884 then
                    local V477=-0x3B1 * 1;
                    V477=V477 - 0x11D % 7;
                end
                V476=0x406CB;
            elseif V476 == 0x15E0D then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V478=0x140 * 1;
                end
                if not V475 then
                    return false;
                end
                V476=0x59CF4;
            elseif V476 == 0x59CF4 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V479=-0x602 * 1;
                    V479=V479 - 0xF5 % 7;
                    local V480=function()
                        return -0x602 + V479;
                    end;
                end
                V476=0xB763B;
            elseif V476 == 0x406CB then
                return true;
            elseif V476 == 0x45634 then
                V475=V65();
                V476=0x15E0D;
            elseif V476 == 0x2D358 then
                if 0xD80226 + 0 == 0xD80368 then
                    local V481=-0x1E54 * 1;
                    V481=V481 - 0x5B % 7;
                end
                V476=0x45634;
            else
                break
            end
        end
    end
end
local function V103()
    local V482=V10:FindFirstChild(V1("\236%?Bao\129h\162\176\185\203\233",0xAB,0x11));
    if V1("\022",0xC6,0xD9):byte() == 14884 then
        local V486=0x137E * 1;
        V486=V486 - 0x150 % 7;
    end
    if not V482 then
        if 0x58AD1A + 0 == 0x58AF66 then
            local V487=0xB84 * 1;
            local V488=function()
                return 0xB84 + V487;
            end;
        end
        return {};
    end
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V489=0xA75 * 1;
        local V490=function()
            return 0xA75 + V489;
        end;
    end
    local V483={};
    local V484={};
    if V1("\207",0x80,0x96):byte() == 14884 then
        local V491=-0x2022 * 1;
    end
    local function V485(V492)
        do
            local V493=nil;
            local V494=0x8ABD9;
            while true do
                if V494 == 0xF4005 then
                    V483[#V483 + (0x1 + 0x0)]={Instance=V492, BoxId=V493};
                    V494=0x97ACF;
                elseif V494 == 0x9FEC5 then
                    V493=V492:GetAttribute(V1(" \000\188@\014",0xDE,0xB3));
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V495=-0x2467 * 1;
                    end
                    V494=0xAF8D;
                elseif V494 == 0xAF8D then
                    if V493 == nil then
                        V493=V492:GetAttribute(V1("=\2029\181-\145\233x",0xE8,0x74));
                    end
                    if V493 == nil then
                        return
                    end
                    V494=0xF95D;
                elseif V494 == 0x8ABD9 then
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V496=-0x2272 * 1;
                        local V497={0x26, 0x53};
                    end
                    if V484[V492] then
                        return
                    end
                    V494=0x9FEC5;
                elseif V494 == 0xF95D then
                    if V1("\143",0x41,0xA9):byte() == 14884 then
                        local V498=0xB4 * 1;
                        V498=V498 - 0xFD % 7;
                        local V499={0x52, 0x52, 0x59};
                    end
                    V484[V492]=true;
                    V494=0xF4005;
                else
                    break
                end
            end
        end
    end
    for V500,V501 in ipairs(V482:GetChildren()) do
        V485(V501);
        for V502,V503 in ipairs(V501:GetDescendants()) do
            if V503:GetAttribute(V1("\127\198\233\212\t",0x3D,0x1A)) ~= nil then
                V485(V503:FindFirstAncestorOfClass(V1("\177:\150\254l",0x64,0x67)) or V501);
                break
            end
        end
    end
    return V483;
end
local function V104(V504)
    do
        local V505,V506=nil,nil;
        local V507=0x60844;
        while true do
            if V507 == 0xBD100 then
                if V506 then
                    if math.floor(math.pi * 100000) % 2 == 0 then
                        local V509=-0xA71 * 1;
                        local V510=function()
                            return -0xA71 + V509;
                        end;
                        local V511={0x5A, 0x36, 0x56};
                    end
                    local V508=V65();
                    if V508 and (V508.Position - V506.Position).Magnitude > 0x477C8 - 0x477BC then
                        V80(V506 + Vector3.new(0xC974F - 0xC974F,0x3 * 0x1,0x0 + 0x0));
                        if math.floor(math.pi * 100000) % 2 == 0 then
                            local V512=-0x1ACC * 1;
                            V512=V512 - 0x1AB % 7;
                        end
                        task.wait(0.15);
                    end
                end
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V513=0x263B * 1;
                    local V514={0x4C, 0x32, 0x2};
                end
                V507=0xA0B4C;
            elseif V507 == 0xA32C9 then
                V506=V505:IsA(V1("\227\191n)\234",0x96,0xBA)) and V505:GetPivot() or (V505:IsA(V1("\024\187Q\1996\203`\230",0xD6,0x84)) and V505.CFrame);
                V507=0xBD100;
            elseif V507 == 0x60844 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    do
                        local V515,V516,V517=nil,nil,nil;
                        local V518=0x62368;
                        while true do
                            if V518 == 0x7A66B then
                                V515=V515 - 0x94 % 7;
                                V518=0x46D35;
                            elseif V518 == 0x62368 then
                                V515=0x195F * 1;
                                V518=0x7A66B;
                            elseif V518 == 0x46D35 then
                                V516=function()
                                    return 0x195F + V515;
                                end;
                                V517={0x3C, 0x53};
                                V518=0xBF088;
                            else
                                break
                            end
                        end
                    end
                end
                V505=V504.Instance;
                V507=0xA32C9;
            elseif V507 == 0xA0B4C then
                pcall(function()
                    V22:LootBox(V504.BoxId):expect();
                end);
                V507=0xBE2D9;
            else
                break
            end
        end
    end
end
local function V105()
    do
        local V519=nil;
        local V520=0x66424;
        while true do
            if V520 == 0xED079 then
                for V521,V522 in ipairs(V519) do
                    if V34.Unloaded or not V63(V1("z\136a6\228\234\193\155nF1\216\218\189\137qH#\000",0x39,0xDA)) then
                        break
                    end
                    V104(V522);
                    task.wait(0.2);
                end
                if V1("\147",0x49,0x2F):byte() == 14884 then
                    do
                        local V523,V524,V525=nil,nil,nil;
                        local V526=0xF0773;
                        while true do
                            if V526 == 0x35E31 then
                                V523=V523 - 0x195 % 7;
                                V526=0x12987;
                            elseif V526 == 0xF0773 then
                                V523=0x24DE * 1;
                                V526=0x35E31;
                            elseif V526 == 0x12987 then
                                V524=function()
                                    return 0x24DE + V523;
                                end;
                                V526=0x7DF07;
                            elseif V526 == 0x7DF07 then
                                V525={0x31, 0x36, 0x24, 0x1};
                                V526=0x4677F;
                            else
                                break
                            end
                        end
                    end
                end
                V520=0x612DD;
            elseif V520 == 0x66424 then
                V519=V103();
                if #V519 == 0x5B43A - 0x5B43A then
                    return false;
                end
                V520=0xED079;
            elseif V520 == 0x612DD then
                return true;
            else
                break
            end
        end
    end
end
local function V106()
    return V77() ~= nil or V73() or V76 ~= nil;
end
local function V107()
    do
        local V527,V528=nil,nil;
        local V529=0xEF1FD;
        while true do
            if V529 == 0x3FF81 then
                if not V527 and not V528 then
                    return
                end
                V529=0xDF1DC;
            elseif V529 == 0xD0AF5 then
                if V1("*",0xD2,0x7C):byte() == 14884 then
                    local V530=-0x6D6 * 1;
                    V530=V530 - 0x149 % 7;
                end
                if V528 and V106() then
                    V102(false);
                end
                V529=0xDE6F2;
            elseif V529 == 0xEF1FD then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V531=-0x12FF * 1;
                end
                if V95() then
                    return
                end
                V529=0xA7D45;
            elseif V529 == 0xDF1DC then
                if V1("8",0xF7,0x8):byte() == 14884 then
                    local V532=-0x1120 * 1;
                    V532=V532 - 0xDA % 7;
                end
                if V527 then
                    local V533=V105();
                    if V533 then
                        if #V103() == 0x0 + 0x0 and V106() then
                            V102(true);
                        end
                        return
                    end
                end
                V529=0xD0AF5;
            elseif V529 == 0xA7D45 then
                V527=V63(V1("\029\181\024w\175?\160\004a\1958i\245b\184*\139\240W",0xDC,0x64));
                V528=V63(V1("\139\133J\v\181\137T\025\204\175u9",0x4A,0xC6));
                V529=0x3FF81;
            else
                break
            end
        end
    end
end
local V108=Instance.new(V1("\206\190\130A\t\221",0x88,0xC7));
V108.Name=V1("\202x\253\130\253\146\029\162.\133=\184<\206/\226j\245P\230k",0x7B,0x88);
V108.Parent=V11:WaitForChild(V1("-\a\186\144:\005\152\1326",0xDD,0xBE));
local V109={};
local function V110(V534)
    do
        local V535=nil;
        local V536=0xBB2B5;
        while true do
            if V536 == 0x61F3C then
                if V535.Billboard then
                    V535.Billboard:Destroy();
                end
                V536=0xA1DF6;
            elseif V536 == 0xBB2B5 then
                V535=V109[V534];
                if not V535 then
                    return
                end
                V536=0x10FAE;
            elseif V536 == 0x10FAE then
                if V535.Highlight then
                    V535.Highlight:Destroy();
                end
                V536=0x61F3C;
            elseif V536 == 0xA1DF6 then
                V109[V534]=nil;
                V536=0x4482B;
            else
                break
            end
        end
    end
end
local function V111(V537,V538,V539)
    do
        local V540,V541=nil,nil;
        local V542=0x62A4A;
        while true do
            if V542 == 0xA5D8B then
                V541=V109[V537];
                V542=0x4E74B;
            elseif V542 == 0xA722F then
                if V1("\221",0x88,0xD):byte() == 14884 then
                    local V543=-0x1ADE * 1;
                    V543=V543 - 0x14D % 7;
                end
                V541.Label.Text=V539;
                V542=0x4960A;
            elseif V542 == 0xA2711 then
                V540=V66(V537);
                V542=0xF21AE;
            elseif V542 == 0xCA86F then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V544=-0x2444 * 1;
                    local V545={0x48, 0x43, 0x36, 0x18};
                end
                V542=0xA5D8B;
            elseif V542 == 0x55070 then
                V541.Billboard.Adornee=V540;
                V541.Label.TextColor3=V538;
                V542=0xA722F;
            elseif V542 == 0x43285 then
                V541.Highlight.OutlineColor=V538;
                V542=0x55070;
            elseif V542 == 0x4E74B then
                if not V541 then
                    do
                        local V546,V547,V548=nil,nil,nil;
                        local V549=0xA44EC;
                        while true do
                            if V549 == 0xE6E3C then
                                V548.TextStrokeTransparency=0.35;
                                V549=0x202F8;
                            elseif V549 == 0x4ECAC then
                                V548.Font=Enum.Font.GothamBold;
                                V548.TextSize=0xD * 0x1;
                                V549=0xE6E3C;
                            elseif V549 == 0x1A636 then
                                V548=Instance.new(V1("\175\131Y\024\179\139O\021\223",0x5B,0xC3));
                                V549=0x7EAB2;
                            elseif V549 == 0x7EAB2 then
                                if 0x90B7CD + 0 == 0x90BA2A then
                                    local V550=-0x647 * 1;
                                end
                                V548.Size=UDim2.fromScale(0x5412A - 0x54129,0x0 + 0x1);
                                V549=0xB2C75;
                            elseif V549 == 0xE4C45 then
                                if math.floor(math.pi * 100000) % 2 == 0 then
                                    local V551=0x9AA * 1;
                                    V551=V551 - 0x109 % 7;
                                    local V552={0x22, 0x1F, 0x15, 0x5B};
                                end
                                V549=0x1A636;
                            elseif V549 == 0xDA772 then
                                V546.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop;
                                V546.FillTransparency=0.65;
                                V549=0x50259;
                            elseif V549 == 0x32A3D then
                                V547.Size=UDim2.fromOffset(0xB31B7 - 0xB3103,0x14 + 0x0);
                                V549=0x6A60F;
                            elseif V549 == 0x9828F then
                                V546.Parent=V108;
                                V547=Instance.new(V1("\225\135\t\136\253\137\250\138\251]\n}",0x9F,0x7F));
                                V549=0x32A3D;
                            elseif V549 == 0xA44EC then
                                V546=Instance.new(V1("\245\225\170vE\r\214\162y",0xAD,0xCB));
                                if V1("\017",0xC1,0xE8):byte() == 14884 then
                                    local V553=-0x225E * 1;
                                    local V554={0x19, 0x21};
                                end
                                V549=0xDA772;
                            elseif V549 == 0x10331 then
                                V109[V537]=V541;
                                V549=0xD9C6B;
                            elseif V549 == 0x1C9BF then
                                V548.Parent=V547;
                                V549=0x201E4;
                            elseif V549 == 0x202F8 then
                                if V1("\174",0x66,0x61):byte() == 14884 then
                                    local V555=-0x26B * 1;
                                    V555=V555 - 0x12D % 7;
                                    local V556=function()
                                        return -0x26B + V555;
                                    end;
                                end
                                V549=0x1C9BF;
                            elseif V549 == 0x6A60F then
                                V547.StudsOffset=Vector3.new(0x0 + 0x0,6.527623502320445 - 3.927623502320445,0x34BC - 0x34BC);
                                V547.AlwaysOnTop=true;
                                V549=0xBB1B;
                            elseif V549 == 0x50259 then
                                if math.floor(math.pi * 100000) % 2 == 0 then
                                    local V557=0x1E7C * 1;
                                    local V558={0x2A, 0x20, 0x45, 0x1B};
                                end
                                V546.OutlineTransparency=0x0 + 0x0;
                                V549=0x9828F;
                            elseif V549 == 0xB2C75 then
                                V548.BackgroundTransparency=0xE065E - 0xE065D;
                                V549=0x4ECAC;
                            elseif V549 == 0xBB1B then
                                V547.Parent=V108;
                                V549=0xE4C45;
                            elseif V549 == 0x201E4 then
                                if math.floor(math.pi * 100000) % 2 == 0 then
                                    local V559=-0x25CC * 1;
                                end
                                V541={Highlight=V546, Billboard=V547, Label=V548};
                                V549=0x10331;
                            else
                                break
                            end
                        end
                    end
                end
                V542=0x35D1C;
            elseif V542 == 0x62A4A then
                if 0xBFB130 + 0 == 0xBFB46E then
                    local V560=0x921 * 1;
                    V560=V560 - 0x53 % 7;
                    local V561=function()
                        return 0x921 + V560;
                    end;
                end
                V542=0xA2711;
            elseif V542 == 0xF21AE then
                if not V540 then
                    V110(V537);
                    if 0x80DB2E + 0 == 0x80DEA7 then
                        local V562=0x7A9 * 1;
                        V562=V562 - 0x1D7 % 7;
                        local V563=function()
                            return 0x7A9 + V562;
                        end;
                    end
                    return
                end
                V542=0xCA86F;
            elseif V542 == 0x35D1C then
                V541.Highlight.Adornee=V537;
                V541.Highlight.FillColor=V538;
                V542=0x43285;
            else
                break
            end
        end
    end
end
local function V112()
    if V1(";",0xEE,0x9F):byte() == 14884 then
        local V564=0xACA * 1;
        V564=V564 - 0x1C5 % 7;
    end
    for V565 in pairs(V109) do
        V110(V565);
    end
end
local function V113()
    do
        local V566=nil;
        local V567=0x7D418;
        while true do
            if V567 == 0x7D418 then
                if 0xEB3910 + 0 == 0xEB395A then
                    local V568=-0xB85 * 1;
                    V568=V568 - 0x99 % 7;
                    local V569={0x11, 0x59};
                end
                V567=0xF17F;
            elseif V567 == 0xDBC36 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V570=0x78B * 1;
                    V570=V570 - 0x93 % 7;
                end
                for V571,V572 in ipairs(V2:GetPlayers()) do
                    if 0x7AF46C + 0 == 0x7AF757 then
                        local V573=0x16E3 * 1;
                        local V574={0x22, 0x4B};
                    end
                    if V572 ~= V11 and V67(V572.Character) then
                        do
                            local V575,V576,V577,V578=nil,nil,nil,nil;
                            local V579=0x394BF;
                            while true do
                                if V579 == 0x501E5 then
                                    V576=V72(V572);
                                    if math.floor(math.pi * 100000) % 2 == 0 then
                                        local V580=0xC7E * 1;
                                        V580=V580 - 0xF1 % 7;
                                    end
                                    V579=0xE4659;
                                elseif V579 == 0xD4E72 then
                                    V566[V575]=true;
                                    if math.floor(math.pi * 100000) % 2 == 0 then
                                        local V581=-0x16FA * 1;
                                        V581=V581 - 0xE9 % 7;
                                    end
                                    V579=0x501E5;
                                elseif V579 == 0xE4659 then
                                    V577=V576 == V1("\238\243\227\227\201\144",0x9A,0xF4) and V62 or V61;
                                    V578=V576 == V1("\139$\168<\182\017",0x37,0x88) and (V1("34u\130\156\161\194\193\152",0xD8,0x14) .. V572.Name) or (V1("\237\155s&\224\137L\251\180U\206",0x92,0xB6) .. V572.Name);
                                    V579=0x59981;
                                elseif V579 == 0x394BF then
                                    V575=V572.Character;
                                    V579=0xC9C94;
                                elseif V579 == 0xC9C94 then
                                    if 0x650254 + 0 == 0x6505D6 then
                                        local V582=-0x1974 * 1;
                                        V582=V582 - 0x75 % 7;
                                        local V583=function()
                                            return -0x1974 + V582;
                                        end;
                                    end
                                    V579=0xD4E72;
                                elseif V579 == 0x59981 then
                                    V111(V575,V577,V578);
                                    V579=0xC682C;
                                else
                                    break
                                end
                            end
                        end
                    end
                end
                V567=0x1F18A;
            elseif V567 == 0xF17F then
                if V34.Unloaded or not V63(V1("\137\237*\138\190\019.\132\201",0x39,0x48)) then
                    V112();
                    if V1("\143",0x3A,0xEE):byte() == 14884 then
                        do
                            local V584,V585,V586=nil,nil,nil;
                            local V587=0x68988;
                            while true do
                                if V587 == 0x1A473 then
                                    V585=function()
                                        return -0x11F1 + V584;
                                    end;
                                    V586={0x1D, 0x4C};
                                    V587=0x2D4B;
                                elseif V587 == 0x68988 then
                                    V584=-0x11F1 * 1;
                                    V584=V584 - 0xCF % 7;
                                    V587=0x1A473;
                                else
                                    break
                                end
                            end
                        end
                    end
                    return
                end
                V567=0x7283D;
            elseif V567 == 0x1F18A then
                for V588 in pairs(V109) do
                    if not V566[V588] then
                        V110(V588);
                    end
                end
                V567=0xEC9E0;
            elseif V567 == 0x7283D then
                V566={};
                V567=0xDBC36;
            else
                break
            end
        end
    end
end
local V114=V34:CreateWindow({Title=V1('n\152\192o\146\206n\144\212m\144\204lq\223\165\"\164\230',0x8A,0x55), Footer={{Text=V13, Copyable=true}, V1("\177",0x35,0xA5), V12}, Icon=0x11 * 0x2C562F31, NotifySide=V1("\023249I",0xC5,0x4), ShowCustomCursor=false, CornerRadius=0x5 + 0x5});
local V115={Info=V114:AddTab(V1("\148L\v-\165\176",0xB0,0xDD),V1("`\225U\218",0xF7,0x7C)), Main=V114:AddTab(V1("\191\148\152\198\133a",0xDB,0x1),V1('\174\238#[K\194\248\"`',0x4A,0x35)), Player=V114:AddTab(V1("\028\vn\242\003S",0x35,0x48),V1("\214\190\190\178\161\147E~rRR;3+\023",0x66,0xF3)), Settings=V114:AddTab(V1("\153\187\'\172\222+",0xB1,0x5C),V1("BP{\151\168\201\222\006",0xCF,0x1C))};
local V116=V1("\014\129\2165\144\242C",0xB9,0x5A);
pcall(function()
    if identifyexecutor then
        local name,version=identifyexecutor();
        if type(name) == V1("\240\230\217\197\191\173",0x7D,0xF5) and name ~= "" then
            V116=type(version) == V1("\236\187\135L\031\230",0x79,0xCE) and version ~= "" and (name .. V1("\r",0xED,0x25) .. version) or name;
        end
    end
end);
local V117=V115.Info:AddLeftGroupbox(V1("\135dg\184k\171",0x9F,0x11),V1("E\249\176O\006\173#\025\197e ",0xE2,0xAE));
V117:AddLabel(V42(V1("I\016\171a",0xF4,0xA9),V11.Name,V43),true);
V117:AddLabel(V42(V1("La\255\161\173 ",0x65,0x72),V1("I\208\191\254\175m\183GA",0x64,0xE7),V43),true);
V117:AddLabel(V42(V1("\202\216a\r1\135Kj\228",0xE4,0x6B),V116,V43),true);
local V118=V115.Info:AddLeftGroupbox(V1("\218\149~\149 \016N\018\221\v\143\166",0xF4,0xE9),V1("\\\141\208\255Ai\163\163\223",0xF5,0x37));
V118:AddLabel(V41(V12 .. V1("N\212",0x2E,0x4B) .. tostring(game.PlaceId) .. V1("\'",0xCA,0x78),V44),true);
V118:AddLabel(V42(V1("w\197p>p><\252\142",0x92,0x97),tostring(game.PlaceId),V44),true);
local V119=V118:AddLabel(V42(V1("\196\238\030\190\215\023\178\181&\171\169%",0xE0,0x52),V1("\175\f",0x7F,0x1A),V45),true);
local V120=tostring(game.JobId);
local V121=#V120 > 0x11 + 0x1 and (string.sub(V120,0x0 + 0x1,0x6422 - 0x6410) .. V1("\182Q\236",0x88,0x9B)) or V120;
V118:AddLabel(V42(V1("&<\141EJ\193ey\232",0x40,0x60),V121,V46),true);
V118:AddButton({Text=V1('\"\230\2121\217\f@\234\005O\244\025a\002\029n)>\183\196\235\021\r\208\254\254\232',0x3D,0x5), Func=function()
    local joinScript=string.format(V1("\222`\244t\209f\f\163\n\1649\197@\194L\151\025\211l\251|\015\150!\171\018\172A\205H\202T\153(\193c\252\139\f\159&\177;\163F\175S\208Z\228P\253\138\019\136\029\154$o\244\187\v\135\017\156r\169;\183\134\b\156\028y\014\180K\178L\225m\232j\244?\193w\027\1528\172A\202\001\144\029\195n\234p\003o\019\1440\1649x",0x77,0x88),game.PlaceId,V120);
    V39(joinScript,V1("\139|\150\232\198\206E\aT\162f\155\255\190\253_\026O\186\143\190\022\216\031s6v\211\190\221.\004E",0xA6,0x1F));
end});
local V122=os.clock();
task.spawn(function()
    while true do
        task.wait(0x47E65 - 0x47E64);
        if V34.Unloaded then
            break
        end
        local elapsed=math.floor(os.clock() - V122);
        local text
        if elapsed < 0x1A + 0x22 then
            text=elapsed .. V1("\212",0x61,0x96);
        elseif elapsed < 0x472 + 0x99E then
            text=string.format(V1("\250&\028\188\174\218\214",0xD5,0xED),elapsed // (0x2B + 0x11),elapsed % (0x3 * 0x14));
        else
            text=string.format(V1("\232\002\225tTnR",0xC3,0xDB),elapsed // (0xF7664 - 0xF6854),(elapsed % (0x5 * 0x2D0)) // (0x5 * 0xC));
        end
        V119:SetText(V42(V1("*2@\190\181\211L-|\223\187\021",0x46,0x30),text,V45));
    end
end);
local V123=V115.Info:AddRightGroupbox(V1(":=\186m\138\001",0x52,0x67),V1("L;;A595",0xDC,0xFE));
V123:AddLabel(V41(V1("\180\134\1705\vQ\182\152\2078*L\243F\158\182\159\142\141\173",0xCF,0x2B),V46),true);
V123:AddLabel(V41(V12,V44),true);
local V124=V115.Info:AddRightGroupbox(V1("c\170aL\137e",0x7E,0xA2),V1("\238\1419\220",0x82,0xA2));
V124:AddLabel(V41(V1("\127\155;\243\021\176j\142\021",0x97,0x7D),V44),true);
V124:AddLabel(V41(V1("bh\1787\'e",0x7D,0x47),V43),true);
V124:AddLabel(V41(V1("\1790\156",0x6E,0x6F),V44),true);
V124:AddLabel(V41(V1("p\162H\015c\246\176\r\134Q|9",0x89,0x8B),V46),true);
local V125=V115.Info:AddRightGroupbox(V1("j\153%\189\005a",0x83,0x72),V1("\250\127\f\145",0x8E,0x88));
V125:AddButton({Text=V1("\225\02323Pdg",0x9D,0x11), Func=V40});
V125:AddButton({Text=V1(">1\243\212\157vL\029",0xEC,0xD2), Func=function()
    V39(V14,V1("\182\245]\253)\127DT\239\198e\243P\2040\164\021\129\155\204\r}\024=\190[k\000\162\179A\236%\1461U\228",0xD1,0x6D));
end});
local V126=V115.Info:AddLeftGroupbox(V1("jQ6\162\130{\216\183\184\014\238\231D\0061\180\238-,",0x86,0x12),V1("\2303t\213\030o\184\022",0x73,0x50));
V126:AddLabel(V1("\218\137\246\129\006+\252j\247l\241s\157d\231\023\233[\214\015\213`\203\a\206V\129J\194T\197<\200F\127\239\155:i2\170<a2\182.\173\028\162&]\207\155\026I\n\141\b\132\n\141\n\130\005\137\006=\175{\250)\243n\241l\245b\237m\224h\216\031",0x95,0x7E),true);
V126:AddLabel(V1("\v6J\028W\147\180\187\222\248\001\2123Cl0\153\163\182\208\252\186\030)C[-\135\170\192\207\233\254!\241\252W\127\145\157o\211\226\b\0191=c3>\156\181\217\223\242\031 O`0;\147\183\196\151\243\006.?c!y\146\169\194\231\254\194-?\alz\163c\205\212\250\b&AW)",0xB7,0x17),true);
V126:AddLabel(V1("\016L\129\174\199\254(P&\150\189\245\202G]\144\179\229\192<W\141\173\220\v2T\138h\131\205\213Jv\164y\241\017\244t\142\176\236\1933f<\174\220\1834Q{\174\132\000\025Qq\161\206\163\031I_\153\196\222\006\235U\144f\208\184\005S\134\159\212\000\027\000v\151\206\247\014=dV",0xBE,0x29),true);
V126:AddButton({Text=V1("jk\1500\021\1331\151\254J|\202\015CAL\'g\017\026d",0x85,0x42), Func=V40});
local V127=V115.Info:AddRightGroupbox(V1("r\221\164\192Q\000",0x8C,0xC4),V1("%\163 \1785",0xBD,0x81));
V127:AddLabel(V41(V1('\132k\166PJ{\028\aN\234\251*\183\149\019\128v\209N1\152\024\250y\229\220\n\185\202\222z\151\164H*\137\022\"X\224\2101\172\150\207uV\156',0x9E,0x44),V45),true);
V127:AddLabel(V41(V1('\159\185\238\171\188\019\180\230\"\193\193\029\206\2448\213\006=\228\227e\236\030P\249\244}\003$Y\016;\133\023G\162-S|//\139<b\166DH\159Rq\204Z\140\190\160){\217+ \022q',0xBA,0x59),V43),true);
V127:AddDivider();
V127:AddLabel(V41(V1("\234c\195\017\145\243,C\215~\1452\207\019M",0x9E,0x71),V54),true);
V127:AddButton({Text=V1("\023t\251\2412\254\206\018\211\167\231\181\127\240WY\174`3\137\n",0x32,0x9E), Func=function()
    V39(V47,V1("\130\215U\vM\185\148\186k I\239\168\205\128/\133\209\184\242\137A|\226",0x9D,0x83));
end});
V127:AddLabel(V41(V1("}T\b\170~4\191M\247\015vk\\\244\130",0x3B,0xC5),V55),true);
V127:AddButton({Text=V1("\192\224*\227\231v\a1w+.\191L\128\170o\135\252\146\171\239",0xDB,0x61), Func=function()
    V39(V48,V1("\163\187\252uz\169G0\164\026)T\237\213K\189\214\229\143\140\230a_\136",0xBE,0x46));
end});
V127:AddLabel(V41(V1("\180\180\153bbD\249\193\156\205}t\160I\'",0x6F,0xF1),V56),true);
V127:AddButton({Text=V1("\215\005]$6\211p\182\015\190\236a\v2\142X~\001\165\204\030",0xF2,0x6F), Func=function()
    V39(V49,V1("\015\031X\201\198\237\131d\208<Qy\247\2448\177\167\210k`\178%\027<",0x2A,0x3E));
end});
V127:AddLabel(V41(V1("\027U\130\206",0xC6,0x3C),V57),true);
V127:AddButton({Text=V1("\022r\248\237-\248\255\209l\250\167\016r\198wI\158\030",0x31,0x9D), Func=function()
    V39(V50,V1('.1]\193\177\203T(\135\"\136\183\217\026\023\r\245:\160\137\157',0x49,0x31));
end});
V127:AddLabel(V41(V1("\180\\\229f\255~",0x61,0x8C),V58),true);
V127:AddButton({Text=V1("\144\162\222\137\127\000\189C\178\002J\170\240\002\026$\139\019\030T",0xAB,0x53), Func=function()
    V39(V51,V1("X\196Y&\127\002\2441\249\253\202\128\023\166M\2183\146\227\145`\178/",0x73,0x9A));
end});
V127:AddLabel(V41(V1("\141\233Ln\202 ",0x3D,0x4B),V59),true);
V127:AddButton({Text=V1("\155\014\171\183\014\240\014\242\183\131\014\211\146\250w\213\180\144\236\183",0xB6,0xB4), Func=function()
    V39(V52,V1("\220S\243\203/\189\186\002\213\228\185o,\168^\014g\213$\244\193\014\202",0xF7,0xA5));
end});
V127:AddLabel(V41(V1("\236-h\153\205",0x96,0x32),V60),true);
V127:AddButton({Text=V1("%S\171r\132!\250\159\029\149\003t\148\204\229\127\022-\179",0x40,0x6F), Func=function()
    V39(V53,V1("\192\194\237P?X\224\179\017\171\017P\137\184\234\203\196\158\249Q)p",0xDB,0x30));
end});
V127:AddDivider();
V127:AddLabel(V41(V1("e\202R0\127\005\249f\209\201\022\180\147\003vZ\201C)\142\026\241]\191\187-\143\134\246aT\138U\030T\029\233)\197\182\028\160\136\238j",0x7F,0x99),V46),true);
V127:AddLabel(V41(V1("\198Q\246$\202w\135\244\200\241\137$I\182\138\168J\006\t\172Ul\212\207\204<\027.\198s\140\244\193",0xDF,0xCB),V44),true);
local V128=V115.Info:AddRightGroupbox(V1("P\213\135i\218f\128\224\169\150\001\169",0x6B,0xB2),V1("\156\134sH5\018\190\221\190\169\145",0x39,0xE4));
V128:AddLabel(V1("\135\151\252\146\153\t\161\152\246\168\171$\178\226%\193\192B\201\251-\211\000!\222\vV\234\003t\247\003F\004\249Z\r<\134 F\130",0xA2,0x59),true);
V128:AddLabel(V1('\"\192\207\r\166\1913PnqZ_[F\202\144Y\175DE\152gQ\1337\031p\001\f[\242\240B\222\213,\251\229\023\230\171\004\198\159\237\186\165\220q\128\197t}\177]@\15834\135V@n\004\255',0x3D,0xF9),true);
V128:AddLabel(V1("d\b\199\f\200\131\182cS_\226\229C5\t\177^NZ\223\245\a\134q\174g;_\015\213",0x7F,0xE3),true);
V128:AddLabel(V1("\215\228b\015\023\159\130\014\155\re\217D\158\145\198\254\192\2061\247\ay/i\204i\167\000\163\195@\225\022N\014L\180F\133\222\128\177\249\183\222K\243\245\151&f\172_j\208\150\212-\211\215G\tG\160CU\232x\136\a\173\178\028",0xF2,0x68),true);
V128:AddLabel(V1("\127\162\224\164\223\025\203\2157\245\020XR\214k\191\169\216\029",0x9A,0x62),true);
V128:AddLabel(V1('\214A\029(\142t\181\159\138Z\016\226\171c\229p\n\205\1942\250\020\173>f\207\189\243\219\212\140\v\154\025\206\236J\"8\155c',0xF1,0xC6),true);
V128:AddLabel(V1('\129?\024wM\"p\022\020f\0055]0,W\026\023U\031\255',0x9C,0xFD),true);
V128:AddLabel(V1("\193j\132\205q\149\020<esgw~t4\253\213\214\n\178\193\025\180\202!\200\244-\a\n<\006\nI\006\249U\241\ag8\fi,3u82\1305T\145/m\152tV\168fs\181W[\191\150\147\199hn",0xDC,0x4),true);
V128:AddLabel(V1("8\227\169\245\184z\183GZr5\2480\237\205\238}\134\17391k\n\r)\195\199\240\167t",0x53,0xEA),true);
V128:AddLabel(V1("\186f\131\207v\157\031Jv\135~\145\155\148&\250\2092\238\014G\254\031[\015\016q&H\1343/\153x]\179wn\196ku\217\138\147\238\200\154\003\193\212\028\188\2281\214\226@\228\237",0xD5,0x7),true);
local function V129(V589)
    local V590=V589:AddLeftGroupbox(V1("\155\180\178\150\150\141s",0x57,0xF4));
    V590:AddButton({Text=V1("8\160y\129\228\199\005\236\212\161T#\233\158\029\166 \235\241\129);\167\137",0x53,0xC3), Func=V40});
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V591=0x493 * 1;
        V591=V591 - 0x7A % 7;
        local V592=function()
            return 0x493 + V591;
        end;
        local V593={0x2E, 0x7};
    end
    V590:AddButton({Text=V1(">\248#}2g\2470j\137\142\175\199\206\159|7u\184w\147\247\172\2016\021\001y7_\183h\147\244\191\228",0x59,0x15), Func=V40});
end
for V594,V595 in pairs(V115) do
    if V595 ~= V115.Info then
        V129(V595);
    end
end
local V130=V115.Main:AddLeftGroupbox(V1("J/\152\025\004h\235\216(",0x62,0x46),V1("A\027\237",0xDF,0xCD));
V130:AddToggle(V1("\169#h\169\2134x\193\251If\203#[",0x68,0x46),{Text=V1("\207\146\2178\001C\167\138\170\020\227\244|Z\153\232\195\251",0xE7,0x24), Default=false});
V130:AddToggle(V1("\156\1339\233\130E\255\179U\'\220\143",0x5B,0xB5),{Text=V1("\0206\220\154\194c#o\205\172\207u6[\021",0x2C,0x83), Default=false});
V130:AddToggle(V1("\223\148\020\144\247\147\v\151\a\139\rm\025\154\030",0x9E,0x81),{Text=V1("Vv\026\214\252\155Y\130\253\2222\160c\146$",0x6E,0x81), Default=false});
V130:AddToggle(V1("\221\195t!\166w6\229",0x9C,0xB2),{Text=V1("\184EV\127\018\030L\249\227\023\176\139\'\203aI\151X3c\251\f,\211\172",0xD0,0xEE), Default=false});
V130:AddToggle(V1("\175\027R\133\149\251\031h\146",0x6E,0x38),{Text=V1("V\163t]\176|j\215\129u\206i\197)\127\'5\182Q=\180<G\157i",0x6E,0xAE), Default=false});
V130:AddToggle(V1("\025KHA\0243-6\f534",0xD8,0xFE),{Text=V1("\1632Ep\005\019?\n\233\018\171\145\228\130\131",0xBB,0xF0), Default=false});
V130:AddToggle(V1("\247X\132\172\177\0060Uk\172\219\r;m\145",0xB6,0x2D),{Text=V1('c\205\187\1931\026%\175v\135\253\181.\175\"\231\018\176hu\018\166\214?\0204\181\158',0x7B,0xCB), Default=false});
V130:AddToggle(V1("/\246\136\022~2\195b\243\137\027\1787\215",0xEE,0x93),{Text=V1("<\145j[\182\138\128\245\167\163\004\167\vw\213\133\155$\199\187\020\200\224U\a\000l@",0x54,0xB6), Default=false});
V130:AddToggle(V1("8psrJz{\127|~\147d\144\157\147\165\166\171\178",0xF7,0x4),{Text=V1("2\251H\173|\196,\004P\173\137\158)\021P\166t\169",0x4A,0x2A), Default=false});
V130:AddToggle(V1("\130\200\217\230\219\000 $2UXoe\140\159",0x41,0x12),{Text=V1("\147\b\001\018\141\129\150%\239\024\176\147\1527\253\030\181m\156;\a",0xAB,0xD6), Default=false});
V130:AddToggle(V1("\1303\175\'x\026\158\027\156\vu\005\144\255x\006t\246Q\241j\238c",0x41,0x7D),{Text=V1("[\020Q\166e\157\248\169\204C\002:\146es\224\188\2270\003\001zNh",0x73,0x1A), Default=false});
V130:AddDropdown(V1("\235\180x \210\153@\251\143h\026\215\133",0x99,0xB6),{Text=V1("_\166(\tY\244\181\252n[\1631",0x78,0x8E), Values=#V31 > 0x439DF - 0x439DF and V31 or ({V1("0~\150\181\213\249\189\014<Wy",0xEF,0x1D)}), Default=(#V31 > 0x0 + 0x0 and V31[0x0 + 0x1]) or V1("\f\025\240\206\173\144\019#\016\234\203",0xCB,0xDC)});
V130:AddDropdown(V1("\149\174\194\186\188\211\202\213\195\235\238\239\240\244\v",0x43,0x6),{Text=V1("]o\188h\131\233u\134\247~\139\247",0x76,0x59), Values=#V29 > 0xE3759 - 0xE3759 and V29 or ({V1("\180\254\018-Ii)t\160\199\210\231\017\0279",0x73,0x19)}), Default={}, Multi=true, AllowNull=true, Searchable=true});
local V131=V115.Main:AddRightGroupbox(V1("\223\003\022",0x9A,0x16),V1("\243\238\193",0x8E,0xE7));
V131:AddToggle(V1("\230*G\135\155\208\203\001&",0x96,0x28),{Text=V1("\192\241M\215\252D\241\230HOdf\197x\171\b\203M\184\018",0xDB,0x5D), Default=false});
local V132=V115.Main:AddLeftGroupbox(V1("\176\179\250|i\164",0xCB,0x44),V1("G\240\1528\204",0xDF,0xA2));
V132:AddToggle(V1("\023V`fEyy\140\155}\165\184\198\222\196\220\249\252\015",0xD6,0xB),{Text=V1("q\027I\143?h\180xg\209\134\152\243\199\178\020\208\2333\021 U\005\'",0x89,0xB), Default=false});
V132:AddToggle(V1("\202u\235]\186J\1919\164#r\018~\a~\231l",0x89,0x77),{Text=V1("\154\199xAt \238;\197\153\210MBi\002\232J\186",0xB2,0x8E), Default=false});
V37.PlayerESP:OnChanged(function()
    if not V37.PlayerESP.Value then
        V112();
    else
        V113();
    end
end);
local V133=V115.Player:AddLeftGroupbox(V1("\180\014\188\128\191w",0xCD,0x9A),V1("\186\149g>\f\224\169\128X)",0x54,0xD2));
V133:AddToggle(V1("\193\024p\188\241[\157\2346d\218\026h\191\005Q",0x6A,0x4D),{Text=V1("\159jg\213\180\193\f\181\230>%#",0xB7,0x12), Default=false});
V133:AddSlider(V1("\212\202\193\172\128\137jVA",0x7D,0xEC),{Text=V1("\151\209=\026h\228\158\182V\029s\224\161\209m#?\252",0xAF,0x81), Default=0x8 + 0x18, Min=0xB + 0x5, Max=0x5 * 0x32, Rounding=0x41BB4 - 0x41BB4});
V133:AddToggle(V1("\242.=8z\137\163",0xA9,0x17),{Text=V1("I\152?&t\t\255l\006\217F\176",0x63,0x9E), Default=false});
V133:AddToggle(V1("\163K\166V\218h",0x55,0x87),{Text=V1("\020\001B\147{\157",0x2D,0x2B), Default=false});
V133:AddToggle(V1("\214\172[\249\128C\248\153M\242\144Q\209\139H\239\138",0x95,0xA9),{Text=V1("P\220\192\225\142ir\239\209\003\146U\147\n\000",0x6A,0xDB), Default=true});
local V134=V115.Player:AddRightGroupbox(V1("c\131\228\148\179\004",0x7A,0x66),V1("\202\017U\176\2361\134",0x64,0x48));
V134:AddToggle(V1("\177\026j",0x6B,0x43),{Text=V1("K\185hf\211r",0x62,0xB4), Default=false});
V134:AddSlider(V1("\024y\193\214.^\153\211",0xD2,0x3B),{Text=V1("\201\015\150l\177(\0174\223\177\018\138",0xE0,0x8C), Default=0x8C4E1 - 0x8C4A5, Min=0x4 + 0x6, Max=0xD5510 - 0xD5380, Rounding=0x0 + 0x0});
local V135=V115.Settings:AddLeftGroupbox(V1("\156Ut\207\137\163",0xB4,0x12));
V135:AddLabel(V1("\132\001\228\003\129_\1351\221\a\166h",0x9C,0xD6)):AddKeyPicker(V1("\162\160\143|882\001\238\217\181",0x55,0xE6),{Default=V1("7SV\\mQkqs\134",0xE5,0x5), NoUI=true, Text=V1("\140\168*\232\005\130G\150\247\167\195b\t)\184",0xA4,0x75)});
V34.ToggleKeybind=V38.MenuKeybind;
V135:AddToggle(V1("\154[\245~\234\163<",0x59,0x94),{Text=V1("\225\221D\197\184\251\172\175\026",0xF8,0x4D), Default=true});
V135:AddButton({Text=V1("(\176\187\203\128`",0x43,0xE0), Func=function()
    V34:Unload();
end});
local V136=tick();
local V137=tick();
pcall(function()
    for _,connection in ipairs(getconnections(V11.Idled)) do
        pcall(function()
            connection:Disable();
        end);
    end
end);
local function V138()
    do
        local V596=nil;
        local V597=0x63F66;
        while true do
            if V597 == 0x8934E then
                if V1("\247",0xA5,0x22):byte() == 14884 then
                    local V598=-0x137E * 1;
                    V598=V598 - 0x15A % 7;
                end
                V597=0x39FFD;
            elseif V597 == 0x2511B then
                task.wait(0.1);
                V597=0x546AE;
            elseif V597 == 0x546AE then
                if V1("4",0xEB,0x6):byte() == 14884 then
                    local V599=0x19C4 * 1;
                    V599=V599 - 0x2 % 7;
                    local V600=function()
                        return 0x19C4 + V599;
                    end;
                end
                V6:Button2Up(Vector2.new(0x0 + 0x0,0x4383A - 0x4383A),V596.CFrame);
                V597=0x8934E;
            elseif V597 == 0x9B736 then
                if V1("\149",0x48,0x5E):byte() == 14884 then
                    local V601=0x1019 * 1;
                    V601=V601 - 0xB8 % 7;
                end
                V6:Button2Down(Vector2.new(0x57A9 - 0x57A9,0x51D41 - 0x51D41),V596.CFrame);
                V597=0x2511B;
            elseif V597 == 0xA4728 then
                if not V596 then
                    return
                end
                V597=0x9B736;
            elseif V597 == 0x39FFD then
                V137=tick();
                V597=0xBD25;
            elseif V597 == 0x63F66 then
                V596=V10.CurrentCamera;
                if 0x7AA0E7 + 0 == 0x7AA285 then
                    local V602=0xA9C * 1;
                    local V603=function()
                        return 0xA9C + V602;
                    end;
                end
                V597=0xA4728;
            else
                break
            end
        end
    end
end
local V139=V5.InputBegan:Connect(function()
    V136=tick();
end);
local V140=V5.InputChanged:Connect(function(input)
    local inputType=input.UserInputType;
    if inputType == Enum.UserInputType.MouseMovement or inputType == Enum.UserInputType.Gamepad1 then
        V136=tick();
    end
end);
task.spawn(function()
    while not V34.Unloaded do
        task.wait(0x1B39 - 0x1B37);
        if V37.AntiAfk.Value then
            local idle=tick() - V136;
            local sinceTap=tick() - V137;
            if idle >= 0xE2A74 - 0xE2948 and sinceTap >= 0x3 * 0x14 then
                pcall(V138);
            elseif idle < 0xA + 0x122 and sinceTap >= 0x12 + 0x11A then
                pcall(V138);
            end
        end
    end
end);
V4.Stepped:Connect(function()
    if V34.Unloaded then
        return
    end
    if V37.NoClip and V37.NoClip.Value then
        local character=V11.Character;
        if character then
            for _,part in ipairs(character:GetDescendants()) do
                if part:IsA(V1(")\a\216\1373\003\211\148",0xE7,0xBF)) and part.CanCollide then
                    part.CanCollide=false;
                end
            end
        end
    end
end);
V5.JumpRequest:Connect(function()
    if V34.Unloaded then
        return
    end
    if V37.InfJump and V37.InfJump.Value then
        local humanoid=V64();
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        end
    end
end);
local V141=V10.CurrentCamera;
V4.RenderStepped:Connect(function(dt)
    if V34.Unloaded then
        return
    end
    if V37.WalkSpeedEnabled and V37.WalkSpeedEnabled.Value then
        local humanoid=V64();
        if humanoid then
            humanoid.WalkSpeed=V38.WalkSpeed.Value;
        end
    end
    if V37.Fly and V37.Fly.Value then
        local root=V65();
        local humanoid=V64();
        if root and humanoid then
            humanoid.PlatformStand=true;
            local direction=Vector3.zero;
            if V5:IsKeyDown(Enum.KeyCode.W) then
                direction=direction + V141.CFrame.LookVector;
            end
            if V5:IsKeyDown(Enum.KeyCode.S) then
                direction=direction - V141.CFrame.LookVector;
            end
            if V5:IsKeyDown(Enum.KeyCode.A) then
                direction=direction - V141.CFrame.RightVector;
            end
            if V5:IsKeyDown(Enum.KeyCode.D) then
                direction=direction + V141.CFrame.RightVector;
            end
            if V5:IsKeyDown(Enum.KeyCode.Space) then
                direction=direction + Vector3.new(0x0 + 0x0,0x0 + 0x1,0x0 + 0x0);
            end
            if V5:IsKeyDown(Enum.KeyCode.LeftControl) then
                direction=direction - Vector3.new(0x0 + 0x0,0x0 + 0x1,0x0 + 0x0);
            end
            root.AssemblyLinearVelocity=Vector3.zero;
            if direction.Magnitude > 0x0 + 0x0 then
                root.CFrame=root.CFrame + direction.Unit * V38.FlySpeed.Value * dt;
            end
        end
    end
end);
V37.Fly:OnChanged(function()
    if not V37.Fly.Value then
        local humanoid=V64();
        if humanoid then
            humanoid.PlatformStand=false;
        end
    end
end);
V37.WalkSpeedEnabled:OnChanged(function()
    if not V37.WalkSpeedEnabled.Value then
        local humanoid=V64();
        if humanoid then
            humanoid.WalkSpeed=0x2 + 0xE;
        end
    end
end);
if 0xC43276 + 0 == 0xC4360E then
    local V604=-0x2543 * 1;
end
local function V142(V605)
    pcall(function()
        V8:SetGameplayPausedNotificationEnabled(not V605);
    end);
    pcall(function()
        local notification=V9:FindFirstChild(V1("\224\026*Qq\151\138\190\234\n\031?UW\133\182\209\224\230$FXr\146\169\196\244\006)E",0x8E,0x1D));
        if notification then
            notification.Enabled=not V605;
        end
    end);
    if not V605 then
        if V1("\b",0xBE,0xD9):byte() == 14884 then
            local V606=0x20DA * 1;
            V606=V606 - 0xBA % 7;
        end
        return
    end
    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(V11,V1("\169\224\t\030F_q\166\154\200\249\020#?",0x62,0x1D),false);
        else
            V11.GameplayPaused=false;
        end
    end);
end
if 0xB035AF + 0 == 0xB035B7 then
    local V607=0x21E8 * 1;
    V607=V607 - 0x17C % 7;
    local V608=function()
        return 0x21E8 + V607;
    end;
end
V37.AntiGameplayPause:OnChanged(function()
    V142(V37.AntiGameplayPause.Value);
end);
task.spawn(function()
    while not V34.Unloaded do
        task.wait(0x0 + 0x1);
        if V37.AntiGameplayPause.Value then
            V142(true);
        end
    end
end);
task.spawn(function()
    while not V34.Unloaded do
        task.wait(0.35);
        pcall(V107);
    end
end);
task.spawn(function()
    while not V34.Unloaded do
        task.wait(5.726100851961956 - 4.476100851961956);
        pcall(V99);
        pcall(V100);
    end
end);
if math.floor(math.pi * 100000) % 2 == 0 then
    local V609=0xDD0 * 1;
    local V610={0x61, 0x18, 0x47};
end
task.spawn(function()
    while not V34.Unloaded do
        repeat
            task.wait(3.7263505916228645 - 2.6263505916228644);
            if not V73() then
                break
            end
            pcall(V95);
            if V63(V1("\182l\237j\210o\232u\230k\238O\252~\003",0x75,0x82)) then
                pcall(V86,V1("\204f\213G",0x88,0x6F));
            end
            if V63(V1("\245\207t\021\142S\006\169",0xB4,0xA6)) then
                pcall(V86,V1("n\201\024Jl\189\252>|\190\242",0x2B,0x3D));
            end
            if V63(V1("\214\006\001\248\204\246\222\235\217",0x95,0xFC)) then
                pcall(V86,V1("\186E\172\022s\230V",0x66,0x6A));
            end
            if V63(V1("\220\207\141G\222\197\1298\224\179t8\248\188r",0x9B,0xBF)) then
                pcall(V86,V1("\246\225\170\1360\017\224\178\128R\022",0xAF,0xCD));
            end
            if V63(V1("\029\160\2388\\\204\025t\193\019a\180\245Q",0xDC,0x4F)) then
                pcall(V86,V1("\145t4\002\194\135H\014\194\145.\004\200\143R\025\210",0x4D,0xC2));
            end
        until true
    end
end);
task.spawn(function()
    while not V34.Unloaded do
        task.wait(0.35);
        if V63(V1("\223=f\139\142\213\25102\135\177\222",0x9E,0x2A)) and V73() then
            pcall(V101);
        end
    end
end);
if V1("\201",0x7D,0x31):byte() == 14884 then
    local V611=-0x3C8 * 1;
    V611=V611 - 0xD9 % 7;
    local V612={0x17, 0x4, 0x3B, 0x35};
end
task.spawn(function()
    while not V34.Unloaded do
        task.wait(0.2);
        if V63(V1("\171\153`J\b\231\140l;",0x5B,0xD2)) then
            pcall(V113);
        end
    end
end);
if math.floor(math.pi * 100000) % 2 == 0 then
    local V613=0x24E * 1;
    V613=V613 - 0x14B % 7;
end
task.spawn(function()
    while not V34.Unloaded do
        task.wait(0x1 + 0x1);
        pcall(V83);
    end
end);
V35:SetLibrary(V34);
V35:SetFolder(V1("\029\155\240E\144\245P\165\001.\179\248",0xCE,0x58));
if V1(",",0xEB,0xF9):byte() == 14884 then
    local V614=-0x1AA5 * 1;
    V614=V614 - 0xD3 % 7;
    local V615={0x2F, 0x1A, 0x42, 0x37};
end
V35:SaveDefault(V1("!\030\248\212\163\131h@\025\236",0xD4,0xDB));
V35:ApplyToTab(V115.Settings);
V35:LoadDefault();
V36:SetLibrary(V34);
if V1("\135",0x42,0xFB):byte() == 14884 then
    local V616=0x1DA3 * 1;
    V616=V616 - 0x26 % 7;
    local V617={0x2D, 0x24, 0x1A, 0x8};
end
V36:IgnoreThemeSettings();
V36:SetIgnoreIndexes({V1("\135=\228\137\253\181g\238\1476\202",0x3A,0x9E), V1("\166\214\r\030(^\141\162\202\234\025(4z\159\192\229\t\nHp\143\162\198",0x53,0x22)});
V36:SetFolder(V1("\028\227\129\031\179a\005\163H\190\140\026\136<\r\161>\233c/\208t",0xCD,0xA1));
local V143=V36:BuildConfigSection(V115.Settings);
local function V144(V618,V619)
    do
        local V620,V621=nil,nil;
        local V622=0xD21A;
        while true do
            if V622 == 0x76450 then
                V621=V620[V619];
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V623=-0x843 * 1;
                    V623=V623 - 0x8A % 7;
                    local V624={0x3D, 0x36, 0x1C, 0x6};
                end
                V622=0x8F7D6;
            elseif V622 == 0x8F7D6 then
                return type(V621) == V1("\213c\005\176J",0x61,0xA1) and V621.Type == V618 and V621 or nil;
            elseif V622 == 0xD21A then
                V620=V618 == V1("\145i\030\219\157S",0x3D,0xBD) and V37 or V38;
                V622=0x76450;
            else
                break
            end
        end
    end
end
if 0xD49388 + 0 == 0xD49573 then
    local V625=0x1BA9 * 1;
    V625=V625 - 0x1CA % 7;
end
local function V145(V626,V627)
    local V628=V627.Type;
    if V628 == V1("\188\234\245\b ,",0x68,0x13) then
        return {idx=V626, type=V1("\023\1810\179;\183",0xC3,0x83), value=V627.Value == true};
    elseif V628 == V1("\b\251\210\167\130i",0xB5,0xDA) then
        if math.floor(math.pi * 100000) % 2 == 0 then
            local V629=0x20D1 * 1;
            V629=V629 - 0x11B % 7;
            local V630={0x5B, 0x54};
        end
        return {idx=V626, type=V1("\245p\207,\143\254",0xA2,0x62), value=tostring(V627.Value)};
    elseif V628 == V1("\tRj\134\149\187\222\240",0xC5,0x1B) then
        return {idx=V626, type=V1("p>\219|\016\187c\250",0x2C,0xA0), multi=V627.Multi == true, value=V627.Value};
    elseif V628 == V1("\153\192\196\203\204",0x50,0x2) then
        return {idx=V626, type=V1("52\f\233\192",0xEC,0xD8), text=tostring(V627.Value or "")};
    elseif V628 == V1("\214\208\155l=\233\208\152n6\017",0x93,0xCE) then
        return {idx=V626, type=V1("\2007w\189\003$\128\189\bE\149",0x85,0x43), value=V627.Value:ToHex(), transparency=V627.Transparency};
    elseif V628 == V1("\199@\179\233a\186!z\230",0x7C,0x5F) then
        return {idx=V626, type=V1("\233>\141\159\243(k\160\232",0x9E,0x3B), mode=V627.Mode, key=V627.Value, modifiers=V627.Modifiers, toggled=V627.Toggled};
    end
    if math.floor(math.pi * 100000) % 2 == 0 then
        local V631=0x99 * 1;
    end
    return nil;
end
local function V146()
    do
        local V632=nil;
        local V633=0x1DEA6;
        while true do
            if V633 == 0x8E8E1 then
                table.sort(V632,function(a,b)
                    if a.type ~= b.type then
                        return a.type < b.type;
                    end
                    return a.idx < b.idx;
                end);
                V633=0x56200;
            elseif V633 == 0x40669 then
                for V634,V635 in ipairs({V37, V38}) do
                    for V636,V637 in pairs(V635) do
                        if type(V637) == V1("\241\199\177\164\134",0x7D,0xE9) and type(V637.Type) == V1("\2046\157\253k\205",0x59,0x69) and not V36.Ignore[V636] then
                            if V1("\171",0x6A,0x4):byte() == 14884 then
                                local V639=0x3AF * 1;
                                V639=V639 - 0x25 % 7;
                            end
                            local V638=V145(V636,V637);
                            if V638 then
                                V632[#V632 + (0x1 + 0x0)]=V638;
                            end
                        end
                    end
                end
                V633=0x8E8E1;
            elseif V633 == 0xE339F then
                V632={};
                if V1("\182",0x6E,0xD8):byte() == 14884 then
                    local V640=0x1FF2 * 1;
                end
                V633=0x40669;
            elseif V633 == 0x1DEA6 then
                if math.floor(math.pi * 100000) % 2 == 0 then
                    local V641=0x1442 * 1;
                    local V642=function()
                        return 0x1442 + V641;
                    end;
                    local V643={0x4D, 0x51, 0x18, 0x2A};
                end
                V633=0xE339F;
            elseif V633 == 0x56200 then
                if V1('\"',0xDA,0xD7):byte() == 14884 then
                    local V644=0x1DDD * 1;
                    local V645={0x4, 0x61, 0x40};
                end
                return {objects=V632};
            else
                break
            end
        end
    end
end
if math.floor(math.pi * 100000) % 2 == 0 then
    local V646=-0x4B1 * 1;
end
local function V147(V647)
    if type(V647) ~= V1("\000\184\132Y\029",0x8C,0xCB) or type(V647.idx) ~= V1("\002B\127\181\2491",0x8F,0x3F) or type(V647.type) ~= V1("\015\229\184\132^,",0x9C,0xD5) or V36.Ignore[V647.idx] then
        return false;
    end
    local V648=V144(V647.type,V647.idx);
    if not V648 then
        if math.floor(math.pi * 100000) % 2 == 0 then
            local V650=-0xDD7 * 1;
            V650=V650 - 0x186 % 7;
        end
        return false;
    end
    if 0x25CB00 + 0 == 0x25CDA2 then
        local V651=0x2187 * 1;
        V651=V651 - 0xE3 % 7;
        local V652=function()
            return 0x2187 + V651;
        end;
    end
    local V649=pcall(function()
        if V647.type == V1("-\005\186r$",0xE4,0xB3) then
            if type(V647.text) ~= V1("\244\206\165uS%",0x81,0xD9) then
                return
            end
            V648:SetValue(V647.text);
        elseif V647.type == V1("\165v\024\192h\235\169H\245\148F",0x62,0xA5) then
            V648:SetValueRGB(Color3.fromHex(V647.value),V647.transparency);
        elseif V647.type == V1("\240\169\\\210\138#\202c\015",0xA5,0x9F) then
            V648:SetValue({V647.key, V647.mode, V647.modifiers});
            if V647.mode == V1("\2529Su\156\183",0xA8,0x22) and V647.toggled ~= nil then
                V648.Toggled=V647.toggled;
                V648:Update();
            end
        else
            V648:SetValue(V647.value);
        end
    end);
    return V649;
end
if math.floor(math.pi * 100000) % 2 == 0 then
    local V653=-0x183D * 1;
    local V654=function()
        return -0x183D + V653;
    end;
    local V655={0x3E, 0x1D};
end
V143:AddDivider();
if 0xEB36C4 + 0 == 0xEB38D9 then
    local V656=-0xA6E * 1;
    local V657={0x58, 0x34, 0x41};
end
V143:AddInput(V1("|\139\161\145z\143\157\145\152\151\165\147~\163\167\167\171\174\142\171\178\176\162\165",0x29,0x1),{Text=V1("?\212\190\218\127Tu\030\226\016\186\152\167O:A\193\210\221n6y\243\217\017\197\148",0x5A,0xDE), Finished=true, AllowEmpty=true});
V143:AddButton(V1("U\142\n\162\179U\243\254u>\131\227\137\1552\214\233y&a\208q\151(",0x70,0x6F),function()
    local encodeSuccess,encoded=pcall(V7.JSONEncode,V7,V146());
    if not encodeSuccess then
        V34:Notify(V1("\173\225\129s\225j;\168\026\003T\205\201 \197\148\248\129",0xC4,0x98));
        return
    end
    local writeClipboard=setclipboard or toclipboard;
    if type(writeClipboard) ~= V1("?0\v\226\213\172\148u",0xD9,0xE2) or not pcall(writeClipboard,encoded) then
        V34:Notify(V1("\140\233P\027R\192\166\205o4q\224\189\245\136H\160\249\214\b\167b\140\005\2370\157y\160R\005,\216\145\185^ p\244\170\229\139",0xA8,0x84));
        return
    end
    V34:Notify(V1('\187\182\029\214\v[\241\"|\014,t+-\186HJ\209eh\232\133\176\015\160\1827',0xD2,0x5F),0x5CF66 - 0x5CF60);
end);
if V1("\255",0xB3,0x13):byte() == 14884 then
    local V658=0x159C * 1;
    local V659=function()
        return 0x159C + V658;
    end;
end
V143:AddButton(V1('\1844\172\168\241\183\154\v\176\135\227\170v\203ae\192uS\194tB\135L5v#\"\1573',0xD4,0xA5),function()
    local source=tostring(V38.SaveManager_ImportSource.Value or ""):match(V1("\186v\185eXSG8)l\024\a",0x5C,0xF5));
    if source == "" then
        V34:Notify(V1('\019\174\138\140\000\215\b\167Q\132\"\003\000v}~\005\195\252lHv \229\242\145Ko\015\227\232_[g\017\186\224TH]\236\165',0x2B,0xD4));
        return
    end
    local decodeSuccess,decoded=pcall(V7.JSONDecode,V7,source);
    if not decodeSuccess or type(decoded) ~= V1("\198\139dF\023",0x52,0xD8) or type(decoded.objects) ~= V1("Q\207a\252\134",0xDD,0x91) then
        V34:Notify(V1('\132\019\165\1684\193\210<\v\250h\r\"\1374K\182Xq\243\184\153\243\222\197\025\217\235y\"',0x9C,0xB8));
        return
    end
    local applied=0x36569 - 0x36569;
    for _,object in ipairs(decoded.objects) do
        if V147(object) then
            applied=applied + (0x1 + 0x0);
        end
    end
    if applied == 0x5EF19 - 0x5EF19 then
        V34:Notify(V1("\177\024\174\146\206vp\230wM\193V/\155*\015e\242\237a\215\209H\194\173!\179\145\205\131o\197uN\149b2n\022\016c\237\241W\a\208F\215",0xC9,0xA0));
        return
    end
    V38.SaveManager_ImportSource:SetValue("");
    V34:Notify((V1("\1711\224\199E\006\2277\v:\243\230V\206V\252\238h,\t\1478ce",0xC6,0xB4)):format(applied,applied == 0x1 + 0x0 and "" or V1("E",0xD2,0x8A)),0x78DA8 - 0x78DA2);
end);
if 0xF52639 + 0 == 0xF52A07 then
    local V660=-0x1132 * 1;
    V660=V660 - 0x7A % 7;
end
V36:LoadAutoloadConfig();
if 0xC68B2B + 0 == 0xC68BBB then
    local V661=-0xC91 * 1;
    local V662=function()
        return -0xC91 + V661;
    end;
end
V34:OnUnload(function()
    V112();
    if V108 then
        V108:Destroy();
    end
    if V139 then
        V139:Disconnect();
    end
    if V140 then
        V140:Disconnect();
    end
    V142(false);
    local humanoid=V64();
    if humanoid then
        humanoid.PlatformStand=false;
        humanoid.WalkSpeed=0x708D4 - 0x708C4;
    end
end);
