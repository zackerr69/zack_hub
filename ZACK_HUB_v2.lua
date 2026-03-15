--[[
    ███████╗ █████╗  ██████╗██╗  ██╗    ██╗  ██╗██╗   ██╗██████╗ 
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝    ██║  ██║██║   ██║██╔══██╗
      ███╔╝ ███████║██║     █████╔╝     ███████║██║   ██║██████╔╝
     ███╔╝  ██╔══██║██║     ██╔═██╗     ██╔══██║██║   ██║██╔══██╗
    ███████╗██║  ██║╚██████╗██║  ██╗    ██║  ██║╚██████╔╝██████╔╝
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
    
    ZACK_HUB v2 | Universal | Delta X (iOS/Android)
    Чистый скрипт — никакой кражи данных.
--]]

-- ══════════════════════════════════════════════════════════
--  СЕРВИСЫ
-- ══════════════════════════════════════════════════════════
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local Debris           = game:GetService("Debris")
local CoreGui          = game:GetService("CoreGui")

local lp  = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- ══════════════════════════════════════════════════════════
--  ПЕРСОНАЖ
-- ══════════════════════════════════════════════════════════
local char, hum, root

local function refreshChar(c)
    char = c or lp.Character
    if not char then return end
    hum  = char:WaitForChild("Humanoid", 5)
    root = char:WaitForChild("HumanoidRootPart", 5)
end
refreshChar(lp.Character)

-- ══════════════════════════════════════════════════════════
--  СОСТОЯНИЯ
-- ══════════════════════════════════════════════════════════
local State = {
    -- MAIN
    fly        = false, flySpeed = 50,
    noclip     = false,
    infJump    = false,
    speed      = 16,
    gravity    = 196.2,
    headless   = false,
    aim        = false, aimRadius = 150,
    aimColor   = Color3.fromRGB(255,0,200),
    clicker    = false,
    tpTool     = false,

    -- VISUAL
    pinkSky    = false,
    spheres    = false,
    trail      = false,
    fullbright = false,
    jerk       = false,
    disco      = false,
    fps        = false,
    copter     = false,
    bigHead    = false,

    -- BOXES
    esp        = false,
    espBoxes   = false,
    espNames   = false,
    espHealth  = false,
    espDist    = false,
    espLines   = false,
    skeleton   = false,
    compass    = false,
    wallhack   = false,

    -- ЦВЕТА (для Color Changer)
    colFov     = Color3.fromRGB(255, 0, 255),
    colText    = Color3.fromRGB(255, 255, 255),
    colBorder  = Color3.fromRGB(10,  10,  10 ),
}

-- ══════════════════════════════════════════════════════════
--  УТИЛИТЫ
-- ══════════════════════════════════════════════════════════
local function rainbowColor(offset)
    return Color3.fromHSV(((tick() * 0.4) + (offset or 0)) % 1, 0.9, 1)
end

local function setToggle(btn, name, st)
    btn.Text = name .. ": " .. (st and "ON" or "OFF")
end

-- Tween-хелпер
local function tween(obj, t, props)
    TweenService:Create(obj, TweenInfo.new(t), props):Play()
end

-- ══════════════════════════════════════════════════════════
--  КОРЕНЬ GUI
-- ══════════════════════════════════════════════════════════
local sg = Instance.new("ScreenGui")
sg.Name           = "ZACK_HUB"
sg.ResetOnSpawn   = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent         = CoreGui

-- ══════════════════════════════════════════════════════════
--  ОКНО ВВОДА КЛЮЧА
-- ══════════════════════════════════════════════════════════
local KEY_VALID = "ZACK-FREE-2025"  -- меняй на свой

local keyGui = Instance.new("Frame")
keyGui.Parent             = sg
keyGui.BackgroundColor3   = Color3.fromRGB(255,255,255)
keyGui.BorderSizePixel    = 3
keyGui.BorderColor3       = Color3.fromRGB(10,10,10)
keyGui.Size               = UDim2.new(0,420,0,210)
keyGui.Position           = UDim2.new(0.5,-210,0.5,-105)
keyGui.Active             = true
keyGui.Draggable          = false

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0,8)
keyCorner.Parent = keyGui

-- Заголовок окна ключа
local keyTitle = Instance.new("TextLabel")
keyTitle.Parent             = keyGui
keyTitle.BackgroundTransparency = 1
keyTitle.Position           = UDim2.new(0,15,0,14)
keyTitle.Size               = UDim2.new(1,-30,0,32)
keyTitle.Font               = Enum.Font.GothamBold
keyTitle.Text               = "ZACK_HUB — ACTIVATION"
keyTitle.TextScaled          = true

-- Поле ввода
local keyBox = Instance.new("TextBox")
keyBox.Parent               = keyGui
keyBox.BackgroundColor3     = Color3.fromRGB(240,240,240)
keyBox.BorderSizePixel      = 2
keyBox.BorderColor3         = Color3.fromRGB(10,10,10)
keyBox.Position             = UDim2.new(0.05,0,0,58)
keyBox.Size                 = UDim2.new(0.9,0,0,42)
keyBox.Font                 = Enum.Font.Gotham
keyBox.PlaceholderText      = "KEY-HERE"
keyBox.Text                 = ""
keyBox.TextColor3           = Color3.fromRGB(20,20,20)
keyBox.TextScaled            = true
keyBox.ClearTextOnFocus     = false

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0,6)
keyBoxCorner.Parent = keyBox

-- Статус
local keyStatus = Instance.new("TextLabel")
keyStatus.Parent            = keyGui
keyStatus.BackgroundTransparency = 1
keyStatus.Position          = UDim2.new(0.05,0,0,106)
keyStatus.Size              = UDim2.new(0.9,0,0,24)
keyStatus.Font              = Enum.Font.Gotham
keyStatus.Text              = ""
keyStatus.TextColor3        = Color3.fromRGB(200,50,50)
keyStatus.TextScaled         = true

-- Кнопка VERIFY
local verifyBtn = Instance.new("TextButton")
verifyBtn.Parent            = keyGui
verifyBtn.BackgroundColor3  = Color3.fromRGB(20,20,20)
verifyBtn.BorderSizePixel   = 0
verifyBtn.Position          = UDim2.new(0.05,0,0,138)
verifyBtn.Size              = UDim2.new(0.42,0,0,42)
verifyBtn.Font              = Enum.Font.GothamBold
verifyBtn.Text              = "VERIFY"
verifyBtn.TextColor3        = Color3.fromRGB(255,255,255)
verifyBtn.TextScaled         = true
verifyBtn.AutoButtonColor   = false

local verifyCorner = Instance.new("UICorner")
verifyCorner.CornerRadius = UDim.new(0,6)
verifyCorner.Parent = verifyBtn

-- Кнопка GET KEY
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Parent            = keyGui
getKeyBtn.BackgroundColor3  = Color3.fromRGB(240,240,240)
getKeyBtn.BorderSizePixel   = 2
getKeyBtn.BorderColor3      = Color3.fromRGB(10,10,10)
getKeyBtn.Position          = UDim2.new(0.53,0,0,138)
getKeyBtn.Size              = UDim2.new(0.42,0,0,42)
getKeyBtn.Font              = Enum.Font.GothamBold
getKeyBtn.Text              = "GET KEY"
getKeyBtn.TextColor3        = Color3.fromRGB(20,20,20)
getKeyBtn.TextScaled         = true
getKeyBtn.AutoButtonColor   = false

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0,6)
getKeyCorner.Parent = getKeyBtn

-- Радужный заголовок
RunService.Heartbeat:Connect(function()
    if keyGui and keyGui.Parent then
        keyTitle.TextColor3 = rainbowColor(0)
        verifyBtn.BackgroundColor3 = rainbowColor(0.5)
    end
end)

getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard("https://t.me/sajkyn") end
    keyStatus.Text      = "📋 Ссылка скопирована!"
    keyStatus.TextColor3 = Color3.fromRGB(50,180,50)
end)

-- ══════════════════════════════════════════════════════════
--  ГЛАВНЫЙ HUB (скрыт до активации ключа)
-- ══════════════════════════════════════════════════════════
local hubVisible = false

-- ИКОНКА
local iconBtn = Instance.new("TextButton")
iconBtn.Parent            = sg
iconBtn.Size              = UDim2.new(0,80,0,80)
iconBtn.Position          = UDim2.new(1,-95,1,-95)
iconBtn.BackgroundColor3  = Color3.fromRGB(255,255,255)
iconBtn.BorderSizePixel   = 3
iconBtn.BorderColor3      = Color3.fromRGB(10,10,10)
iconBtn.Font              = Enum.Font.GothamBold
iconBtn.Text              = "Z_H"
iconBtn.TextScaled         = true
iconBtn.Draggable         = true
iconBtn.Active            = true
iconBtn.AutoButtonColor   = false
iconBtn.Visible           = false  -- появится после ключа

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0.3,0)
iconCorner.Parent = iconBtn

-- ГЛАВНОЕ ОКНО
local mainFrame = Instance.new("Frame")
mainFrame.Parent              = sg
mainFrame.BackgroundColor3    = Color3.fromRGB(255,255,255)
mainFrame.BorderSizePixel     = 3
mainFrame.BorderColor3        = Color3.fromRGB(10,10,10)
mainFrame.Position            = UDim2.new(0.5,-250,0.5,-230)
mainFrame.Size                = UDim2.new(0,500,0,460)
mainFrame.Active              = true
mainFrame.Draggable           = true
mainFrame.Visible             = false
mainFrame.ClipsDescendants    = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,8)
mainCorner.Parent = mainFrame

-- Заголовок
local titleLbl = Instance.new("TextLabel")
titleLbl.Parent               = mainFrame
titleLbl.BackgroundTransparency = 1
titleLbl.Position             = UDim2.new(0,15,0,10)
titleLbl.Size                 = UDim2.new(0,200,0,32)
titleLbl.Font                 = Enum.Font.GothamBold
titleLbl.Text                 = "ZACK_HUB"
titleLbl.TextScaled            = true

-- X и − кнопки
local function makeWindowBtn(text, xOffset, color)
    local b = Instance.new("TextButton")
    b.Parent            = mainFrame
    b.BackgroundTransparency = 1
    b.BorderSizePixel   = 2
    b.BorderColor3      = Color3.fromRGB(10,10,10)
    b.Size              = UDim2.new(0,30,0,30)
    b.Position          = UDim2.new(1,xOffset,0,10)
    b.Font              = Enum.Font.GothamBold
    b.Text              = text
    b.TextColor3        = color
    b.TextScaled         = true
    b.AutoButtonColor   = false
    return b
end

local closeBtn = makeWindowBtn("X",  -70, Color3.fromRGB(200,50,50))
local miniBtn  = makeWindowBtn("−",  -35, Color3.fromRGB(20,20,20))

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
miniBtn.MouseButton1Click:Connect(function()  mainFrame.Visible = false end)

-- Разделитель
local div = Instance.new("Frame")
div.Parent          = mainFrame
div.BackgroundColor3 = Color3.fromRGB(10,10,10)
div.BorderSizePixel = 0
div.Position        = UDim2.new(0,0,0,50)
div.Size            = UDim2.new(1,0,0,2)

-- Скролл
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Parent              = mainFrame
scrollFrame.Position            = UDim2.new(0,0,0,54)
scrollFrame.Size                = UDim2.new(1,0,1,-54)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel     = 0
scrollFrame.ScrollBarThickness  = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(10,10,10)
scrollFrame.CanvasSize          = UDim2.new(0,0,0,0)

local listLayout = Instance.new("UIListLayout")
listLayout.Parent              = scrollFrame
listLayout.FillDirection       = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.Padding             = UDim.new(0,4)
listLayout.SortOrder           = Enum.SortOrder.LayoutOrder

listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y+16)
end)

-- Иконка и открытие
iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        mainFrame.BackgroundTransparency = 1
        tween(mainFrame, 0.2, {BackgroundTransparency = 0})
    end
end)

-- Радужные элементы
RunService.Heartbeat:Connect(function()
    if iconBtn.Visible then
        iconBtn.TextColor3   = rainbowColor(0)
        iconBtn.BorderColor3 = rainbowColor(0.5)
    end
    if titleLbl.Parent then
        titleLbl.TextColor3 = rainbowColor(0)
    end
    if State.disco and mainFrame.Parent then
        mainFrame.BackgroundColor3 = Color3.fromHSV((tick()*0.3)%1, 0.08, 1)
    else
        mainFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
    end
end)

-- ══════════════════════════════════════════════════════════
--  АККОРДЕОН
-- ══════════════════════════════════════════════════════════
local function makeAccordion(title, order)
    local header = Instance.new("TextButton")
    header.Parent             = scrollFrame
    header.LayoutOrder        = order
    header.BackgroundColor3   = Color3.fromRGB(245,245,245)
    header.BorderSizePixel    = 2
    header.BorderColor3       = Color3.fromRGB(10,10,10)
    header.Size               = UDim2.new(0.96,0,0,42)
    header.Font               = Enum.Font.GothamBold
    header.Text               = "▶  " .. title
    header.TextXAlignment     = Enum.TextXAlignment.Left
    header.TextSize           = 15
    header.AutoButtonColor    = false

    local hCorner = Instance.new("UICorner")
    hCorner.CornerRadius = UDim.new(0,6)
    hCorner.Parent = header

    local body = Instance.new("Frame")
    body.Parent             = scrollFrame
    body.LayoutOrder        = order + 0.5
    body.BackgroundColor3   = Color3.fromRGB(252,252,252)
    body.BorderSizePixel    = 2
    body.BorderColor3       = Color3.fromRGB(10,10,10)
    body.Size               = UDim2.new(0.96,0,0,0)
    body.ClipsDescendants   = true
    body.Visible            = false

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0,6)
    bCorner.Parent = body

    local bLayout = Instance.new("UIListLayout")
    bLayout.Parent             = body
    bLayout.Padding            = UDim.new(0,4)
    bLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    bLayout.SortOrder          = Enum.SortOrder.LayoutOrder

    local bPad = Instance.new("UIPadding")
    bPad.Parent       = body
    bPad.PaddingTop   = UDim.new(0,6)
    bPad.PaddingBottom = UDim.new(0,6)

    local open = false

    local function recalc()
        if open then
            body.Size = UDim2.new(0.96,0,0, bLayout.AbsoluteContentSize.Y+14)
        end
    end
    bLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(recalc)

    local function toggle()
        open = not open
        header.Text = (open and "▼  " or "▶  ") .. title
        body.Visible = open
        if open then
            recalc()
        else
            body.Size = UDim2.new(0.96,0,0,0)
        end
    end
    header.MouseButton1Click:Connect(toggle)

    RunService.Heartbeat:Connect(function()
        if header and header.Parent then
            header.TextColor3 = rainbowColor(order * 0.12)
        end
    end)

    return body, bLayout
end

local mainBody,   _ = makeAccordion("MAIN",   1)
local visualBody, _ = makeAccordion("VISUAL", 3)
local boxesBody,  _ = makeAccordion("BOXES",  5)

-- ══════════════════════════════════════════════════════════
--  ХЕЛПЕРЫ ДЛЯ КНОПОК
-- ══════════════════════════════════════════════════════════
local function addBtn(parent, text, order)
    local btn = Instance.new("TextButton")
    btn.Parent              = parent
    btn.LayoutOrder         = order
    btn.BackgroundColor3    = Color3.fromRGB(255,255,255)
    btn.BorderSizePixel     = 2
    btn.BorderColor3        = Color3.fromRGB(10,10,10)
    btn.Size                = UDim2.new(0.92,0,0,38)
    btn.Font                = Enum.Font.GothamBold
    btn.Text                = text
    btn.TextScaled           = true
    btn.AutoButtonColor     = false

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0,6)
    bc.Parent = btn

    btn.MouseEnter:Connect(function()
        tween(btn, 0.1, {BackgroundColor3 = Color3.fromRGB(235,235,235)})
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, 0.1, {BackgroundColor3 = Color3.fromRGB(255,255,255)})
    end)

    RunService.Heartbeat:Connect(function()
        if btn and btn.Parent then
            btn.TextColor3 = rainbowColor(order * 0.07)
        end
    end)

    return btn
end

local function addSlider(parent, labelText, minV, maxV, cur, order, onChange)
    local wrap = Instance.new("Frame")
    wrap.Parent             = parent
    wrap.LayoutOrder        = order
    wrap.BackgroundTransparency = 1
    wrap.Size               = UDim2.new(0.92,0,0,54)

    local lbl = Instance.new("TextLabel")
    lbl.Parent              = wrap
    lbl.BackgroundTransparency = 1
    lbl.Size                = UDim2.new(1,0,0,22)
    lbl.Font                = Enum.Font.GothamBold
    lbl.Text                = labelText .. ": " .. cur
    lbl.TextScaled           = true

    local track = Instance.new("Frame")
    track.Parent            = wrap
    track.BackgroundColor3  = Color3.fromRGB(210,210,210)
    track.BorderSizePixel   = 1
    track.BorderColor3      = Color3.fromRGB(10,10,10)
    track.Position          = UDim2.new(0,0,0,28)
    track.Size              = UDim2.new(1,0,0,12)

    local fill = Instance.new("Frame")
    fill.Parent             = track
    fill.BorderSizePixel    = 0
    fill.Size               = UDim2.new((cur-minV)/(maxV-minV),0,1,0)

    local thumb = Instance.new("TextButton")
    thumb.Parent            = track
    thumb.BackgroundColor3  = Color3.fromRGB(255,255,255)
    thumb.BorderSizePixel   = 2
    thumb.BorderColor3      = Color3.fromRGB(10,10,10)
    thumb.Size              = UDim2.new(0,16,0,20)
    thumb.Position          = UDim2.new((cur-minV)/(maxV-minV),-8,0.5,-10)
    thumb.Text              = ""
    thumb.AutoButtonColor   = false

    local dragging = false
    thumb.MouseButton1Down:Connect(function() dragging = true end)
    thumb.TouchLongPress:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    RunService.Heartbeat:Connect(function()
        fill.BackgroundColor3  = rainbowColor(order * 0.1)
        lbl.TextColor3         = rainbowColor(order * 0.1)
        if dragging then
            local mx = UserInputService:GetMouseLocation().X
            local rel = math.clamp((mx - track.AbsolutePosition.X)/track.AbsoluteSize.X, 0, 1)
            local val = math.floor(minV + rel*(maxV-minV))
            fill.Size      = UDim2.new(rel,0,1,0)
            thumb.Position = UDim2.new(rel,-8,0.5,-10)
            lbl.Text       = labelText .. ": " .. val
            onChange(val)
        end
    end)

    return wrap
end

-- ══════════════════════════════════════════════════════════
--  MAIN — КНОПКИ
-- ══════════════════════════════════════════════════════════

-- FLY
local flyBtn = addBtn(mainBody, "FLY: OFF", 1)
flyBtn.MouseButton1Click:Connect(function()
    State.fly = not State.fly
    setToggle(flyBtn, "FLY", State.fly)
    if hum then hum.PlatformStand = State.fly end
    if not State.fly and root then
        root.AssemblyLinearVelocity = Vector3.zero
    end
end)

-- NOCLIP
local noclipBtn = addBtn(mainBody, "NOCLIP: OFF", 2)
noclipBtn.MouseButton1Click:Connect(function()
    State.noclip = not State.noclip
    setToggle(noclipBtn, "NOCLIP", State.noclip)
end)

-- INF JUMP (без задержки)
local infJumpBtn = addBtn(mainBody, "INF JUMP: OFF", 3)
infJumpBtn.MouseButton1Click:Connect(function()
    State.infJump = not State.infJump
    setToggle(infJumpBtn, "INF JUMP", State.infJump)
end)

-- SPEED
addSlider(mainBody, "SPEED", 16, 150, 16, 4, function(v)
    State.speed = v
    if hum then hum.WalkSpeed = v end
end)

-- GRAVITY
addSlider(mainBody, "GRAVITY", -100, 300, 196, 5, function(v)
    State.gravity = v
    workspace.Gravity = v
end)

-- AIM
local aimBtn = addBtn(mainBody, "AIM: OFF", 6)
aimBtn.MouseButton1Click:Connect(function()
    State.aim = not State.aim
    setToggle(aimBtn, "AIM", State.aim)
end)

addSlider(mainBody, "FOV SIZE", 50, 500, 150, 7, function(v)
    State.aimRadius = v
end)

-- CLICKER
local clickerBtn = addBtn(mainBody, "CLICKER: OFF", 8)
clickerBtn.MouseButton1Click:Connect(function()
    State.clicker = not State.clicker
    setToggle(clickerBtn, "CLICKER", State.clicker)
end)

-- TP TOOL
local tpBtn = addBtn(mainBody, "TP TOOL: OFF", 9)
tpBtn.MouseButton1Click:Connect(function()
    State.tpTool = not State.tpTool
    setToggle(tpBtn, "TP TOOL", State.tpTool)
end)

-- HEADLESS
local headlessBtn = addBtn(mainBody, "HEADLESS: OFF", 10)
headlessBtn.MouseButton1Click:Connect(function()
    State.headless = not State.headless
    setToggle(headlessBtn, "HEADLESS", State.headless)
    if char then
        local head = char:FindFirstChild("Head")
        if head then head.Transparency = State.headless and 1 or 0 end
    end
end)

-- ══════════════════════════════════════════════════════════
--  VISUAL — КНОПКИ
-- ══════════════════════════════════════════════════════════

-- PINK SKY
local skyBtn = addBtn(visualBody, "PINK SKY: OFF", 1)
skyBtn.MouseButton1Click:Connect(function()
    State.pinkSky = not State.pinkSky
    setToggle(skyBtn, "PINK SKY", State.pinkSky)
end)

-- SPHERES
local spheresBtn = addBtn(visualBody, "SPHERES: OFF", 2)
spheresBtn.MouseButton1Click:Connect(function()
    State.spheres = not State.spheres
    setToggle(spheresBtn, "SPHERES", State.spheres)
end)

-- TRAIL
local trailBtn = addBtn(visualBody, "TRAIL: OFF", 3)
trailBtn.MouseButton1Click:Connect(function()
    State.trail = not State.trail
    setToggle(trailBtn, "TRAIL", State.trail)
end)

-- FULLBRIGHT
local fullbrightBtn = addBtn(visualBody, "FULLBRIGHT: OFF", 4)
fullbrightBtn.MouseButton1Click:Connect(function()
    State.fullbright = not State.fullbright
    setToggle(fullbrightBtn, "FULLBRIGHT", State.fullbright)
    if State.fullbright then
        Lighting.Ambient        = Color3.fromRGB(255,255,255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        Lighting.Brightness     = 10
        Lighting.FogEnd         = 100000
        Lighting.FogStart       = 100000
    else
        Lighting.Ambient        = Color3.fromRGB(127,127,127)
        Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
        Lighting.Brightness     = 1
        Lighting.FogEnd         = 100000
        Lighting.FogStart       = 0
    end
end)

-- JERK ANIMATION
local jerkBtn = addBtn(visualBody, "JERK ANIM: OFF", 5)
jerkBtn.MouseButton1Click:Connect(function()
    State.jerk = not State.jerk
    setToggle(jerkBtn, "JERK ANIM", State.jerk)
end)

-- COPTER (быстрое вращение головы)
local copterBtn = addBtn(visualBody, "COPTER: OFF", 6)
copterBtn.MouseButton1Click:Connect(function()
    State.copter = not State.copter
    setToggle(copterBtn, "COPTER", State.copter)
end)

-- BIG HEAD
local bigHeadBtn = addBtn(visualBody, "BIG HEAD: OFF", 7)
bigHeadBtn.MouseButton1Click:Connect(function()
    State.bigHead = not State.bigHead
    setToggle(bigHeadBtn, "BIG HEAD", State.bigHead)
    -- Применяем ко всем игрокам
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local h = plr.Character:FindFirstChild("Head")
            if h then
                h.Size = State.bigHead
                    and Vector3.new(h.Size.X*2, h.Size.Y*2, h.Size.Z*2)
                    or  Vector3.new(2, 1, 1)  -- дефолт R6
            end
        end
    end
end)

-- DISCO
local discoBtn = addBtn(visualBody, "DISCO: OFF", 8)
discoBtn.MouseButton1Click:Connect(function()
    State.disco = not State.disco
    setToggle(discoBtn, "DISCO", State.disco)
end)

-- FPS
local fpsBtn = addBtn(visualBody, "FPS COUNTER: OFF", 9)
fpsBtn.MouseButton1Click:Connect(function()
    State.fps = not State.fps
    setToggle(fpsBtn, "FPS COUNTER", State.fps)
end)

-- COLOR CHANGER кнопка
local colorChangerBtn = addBtn(visualBody, "🎨 COLOR CHANGER", 10)

-- ══════════════════════════════════════════════════════════
--  COLOR CHANGER ОКНО
-- ══════════════════════════════════════════════════════════
local colorWindow = Instance.new("Frame")
colorWindow.Parent            = sg
colorWindow.BackgroundColor3  = Color3.fromRGB(255,255,255)
colorWindow.BorderSizePixel   = 3
colorWindow.BorderColor3      = Color3.fromRGB(10,10,10)
colorWindow.Size              = UDim2.new(0,360,0,340)
colorWindow.Position          = UDim2.new(0.5,-180,0.5,-170)
colorWindow.Active            = true
colorWindow.Draggable         = true
colorWindow.Visible           = false

local cwCorner = Instance.new("UICorner")
cwCorner.CornerRadius = UDim.new(0,8)
cwCorner.Parent = colorWindow

local cwTitle = Instance.new("TextLabel")
cwTitle.Parent              = colorWindow
cwTitle.BackgroundTransparency = 1
cwTitle.Position            = UDim2.new(0,12,0,8)
cwTitle.Size                = UDim2.new(0.8,0,0,28)
cwTitle.Font                = Enum.Font.GothamBold
cwTitle.Text                = "COLOR CHANGER"
cwTitle.TextScaled           = true

RunService.Heartbeat:Connect(function()
    if cwTitle and cwTitle.Parent then
        cwTitle.TextColor3 = rainbowColor(0)
    end
end)

local cwClose = Instance.new("TextButton")
cwClose.Parent            = colorWindow
cwClose.BackgroundTransparency = 1
cwClose.Size              = UDim2.new(0,28,0,28)
cwClose.Position          = UDim2.new(1,-34,0,8)
cwClose.Font              = Enum.Font.GothamBold
cwClose.Text              = "X"
cwClose.TextColor3        = Color3.fromRGB(200,50,50)
cwClose.TextScaled         = true
cwClose.AutoButtonColor   = false
cwClose.MouseButton1Click:Connect(function() colorWindow.Visible = false end)

colorChangerBtn.MouseButton1Click:Connect(function()
    colorWindow.Visible = not colorWindow.Visible
end)

-- Хелпер: секция цвета с 3 ползунками R/G/B
local function makeColorSection(parent, label, yOffset, getColor, setColor)
    local sec = Instance.new("Frame")
    sec.Parent              = parent
    sec.BackgroundTransparency = 1
    sec.Position            = UDim2.new(0,14,0,yOffset)
    sec.Size                = UDim2.new(1,-28,0,80)

    local lbl = Instance.new("TextLabel")
    lbl.Parent              = sec
    lbl.BackgroundTransparency = 1
    lbl.Size                = UDim2.new(1,0,0,20)
    lbl.Font                = Enum.Font.GothamBold
    lbl.Text                = label
    lbl.TextXAlignment      = Enum.TextXAlignment.Left
    lbl.TextScaled           = true
    RunService.Heartbeat:Connect(function()
        if lbl and lbl.Parent then lbl.TextColor3 = rainbowColor(yOffset*0.01) end
    end)

    -- Превью цвета
    local preview = Instance.new("Frame")
    preview.Parent          = sec
    preview.Position        = UDim2.new(1,-50,0,0)
    preview.Size            = UDim2.new(0,46,0,46)
    preview.BorderSizePixel = 2
    preview.BorderColor3    = Color3.fromRGB(10,10,10)

    local pvCorner = Instance.new("UICorner")
    pvCorner.CornerRadius = UDim.new(0,4)
    pvCorner.Parent = preview

    local channels = {
        {name="R", col=Color3.fromRGB(220,50,50),  yOff=22},
        {name="G", col=Color3.fromRGB(50,200,50),  yOff=40},
        {name="B", col=Color3.fromRGB(50,100,220), yOff=58},
    }

    local vals = {
        math.floor(getColor().R * 255),
        math.floor(getColor().G * 255),
        math.floor(getColor().B * 255),
    }

    local function applyColor()
        local nc = Color3.fromRGB(vals[1], vals[2], vals[3])
        setColor(nc)
        preview.BackgroundColor3 = nc
    end
    applyColor()

    for i, ch in ipairs(channels) do
        local track = Instance.new("Frame")
        track.Parent            = sec
        track.BackgroundColor3  = Color3.fromRGB(210,210,210)
        track.BorderSizePixel   = 1
        track.BorderColor3      = Color3.fromRGB(10,10,10)
        track.Position          = UDim2.new(0,0,0,ch.yOff)
        track.Size              = UDim2.new(1,-60,0,10)

        local fill = Instance.new("Frame")
        fill.Parent             = track
        fill.BackgroundColor3   = ch.col
        fill.BorderSizePixel    = 0
        fill.Size               = UDim2.new(vals[i]/255, 0, 1, 0)

        local thumb = Instance.new("TextButton")
        thumb.Parent            = track
        thumb.BackgroundColor3  = Color3.fromRGB(255,255,255)
        thumb.BorderSizePixel   = 2
        thumb.BorderColor3      = Color3.fromRGB(10,10,10)
        thumb.Size              = UDim2.new(0,14,0,18)
        thumb.Position          = UDim2.new(vals[i]/255,-7,0.5,-9)
        thumb.Text              = ""
        thumb.AutoButtonColor   = false

        local lbCh = Instance.new("TextLabel")
        lbCh.Parent             = track
        lbCh.BackgroundTransparency = 1
        lbCh.Position           = UDim2.new(1,2,0,-2)
        lbCh.Size               = UDim2.new(0,56,1,4)
        lbCh.Font               = Enum.Font.Gotham
        lbCh.Text               = ch.name..":"..vals[i]
        lbCh.TextScaled          = true
        lbCh.TextColor3         = ch.col

        local drag = false
        thumb.MouseButton1Down:Connect(function() drag = true end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then
                drag = false
            end
        end)
        RunService.Heartbeat:Connect(function()
            if drag then
                local rel = math.clamp(
                    (UserInputService:GetMouseLocation().X - track.AbsolutePosition.X)
                    / track.AbsoluteSize.X, 0, 1)
                vals[i]        = math.floor(rel * 255)
                fill.Size      = UDim2.new(rel,0,1,0)
                thumb.Position = UDim2.new(rel,-7,0.5,-9)
                lbCh.Text      = ch.name..":"..vals[i]
                applyColor()
            end
        end)
    end
end

makeColorSection(colorWindow, "FOV Circle",  44,
    function() return State.colFov    end,
    function(c) State.colFov    = c   end)

makeColorSection(colorWindow, "Text Color", 130,
    function() return State.colText   end,
    function(c) State.colText   = c   end)

makeColorSection(colorWindow, "Border Color", 216,
    function() return State.colBorder end,
    function(c)
        State.colBorder = c
        mainFrame.BorderColor3   = c
        iconBtn.BorderColor3     = c
        colorWindow.BorderColor3 = c
    end)

-- ══════════════════════════════════════════════════════════
--  BOXES — КНОПКИ
-- ══════════════════════════════════════════════════════════

local function makeEspToggle(label, key, order)
    local btn = addBtn(boxesBody, label..": OFF", order)
    btn.MouseButton1Click:Connect(function()
        State[key] = not State[key]
        setToggle(btn, label, State[key])
        refreshESP()
    end)
    return btn
end

local espBtn      = addBtn(boxesBody, "ESP: OFF", 1)
local espBoxBtn   = addBtn(boxesBody, "BOX ESP: OFF", 2)
local espNameBtn  = addBtn(boxesBody, "NAMES: OFF", 3)
local espHealthBtn= addBtn(boxesBody, "HEALTH BAR: OFF", 4)
local espDistBtn  = addBtn(boxesBody, "DISTANCE: OFF", 5)
local espLinesBtn = addBtn(boxesBody, "TRACERS: OFF", 6)
local skelBtn     = addBtn(boxesBody, "SKELETON: OFF", 7)
local compassBtn  = addBtn(boxesBody, "COMPASS: OFF", 8)
local whBtn       = addBtn(boxesBody, "WALLHACK: OFF", 9)

-- ══════════════════════════════════════════════════════════
--  AIM FOV CIRCLE
-- ══════════════════════════════════════════════════════════
local aimCircle = Instance.new("Frame")
aimCircle.Parent              = sg
aimCircle.BackgroundTransparency = 1
aimCircle.BorderSizePixel     = 3
aimCircle.AnchorPoint         = Vector2.new(0.5,0.5)
aimCircle.Position            = UDim2.new(0.5,0,0.5,0)
aimCircle.Visible             = false

local aimUICorner = Instance.new("UICorner")
aimUICorner.CornerRadius = UDim.new(1,0)
aimUICorner.Parent = aimCircle

-- ══════════════════════════════════════════════════════════
--  ESP СИСТЕМА
-- ══════════════════════════════════════════════════════════
local espHolders = {}

local SKELETON_LINKS = {
    -- R6
    {"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},
    {"Torso","Left Leg"},{"Torso","Right Leg"},
    -- R15
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"UpperTorso","RightUpperArm"},
    {"LeftUpperArm","LeftLowerArm"},{"RightUpperArm","RightLowerArm"},
    {"LowerTorso","LeftUpperLeg"},{"LowerTorso","RightUpperLeg"},
    {"LeftUpperLeg","LeftLowerLeg"},{"RightUpperLeg","RightLowerLeg"},
}

local skeletonLines = {}  -- {line (Drawing), p1name, p2name, plr}

local function clearDrawingLines()
    for _, l in ipairs(skeletonLines) do
        if l.line then l.line:Remove() end
    end
    skeletonLines = {}
end

local tracerLines = {} -- {line, plr}

local function clearTracers()
    for _, l in ipairs(tracerLines) do
        if l.line then l.line:Remove() end
    end
    tracerLines = {}
end

function refreshESP()
    -- Уничтожаем старые
    for _, h in pairs(espHolders) do
        if h and h.Parent then h:Destroy() end
    end
    espHolders = {}
    clearDrawingLines()
    clearTracers()

    local anyESP = State.esp or State.espBoxes or State.espNames
        or State.espHealth or State.espDist or State.wallhack

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == lp or not plr.Character then continue end
        local c = plr.Character
        local torso = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")

        local holder = Instance.new("Folder")
        holder.Name   = "ESP_"..plr.Name
        holder.Parent = c
        espHolders[plr] = holder

        -- Billboard (имя, здоровье, дистанция)
        if State.espNames or State.esp or State.espHealth or State.espDist then
            local headPart = c:FindFirstChild("Head")
            local bb = Instance.new("BillboardGui")
            bb.Adornee     = headPart or torso
            bb.Size        = UDim2.new(0,220,0,70)
            bb.StudsOffset = Vector3.new(0,3.5,0)
            bb.AlwaysOnTop = true
            bb.Parent      = holder

            local nl = Instance.new("TextLabel")
            nl.Parent               = bb
            nl.Size                 = UDim2.new(1,0,0.55,0)
            nl.BackgroundTransparency = 1
            nl.Font                 = Enum.Font.GothamBold
            nl.TextScaled            = true
            nl.TextStrokeTransparency = 0.3
            nl.TextStrokeColor3     = Color3.fromRGB(0,0,0)
            nl.Name                 = "NameLabel"

            local il = Instance.new("TextLabel")
            il.Parent               = bb
            il.Size                 = UDim2.new(1,0,0.45,0)
            il.Position             = UDim2.new(0,0,0.55,0)
            il.BackgroundTransparency = 1
            il.Font                 = Enum.Font.Gotham
            il.TextScaled            = true
            il.Name                 = "InfoLabel"
        end

        -- Box ESP (SelectionBox)
        if State.espBoxes then
            local box = Instance.new("SelectionBox")
            box.Adornee          = c
            box.LineThickness     = 0.05
            box.SurfaceTransparency = 0.85
            box.AlwaysOnTop      = true  -- wallhack через AlwaysOnTop
            box.Name             = "BoxESP"
            box.Parent           = holder
        end

        -- Health bar (BillboardGui под ногами)
        if State.espHealth then
            local hbBB = Instance.new("BillboardGui")
            hbBB.Adornee     = torso or c:FindFirstChild("HumanoidRootPart")
            hbBB.Size        = UDim2.new(0,6,0,60)
            hbBB.StudsOffset = Vector3.new(-3,0,0)
            hbBB.AlwaysOnTop = true
            hbBB.Parent      = holder
            hbBB.Name        = "HealthBar"

            local bg = Instance.new("Frame")
            bg.Parent            = hbBB
            bg.Size              = UDim2.new(1,0,1,0)
            bg.BackgroundColor3  = Color3.fromRGB(50,0,0)
            bg.BorderSizePixel   = 1
            bg.BorderColor3      = Color3.fromRGB(0,0,0)

            local fill = Instance.new("Frame")
            fill.Parent          = bg
            fill.Size            = UDim2.new(1,0,1,0)
            fill.BorderSizePixel = 0
            fill.Name            = "HealthFill"
        end

        -- Skeleton (Drawing Lines)
        if State.skeleton and Drawing then
            for _, link in ipairs(SKELETON_LINKS) do
                local line = Drawing.new("Line")
                line.Visible   = false
                line.Thickness = 2
                line.Color     = Color3.fromRGB(255,100,100)
                table.insert(skeletonLines, {line=line, p1=link[1], p2=link[2], plr=plr})
            end
        end

        -- Tracers (Drawing Lines)
        if State.espLines and Drawing then
            local line = Drawing.new("Line")
            line.Visible   = false
            line.Thickness = 1
            table.insert(tracerLines, {line=line, plr=plr})
        end
    end
end

-- Кнопки ESP
local function espToggle(btn, key, label)
    btn.MouseButton1Click:Connect(function()
        State[key] = not State[key]
        setToggle(btn, label, State[key])
        refreshESP()
    end)
end

espToggle(espBtn,       "esp",       "ESP")
espToggle(espBoxBtn,    "espBoxes",  "BOX ESP")
espToggle(espNameBtn,   "espNames",  "NAMES")
espToggle(espHealthBtn, "espHealth", "HEALTH BAR")
espToggle(espDistBtn,   "espDist",   "DISTANCE")
espToggle(espLinesBtn,  "espLines",  "TRACERS")
espToggle(skelBtn,      "skeleton",  "SKELETON")
espToggle(compassBtn,   "compass",   "COMPASS")

whBtn.MouseButton1Click:Connect(function()
    State.wallhack = not State.wallhack
    setToggle(whBtn, "WALLHACK", State.wallhack)
    -- Wallhack — SelectionBox с AlwaysOnTop видит сквозь стены
    -- Пересоздаём ESP чтобы применить
    refreshESP()
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.5)
        if State.esp or State.espBoxes or State.espNames or State.espHealth
           or State.espLines or State.skeleton or State.wallhack then
            local c = plr.Character
            local holder = Instance.new("Folder")
            holder.Name   = "ESP_"..plr.Name
            holder.Parent = c
            espHolders[plr] = holder
        end
    end)
end)

Players.PlayerRemoving:Connect(function(plr)
    if espHolders[plr] then
        espHolders[plr]:Destroy()
        espHolders[plr] = nil
    end
end)

-- ══════════════════════════════════════════════════════════
--  COMPASS
-- ══════════════════════════════════════════════════════════
local compassGui = Instance.new("Frame")
compassGui.Parent               = sg
compassGui.BackgroundColor3     = Color3.fromRGB(10,10,10)
compassGui.BackgroundTransparency = 0.35
compassGui.BorderSizePixel      = 2
compassGui.BorderColor3         = Color3.fromRGB(255,255,255)
compassGui.Size                 = UDim2.new(0,160,0,160)
compassGui.Position             = UDim2.new(0,10,0,10)
compassGui.Visible              = false

local compCorner = Instance.new("UICorner")
compCorner.CornerRadius = UDim.new(1,0)
compCorner.Parent = compassGui

local compassDots = {}

-- ══════════════════════════════════════════════════════════
--  FPS LABEL
-- ══════════════════════════════════════════════════════════
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Parent               = sg
fpsLabel.BackgroundColor3     = Color3.fromRGB(10,10,10)
fpsLabel.BackgroundTransparency = 0.4
fpsLabel.BorderSizePixel      = 0
fpsLabel.Size                 = UDim2.new(0,90,0,26)
fpsLabel.Position             = UDim2.new(0,10,1,-38)
fpsLabel.Font                 = Enum.Font.GothamBold
fpsLabel.TextColor3           = Color3.fromRGB(255,255,255)
fpsLabel.TextScaled            = true
fpsLabel.Visible              = false

local fpsCorner2 = Instance.new("UICorner")
fpsCorner2.CornerRadius = UDim.new(0,6)
fpsCorner2.Parent = fpsLabel

-- ══════════════════════════════════════════════════════════
--  PINK SKY
-- ══════════════════════════════════════════════════════════
local origSky, customSky = nil, nil

local function applyPinkSky(on)
    if on then
        origSky = Lighting:FindFirstChildOfClass("Sky")
        if origSky then origSky.Parent = nil end
        customSky = Instance.new("Sky")
        for _, f in ipairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do
            customSky["Skybox"..f] = "rbxassetid://153300993"
        end
        customSky.Parent = Lighting
    else
        if customSky then customSky:Destroy() customSky = nil end
        if origSky   then origSky.Parent = Lighting end
    end
end

-- ══════════════════════════════════════════════════════════
--  СФЕРЫ
-- ══════════════════════════════════════════════════════════
local sphereObjects = {}

local function destroySpheres()
    for _, s in ipairs(sphereObjects) do
        if s.part then s.part:Destroy() end
    end
    sphereObjects = {}
end

local function createSpheres()
    destroySpheres()
    for i = 1,2 do
        local p = Instance.new("Part")
        p.Size        = Vector3.new(2,2,2)
        p.Shape       = Enum.PartType.Ball
        p.Material    = Enum.Material.Neon
        p.Anchored    = true
        p.CanCollide  = false
        p.Transparency = 0.2
        p.Parent      = workspace
        table.insert(sphereObjects, {part=p, side=(i==1 and 1 or -1)})
    end
end

-- ══════════════════════════════════════════════════════════
--  JERK ANIMATION
-- ══════════════════════════════════════════════════════════
local jerkAnim = nil

local function startJerk()
    if not hum or not char then return end
    local id = hum.RigType == Enum.HumanoidRigType.R6
        and "rbxassetid://72042024"
        or  "rbxassetid://698251653"
    local a = Instance.new("Animation")
    a.AnimationId = id
    jerkAnim = hum:LoadAnimation(a)
    jerkAnim.Looped = true
    jerkAnim:Play()
end

local function stopJerk()
    if jerkAnim then jerkAnim:Stop() jerkAnim = nil end
end

-- ══════════════════════════════════════════════════════════
--  COPTER (быстрое вращение головы)
-- ══════════════════════════════════════════════════════════
local copterConn = nil

local function startCopter()
    if copterConn then return end
    copterConn = RunService.Heartbeat:Connect(function(dt)
        if not State.copter or not char then return end
        local head = char:FindFirstChild("Head")
        if head then
            head.CFrame = head.CFrame * CFrame.Angles(0, math.rad(30), 0)
        end
    end)
end

local function stopCopter()
    if copterConn then copterConn:Disconnect() copterConn = nil end
end

-- ══════════════════════════════════════════════════════════
--  CLICKER
-- ══════════════════════════════════════════════════════════
local function doClick()
    -- Пробуем VirtualUser, потом mouse
    local ok = false
    local vu = pcall(function()
        local VU = game:GetService("VirtualUser")
        VU:Button1Down(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2), CFrame.new())
        VU:Button1Up(Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2), CFrame.new())
        ok = true
    end)
    if not ok then
        pcall(function()
            local mouse = lp:GetMouse()
            -- Запасной: fire через mouse1click нет публичного API,
            -- но на Delta X работает через VirtualUser
            mouse1click()
        end)
    end
end

-- ══════════════════════════════════════════════════════════
--  ГЛАВНЫЙ HEARTBEAT
-- ══════════════════════════════════════════════════════════
local fpsCount, fpsClock = 0, 0
local trailTimer, lastTrailPos = 0, nil
local copterAngle = 0

RunService.Heartbeat:Connect(function(dt)

    -- FPS
    fpsClock += dt
    fpsCount += 1
    if fpsClock >= 0.5 then
        fpsLabel.Text    = "FPS: " .. math.floor(fpsCount/fpsClock)
        fpsLabel.Visible = State.fps
        fpsCount, fpsClock = 0, 0
    end

    -- ── FLY ─────────────────────────────────────────────
    if State.fly and root and hum then
        local move = Vector3.zero
        local look  = cam.CFrame.LookVector  * Vector3.new(1,0,1)
        local right = cam.CFrame.RightVector * Vector3.new(1,0,1)

        if UserInputService:IsKeyDown(Enum.KeyCode.W)           then move += look  end
        if UserInputService:IsKeyDown(Enum.KeyCode.S)           then move -= look  end
        if UserInputService:IsKeyDown(Enum.KeyCode.A)           then move -= right end
        if UserInputService:IsKeyDown(Enum.KeyCode.D)           then move += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space)       then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

        -- Джойстик (мобильный)
        local joyDir = hum.MoveDirection
        if joyDir.Magnitude > 0.1 then
            local worldDir = cam.CFrame:VectorToWorldSpace(joyDir) * Vector3.new(1,0,1)
            if worldDir.Magnitude > 0 then
                move += worldDir.Unit
            end
        end

        if move.Magnitude > 0 then
            root.AssemblyLinearVelocity = move.Unit * State.flySpeed
        else
            root.AssemblyLinearVelocity = Vector3.zero
        end
    end

    -- ── NOCLIP ──────────────────────────────────────────
    if State.noclip and char then
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end

    -- ── CLICKER ─────────────────────────────────────────
    if State.clicker then doClick() end

    -- ── AIM CIRCLE ──────────────────────────────────────
    if State.aim then
        aimCircle.Visible      = true
        local r                = State.aimRadius
        aimCircle.Size         = UDim2.new(0,r*2,0,r*2)
        aimCircle.BorderColor3 = rainbowColor(0.3) -- радужный если не задан пользователем

        -- Найти ближайшего в FOV и нацелиться
        local closest, closestDist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == lp or not plr.Character then continue end
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            if not tr then continue end
            local sp, onScreen = cam:WorldToScreenPoint(tr.Position)
            if onScreen then
                local dx = sp.X - cam.ViewportSize.X/2
                local dy = sp.Y - cam.ViewportSize.Y/2
                local d  = math.sqrt(dx*dx + dy*dy)
                if d < r and d < closestDist then
                    closest, closestDist = plr, d
                end
            end
        end

        if closest and closest.Character and root then
            local tr = closest.Character:FindFirstChild("HumanoidRootPart")
            if tr then
                -- Поворачиваем только горизонтально чтобы оружие шло в цель
                local dir = (tr.Position - root.Position) * Vector3.new(1,0,1)
                if dir.Magnitude > 0 then
                    root.CFrame = CFrame.new(root.Position,
                        root.Position + dir.Unit)
                end
            end
        end
    else
        aimCircle.Visible = false
    end

    -- ── PINK SKY ────────────────────────────────────────
    if State.pinkSky and not customSky then applyPinkSky(true)  end
    if not State.pinkSky and customSky  then applyPinkSky(false) end

    -- ── СФЕРЫ ───────────────────────────────────────────
    if State.spheres then
        if #sphereObjects == 0 then createSpheres() end
        local t = tick() * 2
        for _, s in ipairs(sphereObjects) do
            if s.part and root then
                local angle = t * s.side
                s.part.Position = Vector3.new(
                    root.Position.X + math.cos(angle) * 5,
                    root.Position.Y + 1,
                    root.Position.Z + math.sin(angle) * 5
                )
                s.part.Color = rainbowColor(s.side * 0.3)
                -- мини-трейл сфер
                local tp = Instance.new("Part")
                tp.Size        = Vector3.new(0.5,0.5,0.5)
                tp.Shape       = Enum.PartType.Ball
                tp.Material    = Enum.Material.Neon
                tp.Anchored    = true
                tp.CanCollide  = false
                tp.Transparency = 0.55
                tp.Color       = s.part.Color
                tp.Position    = s.part.Position
                tp.Parent      = workspace
                Debris:AddItem(tp, 0.22)
            end
        end
    else
        if #sphereObjects > 0 then destroySpheres() end
    end

    -- ── TRAIL ───────────────────────────────────────────
    if State.trail and root then
        trailTimer += dt
        local cur = root.Position
        if trailTimer > 0.06 and lastTrailPos and (cur - lastTrailPos).Magnitude > 0.8 then
            local tp = Instance.new("Part")
            tp.Size        = Vector3.new(0.7,0.7,0.7)
            tp.Shape       = Enum.PartType.Ball
            tp.Material    = Enum.Material.Neon
            tp.Anchored    = true
            tp.CanCollide  = false
            tp.Transparency = 0.3
            tp.Color       = rainbowColor((tick()*0.6)%1)
            tp.Position    = cur
            tp.Parent      = workspace
            Debris:AddItem(tp, 1.2)
            trailTimer = 0
        end
        lastTrailPos = cur
    else
        lastTrailPos = nil
        trailTimer   = 0
    end

    -- ── JERK ────────────────────────────────────────────
    if State.jerk and not jerkAnim   then startJerk() end
    if not State.jerk and jerkAnim   then stopJerk()  end

    -- ── COPTER ──────────────────────────────────────────
    if State.copter then
        if not copterConn then startCopter() end
    else
        if copterConn then stopCopter() end
    end

    -- ── ESP ОБНОВЛЕНИЕ ──────────────────────────────────
    for plr, holder in pairs(espHolders) do
        if not (holder and holder.Parent and plr.Character and root) then continue end
        local c    = plr.Character
        local tHum = c:FindFirstChild("Humanoid")
        local tRoot= c:FindFirstChild("HumanoidRootPart")

        -- Billboard
        local bb = holder:FindFirstChildOfClass("BillboardGui")
        if bb then
            local nl = bb:FindFirstChild("NameLabel")
            local il = bb:FindFirstChild("InfoLabel")
            if nl then
                nl.Text          = plr.Name
                nl.TextColor3    = rainbowColor(plr.UserId * 0.001 % 1)
            end
            if il then
                local info = {}
                if State.espHealth and tHum then
                    table.insert(info, math.floor(tHum.Health).."hp")
                end
                if State.espDist and tRoot then
                    table.insert(info, math.floor((tRoot.Position - root.Position).Magnitude).."m")
                end
                il.Text       = table.concat(info, "  |  ")
                il.TextColor3 = Color3.fromRGB(210,210,210)
            end
        end

        -- Box цвет
        local box = holder:FindFirstChild("BoxESP")
        if box then
            box.Color3 = rainbowColor(plr.UserId * 0.002 % 1)
        end

        -- Health fill
        local hbBB = holder:FindFirstChild("HealthBar")
        if hbBB and tHum then
            local fill = hbBB:FindFirstChild("HealthFill", true)
            if fill then
                local hp = tHum.Health / tHum.MaxHealth
                fill.Size = UDim2.new(1,0,hp,0)
                fill.Position = UDim2.new(0,0,1-hp,0)
                fill.BackgroundColor3 = Color3.fromRGB(
                    math.floor((1-hp)*255), math.floor(hp*200), 0)
            end
        end
    end

    -- ── SKELETON DRAWING ────────────────────────────────
    for _, sl in ipairs(skeletonLines) do
        if not (sl.plr and sl.plr.Character) then
            sl.line.Visible = false
            continue
        end
        local c  = sl.plr.Character
        local p1 = c:FindFirstChild(sl.p1)
        local p2 = c:FindFirstChild(sl.p2)
        if p1 and p2 then
            local sp1, on1 = cam:WorldToScreenPoint(p1.Position)
            local sp2, on2 = cam:WorldToScreenPoint(p2.Position)
            if on1 and on2 and sp1.Z > 0 and sp2.Z > 0 then
                sl.line.Visible = State.skeleton
                sl.line.From    = Vector2.new(sp1.X, sp1.Y)
                sl.line.To      = Vector2.new(sp2.X, sp2.Y)
                sl.line.Color   = rainbowColor(sl.plr.UserId * 0.002 % 1)
            else
                sl.line.Visible = false
            end
        else
            sl.line.Visible = false
        end
    end

    -- ── TRACERS DRAWING ─────────────────────────────────
    for _, tl in ipairs(tracerLines) do
        if not (tl.plr and tl.plr.Character and root) then
            tl.line.Visible = false
            continue
        end
        local tr = tl.plr.Character:FindFirstChild("HumanoidRootPart")
        if tr then
            local sp, onScreen = cam:WorldToScreenPoint(tr.Position)
            if onScreen and sp.Z > 0 then
                tl.line.Visible = State.espLines
                tl.line.From    = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                tl.line.To      = Vector2.new(sp.X, sp.Y)
                tl.line.Color   = rainbowColor(tl.plr.UserId * 0.002 % 1)
            else
                tl.line.Visible = false
            end
        end
    end

    -- ── COMPASS ─────────────────────────────────────────
    compassGui.Visible = State.compass
    if State.compass and root then
        for _, d in ipairs(compassDots) do d:Destroy() end
        compassDots = {}

        local cx = compassGui.AbsoluteSize.X/2
        local cy = compassGui.AbsoluteSize.Y/2

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr == lp or not plr.Character then continue end
            local tr = plr.Character:FindFirstChild("HumanoidRootPart")
            if not tr then continue end
            local rel = tr.Position - root.Position
            local px  = math.clamp(cx + rel.X/3, 6, compassGui.AbsoluteSize.X-6)
            local py  = math.clamp(cy - rel.Z/3, 6, compassGui.AbsoluteSize.Y-6)
            local dot = Instance.new("Frame")
            dot.Parent          = compassGui
            dot.Size            = UDim2.new(0,8,0,8)
            dot.AnchorPoint     = Vector2.new(0.5,0.5)
            dot.Position        = UDim2.new(0,px,0,py)
            dot.BackgroundColor3 = rainbowColor(plr.UserId*0.001%1)
            dot.BorderSizePixel = 0
            local dc = Instance.new("UICorner")
            dc.CornerRadius = UDim.new(1,0)
            dc.Parent = dot
            table.insert(compassDots, dot)
        end

        -- Точка себя
        local sd = Instance.new("Frame")
        sd.Parent           = compassGui
        sd.Size             = UDim2.new(0,10,0,10)
        sd.AnchorPoint      = Vector2.new(0.5,0.5)
        sd.Position         = UDim2.new(0.5,0,0.5,0)
        sd.BackgroundColor3 = Color3.fromRGB(255,255,255)
        sd.BorderSizePixel  = 0
        local sdc = Instance.new("UICorner")
        sdc.CornerRadius = UDim.new(1,0)
        sdc.Parent = sd
        table.insert(compassDots, sd)
    end

end)

-- ══════════════════════════════════════════════════════════
--  STEPPED: NOCLIP (каждый шаг)
-- ══════════════════════════════════════════════════════════
RunService.Stepped:Connect(function()
    if State.noclip and char then
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ══════════════════════════════════════════════════════════
--  INF JUMP (без задержки)
-- ══════════════════════════════════════════════════════════
UserInputService.JumpRequest:Connect(function()
    if State.infJump and hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Дополнительно: ловим StateChanged для немедленного перепрыжка
-- (убирает стандартную задержку Roblox между прыжками)
local function hookJump()
    if not hum then return end
    hum.StateChanged:Connect(function(_, new)
        if State.infJump and new == Enum.HumanoidStateType.Landed then
            task.defer(function()
                if State.infJump and hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)
end

-- ══════════════════════════════════════════════════════════
--  TP TOOL
-- ══════════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe or not State.tpTool or not root then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        local ray = cam:ScreenPointToRay(input.Position.X, input.Position.Y)
        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000)
        if result then
            root.CFrame = CFrame.new(result.Position + Vector3.new(0,3,0))
        end
    end
end)

-- ══════════════════════════════════════════════════════════
--  АВТО-ОБНОВЛЕНИЕ ПЕРСОНАЖА
-- ══════════════════════════════════════════════════════════
lp.CharacterAdded:Connect(function(newChar)
    refreshChar(newChar)
    task.wait(0.5)

    hookJump()

    if State.headless then
        local head = newChar:FindFirstChild("Head")
        if head then head.Transparency = 1 end
    end
    if State.fly and hum then hum.PlatformStand = true end
    if hum then hum.WalkSpeed = State.speed end
    if State.spheres then destroySpheres() end
    refreshESP()

    -- BIG HEAD при респавне
    if State.bigHead then
        local head = newChar:FindFirstChild("Head")
        if head then head.Size = Vector3.new(4,2,2) end
    end
end)

hookJump()

-- ══════════════════════════════════════════════════════════
--  СИСТЕМА КЛЮЧЕЙ — ВЕРИФИКАЦИЯ
-- ══════════════════════════════════════════════════════════
verifyBtn.MouseButton1Click:Connect(function()
    local entered = keyBox.Text:upper():gsub("%s","")
    if entered == "" then
        keyStatus.Text      = "Введи ключ!"
        keyStatus.TextColor3 = Color3.fromRGB(200,50,50)
        return
    end

    if entered == KEY_VALID then
        -- Успех
        keyStatus.Text      = "✅ Ключ принят!"
        keyStatus.TextColor3 = Color3.fromRGB(50,180,50)
        task.wait(0.8)
        tween(keyGui, 0.3, {BackgroundTransparency = 1})
        task.wait(0.35)
        keyGui:Destroy()

        iconBtn.Visible = true
        -- Плавное появление иконки
        iconBtn.BackgroundTransparency = 1
        tween(iconBtn, 0.4, {BackgroundTransparency = 0})
    else
        keyStatus.Text      = "❌ Неверный ключ"
        keyStatus.TextColor3 = Color3.fromRGB(200,50,50)
        -- Тряска поля ввода
        local origPos = keyBox.Position
        for i = 1, 4 do
            tween(keyBox, 0.04, {Position = origPos + UDim2.new(0,6,0,0)})
            task.wait(0.05)
            tween(keyBox, 0.04, {Position = origPos - UDim2.new(0,6,0,0)})
            task.wait(0.05)
        end
        tween(keyBox, 0.04, {Position = origPos})
    end
end)

-- ══════════════════════════════════════════════════════════
print("✅ ZACK_HUB v2 загружен")
print("🔑 Ключ: " .. KEY_VALID)
print("📱 Delta X (iOS/Android) ready")
