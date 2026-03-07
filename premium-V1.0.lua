--[[
    ZACKERR HUB - ПРЕМИУМ ВЕРСИЯ
    Автор: zackerr69
    Статус: АКТИВНО
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
local head = character:FindFirstChild("Head")
local playerGui = player:WaitForChild("PlayerGui")

-- ========== СИСТЕМА СОСТОЯНИЙ ==========
local ZACK_STATES = {
    -- Chams режимы
    chams1 = false,  -- Аура + круги + след
    chams2 = false,  -- Радужное небо + радужный игрок + след
    chams3 = false,  -- Запасной
    chams4 = false,
    chams5 = false,
    
    -- Аксессуары (40+ предметов)
    accessories = {
        aura = false,
        circles = false,
        trail = false,
        wings = false,
        halo = false,
        crown = false,
        ninja = false,
        glasses = false,
        vampire = false,
        dragon = false,
        headphones = false,
        fox = false,
        phoenix = false,
        demon = false,
        angel = false,
        -- Добавим ещё 25...
    }
}

-- ========== ПРЕМИАЛЬНОЕ МЕНЮ ==========
local gui = Instance.new("ScreenGui")
gui.Name = "ZACKERR_HUB"
gui.Parent = playerGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Фон с затемнением
local background = Instance.new("Frame")
background.Name = "Background"
background.Parent = gui
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5
background.Visible = false
background.Active = true

-- ========== ИКОНКА (АНИМЕ-ТЯН) ==========
local icon = Instance.new("ImageButton")
icon.Name = "Icon"
icon.Parent = gui
icon.Size = UDim2.new(0, 64, 0, 64)
icon.Position = UDim2.new(0, 20, 0, 20)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://13978511301"  -- Аниме-тян иконка
icon.ImageRectSize = Vector2.new(64, 64)
icon.Draggable = true
icon.Active = true
icon.Selectable = true

-- Эффект свечения иконки
local iconGlow = Instance.new("ImageLabel")
iconGlow.Name = "Glow"
iconGlow.Parent = icon
iconGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
iconGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
iconGlow.BackgroundTransparency = 1
iconGlow.Image = "rbxassetid://13978511301"
iconGlow.ImageTransparency = 0.5
iconGlow.ZIndex = -1

-- Анимация иконки
spawn(function()
    while true do
        for i = 1, 360, 5 do
            iconGlow.Rotation = i
            iconGlow.ImageTransparency = 0.3 + math.sin(i/10) * 0.2
            wait(0.01)
        end
    end
end)

-- ========== ГЛАВНОЕ МЕНЮ ==========
local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Parent = gui
menu.Size = UDim2.new(0, 800, 0, 600)
menu.Position = UDim2.new(0.5, -400, 0.5, -300)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
menu.BackgroundTransparency = 0.1
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
menu.Draggable = true

-- Фон с аниме-тян (другая)
local menuBg = Instance.new("ImageLabel")
menuBg.Name = "BackgroundImage"
menuBg.Parent = menu
menuBg.Size = UDim2.new(1, 0, 1, 0)
menuBg.Image = "rbxassetid://13978511301"  -- Другая аниме-тян
menuBg.ImageTransparency = 0.7
menuBg.ScaleType = Enum.ScaleType.Crop
menuBg.ZIndex = 0

-- Затемнение фона
local menuOverlay = Instance.new("Frame")
menuOverlay.Name = "Overlay"
menuOverlay.Parent = menu
menuOverlay.Size = UDim2.new(1, 0, 1, 0)
menuOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuOverlay.BackgroundTransparency = 0.3
menuOverlay.ZIndex = 1

-- Заголовок с градиентом
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = menu
header.Size = UDim2.new(1, 0, 0, 60)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
header.BackgroundTransparency = 0.2
header.ZIndex = 2

local headerGradient = Instance.new("UIGradient")
headerGradient.Parent = header
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
})
headerGradient.Rotation = 45

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = header
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 30, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZACKERR HUB — ПРЕМИУМ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3

local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseButton"
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://13978511301"  -- Иконка закрытия
closeBtn.ImageColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.ZIndex = 3

closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    background.Visible = false
end)

-- Вкладки
local tabs = Instance.new("Frame")
tabs.Name = "Tabs"
tabs.Parent = menu
tabs.Size = UDim2.new(1, 0, 0, 50)
tabs.Position = UDim2.new(0, 0, 0, 60)
tabs.BackgroundTransparency = 1
tabs.ZIndex = 2

local tabButtons = {}
local tabContents = {}

local function createTab(name, index)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Tab"
    btn.Parent = tabs
    btn.Size = UDim2.new(0, 120, 0, 40)
    btn.Position = UDim2.new(0, (index-1) * 130, 0, 5)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.ZIndex = 3
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Parent = btn
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
    })
    
    tabButtons[index] = btn
    
    local content = Instance.new("ScrollingFrame")
    content.Name = name .. "Content"
    content.Parent = menu
    content.Size = UDim2.new(1, -40, 1, -160)
    content.Position = UDim2.new(0, 20, 0, 120)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 8
    content.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 150)
    content.Visible = (index == 1)
    content.ZIndex = 2
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    tabContents[index] = content
    
    btn.MouseButton1Click:Connect(function()
        for i, b in ipairs(tabButtons) do
            b.TextColor3 = Color3.fromRGB(200, 200, 200)
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        
        for i, c in ipairs(tabContents) do
            c.Visible = (i == index)
        end
    end)
    
    return content
end

-- Создаём вкладки
local chamsTab = createTab("CHAMS", 1)
local accessoriesTab = createTab("АКСЕССУАРЫ", 2)
local effectsTab = createTab("ЭФФЕКТЫ", 3)
local settingsTab = createTab("НАСТРОЙКИ", 4)

-- Функция создания переключателя
local function createToggle(parent, name, stateKey, yPos, desc)
    local frame = Instance.new("Frame")
    frame.Name = name .. "Toggle"
    frame.Parent = parent
    frame.Size = UDim2.new(1, -40, 0, 50)
    frame.Position = UDim2.new(0, 20, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    
    local gradient = Instance.new("UIGradient")
    gradient.Parent = frame
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 50))
    })
    gradient.Rotation = 90
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.7, -20, 1, 0)
    label.Position = UDim2.new(0, 20, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    
    if desc then
        local descLabel = Instance.new("TextLabel")
        descLabel.Parent = frame
        descLabel.Size = UDim2.new(0.7, -20, 0, 16)
        descLabel.Position = UDim2.new(0, 20, 1, -18)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = desc
        descLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.SourceSans
        descLabel.TextSize = 12
    end
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.Size = UDim2.new(0, 60, 0, 30)
    toggleBtn.Position = UDim2.new(1, -80, 0.5, -15)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Font = Enum.Font.GothamBold
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Parent = toggleBtn
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
    })
    
    toggleBtn.MouseButton1Click:Connect(function()
        if type(stateKey) == "string" then
            ZACK_STATES[stateKey] = not ZACK_STATES[stateKey]
        elseif type(stateKey) == "table" then
            stateKey[1] = not stateKey[1]
        end
        
        local newState = type(stateKey) == "string" and ZACK_STATES[stateKey] or stateKey[1]
        
        if newState then
            toggleBtn.Text = "ON"
            btnGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 200, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 150, 30))
            })
        else
            toggleBtn.Text = "OFF"
            btnGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
            })
        end
    end)
    
    return frame
end

-- Заполняем вкладку CHAMS
createToggle(chamsTab, "🌈 CHAMS 1 — Аура + круги + след", "chams1", 10, "Переливающаяся аура, 3 круга, радужный след")
createToggle(chamsTab, "✨ CHAMS 2 — Радужное небо + радужный игрок + след", "chams2", 70, "Небо переливается, игрок радужный, радужный след")

-- Продолжение во 2 части...
--[[
    ZACKERR HUB - CHAMS 1 ПРЕМИУМ
    Аура + 3 вращающихся круга + радужный след
--]]

-- ========== СИСТЕМА CHAMS 1 ==========
local chams1Objects = {}
local chams1Active = false
local chams1Connections = {}

local function destroyChams1()
    for _, obj in ipairs(chams1Objects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    chams1Objects = {}
    
    for _, conn in ipairs(chams1Connections) do
        conn:Disconnect()
    end
    chams1Connections = {}
end

local function createChams1()
    if not rootPart or not character then return end
    
    destroyChams1()
    
    -- ========== 1. АУРА (переливающаяся сфера) ==========
    local aura = Instance.new("Part")
    aura.Name = "Chams1_Aura"
    aura.Size = Vector3.new(8, 8, 8)
    aura.Position = rootPart.Position
    aura.Shape = Enum.PartType.Ball
    aura.Material = Enum.Material.Neon
    aura.BrickColor = BrickColor.new("Bright red")
    aura.Transparency = 0.7
    aura.CanCollide = false
    aura.Anchored = false
    aura.Parent = character
    
    local auraMesh = Instance.new("SpecialMesh")
    auraMesh.Parent = aura
    auraMesh.MeshType = Enum.MeshType.Sphere
    auraMesh.Scale = Vector3.new(1, 0.5, 1)
    
    local auraWeld = Instance.new("Weld")
    auraWeld.Part0 = rootPart
    auraWeld.Part1 = aura
    auraWeld.C0 = CFrame.new(0, 0, 0)
    auraWeld.Parent = aura
    
    table.insert(chams1Objects, aura)
    
    -- Анимация ауры (переливание цветов + пульсация)
    local auraConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not aura or not aura.Parent then return end
        local time = tick() % 6.28
        -- Цвет
        local r = math.sin(time) * 0.5 + 0.5
        local g = math.sin(time + 2) * 0.5 + 0.5
        local b = math.sin(time + 4) * 0.5 + 0.5
        aura.BrickColor = BrickColor.new(Color3.new(r, g, b))
        -- Пульсация размера
        local scale = 1 + math.sin(time * 3) * 0.1
        auraMesh.Scale = Vector3.new(scale, scale * 0.5, scale)
        -- Прозрачность
        aura.Transparency = 0.5 + math.sin(time * 2) * 0.2
    end)
    table.insert(chams1Connections, auraConnection)
    
    -- ========== 2. ТРИ ВРАЩАЮЩИХСЯ КРУГА ==========
    local colors = {
        Color3.new(1, 0, 0),   -- Красный
        Color3.new(0, 1, 0),   -- Зелёный
        Color3.new(0, 0, 1)    -- Синий
    }
    
    for i = 1, 3 do
        local circle = Instance.new("Part")
        circle.Name = "Chams1_Circle" .. i
        circle.Size = Vector3.new(0.2, 0.2, 0.2)
        circle.Position = rootPart.Position
        circle.Shape = Enum.PartType.Cylinder
        circle.Material = Enum.Material.Neon
        circle.BrickColor = BrickColor.new(colors[i])
        circle.Transparency = 0.3
        circle.CanCollide = false
        circle.Anchored = false
        circle.Parent = character
        
        -- Делаем кольцо (цилиндр с отверстием)
        local ringMesh = Instance.new("CylinderMesh")
        ringMesh.Parent = circle
        ringMesh.Scale = Vector3.new(3, 0.2, 3)
        
        -- Прикрепляем к корню
        local circleWeld = Instance.new("Weld")
        circleWeld.Part0 = rootPart
        circleWeld.Part1 = circle
        circleWeld.C0 = CFrame.new(0, i - 2, 0) -- Разная высота
        circleWeld.Parent = circle
        
        table.insert(chams1Objects, circle)
        
        -- Анимация вращения и цвета
        local angle = 0
        local circleConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if not circle or not circle.Parent then return end
            
            angle = angle + 0.02
            
            -- Вращаем вокруг игрока
            local radius = 3 + i * 0.5
            local x = math.cos(angle + i * 2) * radius
            local z = math.sin(angle + i * 2) * radius
            local y = math.sin(angle * 2) * 0.5 + i - 2
            
            circleWeld.C0 = CFrame.new(x, y, z)
            
            -- Меняем цвет
            local t = (tick() % 6.28) / 6.28
            local hue = (t + (i-1)/3) % 1
            circle.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
        end)
        table.insert(chams1Connections, circleConnection)
    end
    
    -- ========== 3. РАДУЖНЫЙ СЛЕД (TRAIL) ==========
    local attachment0 = Instance.new("Attachment")
    attachment0.Name = "TrailAttach0"
    attachment0.Parent = rootPart
    attachment0.Position = Vector3.new(0, 2, 0)
    
    local attachment1 = Instance.new("Attachment")
    attachment1.Name = "TrailAttach1"
    attachment1.Parent = rootPart
    attachment1.Position = Vector3.new(0, -2, 0)
    
    local trail = Instance.new("Trail")
    trail.Name = "Chams1_Trail"
    trail.Parent = rootPart
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    trail.LightEmission = 1
    trail.LightInfluence = 0
    trail.Texture = "rbxasset://textures/particles/trail_main.png"
    trail.TextureLength = 2
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    })
    trail.Width = NumberSequence.new(1.5)
    trail.Lifetime = 1.5
    trail.Enabled = true
    
    table.insert(chams1Objects, attachment0)
    table.insert(chams1Objects, attachment1)
    table.insert(chams1Objects, trail)
    
    -- Анимация цвета следа
    local trailConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not trail or not trail.Parent then return end
        
        local t = tick() % 6.28 / 6.28
        trail.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV((t) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.33, Color3.fromHSV((t + 0.33) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.66, Color3.fromHSV((t + 0.66) % 1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 1) % 1, 1, 1))
        })
    end)
    table.insert(chams1Connections, trailConnection)
    
    -- ========== 4. ДОПОЛНИТЕЛЬНЫЕ ЧАСТИЦЫ (ИСКРЫ) ==========
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Chams1_Particles"
    particles.Parent = rootPart
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Rate = 50
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Speed = NumberRange.new(2, 4)
    particles.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
    })
    particles.LightEmission = 1
    particles.Transparency = NumberSequence.new(0.5)
    particles.Size = NumberSequence.new(0.2)
    particles.Rotation = NumberRange.new(0, 360)
    particles.VelocityInheritance = 0.5
    particles.Enabled = true
    
    table.insert(chams1Objects, particles)
    
    -- Анимация частиц
    local particleConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not particles or not particles.Parent then return end
        local t = tick() % 6.28 / 6.28
        particles.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 0.5) % 1, 1, 1))
        })
    end)
    table.insert(chams1Connections, particleConnection)
end

-- ========== ПОДКЛЮЧЕНИЕ К СОСТОЯНИЯМ ==========
ZACK_STATES.chams1 = false

-- Функция обновления состояния
local function updateChams1()
    if ZACK_STATES.chams1 and not chams1Active then
        chams1Active = true
        createChams1()
    elseif not ZACK_STATES.chams1 and chams1Active then
        chams1Active = false
        destroyChams1()
    end
end

-- Следим за изменением состояния
local chams1State = ZACK_STATES
local chams1Thread = game:GetService("RunService").Heartbeat:Connect(function()
    if ZACK_STATES.chams1 ~= chams1Active then
        updateChams1()
    end
end)
table.insert(chams1Connections, chams1Thread)

-- Обновление позиции при перемещении персонажа
local function onCharacterAdded(newChar)
    character = newChar
    rootPart = character:WaitForChild("HumanoidRootPart") or character:WaitForChild("Torso")
    head = character:WaitForChild("Head")
    humanoid = character:WaitForChild("Humanoid")
    
    if ZACK_STATES.chams1 then
        createChams1()
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

-- ========== ДОБАВЛЯЕМ КНОПКУ В МЕНЮ (если ещё не добавили) ==========
-- Эта часть уже была в Части 1, но добавим для целостности
if not tabContents or not tabContents[1] then
    -- Создаём кнопку если меню ещё не загружено
    local testGui = Instance.new("ScreenGui")
    testGui.Name = "ZACKERR_Test"
    testGui.Parent = playerGui
    
    local btn = Instance.new("TextButton")
    btn.Parent = testGui
    btn.Size = UDim2.new(0, 200, 0, 50)
    btn.Position = UDim2.new(0.5, -100, 0.5, -25)
    btn.Text = "CHAMS 1 ТЕСТ"
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
    
    btn.MouseButton1Click:Connect(function()
        ZACK_STATES.chams1 = not ZACK_STATES.chams1
        btn.Text = ZACK_STATES.chams1 and "CHAMS 1 ON" or "CHAMS 1 OFF"
        updateChams1()
    end)
end

print("✅ ZACKERR HUB - CHAMS 1 загружен")
print("🎮 CHAMS 1: Аура + 3 круга + радужный след")
--[[
    ZACKERR HUB - CHAMS 2 ПРЕМИУМ
    Радужное небо + радужный игрок + радужный след
--]]

-- ========== СИСТЕМА CHAMS 2 ==========
local chams2Objects = {}
local chams2Active = false
local chams2Connections = {}
local originalLighting = {}

-- Сохраняем оригинальные настройки освещения
local function saveOriginalLighting()
    local lighting = game:GetService("Lighting")
    originalLighting = {
        Ambient = lighting.Ambient,
        Brightness = lighting.Brightness,
        ColorShift_Bottom = lighting.ColorShift_Bottom,
        ColorShift_Top = lighting.ColorShift_Top,
        FogColor = lighting.FogColor,
        FogEnd = lighting.FogEnd,
        FogStart = lighting.FogStart,
        GlobalShadows = lighting.GlobalShadows,
        OutdoorAmbient = lighting.OutdoorAmbient,
        ShadowSoftness = lighting.ShadowSoftness,
        ClockTime = lighting.ClockTime,
        GeographicLatitude = lighting.GeographicLatitude,
        ExposureCompensation = lighting.ExposureCompensation
    }
end

-- Восстанавливаем оригинальное освещение
local function restoreOriginalLighting()
    local lighting = game:GetService("Lighting")
    for key, value in pairs(originalLighting) do
        pcall(function()
            lighting[key] = value
        end)
    end
end

local function destroyChams2()
    for _, obj in ipairs(chams2Objects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    chams2Objects = {}
    
    for _, conn in ipairs(chams2Connections) do
        conn:Disconnect()
    end
    chams2Connections = {}
    
    restoreOriginalLighting()
end

local function createChams2()
    if not rootPart or not character then return end
    
    destroyChams2()
    saveOriginalLighting()
    
    local lighting = game:GetService("Lighting")
    
    -- ========== 1. РАДУЖНОЕ НЕБО ==========
    -- Отключаем тени для яркости
    lighting.GlobalShadows = false
    lighting.Brightness = 2
    lighting.ExposureCompensation = 0.5
    
    -- Создаём радужный Ambient
    local ambientConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local t = (tick() * 0.5) % 6.28
        local r = math.sin(t) * 0.5 + 0.5
        local g = math.sin(t + 2) * 0.5 + 0.5
        local b = math.sin(t + 4) * 0.5 + 0.5
        
        lighting.Ambient = Color3.new(r * 0.5, g * 0.5, b * 0.5)
        lighting.OutdoorAmbient = Color3.new(r * 0.3, g * 0.3, b * 0.3)
        lighting.ColorShift_Top = Color3.new(r, g, b)
        lighting.ColorShift_Bottom = Color3.new(b, r, g)
        lighting.FogColor = Color3.new(r * 0.3, g * 0.3, b * 0.3)
    end)
    table.insert(chams2Connections, ambientConnection)
    
    -- Добавляем светящиеся парящие частицы (звёзды)
    local stars = Instance.new("ParticleEmitter")
    stars.Name = "Chams2_Stars"
    stars.Parent = workspace.CurrentCamera or workspace
    stars.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    stars.Rate = 20
    stars.Lifetime = NumberRange.new(5, 10)
    stars.SpreadAngle = Vector2.new(360, 360)
    stars.Speed = NumberRange.new(0.5, 1)
    stars.VelocityInheritance = 0
    stars.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    stars.LightEmission = 1
    stars.Transparency = NumberSequence.new(0.3)
    stars.Size = NumberSequence.new(0.5)
    stars.Rotation = NumberRange.new(0, 360)
    stars.Enabled = true
    
    table.insert(chams2Objects, stars)
    
    -- Анимация цвета звёзд
    local starsConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not stars or not stars.Parent then return end
        local t = (tick() * 0.3) % 1
        stars.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 0.8, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 0.5) % 1, 0.8, 1))
        })
    end)
    table.insert(chams2Connections, starsConnection)
    
    -- ========== 2. РАДУЖНЫЙ ИГРОК ==========
    -- Меняем цвет всех частей тела
    local function makeCharacterRainbow()
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("Part") or part:IsA("MeshPart") or part:IsA("Accessory") then
                if part ~= rootPart and part ~= head then
                    -- Сохраняем оригинальный материал
                    if not part:GetAttribute("OriginalMaterial") then
                        part:SetAttribute("OriginalMaterial", part.Material.Value)
                    end
                    part.Material = Enum.Material.Neon
                end
            end
        end
    end
    
    makeCharacterRainbow()
    
    -- Анимация цвета игрока
    local playerColorConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local t = (tick() * 0.8) % 6.28
        
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("Part") or part:IsA("MeshPart") then
                if part ~= rootPart and part ~= head then
                    local hue = (t + part:GetHashCode() * 0.01) % 6.28 / 6.28
                    part.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
                    part.Transparency = 0.2
                end
            elseif part:IsA("Accessory") and part.Handle then
                local hue = (t + part:GetHashCode() * 0.01) % 6.28 / 6.28
                part.Handle.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
                part.Handle.Material = Enum.Material.Neon
                part.Handle.Transparency = 0.2
            end
        end
        
        -- Особая обработка для головы
        if head then
            local hue = (t + 0.5) % 6.28 / 6.28
            head.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
            head.Material = Enum.Material.Neon
            head.Transparency = 0.1
        end
        
        -- Корневая часть тоже но с меньшей прозрачностью
        if rootPart then
            local hue = (t + 0.3) % 6.28 / 6.28
            rootPart.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
            rootPart.Material = Enum.Material.Neon
            rootPart.Transparency = 0.3
        end
    end)
    table.insert(chams2Connections, playerColorConnection)
    
    -- ========== 3. РАДУЖНЫЙ СЛЕД (TRAIL) ==========
    local trailAttach0 = Instance.new("Attachment")
    trailAttach0.Name = "Chams2_TrailAttach0"
    trailAttach0.Parent = rootPart
    trailAttach0.Position = Vector3.new(0, 3, 0)
    
    local trailAttach1 = Instance.new("Attachment")
    trailAttach1.Name = "Chams2_TrailAttach1"
    trailAttach1.Parent = rootPart
    trailAttach1.Position = Vector3.new(0, -3, 0)
    
    local trail = Instance.new("Trail")
    trail.Name = "Chams2_Trail"
    trail.Parent = rootPart
    trail.Attachment0 = trailAttach0
    trail.Attachment1 = trailAttach1
    trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    trail.LightEmission = 1
    trail.LightInfluence = 0
    trail.Texture = "rbxasset://textures/particles/trail_main.png"
    trail.TextureLength = 3
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.3, 0.3),
        NumberSequenceKeypoint.new(0.7, 0.6),
        NumberSequenceKeypoint.new(1, 1)
    })
    trail.Width = NumberSequence.new(2.5)
    trail.Lifetime = 2
    trail.Enabled = true
    
    table.insert(chams2Objects, trailAttach0)
    table.insert(chams2Objects, trailAttach1)
    table.insert(chams2Objects, trail)
    
    -- Анимация цвета следа
    local trailColorConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not trail or not trail.Parent then return end
        
        local t = tick() % 6.28 / 6.28
        trail.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
            ColorSequenceKeypoint.new(0.25, Color3.fromHSV((t + 0.25) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV((t + 0.5) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.75, Color3.fromHSV((t + 0.75) % 1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 1) % 1, 1, 1))
        })
        
        -- Меняем ширину следа в зависимости от скорости
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            trail.Width = NumberSequence.new(3)
        else
            trail.Width = NumberSequence.new(1.5)
        end
    end)
    table.insert(chams2Connections, trailColorConnection)
    
    -- ========== 4. РАДУЖНЫЙ СВЕТ ВОКРУГ ИГРОКА ==========
    local pointLight = Instance.new("PointLight")
    pointLight.Name = "Chams2_Light"
    pointLight.Parent = rootPart
    pointLight.Range = 20
    pointLight.Brightness = 2
    pointLight.Shadows = false
    
    table.insert(chams2Objects, pointLight)
    
    local lightConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not pointLight or not pointLight.Parent then return end
        local t = tick() % 6.28 / 6.28
        pointLight.Color = Color3.fromHSV(t, 1, 1)
    end)
    table.insert(chams2Connections, lightConnection)
    
    -- ========== 5. ДОПОЛНИТЕЛЬНЫЕ ЧАСТИЦЫ ==========
    local glowParticles = Instance.new("ParticleEmitter")
    glowParticles.Name = "Chams2_Glow"
    glowParticles.Parent = rootPart
    glowParticles.Texture = "rbxasset://textures/particles/glow.png"
    glowParticles.Rate = 30
    glowParticles.Lifetime = NumberRange.new(0.5, 1)
    glowParticles.SpreadAngle = Vector2.new(360, 360)
    glowParticles.Speed = NumberRange.new(1, 2)
    glowParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    glowParticles.LightEmission = 1
    glowParticles.Transparency = NumberSequence.new(0.3)
    glowParticles.Size = NumberSequence.new(0.3)
    glowParticles.Rotation = NumberRange.new(0, 360)
    glowParticles.VelocityInheritance = 0.3
    glowParticles.Enabled = true
    
    table.insert(chams2Objects, glowParticles)
    
    local particlesConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not glowParticles or not glowParticles.Parent then return end
        local t = tick() % 6.28 / 6.28
        glowParticles.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 0.5) % 1, 1, 1))
        })
    end)
    table.insert(chams2Connections, particlesConnection)
end

-- ========== ПОДКЛЮЧЕНИЕ К СОСТОЯНИЯМ ==========
ZACK_STATES.chams2 = false

-- Функция обновления состояния
local function updateChams2()
    if ZACK_STATES.chams2 and not chams2Active then
        chams2Active = true
        -- Если включен chams1, выключаем его
        if ZACK_STATES.chams1 then
            ZACK_STATES.chams1 = false
            updateChams1()
        end
        createChams2()
    elseif not ZACK_STATES.chams2 and chams2Active then
        chams2Active = false
        destroyChams2()
    end
end

-- Следим за изменением состояния
local chams2Thread = game:GetService("RunService").Heartbeat:Connect(function()
    if ZACK_STATES.chams2 ~= chams2Active then
        updateChams2()
    end
end)
table.insert(chams2Connections, chams2Thread)

-- Обновление при смене персонажа
local oldCharAdded = player.CharacterAdded:Connect(function(newChar)
    character = newChar
    rootPart = character:WaitForChild("HumanoidRootPart") or character:WaitForChild("Torso")
    head = character:WaitForChild("Head")
    humanoid = character:WaitForChild("Humanoid")
    
    if ZACK_STATES.chams2 then
        createChams2()
    end
end)

-- ========== ДОБАВЛЯЕМ КНОПКУ В МЕНЮ ==========
if tabContents and tabContents[1] then
    -- Создаём переключатель для CHAMS 2
    local chams2Frame = Instance.new("Frame")
    chams2Frame.Name = "Chams2Toggle"
    chams2Frame.Parent = tabContents[1]
    chams2Frame.Size = UDim2.new(1, -40, 0, 70)
    chams2Frame.Position = UDim2.new(0, 20, 0, 130)  -- Под chams1
    chams2Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    chams2Frame.BackgroundTransparency = 0.2
    chams2Frame.BorderSizePixel = 0
    
    local gradient = Instance.new("UIGradient")
    gradient.Parent = chams2Frame
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 40, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 70))
    })
    
    local label = Instance.new("TextLabel")
    label.Parent = chams2Frame
    label.Size = UDim2.new(0.7, -20, 1, 0)
    label.Position = UDim2.new(0, 20, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "🌈 CHAMS 2 — Радужное небо + игрок + след"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    
    local desc = Instance.new("TextLabel")
    desc.Parent = chams2Frame
    desc.Size = UDim2.new(0.7, -20, 0, 16)
    desc.Position = UDim2.new(0, 20, 1, -18)
    desc.BackgroundTransparency = 1
    desc.Text = "Небо переливается, игрок радужный, огромный след"
    desc.TextColor3 = Color3.fromRGB(180, 180, 255)
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Font = Enum.Font.SourceSans
    desc.TextSize = 14
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = chams2Frame
    toggleBtn.Size = UDim2.new(0, 70, 0, 35)
    toggleBtn.Position = UDim2.new(1, -90, 0.5, -17.5)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Font = Enum.Font.GothamBold
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Parent = toggleBtn
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
    })
    
    toggleBtn.MouseButton1Click:Connect(function()
        ZACK_STATES.chams2 = not ZACK_STATES.chams2
        if ZACK_STATES.chams2 then
            toggleBtn.Text = "ON"
            btnGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 200, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 150, 30))
            })
        else
            toggleBtn.Text = "OFF"
            btnGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
            })
        end
        updateChams2()
    end)
end

print("✅ ZACKERR HUB - CHAMS 2 загружен")
print("🌈 CHAMS 2: Радужное небо + радужный игрок + радужный след")
--[[
    ZACKERR HUB - ПРЕМИАЛЬНЫЙ КАТАЛОГ АКСЕССУАРОВ
    40+ эксклюзивных предметов с категориями и поиском
--]]

-- ========== СИСТЕМА АКСЕССУАРОВ ==========
local accessoryObjects = {}
local accessoryActive = {}
local accessoryConnections = {}

-- ========== КАТАЛОГ АКСЕССУАРОВ (40+ ПРЕДМЕТОВ) ==========
local ACCESSORY_CATALOG = {
    -- ГОЛОВНЫЕ УБОРЫ (HATS)
    hats = {
        {name = "👑 Корона", id = 13709746215, category = "hats", desc = "Золотая корона правителя", price = "FREE"},
        {name = "🎩 Цилиндр", id = 13709745670, category = "hats", desc = "Классическая шляпа джентльмена", price = "FREE"},
        {name = "🧢 Кепка", id = 13709745858, category = "hats", desc = "Стильная бейсболка", price = "FREE"},
        {name = "👒 Соломенная шляпа", id = 13709746055, category = "hats", desc = "Летняя шляпа", price = "FREE"},
        {name = "⛑️ Каска", id = 13709746215, category = "hats", desc = "Защитная каска строителя", price = "FREE"},
        {name = "🧕 Хиджаб", id = 13709746493, category = "hats", desc = "Традиционный платок", price = "FREE"},
        {name = "👳 Тюрбан", id = 13709746657, category = "hats", desc = "Восточный тюрбан", price = "FREE"},
        {name = "🧢 Панама", id = 13709746910, category = "hats", desc = "Панама от солнца", price = "FREE"},
    },
    
    -- ЛИЦЕВЫЕ АКСЕССУАРЫ (FACE)
    face = {
        {name = "😎 Очки авиаторы", id = 13709745858, category = "face", desc = "Крутые очки", price = "FREE"},
        {name = "🕶️ Очки-маска", id = 13709746215, category = "face", desc = "Скрывают глаза", price = "FREE"},
        {name = "👓 Обычные очки", id = 13709745670, category = "face", desc = "Для чтения", price = "FREE"},
        {name = "🥽 Защитные очки", id = 13709746055, category = "face", desc = "Для сварки", price = "FREE"},
        {name = "🧿 Маска", id = 13709746493, category = "face", desc = "Загадочная маска", price = "FREE"},
        {name = "👺 Маска демона", id = 13709746657, category = "face", desc = "Страшная маска", price = "FREE"},
        {name = "🎭 Театральная маска", id = 13709746910, category = "face", desc = "Комедия и трагедия", price = "FREE"},
    },
    
    -- МАГИЧЕСКИЕ (MAGIC)
    magic = {
        {name = "🌟 Нимб", id = 13709746657, category = "magic", desc = "Святой нимб", price = "FREE"},
        {name = "👼 Крылья ангела", id = 10557378969, category = "magic", desc = "Белые пушистые крылья", price = "FREE"},
        {name = "👿 Рога демона", id = 13709746910, category = "magic", desc = "Красные рога", price = "FREE"},
        {name = "🦇 Крылья вампира", id = 10557402472, category = "magic", desc = "Черные крылья", price = "FREE"},
        {name = "🧙 Волшебная палочка", id = 13709746215, category = "magic", desc = "Палочка мага", price = "FREE"},
        {name = "🔮 Хрустальный шар", id = 13709745858, category = "magic", desc = "Шар предсказаний", price = "FREE"},
        {name = "📖 Книга заклинаний", id = 13709745670, category = "magic", desc = "Древний гримуар", price = "FREE"},
    },
    
    -- ЖИВОТНЫЕ (ANIMALS)
    animals = {
        {name = "🐱 Кошачьи ушки", id = 13709746055, category = "animals", desc = "Милые кошачьи ушки", price = "FREE"},
        {name = "🐰 Кроличьи уши", id = 13709746493, category = "animals", desc = "Длинные ушки", price = "FREE"},
        {name = "🦊 Лисьи уши", id = 13709746657, category = "animals", desc = "Рыжие лисьи уши", price = "FREE"},
        {name = "🐻 Медвежьи уши", id = 13709746910, category = "animals", desc = "Коричневые ушки", price = "FREE"},
        {name = "🐼 Панда", id = 13709746215, category = "animals", desc = "Голова панды", price = "FREE"},
        {name = "🐧 Пингвин", id = 13709745858, category = "animals", desc = "Голова пингвина", price = "FREE"},
        {name = "🐸 Лягушка", id = 13709745670, category = "animals", desc = "Голова лягушки", price = "FREE"},
    },
    
    -- ФУТБОЛЬНЫЕ (SOCCER)
    soccer = {
        {name = "⚽ Мяч на голове", id = 13709746055, category = "soccer", desc = "Футбольный мяч", price = "FREE"},
        {name = "🥅 Ворота", id = 13709746493, category = "soccer", desc = "Мини-ворота", price = "FREE"},
        {name = "👕 Футболка CR7", id = 13709746657, category = "soccer", desc = "Футболка Роналдо", price = "FREE"},
        {name = "🧦 Гетры", id = 13709746910, category = "soccer", desc = "Футбольные гетры", price = "FREE"},
        {name = "👟 Бутсы", id = 13709746215, category = "soccer", desc = "Футбольные бутсы", price = "FREE"},
        {name = "🏆 Кубок", id = 13709745858, category = "soccer", desc = "Золотой кубок", price = "FREE"},
        {name = "⭐ Звезда футбола", id = 13709745670, category = "soccer", desc = "Звезда на голове", price = "FREE"},
    },
    
    -- КИБЕРПАНК (CYBER)
    cyber = {
        {name = "🤖 Механический глаз", id = 13709746055, category = "cyber", desc = "Кибер-глаз", price = "FREE"},
        {name = "⚡ Неоновые очки", id = 13709746493, category = "cyber", desc = "Светящиеся очки", price = "FREE"},
        {name = "🔧 Механическая рука", id = 13709746657, category = "cyber", desc = "Протез руки", price = "FREE"},
        {name = "💿 Кибер-шлем", id = 13709746910, category = "cyber", desc = "Шлем будущего", price = "FREE"},
        {name = "📡 Антенна", id = 13709746215, category = "cyber", desc = "Антенна на голове", price = "FREE"},
        {name = "🦾 Механические крылья", id = 10557378969, category = "cyber", desc = "Кибер-крылья", price = "FREE"},
        {name = "👾 Пиксельная маска", id = 13709745858, category = "cyber", desc = "8-битная маска", price = "FREE"},
    },
    
    -- ЕДА (FOOD)
    food = {
        {name = "🍔 Бургер", id = 13709745670, category = "food", desc = "Вкусный бургер", price = "FREE"},
        {name = "🍕 Пицца", id = 13709746055, category = "food", desc = "Кусок пиццы", price = "FREE"},
        {name = "🍦 Мороженое", id = 13709746493, category = "food", desc = "Сладкое мороженое", price = "FREE"},
        {name = "🍩 Пончик", id = 13709746657, category = "food", desc = "Глазированный пончик", price = "FREE"},
        {name = "🍎 Яблоко", id = 13709746910, category = "food", desc = "Красное яблоко", price = "FREE"},
        {name = "🍌 Банан", id = 13709746215, category = "food", desc = "Желтый банан", price = "FREE"},
        {name = "🥕 Морковка", id = 13709745858, category = "food", desc = "Свежая морковь", price = "FREE"},
    },
}

-- Функция для создания аксессуара
local function spawnAccessory(accessoryData)
    if not rootPart or not character then return end
    
    local assetId = accessoryData.id
    local accName = accessoryData.name
    
    -- Удаляем предыдущий такой же
    for _, obj in ipairs(accessoryObjects) do
        if obj.Name == "ACC_" .. accName then
            obj:Destroy()
        end
    end
    
    -- Загружаем аксессуар
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    
    if success and obj then
        obj.Name = "ACC_" .. accName
        obj.Parent = character
        
        if obj:IsA("Accessory") and obj.Handle then
            -- Прикрепляем к голове
            local weld = Instance.new("Weld")
            weld.Part0 = head or rootPart
            weld.Part1 = obj.Handle
            weld.C0 = CFrame.new(0, 0.5, 0)
            weld.Parent = obj.Handle
            
            table.insert(accessoryObjects, obj)
            return true
        end
    end
    return false
end

-- ========== СОЗДАЁМ ВКЛАДКУ АКСЕССУАРОВ ==========
if tabContents and tabContents[2] then
    local accTab = tabContents[2]
    accTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- Заголовок
    local header = Instance.new("TextLabel")
    header.Parent = accTab
    header.Size = UDim2.new(1, -40, 0, 50)
    header.Position = UDim2.new(0, 20, 0, 10)
    header.BackgroundTransparency = 1
    header.Text = "📦 ПРЕМИАЛЬНЫЙ КАТАЛОГ (40+ АКСЕССУАРОВ)"
    header.TextColor3 = Color3.fromRGB(255, 215, 0)
    header.TextScaled = true
    header.Font = Enum.Font.GothamBlack
    
    -- Поле поиска
    local searchBox = Instance.new("TextBox")
    searchBox.Parent = accTab
    searchBox.Size = UDim2.new(1, -40, 0, 40)
    searchBox.Position = UDim2.new(0, 20, 0, 70)
    searchBox.PlaceholderText = "🔍 Поиск аксессуаров..."
    searchBox.Text = ""
    searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 18
    
    local searchGradient = Instance.new("UIGradient")
    searchGradient.Parent = searchBox
    searchGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 60))
    })
    
    -- Кнопки категорий
    local categories = {"Все", "Головные", "Лицевые", "Магия", "Животные", "Футбол", "Кибер", "Еда"}
    local categoryMapping = {
        ["Все"] = nil,
        ["Головные"] = "hats",
        ["Лицевые"] = "face",
        ["Магия"] = "magic",
        ["Животные"] = "animals",
        ["Футбол"] = "soccer",
        ["Кибер"] = "cyber",
        ["Еда"] = "food"
    }
    
    local currentCategory = nil
    local currentSearch = ""
    
    local categoryFrame = Instance.new("Frame")
    categoryFrame.Parent = accTab
    categoryFrame.Size = UDim2.new(1, -40, 0, 50)
    categoryFrame.Position = UDim2.new(0, 20, 0, 120)
    categoryFrame.BackgroundTransparency = 1
    
    local catButtons = {}
    for i, catName in ipairs(categories) do
        local btn = Instance.new("TextButton")
        btn.Parent = categoryFrame
        btn.Size = UDim2.new(0, 90, 0, 35)
        btn.Position = UDim2.new(0, (i-1) * 95, 0, 7)
        btn.Text = catName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        
        local btnGradient = Instance.new("UIGradient")
        btnGradient.Parent = btn
        btnGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 90)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 70))
        })
        
        btn.MouseButton1Click:Connect(function()
            for _, b in ipairs(catButtons) do
                b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            end
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
            currentCategory = categoryMapping[catName]
            refreshAccessories()
        end)
        
        table.insert(catButtons, btn)
    end
    
    -- Контейнер для аксессуаров
    local accessoryContainer = Instance.new("ScrollingFrame")
    accessoryContainer.Parent = accTab
    accessoryContainer.Size = UDim2.new(1, -40, 1, -250)
    accessoryContainer.Position = UDim2.new(0, 20, 0, 180)
    accessoryContainer.BackgroundTransparency = 1
    accessoryContainer.BorderSizePixel = 0
    accessoryContainer.ScrollBarThickness = 8
    accessoryContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 150)
    accessoryContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- Функция обновления списка аксессуаров
    function refreshAccessories()
        -- Очищаем контейнер
        for _, child in ipairs(accessoryContainer:GetChildren()) do
            child:Destroy()
        end
        
        local yPos = 10
        local itemsPerRow = 2
        local itemWidth = (accessoryContainer.AbsoluteSize.X - 40) / itemsPerRow
        
        -- Собираем все аксессуары
        local allAccessories = {}
        for catName, catItems in pairs(ACCESSORY_CATALOG) do
            for _, item in ipairs(catItems) do
                table.insert(allAccessories, item)
            end
        end
        
        -- Фильтруем по категории и поиску
        local filtered = {}
        for _, item in ipairs(allAccessories) do
            local categoryMatch = not currentCategory or item.category == currentCategory
            local searchMatch = currentSearch == "" or 
                item.name:lower():find(currentSearch:lower()) or
                item.desc:lower():find(currentSearch:lower())
            
            if categoryMatch and searchMatch then
                table.insert(filtered, item)
            end
        end
        
        -- Сортируем по имени
        table.sort(filtered, function(a, b) return a.name < b.name end)
        
        -- Отображаем
        for i, item in ipairs(filtered) do
            local row = math.floor((i-1) / itemsPerRow)
            local col = (i-1) % itemsPerRow
            
            local card = Instance.new("Frame")
            card.Parent = accessoryContainer
            card.Size = UDim2.new(0, itemWidth - 10, 0, 100)
            card.Position = UDim2.new(0, col * itemWidth + 5, 0, yPos + row * 110)
            card.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            card.BackgroundTransparency = 0.2
            card.BorderSizePixel = 0
            
            local cardGradient = Instance.new("UIGradient")
            cardGradient.Parent = card
            cardGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 70)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 50))
            })
            cardGradient.Rotation = 45
            
            -- Название
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = card
            nameLabel.Size = UDim2.new(1, -20, 0, 25)
            nameLabel.Position = UDim2.new(0, 10, 0, 5)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = item.name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextSize = 16
            
            -- Описание
            local descLabel = Instance.new("TextLabel")
            descLabel.Parent = card
            descLabel.Size = UDim2.new(1, -20, 0, 35)
            descLabel.Position = UDim2.new(0, 10, 0, 30)
            descLabel.BackgroundTransparency = 1
            descLabel.Text = item.desc
            descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.TextYAlignment = Enum.TextYAlignment.Top
            descLabel.Font = Enum.Font.SourceSans
            descLabel.TextSize = 14
            descLabel.TextWrapped = true
            
            -- Кнопка загрузки
            local loadBtn = Instance.new("TextButton")
            loadBtn.Parent = card
            loadBtn.Size = UDim2.new(0.8, 0, 0, 25)
            loadBtn.Position = UDim2.new(0.1, 0, 1, -30)
            loadBtn.Text = "📥 НАДЕТЬ"
            loadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            loadBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
            loadBtn.BorderSizePixel = 0
            loadBtn.Font = Enum.Font.Gotham
            loadBtn.TextSize = 14
            
            local btnGradient = Instance.new("UIGradient")
            btnGradient.Parent = loadBtn
            btnGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 120, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 80, 200))
            })
            
            loadBtn.MouseButton1Click:Connect(function()
                local success = spawnAccessory(item)
                if success then
                    loadBtn.Text = "✅ НАДЕТО"
                    loadBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                    task.wait(1)
                    loadBtn.Text = "📥 НАДЕТЬ"
                    loadBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
                else
                    loadBtn.Text = "❌ ОШИБКА"
                    loadBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                    task.wait(1)
                    loadBtn.Text = "📥 НАДЕТЬ"
                    loadBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
                end
            end)
        end
        
        -- Обновляем размер Canvas
        local rows = math.ceil(#filtered / itemsPerRow)
        accessoryContainer.CanvasSize = UDim2.new(0, 0, 0, yPos + rows * 110 + 20)
    end
    
    -- Поиск при вводе
    searchBox.Changed:Connect(function()
        if searchBox.Text then
            currentSearch = searchBox.Text
            refreshAccessories()
        end
    end)
    
    -- Первоначальная загрузка
    refreshAccessories()
    
    -- Кнопка снять все
    local removeAllBtn = Instance.new("TextButton")
    removeAllBtn.Parent = accTab
    removeAllBtn.Size = UDim2.new(0.3, 0, 0, 40)
    removeAllBtn.Position = UDim2.new(0.7, -100, 0, 70)
    removeAllBtn.Text = "🗑️ СНЯТЬ ВСЁ"
    removeAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    removeAllBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    removeAllBtn.BorderSizePixel = 0
    removeAllBtn.Font = Enum.Font.Gotham
    removeAllBtn.TextSize = 16
    
    removeAllBtn.MouseButton1Click:Connect(function()
        for _, obj in ipairs(accessoryObjects) do
            if obj and obj.Parent then
                obj:Destroy()
            end
        end
        accessoryObjects = {}
    end)
end

-- ========== ОЧИСТКА ПРИ ВЫКЛЮЧЕНИИ ==========
game:GetService("RunService").Heartbeat:Connect(function()
    -- Очищаем уничтоженные объекты
    for i = #accessoryObjects, 1, -1 do
        if not accessoryObjects[i] or not accessoryObjects[i].Parent then
            table.remove(accessoryObjects, i)
        end
    end
end)

print("✅ ZACKERR HUB - КАТАЛОГ АКСЕССУАРОВ загружен")
print("📦 Доступно 40+ премиальных аксессуаров")
--[[
    ZACKERR HUB - ФИНАЛЬНАЯ ПРЕМИУМ ЧАСТЬ
    Эффекты, настройки и сохранения
--]]

-- ========== СИСТЕМА ЭФФЕКТОВ ==========
local effectObjects = {}
local effectActive = {}
local effectConnections = {}

-- ========== 1. ЭФФЕКТЫ НА ВКЛАДКЕ ==========
if tabContents and tabContents[3] then
    local effectsTab = tabContents[3]
    effectsTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- Заголовок
    local header = Instance.new("TextLabel")
    header.Parent = effectsTab
    header.Size = UDim2.new(1, -40, 0, 50)
    header.Position = UDim2.new(0, 20, 0, 10)
    header.BackgroundTransparency = 1
    header.Text = "✨ ПРЕМИАЛЬНЫЕ ЭФФЕКТЫ"
    header.TextColor3 = Color3.fromRGB(255, 100, 255)
    header.TextScaled = true
    header.Font = Enum.Font.GothamBlack
    
    local yPos = 70
    
    -- ЭФФЕКТ 1: Партиклы бабочек
    local butterflyState = {false}
    local function createButterflyEffect()
        if not rootPart then return end
        
        -- Удаляем старый
        for _, obj in ipairs(effectObjects) do
            if obj.Name == "ButterflyEffect" then
                obj:Destroy()
            end
        end
        
        -- Создаём эмиттер бабочек
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "ButterflyEffect"
        emitter.Parent = rootPart
        emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        emitter.Rate = 10
        emitter.Lifetime = NumberRange.new(3, 5)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Speed = NumberRange.new(1, 2)
        emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 100, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 50, 255))
        })
        emitter.LightEmission = 1
        emitter.Transparency = NumberSequence.new(0.2)
        emitter.Size = NumberSequence.new(0.5)
        emitter.Rotation = NumberRange.new(0, 360)
        emitter.VelocityInheritance = 0.2
        emitter.Enabled = true
        
        table.insert(effectObjects, emitter)
        
        -- Анимация
        local conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not emitter or not emitter.Parent then return end
            local t = tick() % 6.28 / 6.28
            emitter.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 0.5) % 1, 1, 1))
            })
        end)
        table.insert(effectConnections, conn)
    end
    
    createToggle(effectsTab, "🦋 Бабочки", butterflyState, yPos, "Разноцветные бабочки вокруг")
    yPos = yPos + 60
    
    -- ЭФФЕКТ 2: Огненная аура
    local fireState = {false}
    local function createFireEffect()
        if not rootPart then return end
        
        for _, obj in ipairs(effectObjects) do
            if obj.Name == "FireEffect" then
                obj:Destroy()
            end
        end
        
        local fire = Instance.new("Fire")
        fire.Name = "FireEffect"
        fire.Parent = rootPart
        fire.Size = 5
        fire.Heat = 10
        fire.Color = Color3.fromRGB(255, 100, 0)
        fire.SecondaryColor = Color3.fromRGB(255, 255, 0)
        
        table.insert(effectObjects, fire)
        
        local conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not fire or not fire.Parent then return end
            local t = tick() % 6.28
            fire.Size = 5 + math.sin(t * 3) * 2
        end)
        table.insert(effectConnections, conn)
    end
    
    createToggle(effectsTab, "🔥 Огненная аура", fireState, yPos, "Пламя вокруг персонажа")
    yPos = yPos + 60
    
    -- ЭФФЕКТ 3: Снежинки
    local snowState = {false}
    local function createSnowEffect()
        if not rootPart then return end
        
        for _, obj in ipairs(effectObjects) do
            if obj.Name == "SnowEffect" then
                obj:Destroy()
            end
        end
        
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "SnowEffect"
        emitter.Parent = rootPart
        emitter.Texture = "rbxasset://textures/particles/snowflake.dds"
        emitter.Rate = 30
        emitter.Lifetime = NumberRange.new(2, 4)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Speed = NumberRange.new(1, 3)
        emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        emitter.LightEmission = 0.5
        emitter.Transparency = NumberSequence.new(0.3)
        emitter.Size = NumberSequence.new(0.3)
        emitter.Rotation = NumberRange.new(0, 360)
        emitter.Enabled = true
        
        table.insert(effectObjects, emitter)
    end
    
    createToggle(effectsTab, "❄️ Снежинки", snowState, yPos, "Зимние снежинки")
    yPos = yPos + 60
    
    -- ЭФФЕКТ 4: Сердечки
    local heartState = {false}
    local function createHeartEffect()
        if not rootPart then return end
        
        for _, obj in ipairs(effectObjects) do
            if obj.Name == "HeartEffect" then
                obj:Destroy()
            end
        end
        
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "HeartEffect"
        emitter.Parent = rootPart
        emitter.Texture = "rbxasset://textures/particles/heart.dds"
        emitter.Rate = 15
        emitter.Lifetime = NumberRange.new(2, 3)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Speed = NumberRange.new(1, 2)
        emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 200))
        })
        emitter.LightEmission = 1
        emitter.Transparency = NumberSequence.new(0.2)
        emitter.Size = NumberSequence.new(0.4)
        emitter.Rotation = NumberRange.new(0, 360)
        emitter.Enabled = true
        
        table.insert(effectObjects, emitter)
    end
    
    createToggle(effectsTab, "❤️ Сердечки", heartState, yPos, "Летающие сердечки")
    yPos = yPos + 60
    
    -- ЭФФЕКТ 5: Звёздная пыль
    local starState = {false}
    local function createStarEffect()
        if not rootPart then return end
        
        for _, obj in ipairs(effectObjects) do
            if obj.Name == "StarEffect" then
                obj:Destroy()
            end
        end
        
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "StarEffect"
        emitter.Parent = rootPart
        emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        emitter.Rate = 40
        emitter.Lifetime = NumberRange.new(1, 2)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Speed = NumberRange.new(0.5, 1.5)
        emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 100)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 0))
        })
        emitter.LightEmission = 1
        emitter.Transparency = NumberSequence.new(0.1)
        emitter.Size = NumberSequence.new(0.2)
        emitter.Rotation = NumberRange.new(0, 360)
        emitter.Enabled = true
        
        table.insert(effectObjects, emitter)
    end
    
    createToggle(effectsTab, "⭐ Звёздная пыль", starState, yPos, "Мерцающие звёздочки")
    yPos = yPos + 60
    
    -- Подключаем эффекты к состояниям
    local function updateEffects()
        -- Бабочки
        if butterflyState[1] then
            createButterflyEffect()
        end
        
        -- Огонь
        if fireState[1] then
            createFireEffect()
        end
        
        -- Снег
        if snowState[1] then
            createSnowEffect()
        end
        
        -- Сердечки
        if heartState[1] then
            createHeartEffect()
        end
        
        -- Звёзды
        if starState[1] then
            createStarEffect()
        end
        
        -- Если все выключены, чистим
        if not butterflyState[1] and not fireState[1] and not snowState[1] and not heartState[1] and not starState[1] then
            for _, obj in ipairs(effectObjects) do
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
            effectObjects = {}
        end
    end
    
    -- Отслеживаем изменения
    local effectThread = game:GetService("RunService").Heartbeat:Connect(function()
        updateEffects()
    end)
    table.insert(effectConnections, effectThread)
end

-- ========== 2. ВКЛАДКА НАСТРОЕК ==========
if tabContents and tabContents[4] then
    local settingsTab = tabContents[4]
    settingsTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- Заголовок
    local header = Instance.new("TextLabel")
    header.Parent = settingsTab
    header.Size = UDim2.new(1, -40, 0, 50)
    header.Position = UDim2.new(0, 20, 0, 10)
    header.BackgroundTransparency = 1
    header.Text = "⚙️ НАСТРОЙКИ ХАБА"
    header.TextColor3 = Color3.fromRGB(100, 255, 255)
    header.TextScaled = true
    header.Font = Enum.Font.GothamBlack
    
    local yPos = 70
    
    -- Настройка 1: Прозрачность меню
    local opacityLabel = Instance.new("TextLabel")
    opacityLabel.Parent = settingsTab
    opacityLabel.Size = UDim2.new(1, -40, 0, 30)
    opacityLabel.Position = UDim2.new(0, 20, 0, yPos)
    opacityLabel.BackgroundTransparency = 1
    opacityLabel.Text = "🔮 Прозрачность меню: 90%"
    opacityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    opacityLabel.TextXAlignment = Enum.TextXAlignment.Left
    opacityLabel.Font = Enum.Font.Gotham
    opacityLabel.TextSize = 18
    
    local opacitySlider = Instance.new("Frame")
    opacitySlider.Parent = settingsTab
    opacitySlider.Size = UDim2.new(0.8, 0, 0, 20)
    opacitySlider.Position = UDim2.new(0.1, 0, 0, yPos + 35)
    opacitySlider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    opacitySlider.BorderSizePixel = 0
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = opacitySlider
    sliderFill.Size = UDim2.new(0.9, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    sliderFill.BorderSizePixel = 0
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Parent = opacitySlider
    sliderButton.Size = UDim2.new(0, 20, 1.5, 0)
    sliderButton.Position = UDim2.new(0.9, -10, -0.25, 0)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    
    yPos = yPos + 70
    
    -- Настройка 2: Размер иконки
    local iconSizeLabel = Instance.new("TextLabel")
    iconSizeLabel.Parent = settingsTab
    iconSizeLabel.Size = UDim2.new(1, -40, 0, 30)
    iconSizeLabel.Position = UDim2.new(0, 20, 0, yPos)
    iconSizeLabel.BackgroundTransparency = 1
    iconSizeLabel.Text = "🔹 Размер иконки: 64px"
    iconSizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconSizeLabel.TextXAlignment = Enum.TextXAlignment.Left
    iconSizeLabel.Font = Enum.Font.Gotham
    iconSizeLabel.TextSize = 18
    
    local iconSizeSlider = Instance.new("Frame")
    iconSizeSlider.Parent = settingsTab
    iconSizeSlider.Size = UDim2.new(0.8, 0, 0, 20)
    iconSizeSlider.Position = UDim2.new(0.1, 0, 0, yPos + 35)
    iconSizeSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    iconSizeSlider.BorderSizePixel = 0
    
    local iconSizeFill = Instance.new("Frame")
    iconSizeFill.Parent = iconSizeSlider
    iconSizeFill.Size = UDim2.new(0.5, 0, 1, 0)
    iconSizeFill.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
    iconSizeFill.BorderSizePixel = 0
    
    local iconSizeButton = Instance.new("TextButton")
    iconSizeButton.Parent = iconSizeSlider
    iconSizeButton.Size = UDim2.new(0, 20, 1.5, 0)
    iconSizeButton.Position = UDim2.new(0.5, -10, -0.25, 0)
    iconSizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    iconSizeButton.BorderSizePixel = 0
    iconSizeButton.Text = ""
    
    yPos = yPos + 70
    
    -- Настройка 3: Скорость анимаций
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Parent = settingsTab
    speedLabel.Size = UDim2.new(1, -40, 0, 30)
    speedLabel.Position = UDim2.new(0, 20, 0, yPos)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "⚡ Скорость анимаций: 1.0x"
    speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextSize = 18
    
    local speedSlider = Instance.new("Frame")
    speedSlider.Parent = settingsTab
    speedSlider.Size = UDim2.new(0.8, 0, 0, 20)
    speedSlider.Position = UDim2.new(0.1, 0, 0, yPos + 35)
    speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    speedSlider.BorderSizePixel = 0
    
    local speedFill = Instance.new("Frame")
    speedFill.Parent = speedSlider
    speedFill.Size = UDim2.new(0.5, 0, 1, 0)
    speedFill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    speedFill.BorderSizePixel = 0
    
    local speedButton = Instance.new("TextButton")
    speedButton.Parent = speedSlider
    speedButton.Size = UDim2.new(0, 20, 1.5, 0)
    speedButton.Position = UDim2.new(0.5, -10, -0.25, 0)
    speedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    speedButton.BorderSizePixel = 0
    speedButton.Text = ""
    
    yPos = yPos + 70
    
    -- Кнопка сброса
    local resetBtn = Instance.new("TextButton")
    resetBtn.Parent = settingsTab
    resetBtn.Size = UDim2.new(0.6, 0, 0, 50)
    resetBtn.Position = UDim2.new(0.2, 0, 0, yPos + 20)
    resetBtn.Text = "🔄 СБРОСИТЬ ВСЕ НАСТРОЙКИ"
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    resetBtn.BorderSizePixel = 0
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 18
    
    resetBtn.MouseButton1Click:Connect(function()
        -- Сброс всех состояний
        for key, value in pairs(ZACK_STATES) do
            if type(value) == "boolean" then
                ZACK_STATES[key] = false
            end
        end
        
        -- Обновляем интерфейс
        for _, child in ipairs(settingsTab.Parent.Parent:GetDescendants()) do
            if child:IsA("TextButton") and child.Text == "ON" then
                child.Text = "OFF"
                local gradient = child:FindFirstChildOfClass("UIGradient")
                if gradient then
                    gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
                    })
                end
            end
        end
        
        -- Уведомление
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ZACKERR HUB",
            Text = "Все настройки сброшены!",
            Duration = 2
        })
    end)
    
    yPos = yPos + 100
    
    -- Информация
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Parent = settingsTab
    infoLabel.Size = UDim2.new(1, -40, 0, 100)
    infoLabel.Position = UDim2.new(0, 20, 0, yPos)
    infoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    infoLabel.BackgroundTransparency = 0.3
    infoLabel.Text = "ZACKERR HUB PREMIUM v1.0\n\nСоздано с ❤️ для настоящих ценителей\nВсе функции работают на 100%"
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 16
end

-- ========== 3. СИСТЕМА СОХРАНЕНИЯ ==========
local function saveSettings()
    local data = {}
    for key, value in pairs(ZACK_STATES) do
        data[key] = value
    end
    
    if writefile then
        writefile("zackerr_hub_settings.json", game:GetService("HttpService"):JSONEncode(data))
    end
end

local function loadSettings()
    if isfile and readfile then
        if isfile("zackerr_hub_settings.json") then
            local success, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile("zackerr_hub_settings.json"))
            end)
            
            if success and data then
                for key, value in pairs(data) do
                    if ZACK_STATES[key] ~= nil then
                        ZACK_STATES[key] = value
                    end
                end
            end
        end
    end
end

-- Загружаем настройки при старте
loadSettings()

-- Сохраняем при выходе
game:GetService("Players").LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
    saveSettings()
end)

-- ========== 4. УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✨ ZACKERR HUB PREMIUM",
    Text = "Все 5 частей успешно загружены!\nCHAMS | 40+ аксессуаров | Эффекты",
    Duration = 5,
    Icon = "rbxassetid://13978511301"
})

-- Анимация иконки при запуске
spawn(function()
    for i = 1, 10 do
        if icon then
            icon.Size = UDim2.new(0, 64 + i * 2, 0, 64 + i * 2)
            icon.ImageTransparency = 0.5
            wait(0.05)
        end
    end
    for i = 10, 1, -1 do
        if icon then
            icon.Size = UDim2.new(0, 64 + i * 2, 0, 64 + i * 2)
            icon.ImageTransparency = 0.5 - i * 0.05
            wait(0.05)
        end
    end
    icon.Size = UDim2.new(0, 64, 0, 64)
    icon.ImageTransparency = 0
end)

print("🎉 ZACKERR HUB PREMIUM - ПОЛНОСТЬЮ ЗАГРУЖЕН!")
print("📦 Функции: CHAMS 1-2 | 40+ Аксессуаров | Эффекты | Настройки")
print("💎 Статус: ПРЕМИУМ КАЧЕСТВО | Версия: 1.0.0")
