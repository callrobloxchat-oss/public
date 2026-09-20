-- Watermelon Hub v102
local Pl=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local WS=game:GetService("Workspace")
local RSt=game:GetService("ReplicatedStorage")
local LP=Pl.LocalPlayer
local Cam=WS.CurrentCamera
local CG
pcall(function() CG=game:GetService("CoreGui") end)

local C={
    InfJump=false, BhopOn=false, BhopMax=200, BhopAccel=8,
    SpinOn=false, SpinSpeed=15, TPVOn=false,
    CocoP=false, CocoPLen=5, CocoB=false, CocoBt=false,
    CocoC=false, CocoCR=4, CocoCD=30, CocoCS=0,
    RocketOn=false, RocketSpd=90, RocketMin=5, RocketMax=300,
}

local bSpd=16
local bGrounded=true
local fTgt,fBP,fBG=nil,nil,nil

if _G.WM_Clean then pcall(_G.WM_Clean) end
local conns={}
local function clean()
    for _,c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    conns={}
    if fBP then fBP:Destroy() end
    if fBG then fBG:Destroy() end
    fBP,fBG,fTgt=nil,nil,nil
end
_G.WM_Clean=clean

local function sRm(n)
    if CG and CG:FindFirstChild(n) then CG[n]:Destroy() end
    if LP.PlayerGui and LP.PlayerGui:FindFirstChild(n) then LP.PlayerGui[n]:Destroy() end
end
for i=89,102 do sRm("WM"..i) end
sRm("RocketControlGui")

local SG=Instance.new("ScreenGui")
SG.Name="WM102"
SG.ResetOnSpawn=false
SG.IgnoreGuiInset=true
SG.DisplayOrder=5
local ok=pcall(function() SG.Parent=LP.PlayerGui end)
if not ok and CG then pcall(function() SG.Parent=CG end) end
if not SG.Parent then SG.Parent=LP:WaitForChild("PlayerGui") end

local CL={
    W=Color3.fromRGB(22,22,26), H=Color3.fromRGB(32,32,38),
    S=Color3.fromRGB(14,14,18), Ct=Color3.fromRGB(26,26,32),
    Cd=Color3.fromRGB(38,38,46), Tx=Color3.fromRGB(240,240,245),
    Td=Color3.fromRGB(165,165,175), Tm=Color3.fromRGB(120,120,135),
    A=Color3.fromRGB(100,155,255), Ad=Color3.fromRGB(60,95,180),
    G=Color3.fromRGB(85,210,115), R=Color3.fromRGB(235,80,80),
    O=Color3.fromRGB(255,140,60),
    CW=Color3.fromRGB(255,255,255),
}

local WW,WH,SW=480,360,140
local M=Instance.new("Frame")
M.Size=UDim2.new(0,WW,0,WH)
M.Position=UDim2.new(0.5,-WW/2,0.5,-WH/2)
M.BackgroundColor3=CL.W
M.BorderSizePixel=0
M.Active=true
M.Draggable=true
M.Parent=SG
Instance.new("UICorner",M).CornerRadius=UDim.new(0,10)

local Hd=Instance.new("Frame")
Hd.Size=UDim2.new(1,0,0,28)
Hd.BackgroundColor3=CL.H
Hd.BorderSizePixel=0
Hd.Parent=M
Instance.new("UICorner",Hd).CornerRadius=UDim.new(0,10)
local HF=Instance.new("Frame")
HF.Size=UDim2.new(1,0,0,10)
HF.Position=UDim2.new(0,0,1,-10)
HF.BackgroundColor3=CL.H
HF.BorderSizePixel=0
HF.Parent=Hd
local HT=Instance.new("TextLabel")
HT.Size=UDim2.new(1,-60,1,0)
HT.Position=UDim2.new(0,14,0,0)
HT.BackgroundTransparency=1
HT.Text="WATERMELON HUB v102"
HT.TextColor3=CL.Td
HT.Font=Enum.Font.GothamBold
HT.TextSize=11
HT.TextXAlignment=Enum.TextXAlignment.Left
HT.Parent=Hd
local CBB=Instance.new("TextButton")
CBB.Size=UDim2.new(0,30,0,22)
CBB.Position=UDim2.new(1,-34,0.5,-11)
CBB.BackgroundTransparency=1
CBB.Text="X"
CBB.TextColor3=CL.Td
CBB.Font=Enum.Font.GothamBold
CBB.TextSize=13
CBB.AutoButtonColor=false
CBB.Parent=Hd
CBB.Activated:Connect(function() M.Visible=false end)

local Side=Instance.new("Frame")
Side.Size=UDim2.new(0,SW,1,-28)
Side.Position=UDim2.new(0,0,0,28)
Side.BackgroundColor3=CL.S
Side.BorderSizePixel=0
Side.Parent=M
Instance.new("UICorner",Side).CornerRadius=UDim.new(0,10)

local CA=Instance.new("Frame")
CA.Size=UDim2.new(1,-SW,1,-28)
CA.Position=UDim2.new(0,SW,0,28)
CA.BackgroundColor3=CL.Ct
CA.BorderSizePixel=0
CA.ClipsDescendants=true
CA.Parent=M
Instance.new("UICorner",CA).CornerRadius=UDim.new(0,10)

local tabs={}
local function mkTab(name,icon,idx,scroll)
    local tb=Instance.new("TextButton")
    tb.Size=UDim2.new(1,-16,0,36)
    tb.Position=UDim2.new(0,8,0,10+(idx-1)*40)
    tb.BackgroundColor3=CL.Cd
    tb.BackgroundTransparency=1
    tb.Text=""
    tb.AutoButtonColor=false
    tb.Parent=Side
    Instance.new("UICorner",tb).CornerRadius=UDim.new(0,8)
    local il=Instance.new("TextLabel")
    il.Size=UDim2.new(0,26,1,0)
    il.Position=UDim2.new(0,8,0,0)
    il.BackgroundTransparency=1
    il.Text=icon
    il.TextColor3=CL.Tm
    il.Font=Enum.Font.GothamBold
    il.TextSize=15
    il.TextXAlignment=Enum.TextXAlignment.Center
    il.Parent=tb
    local tl=Instance.new("TextLabel")
    tl.Size=UDim2.new(1,-42,1,0)
    tl.Position=UDim2.new(0,38,0,0)
    tl.BackgroundTransparency=1
    tl.Text=name
    tl.TextColor3=CL.Tx
    tl.Font=Enum.Font.GothamBold
    tl.TextSize=12
    tl.TextXAlignment=Enum.TextXAlignment.Left
    tl.Parent=tb
    local pg=Instance.new("Frame")
    pg.Size=UDim2.new(1,0,1,0)
    pg.BackgroundTransparency=1
    pg.Visible=false
    pg.Parent=CA
    local ct
    if scroll then
        ct=Instance.new("ScrollingFrame")
        ct.Size=UDim2.new(1,0,1,0)
        ct.BackgroundTransparency=1
        ct.BorderSizePixel=0
        ct.ScrollBarThickness=4
        ct.ScrollBarImageColor3=CL.A
        ct.CanvasSize=UDim2.new(0,0,0,0)
        ct.AutomaticCanvasSize=Enum.AutomaticSize.Y
    else
        ct=Instance.new("Frame")
        ct.Size=UDim2.new(1,0,1,0)
        ct.BackgroundTransparency=1
    end
    ct.Parent=pg
    local p=Instance.new("UIPadding",ct)
    p.PaddingTop=UDim.new(0,12)
    p.PaddingLeft=UDim.new(0,12)
    p.PaddingRight=UDim.new(0,12)
    p.PaddingBottom=UDim.new(0,12)
    local l=Instance.new("UIListLayout",ct)
    l.Padding=UDim.new(0,6)
    l.SortOrder=Enum.SortOrder.LayoutOrder
    local pt=Instance.new("TextLabel")
    pt.Size=UDim2.new(1,0,0,22)
    pt.BackgroundTransparency=1
    pt.Text=name
    pt.TextColor3=CL.Tx
    pt.Font=Enum.Font.GothamBold
    pt.TextSize=16
    pt.TextXAlignment=Enum.TextXAlignment.Left
    pt.LayoutOrder=0
    pt.Parent=ct
    local function sel()
        for _,t in ipairs(tabs) do
            t.pg.Visible=false
            t.tb.BackgroundTransparency=1
            t.il.TextColor3=CL.Tm
            t.tl.TextColor3=CL.Td
        end
        pg.Visible=true
        tb.BackgroundTransparency=0
        tb.BackgroundColor3=CL.Cd
        il.TextColor3=CL.A
        tl.TextColor3=CL.Tx
    end
    tb.Activated:Connect(sel)
    table.insert(tabs,{tb=tb,pg=pg,il=il,tl=tl,sel=sel})
    return ct
end

local function Tog(text,parent,get,set,ord)
    local bt=Instance.new("TextButton")
    bt.Size=UDim2.new(1,0,0,36)
    bt.BackgroundColor3=CL.Cd
    bt.Text=""
    bt.AutoButtonColor=false
    bt.LayoutOrder=ord or 0
    bt.Parent=parent
    Instance.new("UICorner",bt).CornerRadius=UDim.new(0,6)
    local lb=Instance.new("TextLabel")
    lb.Size=UDim2.new(1,-46,1,0)
    lb.Position=UDim2.new(0,12,0,0)
    lb.BackgroundTransparency=1
    lb.Text=text
    lb.TextColor3=CL.Tx
    lb.Font=Enum.Font.GothamMedium
    lb.TextSize=12
    lb.TextXAlignment=Enum.TextXAlignment.Left
    lb.Parent=bt
    local ind=Instance.new("Frame")
    ind.Size=UDim2.new(0,16,0,16)
    ind.Position=UDim2.new(1,-24,0.5,-8)
    ind.BackgroundColor3=get() and CL.G or Color3.fromRGB(60,60,70)
    ind.BorderSizePixel=0
    ind.Parent=bt
    Instance.new("UICorner",ind).CornerRadius=UDim.new(1,0)
    bt.Activated:Connect(function()
        local n=not get()
        set(n)
        ind.BackgroundColor3=n and CL.G or Color3.fromRGB(60,60,70)
    end)
end

local function Sld(text,parent,mn,mx,get,set,ord,step)
    step=step or math.max(1,math.floor((mx-mn)/50))
    local cd=Instance.new("Frame")
    cd.Size=UDim2.new(1,0,0,60)
    cd.BackgroundColor3=CL.Cd
    cd.BorderSizePixel=0
    cd.LayoutOrder=ord or 0
    cd.Parent=parent
    Instance.new("UICorner",cd).CornerRadius=UDim.new(0,6)
    local lb=Instance.new("TextLabel")
    lb.Size=UDim2.new(1,-70,0,14)
    lb.Position=UDim2.new(0,12,0,4)
    lb.BackgroundTransparency=1
    lb.Text=text
    lb.TextColor3=CL.Tx
    lb.Font=Enum.Font.GothamMedium
    lb.TextSize=12
    lb.TextXAlignment=Enum.TextXAlignment.Left
    lb.Parent=cd
    local vl=Instance.new("TextLabel")
    vl.Size=UDim2.new(0,60,0,14)
    vl.Position=UDim2.new(1,-72,0,4)
    vl.BackgroundTransparency=1
    vl.Text=tostring(get())
    vl.TextColor3=CL.A
    vl.Font=Enum.Font.GothamBold
    vl.TextSize=12
    vl.TextXAlignment=Enum.TextXAlignment.Right
    vl.Parent=cd
    local m1=Instance.new("TextButton")
    m1.Size=UDim2.new(0,26,0,24)
    m1.Position=UDim2.new(0,12,0,26)
    m1.BackgroundColor3=Color3.fromRGB(55,55,68)
    m1.Text="-"
    m1.TextColor3=CL.Tx
    m1.Font=Enum.Font.GothamBold
    m1.TextSize=16
    m1.AutoButtonColor=false
    m1.Parent=cd
    Instance.new("UICorner",m1).CornerRadius=UDim.new(0,6)
    local p1=Instance.new("TextButton")
    p1.Size=UDim2.new(0,26,0,24)
    p1.Position=UDim2.new(1,-38,0,26)
    p1.BackgroundColor3=Color3.fromRGB(55,55,68)
    p1.Text="+"
    p1.TextColor3=CL.Tx
    p1.Font=Enum.Font.GothamBold
    p1.TextSize=14
    p1.AutoButtonColor=false
    p1.Parent=cd
    Instance.new("UICorner",p1).CornerRadius=UDim.new(0,6)
    local tr=Instance.new("Frame")
    tr.Size=UDim2.new(1,-88,0,16)
    tr.Position=UDim2.new(0,46,0,30)
    tr.BackgroundColor3=Color3.fromRGB(50,50,60)
    tr.BorderSizePixel=0
    tr.Parent=cd
    Instance.new("UICorner",tr).CornerRadius=UDim.new(0,8)
    local fl=Instance.new("Frame")
    fl.Size=UDim2.new((get()-mn)/(mx-mn),0,1,0)
    fl.BackgroundColor3=CL.A
    fl.BorderSizePixel=0
    fl.Parent=tr
    Instance.new("UICorner",fl).CornerRadius=UDim.new(1,0)
    local kn=Instance.new("Frame")
    kn.Size=UDim2.new(0,14,0,14)
    kn.Position=UDim2.new((get()-mn)/(mx-mn),-7,0.5,-7)
    kn.BackgroundColor3=Color3.fromRGB(255,255,255)
    kn.BorderSizePixel=0
    kn.Parent=tr
    Instance.new("UICorner",kn).CornerRadius=UDim.new(1,0)
    local function upd()
        local r=(get()-mn)/(mx-mn)
        fl.Size=UDim2.new(r,0,1,0)
        kn.Position=UDim2.new(r,-7,0.5,-7)
        vl.Text=tostring(get())
    end
    local function sv(v)
        v=math.clamp(math.floor(v+0.5),mn,mx)
        set(v)
        upd()
    end
    m1.Activated:Connect(function() sv(get()-step) end)
    p1.Activated:Connect(function() sv(get()+step) end)
    local th=Instance.new("TextButton")
    th.Size=UDim2.new(1,0,1,0)
    th.BackgroundTransparency=1
    th.Text=""
    th.AutoButtonColor=false
    th.Parent=tr
    th.MouseButton1Down:Connect(function(x)
        local tp=tr.AbsolutePosition
        local ts=tr.AbsoluteSize
        if ts.X<=0 then return end
        local r=math.clamp((x-tp.X)/ts.X,0,1)
        sv(mn+r*(mx-mn))
    end)
end

local function Sec(text,parent,ord)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,0,0,16)
    l.BackgroundTransparency=1
    l.Text=text
    l.TextColor3=CL.Tm
    l.Font=Enum.Font.GothamBold
    l.TextSize=10
    l.TextXAlignment=Enum.TextXAlignment.Left
    l.LayoutOrder=ord or 0
    l.Parent=parent
end

local function Act(text,parent,cb,ord,color)
    local bt=Instance.new("TextButton")
    bt.Size=UDim2.new(1,0,0,40)
    bt.BackgroundColor3=color or CL.Cd
    bt.Text=text
    bt.TextColor3=CL.Tx
    bt.Font=Enum.Font.GothamBold
    bt.TextSize=13
    bt.AutoButtonColor=false
    bt.LayoutOrder=ord or 0
    bt.Parent=parent
    Instance.new("UICorner",bt).CornerRadius=UDim.new(0,6)
    bt.Activated:Connect(cb)
    return bt
end

local pgM=mkTab("Misc","M",1,false)
local pgB=mkTab("Bhop","B",2,false)
local pgO=mkTab("Other","O",3,false)
local pgT=mkTab("Troll","T",4,true)

Tog("Infinite Jump",pgM,function() return C.InfJump end,function(v) C.InfJump=v end,10)

Tog("Bunny Hop",pgB,function() return C.BhopOn end,function(v) C.BhopOn=v if not v then bSpd=16 end end,10)
Sld("Max Speed",pgB,40,500,function() return C.BhopMax end,function(v) C.BhopMax=v end,11,10)
Sld("Acceleration",pgB,2,30,function() return C.BhopAccel end,function(v) C.BhopAccel=v end,12,1)

Tog("Spin",pgO,function() return C.SpinOn end,function(v) C.SpinOn=v end,10)
Sld("Spin Speed",pgO,5,50,function() return C.SpinSpeed end,function(v) C.SpinSpeed=v end,11,1)
Tog("Third Person",pgO,function() return C.TPVOn end,function(v)
    C.TPVOn=v
    if v then
        LP.CameraMode=Enum.CameraMode.Classic
        LP.CameraMinZoomDistance=10
        LP.CameraMaxZoomDistance=100
    else
        LP.CameraMode=Enum.CameraMode.LockFirstPerson
        LP.CameraMinZoomDistance=0.5
        LP.CameraMaxZoomDistance=0.5
    end
end,12)

Sec("COCONUT VISUALS",pgT,20)
Tog("Coconut Penis",pgT,function() return C.CocoP end,function(v) C.CocoP=v end,21)
Sld("Penis Length",pgT,1,20,function() return C.CocoPLen end,function(v) C.CocoPLen=v end,22,1)
Tog("Coconut Breasts",pgT,function() return C.CocoB end,function(v) C.CocoB=v end,23)
Tog("Coconut Butt",pgT,function() return C.CocoBt end,function(v) C.CocoBt=v end,24)

Sec("COCOON",pgT,25)
Tog("Coconut Cocoon",pgT,function() return C.CocoC end,function(v) C.CocoC=v end,26)
Sld("Cocoon Radius",pgT,2,10,function() return C.CocoCR end,function(v) C.CocoCR=v end,27,1)
Sld("Cocoon Density",pgT,10,80,function() return C.CocoCD end,function(v) C.CocoCD=v end,28,5)
Sld("Cocoon Spin",pgT,0,10,function() return C.CocoCS end,function(v) C.CocoCS=v end,29,1)

-- ROCKET
Sec("ROCKET",pgT,50)
local rGui=Instance.new("ScreenGui")
rGui.Name="RocketControlGui"
rGui.IgnoreGuiInset=true
rGui.DisplayOrder=1000
rGui.ResetOnSpawn=false
rGui.Enabled=true
pcall(function() rGui.Parent=CG end)
if not rGui.Parent then rGui.Parent=LP:WaitForChild("PlayerGui") end

local rocketHUD=Instance.new("Frame")
rocketHUD.Size=UDim2.new(1,0,1,0)
rocketHUD.BackgroundTransparency=1
rocketHUD.BorderSizePixel=0
rocketHUD.ClipsDescendants=true
rocketHUD.Visible=false
rocketHUD.Parent=rGui

local staticLayer=Instance.new("Frame")
staticLayer.Size=UDim2.new(1,0,1,0)
staticLayer.BackgroundTransparency=1
staticLayer.BorderSizePixel=0
staticLayer.Parent=rocketHUD

local noiseLines={}
for i=1,40 do
    local ln=Instance.new("Frame")
    ln.BackgroundColor3=Color3.fromRGB(255,255,255)
    ln.BackgroundTransparency=0.85
    ln.BorderSizePixel=0
    ln.Size=UDim2.new(1,0,0,math.random(1,3))
    ln.Position=UDim2.new(0,0,math.random()*0.98,0)
    ln.Parent=staticLayer
    noiseLines[i]={frame=ln,life=math.random()*0.3,speed=math.random(20,80)/100}
end

local recDot=Instance.new("Frame")
recDot.Size=UDim2.new(0,12,0,12)
recDot.Position=UDim2.new(0,50,0,60)
recDot.BackgroundColor3=Color3.fromRGB(255,50,50)
recDot.BorderSizePixel=0
recDot.Parent=rocketHUD
Instance.new("UICorner",recDot).CornerRadius=UDim.new(1,0)

local recTxt=Instance.new("TextLabel")
recTxt.Size=UDim2.new(0,100,0,40)
recTxt.Position=UDim2.new(0,70,0,50)
recTxt.BackgroundTransparency=1
recTxt.Text="REC"
recTxt.TextColor3=CL.CW
recTxt.Font=Enum.Font.GothamBold
recTxt.TextSize=28
recTxt.TextXAlignment=Enum.TextXAlignment.Left
recTxt.Parent=rocketHUD
local rs1=Instance.new("UIStroke",recTxt)
rs1.Color=Color3.fromRGB(0,0,0)
rs1.Thickness=2

local tcTxt=Instance.new("TextLabel")
tcTxt.Size=UDim2.new(0,300,0,30)
tcTxt.Position=UDim2.new(0.5,-150,0,60)
tcTxt.BackgroundTransparency=1
tcTxt.Text="00:00:00:00"
tcTxt.TextColor3=CL.CW
tcTxt.Font=Enum.Font.GothamBold
tcTxt.TextSize=22
tcTxt.Parent=rocketHUD
local rs2=Instance.new("UIStroke",tcTxt)
rs2.Color=Color3.fromRGB(0,0,0)
rs2.Thickness=2

local sC=Instance.new("Frame")
sC.Size=UDim2.new(0,60,0,160)
sC.Position=UDim2.new(0,30,0.5,-80)
sC.BackgroundColor3=Color3.fromRGB(0,0,0)
sC.BackgroundTransparency=0.5
sC.BorderSizePixel=0
sC.Parent=rocketHUD
Instance.new("UICorner",sC).CornerRadius=UDim.new(0,6)

local bU=Instance.new("TextButton")
bU.Size=UDim2.new(1,-10,0,40)
bU.Position=UDim2.new(0,5,0,5)
bU.BackgroundColor3=Color3.fromRGB(0,150,0)
bU.TextColor3=CL.CW
bU.TextSize=24
bU.Font=Enum.Font.GothamBold
bU.Text="+"
bU.Parent=sC
Instance.new("UICorner",bU).CornerRadius=UDim.new(0,6)

local sL=Instance.new("TextLabel")
sL.Size=UDim2.new(1,0,0,50)
sL.Position=UDim2.new(0,0,0,50)
sL.BackgroundTransparency=1
sL.TextColor3=CL.CW
sL.TextSize=18
sL.Font=Enum.Font.GothamBold
sL.Text=tostring(C.RocketSpd)
sL.Parent=sC

local bD=Instance.new("TextButton")
bD.Size=UDim2.new(1,-10,0,40)
bD.Position=UDim2.new(0,5,1,-45)
bD.BackgroundColor3=Color3.fromRGB(0,150,0)
bD.TextColor3=CL.CW
bD.TextSize=24
bD.Font=Enum.Font.GothamBold
bD.Text="-"
bD.Parent=sC
Instance.new("UICorner",bD).CornerRadius=UDim.new(0,6)

bU.Activated:Connect(function()
    C.RocketSpd=math.clamp(C.RocketSpd+10,C.RocketMin,C.RocketMax)
    sL.Text=tostring(C.RocketSpd)
end)
bD.Activated:Connect(function()
    C.RocketSpd=math.clamp(C.RocketSpd-10,C.RocketMin,C.RocketMax)
    sL.Text=tostring(C.RocketSpd)
end)

local hudStart=tick()
local hudActive=false

RS.RenderStepped:Connect(function(dt)
    if not hudActive then return end
    local elapsed=tick()-hudStart
    local h=math.floor(elapsed/3600)
    local m=math.floor((elapsed%3600)/60)
    local s=math.floor(elapsed%60)
    local f=math.floor((elapsed*30)%30)
    tcTxt.Text=string.format("%02d:%02d:%02d:%02d",h,m,s,f)
    recDot.BackgroundTransparency=(math.floor(elapsed*2)%2==0) and 0 or 1

    for _,entry in ipairs(noiseLines) do
        local ln=entry.frame
        entry.life=entry.life-dt
        if entry.life<=0 then
            entry.life=math.random(3,15)/100
            entry.speed=math.random(40,160)/100
            ln.Size=UDim2.new(1,0,0,math.random(1,3))
            ln.Position=UDim2.new(0,0,math.random()*0.98,0)
            ln.BackgroundTransparency=math.random(70,95)/100
            if math.random()<0.15 then
                ln.BackgroundTransparency=math.random(20,50)/100
            end
        else
            local newY=ln.Position.Y.Scale-dt*entry.speed
            if newY<0 then newY=1 end
            ln.Position=UDim2.new(0,0,newY,0)
        end
    end
end)

local rSt=Instance.new("TextLabel")
rSt.Size=UDim2.new(1,0,0,44)
rSt.BackgroundColor3=CL.Cd
rSt.Text="Searching rocket..."
rSt.TextColor3=CL.O
rSt.Font=Enum.Font.Gotham
rSt.TextSize=10
rSt.TextWrapped=true
rSt.TextXAlignment=Enum.TextXAlignment.Center
rSt.TextYAlignment=Enum.TextYAlignment.Center
rSt.LayoutOrder=51
rSt.Visible=false
rSt.Parent=pgT
Instance.new("UICorner",rSt).CornerRadius=UDim.new(0,6)
local rH={rSt}

local function fR()
    if not LP.Character then return nil end
    local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local cs={}
    for _,f in pairs(WS:GetChildren()) do
        if f.Name:find("SpawnedInToys") then
            for _,o in pairs(f:GetChildren()) do
                if o.Name=="BombMissile" then table.insert(cs,o) end
            end
        end
    end
    local cl,sh=nil,30
    for _,r in pairs(cs) do
        local p=r:IsA("BasePart") and r or (r.PrimaryPart or r:FindFirstChildWhichIsA("BasePart"))
        if p then
            local d=(p.Position-hrp.Position).Magnitude
            if d<=sh then sh=d cl=r end
        end
    end
    return cl
end

local rA,rMP,rBv,rBg
local rY,rP,rLTP=0,0,nil
local rCD=0
local rFP=false

local function aR(f)
    if rA then return end
    rA=f
    rMP=f:IsA("BasePart") and f or (f.PrimaryPart or f:FindFirstChildWhichIsA("BasePart"))
    if not rMP then rA=nil return end
    rBv=rMP:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity")
    rBv.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
    rBv.Parent=rMP
    rBg=rMP:FindFirstChild("BodyGyro") or Instance.new("BodyGyro")
    rBg.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
    rBg.D=150
    rBg.P=5000
    rBg.Parent=rMP
    Cam.CameraType=Enum.CameraType.Scriptable
    rSt.Text="Attached!"
    rSt.TextColor3=CL.G
    rocketHUD.Visible=true
    hudActive=true
    hudStart=tick()
    rGui.Enabled=true
end

local function dR()
    if rA then
        for _,p in ipairs(rA:GetDescendants()) do
            if p:IsA("BasePart") then p.LocalTransparencyModifier=0 end
        end
    end
    rA,rMP,rCD=nil,nil,1.5
    Cam.CameraType=Enum.CameraType.Custom
    if LP.Character then
        local h=LP.Character:FindFirstChildOfClass("Humanoid")
        if h then Cam.CameraSubject=h end
    end
    rocketHUD.Visible=false
    hudActive=false
end

Tog("Enable Rocket",pgT,function() return C.RocketOn end,function(v)
    C.RocketOn=v
    if v then
        for _,e in ipairs(rH) do e.Visible=true end
        rSt.Text="Searching rocket..."
        rCD=0
    else
        for _,e in ipairs(rH) do e.Visible=false end
        dR()
    end
end,52)

local ba=Act("ATTACH",pgT,function()
    if not C.RocketOn or rA then return end
    local f=fR()
    if f then aR(f) else rSt.Text="Not found" end
end,53,CL.Ad)
ba.Visible=false
table.insert(rH,ba)

local bd=Act("DETACH",pgT,function()
    if not C.RocketOn then return end
    if rA then dR() end
end,54,Color3.fromRGB(90,95,115))
bd.Visible=false
table.insert(rH,bd)

local vB=Instance.new("TextButton")
vB.Size=UDim2.new(0,140,0,30)
vB.Position=UDim2.new(1,-170,1,-40)
vB.BackgroundColor3=Color3.fromRGB(80,40,140)
vB.TextColor3=CL.CW
vB.TextSize=12
vB.Font=Enum.Font.GothamBold
vB.Text="VIEW 3-E"
vB.Parent=rocketHUD
Instance.new("UICorner",vB).CornerRadius=UDim.new(0,6)

vB.Activated:Connect(function()
    rFP=not rFP
    vB.Text=rFP and "VIEW 1-E" or "VIEW 3-E"
end)

UIS.TouchStarted:Connect(function(t)
    if not C.RocketOn then return end
    rLTP=t.Position
end)
UIS.TouchMoved:Connect(function(t)
    if not C.RocketOn then return end
    if rLTP then
        local d=t.Position-rLTP
        rY=rY-d.X*0.004
        rP=math.clamp(rP-d.Y*0.004,-1.4,1.4)
        rLTP=t.Position
    end
end)
UIS.TouchEnded:Connect(function() rLTP=nil end)

RS.RenderStepped:Connect(function(dt)
    if not C.RocketOn then return end
    if rCD>0 then rCD=rCD-dt end
    if rA and (not rA.Parent or not rMP or not rMP.Parent) then
        for _,p in ipairs(rA:GetDescendants()) do
            if p:IsA("BasePart") then p.LocalTransparencyModifier=0 end
        end
        rA,rMP=nil,nil
        Cam.CameraType=Enum.CameraType.Custom
        if LP.Character then
            local h=LP.Character:FindFirstChildOfClass("Humanoid")
            if h then Cam.CameraSubject=h end
        end
        rocketHUD.Visible=false
        hudActive=false
    end
    if not rA and rCD<=0 then
        local f=fR()
        if f then aR(f) end
    end
    if rA and rMP and rMP.Parent then
        local aim=CFrame.Angles(0,rY,0)*CFrame.Angles(rP,0,0)
        local dir=aim.LookVector
        if rBg and rBg.Parent then
            rBg.CFrame=CFrame.new(rMP.Position,rMP.Position+dir)*CFrame.Angles(math.rad(-90),0,0)
        end
        if rBv and rBv.Parent then rBv.Velocity=dir*C.RocketSpd end
        if rFP then
            for _,p in ipairs(rA:GetDescendants()) do
                if p:IsA("BasePart") then p.LocalTransparencyModifier=1 end
            end
            local n=dir*((math.max(rMP.Size.X,rMP.Size.Y,rMP.Size.Z)/2)+0.5)
            local np=rMP.Position+n
            Cam.CFrame=CFrame.new(np,np+dir)
        else
            for _,p in ipairs(rA:GetDescendants()) do
                if p:IsA("BasePart") then p.LocalTransparencyModifier=0 end
            end
            Cam.CFrame=CFrame.new(rMP.Position)*aim*CFrame.new(0,3,10)
        end
    end
end)

-- PLAYERS
Sec("PLAYERS",pgT,60)
local fSt=Instance.new("TextLabel")
fSt.Size=UDim2.new(1,0,0,26)
fSt.BackgroundColor3=CL.Cd
fSt.Text="Status: idle"
fSt.TextColor3=CL.Td
fSt.Font=Enum.Font.GothamMedium
fSt.TextSize=12
fSt.LayoutOrder=61
fSt.Parent=pgT
Instance.new("UICorner",fSt).CornerRadius=UDim.new(0,6)

local stopRow=Instance.new("Frame")
stopRow.Size=UDim2.new(1,0,0,30)
stopRow.BackgroundTransparency=1
stopRow.LayoutOrder=62
stopRow.Parent=pgT
local sLay=Instance.new("UIListLayout",stopRow)
sLay.FillDirection=Enum.FillDirection.Horizontal
sLay.Padding=UDim.new(0,6)
sLay.SortOrder=Enum.SortOrder.LayoutOrder

local orbitTarget=nil
local orbitRad=8
local orbitSpd=2.5
local orbitAng=0
local orbitBP,orbitBG

local function sF()
    fTgt=nil
    if fBP then fBP:Destroy() end
    if fBG then fBG:Destroy() end
    fBP,fBG=nil,nil
    fSt.Text="Status: idle"
    fSt.TextColor3=CL.Td
end

local function sO()
    orbitTarget=nil
    if orbitBP then orbitBP:Destroy() end
    if orbitBG then orbitBG:Destroy() end
    orbitBP,orbitBG=nil,nil
    if not fTgt then
        fSt.Text="Status: idle"
        fSt.TextColor3=CL.Td
    end
end

local function mkStopBtn(text,cb,ord)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0.5,-3,1,0)
    b.BackgroundColor3=Color3.fromRGB(70,45,45)
    b.Text=text
    b.TextColor3=CL.Tx
    b.Font=Enum.Font.GothamBold
    b.TextSize=11
    b.AutoButtonColor=false
    b.LayoutOrder=ord or 0
    b.Parent=stopRow
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    b.Activated:Connect(cb)
    return b
end

mkStopBtn("Stop Follow",function() sF() end,1)
mkStopBtn("Stop Orbit",function() sO() end,2)

Sld("Orbit Speed",pgT,1,10,function() return orbitSpd end,function(v) orbitSpd=v end,63,1)
Sld("Orbit Radius",pgT,3,20,function() return orbitRad end,function(v) orbitRad=v end,64,1)

local listWrap=Instance.new("Frame")
listWrap.Size=UDim2.new(1,0,0,260)
listWrap.BackgroundTransparency=1
listWrap.LayoutOrder=65
listWrap.Parent=pgT

local fSL=Instance.new("ScrollingFrame")
fSL.Size=UDim2.new(1,0,1,0)
fSL.BackgroundColor3=CL.Ct
fSL.BackgroundTransparency=0.3
fSL.BorderSizePixel=0
fSL.ScrollBarThickness=8
fSL.ScrollBarImageColor3=CL.A
fSL.CanvasSize=UDim2.new(0,0,0,0)
fSL.AutomaticCanvasSize=Enum.AutomaticSize.Y
fSL.ScrollingDirection=Enum.ScrollingDirection.Y
fSL.Parent=listWrap
Instance.new("UICorner",fSL).CornerRadius=UDim.new(0,8)
local LL=Instance.new("UIListLayout",fSL)
LL.Padding=UDim.new(0,4)
LL.SortOrder=Enum.SortOrder.Name
local pd=Instance.new("UIPadding",fSL)
pd.PaddingTop=UDim.new(0,6)
pd.PaddingLeft=UDim.new(0,6)
pd.PaddingRight=UDim.new(0,6)
pd.PaddingBottom=UDim.new(0,6)

local pb={}
local function upPL()
    for _,d in pairs(pb) do
        if d and d.f and d.f.Parent then d.f:Destroy() end
    end
    pb={}
    local players=Pl:GetPlayers()
    table.sort(players,function(a,b) return a.Name:lower()<b.Name:lower() end)
    for _,plr in ipairs(players) do
        if plr~=LP then
            local rw=Instance.new("Frame")
            rw.Size=UDim2.new(1,-4,0,44)
            rw.BackgroundColor3=CL.Cd
            rw.BorderSizePixel=0
            rw.Parent=fSL
            Instance.new("UICorner",rw).CornerRadius=UDim.new(0,6)

            local av=Instance.new("ImageLabel")
            av.Size=UDim2.new(0,32,0,32)
            av.Position=UDim2.new(0,6,0.5,-16)
            av.BackgroundColor3=Color3.fromRGB(50,50,60)
            av.BorderSizePixel=0
            av.Image="rbxthumb://type=AvatarHeadShot&id="..plr.UserId.."&w=48&h=48"
            av.Parent=rw
            Instance.new("UICorner",av).CornerRadius=UDim.new(0,16)

            local nl=Instance.new("TextLabel")
            nl.Size=UDim2.new(0,100,0,14)
            nl.Position=UDim2.new(0,44,0,6)
            nl.BackgroundTransparency=1
            nl.Text=plr.Name
            nl.TextColor3=CL.Tx
            nl.Font=Enum.Font.GothamBold
            nl.TextSize=11
            nl.TextXAlignment=Enum.TextXAlignment.Left
            nl.TextTruncate=Enum.TextTruncate.AtEnd
            nl.Parent=rw

            local dl=Instance.new("TextLabel")
            dl.Size=UDim2.new(0,100,0,12)
            dl.Position=UDim2.new(0,44,0,22)
            dl.BackgroundTransparency=1
            dl.Text=""
            dl.TextColor3=CL.Tm
            dl.Font=Enum.Font.Gotham
            dl.TextSize=9
            dl.TextXAlignment=Enum.TextXAlignment.Left
            dl.Parent=rw

            local function updDist()
                if plr.Character and LP.Character then
                    local thrp=plr.Character:FindFirstChild("HumanoidRootPart")
                    local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
                    if thrp and hrp then
                        dl.Text=string.format("%.0f studs",(thrp.Position-hrp.Position).Magnitude)
                    end
                end
            end
            updDist()

            local btnW=52
            local btnGap=4
            local baseX=-(btnW*3+btnGap*2)-6

            local fb=Instance.new("TextButton")
            fb.Size=UDim2.new(0,btnW,0,26)
            fb.Position=UDim2.new(1,baseX,0.5,-13)
            fb.BackgroundColor3=CL.Ad
            fb.Text="Follow"
            fb.TextColor3=Color3.fromRGB(255,255,255)
            fb.Font=Enum.Font.GothamBold
            fb.TextSize=9
            fb.AutoButtonColor=false
            fb.Parent=rw
            Instance.new("UICorner",fb).CornerRadius=UDim.new(0,5)

            local ob=Instance.new("TextButton")
            ob.Size=UDim2.new(0,btnW,0,26)
            ob.Position=UDim2.new(1,baseX+btnW+btnGap,0.5,-13)
            ob.BackgroundColor3=Color3.fromRGB(180,120,40)
            ob.Text="Orbit"
            ob.TextColor3=Color3.fromRGB(255,255,255)
            ob.Font=Enum.Font.GothamBold
            ob.TextSize=9
            ob.AutoButtonColor=false
            ob.Parent=rw
            Instance.new("UICorner",ob).CornerRadius=UDim.new(0,5)

            local tb=Instance.new("TextButton")
            tb.Size=UDim2.new(0,btnW,0,26)
            tb.Position=UDim2.new(1,baseX+(btnW+btnGap)*2,0.5,-13)
            tb.BackgroundColor3=Color3.fromRGB(60,160,80)
            tb.Text="TP"
            tb.TextColor3=Color3.fromRGB(255,255,255)
            tb.Font=Enum.Font.GothamBold
            tb.TextSize=10
            tb.AutoButtonColor=false
            tb.Parent=rw
            Instance.new("UICorner",tb).CornerRadius=UDim.new(0,5)

            local function refresh()
                if fTgt==plr then
                    fb.BackgroundColor3=CL.G
                    fb.Text="Active"
                else
                    fb.BackgroundColor3=CL.Ad
                    fb.Text="Follow"
                end
                if orbitTarget==plr then
                    ob.BackgroundColor3=CL.G
                    ob.Text="Orbit!"
                else
                    ob.BackgroundColor3=Color3.fromRGB(180,120,40)
                    ob.Text="Orbit"
                end
            end
            refresh()

            fb.Activated:Connect(function()
                if fTgt==plr then
                    sF()
                else
                    sF()
                    fTgt=plr
                    fSt.Text="Following: "..plr.Name
                    fSt.TextColor3=CL.G
                    local ch2=LP.Character
                    if not ch2 or not ch2:FindFirstChild("HumanoidRootPart") then return end
                    local hrp=ch2.HumanoidRootPart
                    fBP=Instance.new("BodyPosition")
                    fBP.MaxForce=Vector3.new(1e5,1e5,1e5)
                    fBP.Position=hrp.Position
                    fBP.D=300
                    fBP.P=5000
                    fBP.Parent=hrp
                    fBG=Instance.new("BodyGyro")
                    fBG.MaxTorque=Vector3.new(0,1e5,0)
                    fBG.CFrame=hrp.CFrame
                    fBG.D=200
                    fBG.P=3000
                    fBG.Parent=hrp
                end
                for _,d in pairs(pb) do if d.refresh then d.refresh() end end
            end)

            ob.Activated:Connect(function()
                if orbitTarget==plr then
                    sO()
                else
                    sO()
                    orbitTarget=plr
                    orbitAng=0
                    fSt.Text="Orbiting: "..plr.Name
                    fSt.TextColor3=Color3.fromRGB(255,180,60)
                    local ch2=LP.Character
                    if not ch2 or not ch2:FindFirstChild("HumanoidRootPart") then return end
                    local hrp=ch2.HumanoidRootPart
                    orbitBP=Instance.new("BodyPosition")
                    orbitBP.MaxForce=Vector3.new(1e5,1e5,1e5)
                    orbitBP.Position=hrp.Position
                    orbitBP.D=300
                    orbitBP.P=5000
                    orbitBP.Parent=hrp
                    orbitBG=Instance.new("BodyGyro")
                    orbitBG.MaxTorque=Vector3.new(1e5,1e5,1e5)
                    orbitBG.CFrame=hrp.CFrame
                    orbitBG.D=200
                    orbitBG.P=3000
                    orbitBG.Parent=hrp
                end
                for _,d in pairs(pb) do if d.refresh then d.refresh() end end
            end)

            tb.Activated:Connect(function()
                local ch2=LP.Character
                if not ch2 then return end
                local hrp=ch2:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local tch=plr.Character
                if not tch then return end
                local thrp=tch:FindFirstChild("HumanoidRootPart")
                if not thrp then return end
                local tpos=thrp.Position
                local rp=RaycastParams.new()
                rp.FilterType=Enum.RaycastFilterType.Exclude
                rp.FilterDescendantsInstances={ch2}
                local res=WS:Raycast(tpos+Vector3.new(0,10,0),Vector3.new(0,-50,0),rp)
                local y=tpos.Y
                if res then y=res.Position.Y+3 end
                local tOri=thrp.Orientation.Y
                hrp.CFrame=CFrame.new(tpos.X,y,tpos.Z)*CFrame.Angles(0,math.rad(tOri),0)
            end)

            table.insert(pb,{f=rw,refresh=refresh,_dist=upDist})
        end
    end
end

conns[#conns+1]=Pl.PlayerAdded:Connect(function() task.wait(0.1) upPL() end)
conns[#conns+1]=Pl.PlayerRemoving:Connect(function(plr)
    if fTgt==plr then sF() end
    if orbitTarget==plr then sO() end
    task.wait(0.1) upPL()
end)
upPL()

task.spawn(function()
    while task.wait(0.5) do
        for _,d in ipairs(pb) do
            if d._dist then pcall(d._dist) end
        end
    end
end)

-- ============================================================
--   BREAK SAFEZONE (Troll)
-- ============================================================
Sec("BREAK SAFEZONE",pgT,70)

local BSZLabel=Instance.new("TextLabel")
BSZLabel.Size=UDim2.new(1,0,0,20)
BSZLabel.BackgroundColor3=CL.Cd
BSZLabel.Text="Break SZ: idle"
BSZLabel.TextColor3=CL.Td
BSZLabel.Font=Enum.Font.Gotham
BSZLabel.TextSize=11
BSZLabel.LayoutOrder=71
BSZLabel.Parent=pgT
Instance.new("UICorner",BSZLabel).CornerRadius=UDim.new(0,6)

do
local BSZ_MenuToys=RSt:FindFirstChild("MenuToys")
local BSZ_spawnRF=BSZ_MenuToys and BSZ_MenuToys:FindFirstChild("SpawnToyRemoteFunction")
local BSZ_destroyToy=BSZ_MenuToys and BSZ_MenuToys:FindFirstChild("DestroyToy")
local BSZ_GE=RSt:FindFirstChild("GrabEvents")
local BSZ_SetNetworkOwner=BSZ_GE and BSZ_GE:FindFirstChild("SetNetworkOwner")

local function bszNotify(txt,sec)
    BSZLabel.Text=txt
    BSZLabel.TextColor3=CL.O
    if sec then
        task.delay(sec,function()
            if BSZLabel.Text==txt then
                BSZLabel.Text="Break SZ: idle"
                BSZLabel.TextColor3=CL.Td
            end
        end)
    end
end

local function bszGetSnowballs()
    local out={}
    local f=WS:FindFirstChild(LP.Name.."SpawnedInToys")
    if f then
        for _,t in ipairs(f:GetChildren()) do
            if t.Name=="BallSnowball" then table.insert(out,t) end
        end
    end
    return out
end

local function bszSpawnSnowball()
    if not BSZ_spawnRF then return end
    local cf=CFrame.new(263.5,-4.5,486.9)
    task.spawn(function()
        pcall(function()
            BSZ_spawnRF:InvokeServer("BallSnowball",cf,Vector3.new(0,-120.21099853515625,0))
        end)
    end)
end

local function bszClaimSnowball(s)
    if not BSZ_SetNetworkOwner then return end
    local sp=s:FindFirstChild("SoundPart")
    if sp then
        task.spawn(function()
            pcall(function() BSZ_SetNetworkOwner:FireServer(sp,sp.CFrame) end)
        end)
    end
end

local function bszTeleportSnowballs(list)
    local target=CFrame.new(264.5792541503906,-5.477070331573486,433.4557800292969)
    for _,s in ipairs(list) do
        task.spawn(function()
            for _,p in ipairs(s:GetDescendants()) do
                if p:IsA("BasePart") then p.CFrame=target end
            end
        end)
    end
end

local function bszTestOven()
    if not BSZ_spawnRF then return false end
    local target=CFrame.new(242.66055297851562,-9.196549415588379,444.3758850097656)
    pcall(function()
        BSZ_spawnRF:InvokeServer("OvenDarkGray",target,Vector3.new(0,-74.0790023803711,0))
    end)
    task.wait(0.5)
    local f=WS:FindFirstChild(LP.Name.."SpawnedInToys")
    if not f then return false end
    for _,c in ipairs(f:GetChildren()) do
        if c.Name=="OvenDarkGray" and c:GetAttribute("AtSpawned")==nil then
            return true
        end
    end
    return false
end

local function bszCleanup()
    if not BSZ_destroyToy then return end
    local f=WS:FindFirstChild(LP.Name.."SpawnedInToys")
    if f then
        for _,item in ipairs(f:GetChildren()) do
            if item.Name=="BallSnowball" or item.Name=="OvenDarkGray" then
                pcall(function() BSZ_destroyToy:FireServer(item) end)
            end
        end
    end
end

local function bszSetAntiBarrier(val)
    local plots=WS:FindFirstChild("Plots")
    if not plots then return end
    for _,plot in ipairs(plots:GetChildren()) do
        local barrierModel=plot:FindFirstChild("Barrier")
        if barrierModel then
            for _,part in ipairs(barrierModel:GetChildren()) do
                if part:IsA("BasePart") and part.Name=="PlotBarrier" then
                    part.CanCollide=not val
                end
            end
        end
    end
end

Act("Break SafeZone",pgT,function()
    task.spawn(function()
        bszNotify("Break SZ: breaking barrier...",3)
        bszSetAntiBarrier(true)
        local t0=tick()
        local broken=false
        while (tick()-t0)<15 and not broken do
            local sb=bszGetSnowballs()
            if #sb<2 then
                if #sb<1 then
                    bszSpawnSnowball()
                    task.wait(0.02)
                end
                bszSpawnSnowball()
                task.wait(0.02)
                sb=bszGetSnowballs()
            end
            if #sb==2 then
                for _,s in ipairs(sb) do bszClaimSnowball(s) end
                bszTeleportSnowballs(sb)
                if bszTestOven() then
                    broken=true
                else
                    task.wait(0.05)
                end
            end
            task.wait(0.05)
        end
        bszCleanup()
        if broken then
            bszNotify("Break SZ: broken + AntiBarrier ON",3)
        else
            bszNotify("Break SZ: AntiBarrier ON (snowballs failed)",3)
        end
    end)
end,72,Color3.fromRGB(180,60,60))
end

-- ============================================================
--   ANTI GRAB
-- ============================================================
local antiGrabRS=game:GetService("ReplicatedStorage")
local antiGrabProc=false
local antiGrabConns={}

local agLabel=Instance.new("TextLabel")
agLabel.Size=UDim2.new(1,0,0,20)
agLabel.BackgroundColor3=CL.Cd
agLabel.Text="Anti Grab: idle"
agLabel.TextColor3=CL.Td
agLabel.Font=Enum.Font.Gotham
agLabel.TextSize=11
agLabel.LayoutOrder=22
agLabel.Parent=pgM
Instance.new("UICorner",agLabel).CornerRadius=UDim.new(0,6)

local function agStruggle()
    local ce=antiGrabRS:FindFirstChild("CharacterEvents")
    return ce and ce:FindFirstChild("Struggle")
end

local function agRagRemote()
    local ce=antiGrabRS:FindFirstChild("CharacterEvents")
    return ce and ce:FindFirstChild("RagdollRemote")
end

local function agDisableRag(char)
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name~="Head" then
            v.BallSocketConstraint.Enabled=false
            if v:FindFirstChild("RagdollLimbPart") then
                v.RagdollLimbPart.WeldConstraint.Enabled=false
            end
        end
    end
end

local function agEnableRag(char)
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") and v:FindFirstChild("BallSocketConstraint") and v.Name~="Head" then
            v.BallSocketConstraint.Enabled=true
            if v:FindFirstChild("RagdollLimbPart") then
                v.RagdollLimbPart.WeldConstraint.Enabled=true
            end
        end
    end
end

local function agApply(char)
    if not char then return end
    local hrp=char:FindFirstChild("HumanoidRootPart")
    local hum=char:FindFirstChild("Humanoid")
    local head=char:FindFirstChild("Head")
    if not (hrp and hum and head) then return end
    agDisableRag(char)

    if antiGrabConns.Head then antiGrabConns.Head:Disconnect() end
    antiGrabConns.Head=head.ChildAdded:Connect(function(po)
        if po.Name~="PartOwner" or antiGrabProc then return end
        antiGrabProc=true
        hum.Sit=false
        local struggle=agStruggle()
        local ragRemote=agRagRemote()
        hrp.Anchored=true
        agLabel.Text="Anti Grab: HELD - escaping"
        agLabel.TextColor3=CL.G
        task.spawn(function()
            while (head:FindFirstChild("PartOwner")) or (LP:FindFirstChild("IsHeld") and LP.IsHeld.Value) do
                if struggle then pcall(function() struggle:FireServer(LP) end) end
                if ragRemote then pcall(function() ragRemote:FireServer(hrp,0) end) end
                pcall(function()
                    hrp.CFrame=hrp.CFrame + hum.MoveDirection*(hum.WalkSpeed/60)
                    hum.PlatformStand=false
                    hum.Sit=false
                    hum.AutoRotate=true
                end)
                if hrp:FindFirstChild("WeldHRP") and hrp.WeldHRP.Enabled then
                    pcall(function() head.CFrame=hrp.CFrame+Vector3.new(0,1.35,0) end)
                end
                task.wait()
            end
            pcall(function() hrp.Anchored=false end)
            agLabel.Text="Anti Grab: escaping lines..."
            agLabel.TextColor3=CL.O
            task.spawn(function()
                task.wait(0.3)
                local ge=antiGrabRS:FindFirstChild("GrabEvents")
                local dgl=ge and ge:FindFirstChild("DestroyGrabLine")
                if dgl then
                    for _,plr in ipairs(Pl:GetPlayers()) do
                        if plr~=LP and plr.Character then
                            local tRoot=plr.Character:FindFirstChild("HumanoidRootPart")
                            local tHead=plr.Character:FindFirstChild("Head")
                            if tRoot then
                                for _=1,3 do pcall(function() dgl:FireServer(tRoot) end) end
                            end
                            if tHead then pcall(function() dgl:FireServer(tHead) end) end
                            for _,v in ipairs(plr.Character:GetDescendants()) do
                                if v.Name=="PartOwner" then
                                    pcall(function() dgl:FireServer(v.Parent) end)
                                end
                            end
                        end
                    end
                end
                agLabel.Text="Anti Grab: active"
                agLabel.TextColor3=CL.G
            end)
            antiGrabProc=false
        end)
    end)

    if antiGrabConns.Hum then antiGrabConns.Hum:Disconnect() end
    antiGrabConns.Hum=hum.Changed:Connect(function(prop)
        if prop=="Sit" and hum.Sit then
            if not (hum.SeatPart and hum.SeatPart.Parent and hum.SeatPart.Parent.Name=="CreatureBlobman") then
                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
                hum.Sit=false
            end
        end
    end)

    local weldHRP=hrp:FindFirstChild("WeldHRP")
    if weldHRP then
        if antiGrabConns.Weld then antiGrabConns.Weld:Disconnect() end
        antiGrabConns.Weld=weldHRP.Changed:Connect(function()
            if not hrp.WeldHRP.Enabled then return end
            task.spawn(function()
                while not hum.Sit do task.wait() end
                hum.Sit=false
                hum.AutoRotate=true
                while hrp.WeldHRP.Enabled do
                    pcall(function() head.CFrame=hrp.CFrame+Vector3.new(0,1.35,0) end)
                    task.wait()
                end
            end)
        end)
    end

    local ragdolled=hum:FindFirstChild("Ragdolled")
    if ragdolled then
        if antiGrabConns.Ragdoll then antiGrabConns.Ragdoll:Disconnect() end
        antiGrabConns.Ragdoll=ragdolled.Changed:Connect(function()
            if hum.Ragdolled.Value then
                agDisableRag(char)
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
            end
        end)
    end
    agLabel.Text="Anti Grab: active"
    agLabel.TextColor3=CL.G
end

local function agCleanup()
    for _,conn in pairs(antiGrabConns) do
        if conn then conn:Disconnect() end
    end
    antiGrabConns={}
    antiGrabProc=false
end

Tog("Anti Grab [BEST]",pgM,function() return _G.WM_AntiGrab end,function(v)
    _G.WM_AntiGrab=v
    if v then
        agCleanup()
        pcall(function() agApply(LP.Character) end)
        antiGrabConns.CharAdded=LP.CharacterAdded:Connect(function(newChar)
            task.wait(0.5)
            if _G.WM_AntiGrab then pcall(function() agApply(newChar) end) end
        end)
    else
        agCleanup()
        local char=LP.Character
        if char then
            agEnableRag(char)
            local hrp=char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.Anchored=false end
        end
        agLabel.Text="Anti Grab: idle"
        agLabel.TextColor3=CL.Td
    end
end,21)

-- ============================================================
--   COCONUTS (destroy on disable)
-- ============================================================
local cocoClaimTime={}
SNO=nil
local SpawnToy=nil
local trackedToys={}
local prevAnyCoco=false

local function destroyToy(toy)
    if toy and toy.Parent then pcall(function() toy:Destroy() end) end
end

local function destroyAllCoconuts()
    local folder=WS:FindFirstChild(LP.Name.."SpawnedInToys")
    if folder then
        for _,t in ipairs(folder:GetChildren()) do
            if t.Name=="FoodCoconut" then destroyToy(t) end
        end
    end
    for toy in pairs(trackedToys) do destroyToy(toy) end
    trackedToys={}
    cocoClaimTime={}
end

task.spawn(function()
    local GE=RSt:FindFirstChild("GrabEvents") or RSt:WaitForChild("GrabEvents",10)
    local MT=RSt:FindFirstChild("MenuToys") or RSt:WaitForChild("MenuToys",10)
    if not GE or not MT then return end
    SNO=GE:FindFirstChild("SetNetworkOwner")
    SpawnToy=MT:FindFirstChild("SpawnToyRemoteFunction")
    if not SpawnToy then return end

    local ct=0
    local spCount=0

    while true do
        task.wait(0.05)
        ct=ct+0.05
        spCount=spCount+1

        local pe=C.CocoP
        local be=C.CocoB
        local bue=C.CocoBt
        local ce=C.CocoC
        local anyCoco=pe or be or bue or ce

        if prevAnyCoco and not anyCoco then
            destroyAllCoconuts()
        end
        prevAnyCoco=anyCoco

        if anyCoco then
            local ch=LP.Character
            local rt=ch and ch:FindFirstChild("HumanoidRootPart")
            if rt then
                local len=C.CocoPLen
                local cc=C.CocoCD

                local folder=WS:FindFirstChild(LP.Name.."SpawnedInToys")
                if folder then
                    local aC={}
                    for _,t in ipairs(folder:GetChildren()) do
                        if t.Name=="FoodCoconut" then
                            table.insert(aC,t)
                        end
                    end

                    local need=0
                    if pe then need=need+len+2 end
                    if be then need=need+2 end
                    if bue then need=need+2 end
                    if ce then need=need+cc end
                    if #aC<need and spCount%10==0 then
                        pcall(function()
                            SpawnToy:InvokeServer("FoodCoconut",rt.CFrame*CFrame.new(-5,5,10),Vector3.new(0,0,0))
                        end)
                    end

                    local idx=1
                    local function placeC(toy,off)
                        local parts={}
                        for _,x in ipairs(toy:GetDescendants()) do
                            if x:IsA("BasePart") then table.insert(parts,x) end
                        end
                        if #parts==0 then return end

                        trackedToys[toy]=true

                        local last=cocoClaimTime[toy] or -999
                        if SNO and (ct-last)>0.3 then
                            for _,p in ipairs(parts) do
                                pcall(function() SNO:FireServer(p,p.CFrame) end)
                            end
                            cocoClaimTime[toy]=ct
                        end

                        local tc=rt.CFrame*off
                        if toy:IsA("Model") then
                            pcall(function() toy:PivotTo(tc) end)
                        else
                            if parts[1] then parts[1].CFrame=tc end
                        end
                        for _,p in ipairs(parts) do
                            p.Anchored=true
                            p.CanCollide=false
                            p.CanQuery=false
                            p.CanTouch=false
                        end
                    end

                    if pe then
                        local b={CFrame.new(-0.55,-1.2,-0.8),CFrame.new(0.55,-1.2,-0.8)}
                        for i=1,2 do
                            if aC[idx] then placeC(aC[idx],b[i]) idx=idx+1 end
                        end
                        for i=1,len do
                            if aC[idx] then
                                placeC(aC[idx],CFrame.new(0,-1.2,-0.8-(i*0.9)))
                                idx=idx+1
                            end
                        end
                    end
                    if be then
                        local o={CFrame.new(-0.6,0.5,-0.9),CFrame.new(0.6,0.5,-0.9)}
                        for i=1,2 do
                            if aC[idx] then placeC(aC[idx],o[i]) idx=idx+1 end
                        end
                    end
                    if bue then
                        local o={CFrame.new(-0.55,-1,0.75),CFrame.new(0.55,-1,0.75)}
                        for i=1,2 do
                            if aC[idx] then placeC(aC[idx],o[i]) idx=idx+1 end
                        end
                    end
                    if ce then
                        local ga=math.pi*(3-math.sqrt(5))
                        for i=1,cc do
                            if aC[idx] then
                                local y=1-(i/math.max(cc-1,1))*2
                                local r=math.sqrt(math.max(0,1-y*y))
                                local th=ga*i+(ct*C.CocoCS)
                                local off=CFrame.new(
                                    math.cos(th)*r*C.CocoCR,
                                    y*C.CocoCR,
                                    math.sin(th)*r*C.CocoCR
                                )
                                placeC(aC[idx],off)
                                idx=idx+1
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
--   FINALIZE
-- ============================================================
tabs[1].sel()

local BS=46
local MB=Instance.new("TextButton")
MB.Size=UDim2.new(0,BS,0,BS)
MB.Position=UDim2.new(0,15,0.5,-BS/2)
MB.BackgroundColor3=Color3.fromRGB(24,28,38)
MB.Text="W"
MB.TextColor3=Color3.fromRGB(200,240,200)
MB.Font=Enum.Font.GothamBold
MB.TextSize=20
MB.AutoButtonColor=false
MB.ZIndex=999
MB.Parent=SG
Instance.new("UICorner",MB).CornerRadius=UDim.new(0,14)
Instance.new("UIStroke",MB).Color=Color3.fromRGB(60,90,65)
MB.Activated:Connect(function() M.Visible=not M.Visible end)

conns[#conns+1]=UIS.JumpRequest:Connect(function()
    local ch=LP.Character
    if not ch then return end
    local h=ch:FindFirstChildOfClass("Humanoid")
    if h and C.InfJump then h:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

conns[#conns+1]=RS.Heartbeat:Connect(function(dt)
    local ch=LP.Character
    if not ch then return end
    local h=ch:FindFirstChildOfClass("Humanoid")
    local hrp=ch:FindFirstChild("HumanoidRootPart")
    if not h or not hrp then return end

    if fTgt then
        if not fTgt.Parent then sF()
        elseif fTgt.Character and fTgt.Character:FindFirstChild("Head") then
            local th=fTgt.Character.Head
            if fBP and fBP.Parent then fBP.Position=th.Position+Vector3.new(0,3,0) end
            if fBG and fBG.Parent then fBG.CFrame=th.CFrame end
        end
    end

    if orbitTarget then
        if not orbitTarget.Parent then sO()
        elseif orbitTarget.Character and orbitTarget.Character:FindFirstChild("HumanoidRootPart") then
            local thrp=orbitTarget.Character.HumanoidRootPart
            orbitAng=orbitAng+dt*orbitSpd
            local pos=thrp.Position+Vector3.new(
                math.cos(orbitAng)*orbitRad,
                3,
                math.sin(orbitAng)*orbitRad
            )
            if orbitBP and orbitBP.Parent then orbitBP.Position=pos end
            if orbitBG and orbitBG.Parent then
                orbitBG.CFrame=CFrame.new(pos,thrp.Position)
            end
        end
    end

    if C.SpinOn then
        hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(C.SpinSpeed*10),0)
    end
    if fTgt or orbitTarget or not C.BhopOn then
        bSpd=16
        bGrounded=true
        return
    end
    local st=h:GetState()
    local ig=st==Enum.HumanoidStateType.Landed
        or st==Enum.HumanoidStateType.Running
        or st==Enum.HumanoidStateType.RunningNoPhysics
        or st==Enum.HumanoidStateType.PlatformStanding
    if ig and not bGrounded then
        if h.MoveDirection.Magnitude>0.1 then
            local md=h.MoveDirection.Unit
            bSpd=math.min(bSpd+C.BhopAccel,C.BhopMax)
            h:ChangeState(Enum.HumanoidStateType.Jumping)
            hrp.AssemblyLinearVelocity=Vector3.new(
                md.X*bSpd,
                hrp.AssemblyLinearVelocity.Y+35,
                md.Z*bSpd
            )
        else
            bSpd=16
        end
    end
    if not ig and bSpd>16 then
        if h.MoveDirection.Magnitude>0.1 then
            local md=h.MoveDirection.Unit
            hrp.AssemblyLinearVelocity=Vector3.new(
                md.X*bSpd,
                hrp.AssemblyLinearVelocity.Y,
                md.Z*bSpd
            )
        end
    end
    bGrounded=ig
end)

conns[#conns+1]=UIS.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.RightShift then
        M.Visible=not M.Visible
    end
end)

conns[#conns+1]=LP.CharacterAdded:Connect(function()
    task.wait(1)
    if fTgt and fTgt.Parent then sF() end
    if orbitTarget and orbitTarget.Parent then sO() end
end)

print("[WM102] loaded")