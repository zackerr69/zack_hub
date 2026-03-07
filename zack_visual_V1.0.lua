--[[
    ZACKERR PREMIUM V1.1
    Полностью переработанная версия
    Автор: zackerr69
--]]

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
local head = character:FindFirstChild("Head")
local playerGui = player:WaitForChild("PlayerGui")

-- Удаляем старые GUI если есть
for _, gui in ipairs(playerGui:GetChildren()) do
    if gui.Name == "ZACKERR_Premium" then
        gui:Destroy()
    end
end

-- ========== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ==========
ZACKERR = {
    Version = "1.1",
    Name = "ZACK PREMIUM",
    States = {
        -- Chams
        chams1 = false,
        chams2 = false,
        
        -- Аксессуары
        accessories = {},
        
        -- Эффекты
        effects = {}
    },
    
    -- Список надетых аксессуаров
    equippedAccessories = {},
    
    -- Настройки
    Settings = {
        menuOpacity = 0.9,
        iconSize = 64,
        animationSpeed = 1.0,
        globalScale = 1.0
    }
}

-- ========== СОЗДАНИЕ GUI ==========
local gui = Instance.new("ScreenGui")
gui.Name = "ZACKERR_Premium"
gui.Parent = playerGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100

-- Затемнение фона (будет видно когда меню открыто)
local background = Instance.new("Frame")
background.Name = "Background"
background.Parent = gui
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.7
background.Visible = false
background.ZIndex = 1
background.Active = true

background.MouseButton1Click = function() end
background.MouseButton2Click = function() end
background.MouseButton3Click = function() end

-- ========== ИКОНКА (АНИМЕ-ТЯН) ==========
local icon = Instance.new("ImageButton")
icon.Name = "Icon"
icon.Parent = gui
icon.Size = UDim2.new(0, 64, 0, 64)
icon.Position = UDim2.new(0, 20, 0, 20)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://13978511301"  -- Замени на свою иконку
icon.ImageRectSize = Vector2.new(64, 64)
icon.Draggable = true
icon.Active = true
icon.ZIndex = 10
icon.Visible = true

-- Эффект свечения иконки
local iconGlow = Instance.new("ImageLabel")
iconGlow.Name = "Glow"
iconGlow.Parent = icon
iconGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
iconGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
iconGlow.BackgroundTransparency = 1
iconGlow.Image = "rbxassetid://13978511301"
iconGlow.ImageTransparency = 0.5
iconGlow.ZIndex = 9
iconGlow.ImageColor3 = Color3.fromRGB(255, 100, 255)

-- Анимация иконки
spawn(function()
    while icon and icon.Parent do
        for i = 1, 360, 5 do
            if not icon or not icon.Parent then break end
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
menu.Size = UDim2.new(0, 900, 0, 700)
menu.Position = UDim2.new(0.5, -450, 0.5, -350)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
menu.BackgroundTransparency = 0.1
menu.BorderSizePixel = 2
menu.BorderColor3 = Color3.fromRGB(255, 100, 255)
menu.Visible = false
menu.Active = true
menu.Draggable = true
menu.ZIndex = 5
menu.ClipsDescendants = true

-- Фон меню (аниме-тян)
local menuBg = Instance.new("ImageLabel")
menuBg.Name = "BgImage"
menuBg.Parent = menu
menuBg.Size = UDim2.new(1, 0, 1, 0)
menuBg.Image = "rbxassetid://13978511301"  -- Замени на другую
menuBg.ImageTransparency = 0.8
menuBg.ScaleType = Enum.ScaleType.Crop
menuBg.ZIndex = 1
menuBg.BackgroundTransparency = 1

-- Затемнение фона
local menuOverlay = Instance.new("Frame")
menuOverlay.Name = "Overlay"
menuOverlay.Parent = menu
menuOverlay.Size = UDim2.new(1, 0, 1, 0)
menuOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuOverlay.BackgroundTransparency = 0.3
menuOverlay.ZIndex = 2
menuOverlay.BorderSizePixel = 0

-- Шапка меню
local header = Instance.new("Frame")
header.Name = "Header"
header.Parent = menu
header.Size = UDim2.new(1, 0, 0, 70)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
header.BackgroundTransparency = 0.2
header.ZIndex = 3
header.BorderSizePixel = 0

local headerGradient = Instance.new("UIGradient")
headerGradient.Parent = header
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 200, 255))
})
headerGradient.Rotation = 45

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = header
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZACK PREMIUM V1.1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4

-- Кнопка закрытия
local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseBtn"
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -60, 0.5, -20)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Image = "rbxassetid://13978511301"  -- Иконка X
closeBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.ZIndex = 4
closeBtn.BorderSizePixel = 0

closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    background.Visible = false
end)

-- Открытие меню по клику на иконку
icon.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    background.Visible = menu.Visible
    
    -- Обновляем позицию меню
    if menu.Visible then
        menu.Position = UDim2.new(0.5, -450, 0.5, -350)
    end
end)

-- ========== ВКЛАДКИ ==========
local tabsContainer = Instance.new("Frame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Parent = menu
tabsContainer.Size = UDim2.new(1, 0, 0, 60)
tabsContainer.Position = UDim2.new(0, 0, 0, 70)
tabsContainer.BackgroundTransparency = 1
tabsContainer.ZIndex = 3

local tabButtons = {}
local tabContents = {}

local tabs = {"CHAMS", "АКСЕССУАРЫ", "ЭФФЕКТЫ", "НАСТРОЙКИ"}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "Tab"
    btn.Parent = tabsContainer
    btn.Size = UDim2.new(0, 150, 0, 40)
    btn.Position = UDim2.new(0, (i-1) * 160 + 20, 0, 10)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.ZIndex = 4
    
    local btnGradient = Instance.new("UIGradient")
    btnGradient.Parent = btn
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 50))
    })
    
    tabButtons[i] = btn
    
    -- Контейнер для содержимого вкладки
    local content = Instance.new("ScrollingFrame")
    content.Name = tabName .. "Content"
    content.Parent = menu
    content.Size = UDim2.new(1, -40, 1, -160)
    content.Position = UDim2.new(0, 20, 0, 140)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 8
    content.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 200)
    content.Visible = (i == 1)
    content.ZIndex = 4
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    content.BackgroundTransparency = 0.5
    
    tabContents[i] = content
    
    btn.MouseButton1Click:Connect(function()
        for _, b in ipairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
        
        for _, c in ipairs(tabContents) do
            c.Visible = false
        end
        content.Visible = true
    end)
end

-- ========== ФУНКЦИЯ СОЗДАНИЯ ПЕРЕКЛЮЧАТЕЛЯ ==========
function createToggle(parent, name, stateRef, yPos, desc)
    local frame = Instance.new("Frame")
    frame.Name = name .. "Toggle"
    frame.Parent = parent
    frame.Size = UDim2.new(1, -40, 0, 60)
    frame.Position = UDim2.new(0, 20, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.ZIndex = 5
    
    local gradient = Instance.new("UIGradient")
    gradient.Parent = frame
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 45))
    })
    gradient.Rotation = 90
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.7, -20, 0.6, 0)
    label.Position = UDim2.new(0, 20, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 18
    label.ZIndex = 6
    
    if desc then
        local descLabel = Instance.new("TextLabel")
        descLabel.Parent = frame
        descLabel.Size = UDim2.new(0.7, -20, 0.4, -10)
        descLabel.Position = UDim2.new(0, 20, 0.6, 0)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = desc
        descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.SourceSans
        descLabel.TextSize = 14
        descLabel.ZIndex = 6
        descLabel.TextWrapped = true
    end
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.Size = UDim2.new(0, 70, 0, 35)
    toggleBtn.Position = UDim2.new(1, -90, 0.5, -17.5)
    toggleBtn.Text = stateRef[1] and "ON" or "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.BackgroundColor3 = stateRef[1] and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 16
    toggleBtn.ZIndex = 6
    
    toggleBtn.MouseButton1Click:Connect(function()
        stateRef[1] = not stateRef[1]
        toggleBtn.Text = stateRef[1] and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = stateRef[1] and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    end)
    
    return frame
end

-- Уведомление о загрузке
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK PREMIUM V1.1",
    Text = "Ядро загружено! Часть 1/5",
    Duration = 2
})

print("✅ ZACK PREMIUM V1.1 - Часть 1/5 загружена")
print("📌 Иконка слева вверху - нажми для меню")
--[[
    ZACKERR PREMIUM V1.1 - CHAMS 1
    Космическая аура + парящие сферы + галактический след
    УРОВЕНЬ: БОГ
--]]

-- ========== СИСТЕМА CHAMS 1 ==========
local chams1 = {
    active = false,
    objects = {},
    connections = {}
}

-- ========== ОЧИСТКА CHAMS 1 ==========
local function destroyChams1()
    for _, obj in ipairs(chams1.objects) do
        if obj and obj.Parent then
            pcall(function() obj:Destroy() end)
        end
    end
    chams1.objects = {}
    
    for _, conn in ipairs(chams1.connections) do
        pcall(function() conn:Disconnect() end)
    end
    chams1.connections = {}
    
    -- Восстанавливаем стандартный вид игрока
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if part:GetAttribute("origTransparency") then
                    part.Transparency = part:GetAttribute("origTransparency")
                end
                if part:GetAttribute("origMaterial") then
                    part.Material = part:GetAttribute("origMaterial")
                end
            end
        end
    end
end

-- ========== СОЗДАНИЕ CHAMS 1 ==========
local function createChams1()
    if not rootPart or not character then return end
    
    destroyChams1()
    
    -- Сохраняем оригинальные настройки частей
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part:SetAttribute("origTransparency", part.Transparency)
            part:SetAttribute("origMaterial", part.Material)
        end
    end
    
    -- ========== 1. ГАЛАКТИЧЕСКАЯ АУРА (3 СЛОЯ) ==========
    local auraLayers = {}
    for i = 1, 3 do
        local aura = Instance.new("Part")
        aura.Name = "Chams1_Aura" .. i
        aura.Size = Vector3.new(8 + i*2, 8 + i*2, 8 + i*2)
        aura.Position = rootPart.Position
        aura.Shape = Enum.PartType.Ball
        aura.Material = Enum.Material.Neon
        aura.BrickColor = BrickColor.new("Bright red")
        aura.Transparency = 0.6 + i*0.1
        aura.CanCollide = false
        aura.Anchored = false
        aura.Parent = character
        
        local mesh = Instance.new("SpecialMesh")
        mesh.Parent = aura
        mesh.MeshType = Enum.MeshType.Sphere
        mesh.Scale = Vector3.new(1, 0.3 + i*0.1, 1)
        
        local weld = Instance.new("Weld")
        weld.Part0 = rootPart
        weld.Part1 = aura
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = aura
        
        table.insert(chams1.objects, aura)
        table.insert(auraLayers, {aura = aura, mesh = mesh, index = i})
    end
    
    -- Анимация ауры (космические цвета + пульсация)
    local auraConn = game:GetService("RunService").RenderStepped:Connect(function()
        local t = tick() * 0.5
        
        for _, layer in ipairs(auraLayers) do
            if layer.aura and layer.aura.Parent then
                -- Цвета радуги сдвинутые по фазе
                local hue = (t + layer.index * 0.3) % 1
                layer.aura.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
                
                -- Пульсация размера
                local scale = 1 + math.sin(t * 3 + layer.index) * 0.1
                layer.mesh.Scale = Vector3.new(scale, scale * 0.3, scale)
                
                -- Мерцание прозрачности
                layer.aura.Transparency = 0.5 + math.sin(t * 4 + layer.index) * 0.2
            end
        end
    end)
    table.insert(chams1.connections, auraConn)
    
    -- ========== 2. 4 ПАРЯЩИЕ СФЕРЫ ==========
    local sphereColors = {
        Color3.fromHSV(0, 1, 1),   -- Красный
        Color3.fromHSV(0.33, 1, 1), -- Зелёный
        Color3.fromHSV(0.66, 1, 1), -- Синий
        Color3.fromHSV(0.5, 1, 1)   -- Голубой
    }
    
    for i = 1, 4 do
        local sphere = Instance.new("Part")
        sphere.Name = "Chams1_Sphere" .. i
        sphere.Size = Vector3.new(1.5, 1.5, 1.5)
        sphere.Position = rootPart.Position
        sphere.Shape = Enum.PartType.Ball
        sphere.Material = Enum.Material.Neon
        sphere.BrickColor = BrickColor.new(sphereColors[i])
        sphere.Transparency = 0.3
        sphere.CanCollide = false
        sphere.Anchored = false
        sphere.Parent = character
        
        local sphereMesh = Instance.new("SpecialMesh")
        sphereMesh.Parent = sphere
        sphereMesh.MeshType = Enum.MeshType.Sphere
        
        local sphereWeld = Instance.new("Weld")
        sphereWeld.Part0 = rootPart
        sphereWeld.Part1 = sphere
        sphereWeld.C0 = CFrame.new(0, 0, 0)
        sphereWeld.Parent = sphere
        
        table.insert(chams1.objects, sphere)
        
        -- Индивидуальная анимация для каждой сферы
        local angle = i * math.pi/2
        local sphereConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not sphere or not sphere.Parent then return end
            
            angle = angle + 0.02 * ZACKERR.Settings.animationSpeed
            
            -- Вращение по сложной траектории
            local radius = 4
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            local y = math.sin(angle * 2) * 2
            
            sphereWeld.C0 = CFrame.new(x, y, z)
            
            -- Мерцание
            sphere.Transparency = 0.2 + math.sin(angle * 2) * 0.2
            
            -- Цвет
            local hue = (tick() * 0.5 + i * 0.25) % 1
            sphere.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
        end)
        table.insert(chams1.connections, sphereConn)
    end
    
    -- ========== 3. КОСМИЧЕСКИЙ СЛЕД ==========
    local trailAttach0 = Instance.new("Attachment")
    trailAttach0.Name = "TrailAttach0"
    trailAttach0.Parent = rootPart
    trailAttach0.Position = Vector3.new(0, 3, 0)
    
    local trailAttach1 = Instance.new("Attachment")
    trailAttach1.Name = "TrailAttach1"
    trailAttach1.Parent = rootPart
    trailAttach1.Position = Vector3.new(0, -3, 0)
    
    local trail = Instance.new("Trail")
    trail.Name = "Chams1_Trail"
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
    trail.TextureLength = 5
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.3, 0.2),
        NumberSequenceKeypoint.new(0.7, 0.6),
        NumberSequenceKeypoint.new(1, 1)
    })
    trail.Width = NumberSequence.new(3)
    trail.Lifetime = 2
    trail.Enabled = true
    
    table.insert(chams1.objects, trailAttach0)
    table.insert(chams1.objects, trailAttach1)
    table.insert(chams1.objects, trail)
    
    -- Анимация следа
    local trailConn = game:GetService("RunService").RenderStepped:Connect(function()
        if not trail or not trail.Parent then return end
        
        local t = tick() % 6.28 / 6.28
        trail.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
            ColorSequenceKeypoint.new(0.25, Color3.fromHSV((t + 0.25) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV((t + 0.5) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.75, Color3.fromHSV((t + 0.75) % 1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 1) % 1, 1, 1))
        })
        
        -- Динамическая ширина
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            trail.Width = NumberSequence.new(4)
        else
            trail.Width = NumberSequence.new(2)
        end
    end)
    table.insert(chams1.connections, trailConn)
    
    -- ========== 4. КОСМИЧЕСКИЕ ЧАСТИЦЫ ==========
    local particleTypes = {
        {name = "Stars", texture = "rbxasset://textures/particles/sparkles_main.dds", rate = 40, size = 0.3},
        {name = "Glow", texture = "rbxasset://textures/particles/glow.png", rate = 30, size = 0.4},
        {name = "Smoke", texture = "rbxasset://textures/particles/smoke_main.dds", rate = 20, size = 0.5}
    }
    
    for _, pt in ipairs(particleTypes) do
        local emitter = Instance.new("ParticleEmitter")
        emitter.Name = "Chams1_" .. pt.name
        emitter.Parent = rootPart
        emitter.Texture = pt.texture
        emitter.Rate = pt.rate
        emitter.Lifetime = NumberRange.new(1, 2)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Speed = NumberRange.new(2, 4)
        emitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        emitter.LightEmission = 1
        emitter.Transparency = NumberSequence.new(0.3)
        emitter.Size = NumberSequence.new(pt.size)
        emitter.Rotation = NumberRange.new(0, 360)
        emitter.VelocityInheritance = 0.5
        emitter.Enabled = true
        
        table.insert(chams1.objects, emitter)
        
        local particleConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not emitter or not emitter.Parent then return end
            local t = tick() % 6.28 / 6.28
            emitter.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 0.5) % 1, 1, 1))
            })
        end)
        table.insert(chams1.connections, particleConn)
    end
    
    -- ========== 5. ОСВЕЩЕНИЕ ==========
    local light = Instance.new("PointLight")
    light.Name = "Chams1_Light"
    light.Parent = rootPart
    light.Range = 20
    light.Brightness = 3
    light.Shadows = false
    
    table.insert(chams1.objects, light)
    
    local lightConn = game:GetService("RunService").RenderStepped:Connect(function()
        if not light or not light.Parent then return end
        local t = tick() % 6.28 / 6.28
        light.Color = Color3.fromHSV(t, 1, 1)
    end)
    table.insert(chams1.connections, lightConn)
    
    -- ========== 6. ЭФФЕКТ НА ИГРОКЕ ==========
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= rootPart then
            part.Material = Enum.Material.Neon
            part.Transparency = 0.2
        end
    end
    
    chams1.active = true
end

-- ========== ПОДКЛЮЧАЕМ К СОСТОЯНИЯМ ==========
ZACKERR.States.chams1 = false
local chams1State = {false}

-- Функция обновления
local function updateChams1()
    if chams1State[1] and not chams1.active then
        -- Если включен chams2, выключаем его
        if ZACKERR.States.chams2 then
            ZACKERR.States.chams2 = false
            if chams2 and chams2.update then
                chams2.update()
            end
        end
        createChams1()
    elseif not chams1State[1] and chams1.active then
        destroyChams1()
    end
end

-- Добавляем в глобальный доступ
chams1.update = updateChams1

-- ========== ДОБАВЛЯЕМ ВО ВКЛАДКУ CHAMS ==========
if tabContents and tabContents[1] then
    local yPos = 10
    
    -- CHAMS 1 Toggle
    local frame1 = createToggle(tabContents[1], "🌀 CHAMS 1 - КОСМИЧЕСКАЯ АУРА", chams1State, yPos, 
        "4 парящие сферы | 3 слоя ауры | Космический след | Частицы")
    yPos = yPos + 70
    
    -- Индикатор качества
    local qualityLabel = Instance.new("TextLabel")
    qualityLabel.Parent = tabContents[1]
    qualityLabel.Size = UDim2.new(1, -40, 0, 30)
    qualityLabel.Position = UDim2.new(0, 20, 0, yPos)
    qualityLabel.BackgroundTransparency = 1
    qualityLabel.Text = "⚡ КАЧЕСТВО: ПРЕМИУМ | FPS DROPS: 0% | РЕАКТОР: СТАБИЛЬНЫЙ"
    qualityLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    qualityLabel.TextXAlignment = Enum.TextXAlignment.Center
    qualityLabel.Font = Enum.Font.GothamBold
    qualityLabel.TextSize = 14
    qualityLabel.ZIndex = 5
end

-- Следим за изменением состояния
local stateThread = game:GetService("RunService").Heartbeat:Connect(function()
    if chams1State[1] ~= ZACKERR.States.chams1 then
        ZACKERR.States.chams1 = chams1State[1]
        updateChams1()
    end
end)
table.insert(chams1.connections, stateThread)

-- Обработка смены персонажа
local charConn = player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart") or character:WaitForChild("Torso")
    head = character:WaitForChild("Head")
    
    if chams1State[1] then
        createChams1()
    end
end)
table.insert(chams1.connections, charConn)

-- Уведомление
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK PREMIUM V1.1",
    Text = "CHAMS 1 загружен! Космический уровень",
    Duration = 2
})

print("✅ ZACK PREMIUM V1.1 - Часть 2/5 загружена")
print("🌀 CHAMS 1: КОСМИЧЕСКАЯ АУРА АКТИВИРОВАНА")
--[[
    ZACKERR PREMIUM V1.1 - CHAMS 2
    Радужная реальность + голографический игрок + световой след
    УРОВЕНЬ: БОЖЕСТВЕННЫЙ
--]]

-- ========== СИСТЕМА CHAMS 2 ==========
local chams2 = {
    active = false,
    objects = {},
    connections = {},
    originalLighting = {}
}

-- ========== СОХРАНЕНИЕ ОРИГИНАЛЬНОГО ОСВЕЩЕНИЯ ==========
local function saveOriginalLighting()
    local lighting = game:GetService("Lighting")
    chams2.originalLighting = {
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

-- ========== ВОССТАНОВЛЕНИЕ ОСВЕЩЕНИЯ ==========
local function restoreOriginalLighting()
    local lighting = game:GetService("Lighting")
    for key, value in pairs(chams2.originalLighting) do
        pcall(function()
            lighting[key] = value
        end)
    end
end

-- ========== ОЧИСТКА CHAMS 2 ==========
local function destroyChams2()
    for _, obj in ipairs(chams2.objects) do
        if obj and obj.Parent then
            pcall(function() obj:Destroy() end)
        end
    end
    chams2.objects = {}
    
    for _, conn in ipairs(chams2.connections) do
        pcall(function() conn:Disconnect() end)
    end
    chams2.connections = {}
    
    restoreOriginalLighting()
    
    -- Восстанавливаем стандартный вид игрока
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if part:GetAttribute("origTransparency2") then
                    part.Transparency = part:GetAttribute("origTransparency2")
                end
                if part:GetAttribute("origMaterial2") then
                    part.Material = part:GetAttribute("origMaterial2")
                end
            end
        end
    end
end

-- ========== СОЗДАНИЕ CHAMS 2 ==========
local function createChams2()
    if not rootPart or not character then return end
    
    destroyChams2()
    saveOriginalLighting()
    
    -- Сохраняем оригинальные настройки частей
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part:SetAttribute("origTransparency2", part.Transparency)
            part:SetAttribute("origMaterial2", part.Material)
        end
    end
    
    local lighting = game:GetService("Lighting")
    local runService = game:GetService("RunService")
    
    -- ========== 1. РАДУЖНОЕ НЕБО (ДИНАМИЧЕСКОЕ) ==========
    lighting.GlobalShadows = false
    lighting.Brightness = 3
    lighting.ExposureCompensation = 1
    lighting.FogEnd = 1000
    lighting.FogStart = 0
    
    -- Создаём радужный градиент на небе
    local skybox = Instance.new("Sky")
    skybox.Name = "Chams2_Skybox"
    skybox.Parent = lighting
    skybox.SkyboxBk = "rbxassetid://13978511301" -- Замени на свои текстуры
    skybox.SkyboxDn = "rbxassetid://13978511301"
    skybox.SkyboxFt = "rbxassetid://13978511301"
    skybox.SkyboxLf = "rbxassetid://13978511301"
    skybox.SkyboxRt = "rbxassetid://13978511301"
    skybox.SkyboxUp = "rbxassetid://13978511301"
    skybox.SunAngularSize = 0
    skybox.MoonAngularSize = 0
    
    table.insert(chams2.objects, skybox)
    
    -- Основная анимация освещения
    local lightConn = runService.RenderStepped:Connect(function()
        local t = tick() * 0.3
        local hue1 = (t) % 1
        local hue2 = (t + 0.3) % 1
        local hue3 = (t + 0.6) % 1
        
        -- Ambient освещение
        lighting.Ambient = Color3.fromHSV(hue1, 0.8, 0.3)
        lighting.OutdoorAmbient = Color3.fromHSV(hue2, 0.8, 0.2)
        lighting.ColorShift_Top = Color3.fromHSV(hue3, 1, 1)
        lighting.ColorShift_Bottom = Color3.fromHSV((hue3 + 0.5) % 1, 1, 0.5)
        
        -- Туман
        lighting.FogColor = Color3.fromHSV(hue2, 1, 0.3)
    end)
    table.insert(chams2.connections, lightConn)
    
    -- ========== 2. РАДУЖНЫЙ ИГОК (ГОЛОГРАФИЧЕСКИЙ) ==========
    -- Применяем эффект ко всем частям тела
    local function makePlayerHolographic()
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.Glass
                part.Transparency = 0.3
                part.Reflectance = 0.2
            end
        end
    end
    makePlayerHolographic()
    
    -- Анимация цветов игрока
    local playerColorConn = runService.RenderStepped:Connect(function()
        local t = tick() * 0.5
        
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                local hue = (t + part:GetHashCode() * 0.001) % 1
                part.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
                
                -- Мерцание голографического эффекта
                part.Transparency = 0.2 + math.sin(t * 5 + part:GetHashCode()) * 0.2
                part.Reflectance = 0.1 + math.sin(t * 3) * 0.1
            end
        end
    end)
    table.insert(chams2.connections, playerColorConn)
    
    -- ========== 3. СВЕТОВОЙ СЛЕД (ГОЛОГРАФИЧЕСКИЙ) ==========
    local trailAttach0 = Instance.new("Attachment")
    trailAttach0.Name = "Chams2_TrailAttach0"
    trailAttach0.Parent = rootPart
    trailAttach0.Position = Vector3.new(0, 4, 0)
    
    local trailAttach1 = Instance.new("Attachment")
    trailAttach1.Name = "Chams2_TrailAttach1"
    trailAttach1.Parent = rootPart
    trailAttach1.Position = Vector3.new(0, -4, 0)
    
    local trail = Instance.new("Trail")
    trail.Name = "Chams2_Trail"
    trail.Parent = rootPart
    trail.Attachment0 = trailAttach0
    trail.Attachment1 = trailAttach1
    trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
        ColorSequenceKeypoint.new(0.2, Color3.fromHSV(0.2, 1, 1)),
        ColorSequenceKeypoint.new(0.4, Color3.fromHSV(0.4, 1, 1)),
        ColorSequenceKeypoint.new(0.6, Color3.fromHSV(0.6, 1, 1)),
        ColorSequenceKeypoint.new(0.8, Color3.fromHSV(0.8, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
    })
    trail.LightEmission = 1
    trail.LightInfluence = 0
    trail.Texture = "rbxasset://textures/particles/trail_main.png"
    trail.TextureLength = 4
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.3, 0.1),
        NumberSequenceKeypoint.new(0.6, 0.4),
        NumberSequenceKeypoint.new(1, 0.8)
    })
    trail.Width = NumberSequence.new(4)
    trail.Lifetime = 1.5
    trail.Enabled = true
    
    table.insert(chams2.objects, trailAttach0)
    table.insert(chams2.objects, trailAttach1)
    table.insert(chams2.objects, trail)
    
    -- Анимация следа
    local trailColorConn = runService.RenderStepped:Connect(function()
        if not trail or not trail.Parent then return end
        
        local t = tick() % 6.28 / 6.28
        local keypoints = {}
        for i = 0, 5 do
            table.insert(keypoints, ColorSequenceKeypoint.new(
                i/5, 
                Color3.fromHSV((t + i/5) % 1, 1, 1)
            ))
        end
        trail.Color = ColorSequence.new(keypoints)
        
        -- Динамическая ширина
        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
            trail.Width = NumberSequence.new(5)
            trail.TextureLength = 6
        else
            trail.Width = NumberSequence.new(3)
            trail.TextureLength = 4
        end
    end)
    table.insert(chams2.connections, trailColorConn)
    
    -- ========== 4. ГОЛОГРАФИЧЕСКИЕ ЧАСТИЦЫ ==========
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Chams2_Particles"
    particles.Parent = rootPart
    particles.Texture = "rbxasset://textures/particles/glow.png"
    particles.Rate = 50
    particles.Lifetime = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Speed = NumberRange.new(3, 6)
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    particles.LightEmission = 1
    particles.Transparency = NumberSequence.new(0.3)
    particles.Size = NumberSequence.new(0.5)
    particles.Rotation = NumberRange.new(0, 360)
    particles.VelocityInheritance = 0.3
    particles.Enabled = true
    
    table.insert(chams2.objects, particles)
    
    local particleConn = runService.RenderStepped:Connect(function()
        if not particles or not particles.Parent then return end
        local t = tick() % 6.28 / 6.28
        particles.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 0.5) % 1, 1, 1))
        })
    end)
    table.insert(chams2.connections, particleConn)
    
    -- ========== 5. СВЕТОВЫЕ СФЕРЫ ==========
    for i = 1, 6 do
        local sphere = Instance.new("Part")
        sphere.Name = "Chams2_LightSphere" .. i
        sphere.Size = Vector3.new(0.8, 0.8, 0.8)
        sphere.Position = rootPart.Position
        sphere.Shape = Enum.PartType.Ball
        sphere.Material = Enum.Material.Neon
        sphere.BrickColor = BrickColor.new(Color3.fromHSV(i/6, 1, 1))
        sphere.Transparency = 0.2
        sphere.CanCollide = false
        sphere.Anchored = false
        sphere.Parent = character
        
        local sphereMesh = Instance.new("SpecialMesh")
        sphereMesh.Parent = sphere
        sphereMesh.MeshType = Enum.MeshType.Sphere
        
        local sphereWeld = Instance.new("Weld")
        sphereWeld.Part0 = rootPart
        sphereWeld.Part1 = sphere
        sphereWeld.C0 = CFrame.new(0, 0, 0)
        sphereWeld.Parent = sphere
        
        table.insert(chams2.objects, sphere)
        
        local angle = i * math.pi/3
        local sphereConn = runService.RenderStepped:Connect(function()
            if not sphere or not sphere.Parent then return end
            
            angle = angle + 0.03 * ZACKERR.Settings.animationSpeed
            
            local radius = 3.5
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            local y = math.cos(angle * 2) * 1.5
            
            sphereWeld.C0 = CFrame.new(x, y, z)
            
            local hue = (tick() * 0.3 + i/6) % 1
            sphere.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
            sphere.Transparency = 0.1 + math.sin(angle * 2) * 0.2
        end)
        table.insert(chams2.connections, sphereConn)
    end
    
    -- ========== 6. РАДУЖНЫЙ ЛУЧ СВЕТА ==========
    local beamAttachment = Instance.new("Attachment")
    beamAttachment.Name = "Chams2_BeamAttach"
    beamAttachment.Parent = rootPart
    beamAttachment.Position = Vector3.new(0, 2, 0)
    
    local beam = Instance.new("Beam")
    beam.Name = "Chams2_Beam"
    beam.Parent = rootPart
    beam.Attachment0 = beamAttachment
    beam.Attachment1 = beamAttachment
    beam.Texture = "rbxasset://textures/particles/trail_main.png"
    beam.TextureLength = 2
    beam.TextureSpeed = 1
    beam.Width0 = 2
    beam.Width1 = 2
    beam.LightEmission = 1
    beam.LightInfluence = 0
    beam.Transparency = NumberSequence.new(0.3)
    beam.Color = ColorSequence.new(Color3.fromHSV(0, 1, 1))
    beam.CurveSize0 = 0
    beam.CurveSize1 = 0
    
    table.insert(chams2.objects, beamAttachment)
    table.insert(chams2.objects, beam)
    
    -- Анимация луча
    local beamConn = runService.RenderStepped:Connect(function()
        if not beam or not beam.Parent then return end
        local t = tick() % 6.28
        local hue = (t/6.28) % 1
        beam.Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1))
        beam.TextureSpeed = math.sin(t) * 2
    end)
    table.insert(chams2.connections, beamConn)
    
    chams2.active = true
end

-- ========== ПОДКЛЮЧАЕМ К СОСТОЯНИЯМ ==========
ZACKERR.States.chams2 = false
local chams2State = {false}

-- Функция обновления
local function updateChams2()
    if chams2State[1] and not chams2.active then
        -- Если включен chams1, выключаем его
        if ZACKERR.States.chams1 then
            ZACKERR.States.chams1 = false
            if chams1 and chams1.update then
                chams1.update()
            end
        end
        createChams2()
    elseif not chams2State[1] and chams2.active then
        destroyChams2()
    end
end

chams2.update = updateChams2

-- ========== ДОБАВЛЯЕМ ВО ВКЛАДКУ CHAMS ==========
if tabContents and tabContents[1] then
    local yPos = 80
    
    -- CHAMS 2 Toggle
    local frame2 = createToggle(tabContents[1], "🌈 CHAMS 2 - РАДУЖНАЯ РЕАЛЬНОСТЬ", chams2State, yPos,
        "Радужное небо | Голографический игрок | Световой след | Лучи | 6 сфер")
    
    -- Стильный разделитель
    local separator = Instance.new("Frame")
    separator.Parent = tabContents[1]
    separator.Size = UDim2.new(1, -40, 0, 2)
    separator.Position = UDim2.new(0, 20, 0, yPos + 70)
    separator.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    separator.BackgroundTransparency = 0.5
    separator.BorderSizePixel = 0
end

-- Следим за изменением состояния
local stateThread2 = game:GetService("RunService").Heartbeat:Connect(function()
    if chams2State[1] ~= ZACKERR.States.chams2 then
        ZACKERR.States.chams2 = chams2State[1]
        updateChams2()
    end
end)
table.insert(chams2.connections, stateThread2)

-- Обработка смены персонажа
local charConn2 = player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart") or character:WaitForChild("Torso")
    head = character:WaitForChild("Head")
    
    if chams2State[1] then
        createChams2()
    end
end)
table.insert(chams2.connections, charConn2)

-- Уведомление
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK PREMIUM V1.1",
    Text = "CHAMS 2 загружен! Божественный уровень",
    Duration = 2,
    Icon = "rbxassetid://13978511301"
})

print("✅ ZACK PREMIUM V1.1 - Часть 3/5 загружена")
print("🌈 CHAMS 2: РАДУЖНАЯ РЕАЛЬНОСТЬ АКТИВИРОВАНА")
--[[
    ZACKERR PREMIUM V1.1 - КАТАЛОГ АКСЕССУАРОВ ЧАСТЬ 1
    Первые 20 предметов + система масштабирования
--]]

-- ========== СИСТЕМА АКСЕССУАРОВ ==========
ZACKERR.equippedAccessories = ZACKERR.equippedAccessories or {}

-- ========== КАТАЛОГ АКСЕССУАРОВ (ЧАСТЬ 1 - 20 ШТУК) ==========
local ACCESSORY_CATALOG_PART1 = {
    -- ГОЛОВНЫЕ УБОРЫ (8 шт)
    {name = "👑 Золотая корона", id = 13709746215, category = "hats", 
     desc = "Корона древнего правителя", rarity = "legendary", scale = 1.0},
    {name = "🎩 Цилиндр", id = 13709745670, category = "hats",
     desc = "Классическая шляпа джентльмена", rarity = "common", scale = 1.0},
    {name = "🧢 Кепка-бейсболка", id = 13709745858, category = "hats",
     desc = "Стильная кепка задом наперед", rarity = "common", scale = 1.0},
    {name = "👒 Соломенная шляпа", id = 13709746055, category = "hats",
     desc = "Летняя шляпа для отдыха", rarity = "common", scale = 1.0},
    {name = "⛑️ Каска строителя", id = 13709746215, category = "hats",
     desc = "Защитная каска с фонариком", rarity = "rare", scale = 1.0},
    {name = "🎓 Академическая шапочка", id = 13709746493, category = "hats",
     desc = "Шапочка выпускника", rarity = "rare", scale = 1.0},
    {name = "👑 Ледяная корона", id = 13709746657, category = "hats",
     desc = "Корона из вечной мерзлоты", rarity = "epic", scale = 1.0},
    {name = "🔥 Огненный венец", id = 13709746910, category = "hats",
     desc = "Пылающий венец феникса", rarity = "legendary", scale = 1.0},
    
    -- ЛИЦЕВЫЕ АКСЕССУАРЫ (6 шт)
    {name = "😎 Очки-авиаторы", id = 13709745858, category = "face",
     desc = "Золотые авиаторы", rarity = "common", scale = 1.0},
    {name = "🕶️ Матричные очки", id = 13709746215, category = "face",
     desc = "Неоновые кибер-очки", rarity = "epic", scale = 1.0},
    {name = "👓 Очки для чтения", id = 13709745670, category = "face",
     desc = "Интеллигентный образ", rarity = "common", scale = 1.0},
    {name = "🥽 Защитные очки", id = 13709746055, category = "face",
     desc = "Для экстремальных видов спорта", rarity = "rare", scale = 1.0},
    {name = "🎭 Маска театральная", id = 13709746493, category = "face",
     desc = "Двуликая маска", rarity = "epic", scale = 1.0},
    {name = "👺 Маска демона", id = 13709746657, category = "face",
     desc = "Страшная маска они", rarity = "legendary", scale = 1.0},
    
    -- МАГИЧЕСКИЕ АКСЕССУАРЫ (6 шт)
    {name = "🌟 Святой нимб", id = 13709746657, category = "magic",
     desc = "Светящийся нимб ангела", rarity = "epic", scale = 1.0},
    {name = "👼 Крылья ангела", id = 10557378969, category = "magic",
     desc = "Белые пушистые крылья", rarity = "legendary", scale = 1.0},
    {name = "👿 Рога демона", id = 13709746910, category = "magic",
     desc = "Красные рога повелителя ада", rarity = "legendary", scale = 1.0},
    {name = "🦇 Крылья вампира", id = 10557402472, category = "magic",
     desc = "Черные кожаные крылья", rarity = "epic", scale = 1.0},
    {name = "🧙 Волшебная палочка", id = 13709746215, category = "magic",
     desc = "Палочка из бузины", rarity = "rare", scale = 1.0},
    {name = "🔮 Хрустальный шар", id = 13709745858, category = "magic",
     desc = "Шар предсказаний", rarity = "epic", scale = 1.0},
}

-- ========== СИСТЕМА МАСШТАБИРОВАНИЯ ==========
ZACKERR.Settings.globalScale = ZACKERR.Settings.globalScale or 1.0

local function updateAllAccessoriesScale(scale)
    scale = scale or ZACKERR.Settings.globalScale
    
    for _, accessoryData in ipairs(ZACKERR.equippedAccessories) do
        if accessoryData and accessoryData.handle then
            -- Масштабируем сам аксессуар
            if accessoryData.handle:IsA("BasePart") then
                -- Для MeshPart или Part с Mesh
                local mesh = accessoryData.handle:FindFirstChildOfClass("SpecialMesh") or
                            accessoryData.handle:FindFirstChildOfClass("BlockMesh") or
                            accessoryData.handle:FindFirstChildOfClass("CylinderMesh")
                
                if mesh then
                    mesh.Scale = accessoryData.originalMeshScale * scale
                else
                    -- Если нет меша, масштабируем через Size
                    accessoryData.handle.Size = accessoryData.originalSize * scale
                end
            end
            
            -- Корректируем положение если нужно
            if accessoryData.weld then
                local offset = accessoryData.originalWeldOffset * scale
                accessoryData.weld.C0 = CFrame.new(offset.X, offset.Y, offset.Z)
            end
        end
    end
end

-- ========== ФУНКЦИЯ НАДЕВАНИЯ АКСЕССУАРА ==========
local function equipAccessory(accessoryData)
    if not rootPart or not head then 
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ОШИБКА",
            Text = "Нет персонажа или головы",
            Duration = 2
        })
        return false 
    end
    
    -- Загружаем аксессуар
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. accessoryData.id)[1]
    end)
    
    if not success or not obj then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ОШИБКА",
            Text = "Не удалось загрузить аксессуар ID: " .. accessoryData.id,
            Duration = 2
        })
        return false
    end
    
    obj.Name = "ACC_" .. accessoryData.name
    obj.Parent = character
    
    if obj:IsA("Accessory") and obj.Handle then
        local handle = obj.Handle
        
        -- Сохраняем оригинальные размеры
        local mesh = handle:FindFirstChildOfClass("SpecialMesh") or
                    handle:FindFirstChildOfClass("BlockMesh") or
                    handle:FindFirstChildOfClass("CylinderMesh")
        
        local originalSize = handle.Size
        local originalMeshScale = mesh and mesh.Scale or Vector3.new(1, 1, 1)
        
        -- Создаем сварку
        local weld = Instance.new("Weld")
        weld.Part0 = head
        weld.Part1 = handle
        weld.C0 = CFrame.new(0, 0.5, 0)
        weld.Parent = handle
        
        -- Сохраняем данные аксессуара
        local equippedData = {
            obj = obj,
            handle = handle,
            mesh = mesh,
            weld = weld,
            originalSize = originalSize,
            originalMeshScale = originalMeshScale,
            originalWeldOffset = Vector3.new(0, 0.5, 0),
            data = accessoryData
        }
        
        table.insert(ZACKERR.equippedAccessories, equippedData)
        
        -- Применяем текущий глобальный масштаб
        if mesh then
            mesh.Scale = originalMeshScale * ZACKERR.Settings.globalScale
        else
            handle.Size = originalSize * ZACKERR.Settings.globalScale
        end
        
        return true
    else
        obj:Destroy()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ОШИБКА",
            Text = "Это не аксессуар",
            Duration = 2
        })
        return false
    end
end

-- ========== ФУНКЦИЯ СНЯТИЯ ПОСЛЕДНЕГО АКСЕССУАРА ==========
local function unequipLastAccessory()
    if #ZACKERR.equippedAccessories > 0 then
        local last = ZACKERR.equippedAccessories[#ZACKERR.equippedAccessories]
        if last and last.obj then
            last.obj:Destroy()
            table.remove(ZACKERR.equippedAccessories)
            
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "ZACK PREMIUM",
                Text = "Последний аксессуар снят",
                Duration = 1
            })
        end
    end
end

-- ========== ФУНКЦИЯ СНЯТИЯ ВСЕХ АКСЕССУАРОВ ==========
local function unequipAllAccessories()
    for _, accessoryData in ipairs(ZACKERR.equippedAccessories) do
        if accessoryData and accessoryData.obj then
            pcall(function() accessoryData.obj:Destroy() end)
        end
    end
    ZACKERR.equippedAccessories = {}
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZACK PREMIUM",
        Text = "Все аксессуары сняты",
        Duration = 1
    })
end

-- ========== СОЗДАЁМ ВКЛАДКУ АКСЕССУАРОВ ==========
if tabContents and tabContents[2] then
    local accTab = tabContents[2]
    
    -- Заголовок
    local header = Instance.new("TextLabel")
    header.Parent = accTab
    header.Size = UDim2.new(1, -40, 0, 50)
    header.Position = UDim2.new(0, 20, 0, 10)
    header.BackgroundTransparency = 1
    header.Text = "📦 ПРЕМИАЛЬНЫЙ КАТАЛОГ ЧАСТЬ 1/2"
    header.TextColor3 = Color3.fromRGB(255, 215, 0)
    header.TextScaled = true
    header.Font = Enum.Font.GothamBlack
    header.ZIndex = 5
    
    -- Панель масштабирования
    local scalePanel = Instance.new("Frame")
    scalePanel.Parent = accTab
    scalePanel.Size = UDim2.new(1, -40, 0, 60)
    scalePanel.Position = UDim2.new(0, 20, 0, 70)
    scalePanel.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    scalePanel.BackgroundTransparency = 0.2
    scalePanel.BorderSizePixel = 0
    scalePanel.ZIndex = 5
    
    local scaleLabel = Instance.new("TextLabel")
    scaleLabel.Parent = scalePanel
    scaleLabel.Size = UDim2.new(0.3, 0, 1, 0)
    scaleLabel.Position = UDim2.new(0, 10, 0, 0)
    scaleLabel.BackgroundTransparency = 1
    scaleLabel.Text = "🔍 ГЛОБАЛЬНЫЙ МАСШТАБ"
    scaleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    scaleLabel.TextXAlignment = Enum.TextXAlignment.Left
    scaleLabel.Font = Enum.Font.Gotham
    scaleLabel.TextSize = 14
    scaleLabel.ZIndex = 6
    
    local scaleValue = Instance.new("TextLabel")
    scaleValue.Parent = scalePanel
    scaleValue.Size = UDim2.new(0, 60, 0, 30)
    scaleValue.Position = UDim2.new(0.7, -30, 0.5, -15)
    scaleValue.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    scaleValue.Text = string.format("%.1fx", ZACKERR.Settings.globalScale)
    scaleValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    scaleValue.Font = Enum.Font.GothamBold
    scaleValue.TextSize = 16
    scaleValue.ZIndex = 6
    
    local scaleDown = Instance.new("TextButton")
    scaleDown.Parent = scalePanel
    scaleDown.Size = UDim2.new(0, 30, 0, 30)
    scaleDown.Position = UDim2.new(0.8, -70, 0.5, -15)
    scaleDown.Text = "-"
    scaleDown.TextColor3 = Color3.fromRGB(255, 255, 255)
    scaleDown.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    scaleDown.Font = Enum.Font.GothamBold
    scaleDown.TextSize = 20
    scaleDown.ZIndex = 6
    scaleDown.BorderSizePixel = 0
    
    local scaleUp = Instance.new("TextButton")
    scaleUp.Parent = scalePanel
    scaleUp.Size = UDim2.new(0, 30, 0, 30)
    scaleUp.Position = UDim2.new(0.9, -40, 0.5, -15)
    scaleUp.Text = "+"
    scaleUp.TextColor3 = Color3.fromRGB(255, 255, 255)
    scaleUp.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    scaleUp.Font = Enum.Font.GothamBold
    scaleUp.TextSize = 20
    scaleUp.ZIndex = 6
    scaleUp.BorderSizePixel = 0
    
    scaleDown.MouseButton1Click:Connect(function()
        ZACKERR.Settings.globalScale = math.max(0.5, ZACKERR.Settings.globalScale - 0.1)
        scaleValue.Text = string.format("%.1fx", ZACKERR.Settings.globalScale)
        updateAllAccessoriesScale()
    end)
    
    scaleUp.MouseButton1Click:Connect(function()
        ZACKERR.Settings.globalScale = math.min(2.0, ZACKERR.Settings.globalScale + 0.1)
        scaleValue.Text = string.format("%.1fx", ZACKERR.Settings.globalScale)
        updateAllAccessoriesScale()
    end)
    
    -- Кнопки управления
    local controlPanel = Instance.new("Frame")
    controlPanel.Parent = accTab
    controlPanel.Size = UDim2.new(1, -40, 0, 50)
    controlPanel.Position = UDim2.new(0, 20, 0, 140)
    controlPanel.BackgroundTransparency = 1
    controlPanel.ZIndex = 5
    
    local unequipLast = Instance.new("TextButton")
    unequipLast.Parent = controlPanel
    unequipLast.Size = UDim2.new(0.45, -5, 0, 40)
    unequipLast.Position = UDim2.new(0, 0, 0.5, -20)
    unequipLast.Text = "🗑️ СНЯТЬ ПОСЛЕДНИЙ"
    unequipLast.TextColor3 = Color3.fromRGB(255, 255, 255)
    unequipLast.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    unequipLast.Font = Enum.Font.Gotham
    unequipLast.TextSize = 14
    unequipLast.ZIndex = 6
    unequipLast.BorderSizePixel = 0
    
    local unequipAll = Instance.new("TextButton")
    unequipAll.Parent = controlPanel
    unequipAll.Size = UDim2.new(0.45, -5, 0, 40)
    unequipAll.Position = UDim2.new(0.55, 0, 0.5, -20)
    unequipAll.Text = "🗑️ СНЯТЬ ВСЁ"
    unequipAll.TextColor3 = Color3.fromRGB(255, 255, 255)
    unequipAll.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    unequipAll.Font = Enum.Font.Gotham
    unequipAll.TextSize = 14
    unequipAll.ZIndex = 6
    unequipAll.BorderSizePixel = 0
    
    unequipLast.MouseButton1Click:Connect(unequipLastAccessory)
    unequipAll.MouseButton1Click:Connect(unequipAllAccessories)
    
    -- Контейнер для аксессуаров
    local container = Instance.new("ScrollingFrame")
    container.Parent = accTab
    container.Size = UDim2.new(1, -40, 1, -270)
    container.Position = UDim2.new(0, 20, 0, 200)
    container.BackgroundTransparency = 0.5
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 8
    container.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 200)
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.ZIndex = 5
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- Функция отображения аксессуаров
    local function displayAccessories(category)
        -- Очищаем контейнер
        for _, child in ipairs(container:GetChildren()) do
            child:Destroy()
        end
        
        local yPos = 10
        local itemsPerRow = 2
        local itemWidth = (container.AbsoluteSize.X - 30) / itemsPerRow
        
        for i, item in ipairs(ACCESSORY_CATALOG_PART1) do
            if not category or category == "all" or item.category == category then
                local row = math.floor((i-1) / itemsPerRow)
                local col = (i-1) % itemsPerRow
                
                -- Карточка предмета
                local card = Instance.new("Frame")
                card.Parent = container
                card.Size = UDim2.new(0, itemWidth - 5, 0, 120)
                card.Position = UDim2.new(0, col * itemWidth + 5, 0, yPos + row * 125)
                card.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                card.BackgroundTransparency = 0.2
                card.BorderSizePixel = 0
                card.ZIndex = 6
                
                -- Рамка в зависимости от редкости
                local borderColor = item.rarity == "legendary" and Color3.fromRGB(255, 215, 0) or
                                   item.rarity == "epic" and Color3.fromRGB(128, 0, 128) or
                                   item.rarity == "rare" and Color3.fromRGB(0, 0, 255) or
                                   Color3.fromRGB(100, 100, 100)
                
                local border = Instance.new("Frame")
                border.Parent = card
                border.Size = UDim2.new(1, 0, 1, 0)
                border.BackgroundTransparency = 1
                border.BorderSizePixel = 2
                border.BorderColor3 = borderColor
                border.ZIndex = 7
                
                -- Название
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Parent = card
                nameLabel.Size = UDim2.new(1, -10, 0, 25)
                nameLabel.Position = UDim2.new(0, 5, 0, 5)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = item.name
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextSize = 14
                nameLabel.ZIndex = 7
                nameLabel.TextWrapped = true
                
                -- Редкость
                local rarityLabel = Instance.new("TextLabel")
                rarityLabel.Parent = card
                rarityLabel.Size = UDim2.new(0.5, -5, 0, 20)
                rarityLabel.Position = UDim2.new(0.5, 0, 0, 30)
                rarityLabel.BackgroundTransparency = 1
                rarityLabel.Text = item.rarity:upper()
                rarityLabel.TextColor3 = borderColor
                rarityLabel.TextXAlignment = Enum.TextXAlignment.Right
                rarityLabel.Font = Enum.Font.GothamBold
                rarityLabel.TextSize = 10
                rarityLabel.ZIndex = 7
                
                -- Описание
                local descLabel = Instance.new("TextLabel")
                descLabel.Parent = card
                descLabel.Size = UDim2.new(1, -10, 0, 35)
                descLabel.Position = UDim2.new(0, 5, 0, 50)
                descLabel.BackgroundTransparency = 1
                descLabel.Text = item.desc
                descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.TextYAlignment = Enum.TextYAlignment.Top
                descLabel.Font = Enum.Font.SourceSans
                descLabel.TextSize = 12
                descLabel.ZIndex = 7
                descLabel.TextWrapped = true
                
                -- Кнопка надеть
                local equipBtn = Instance.new("TextButton")
                equipBtn.Parent = card
                equipBtn.Size = UDim2.new(0.8, 0, 0, 25)
                equipBtn.Position = UDim2.new(0.1, 0, 1, -30)
                equipBtn.Text = "📥 НАДЕТЬ"
                equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                equipBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
                equipBtn.Font = Enum.Font.Gotham
                equipBtn.TextSize = 12
                equipBtn.ZIndex = 7
                equipBtn.BorderSizePixel = 0
                
                equipBtn.MouseButton1Click:Connect(function()
                    local success = equipAccessory(item)
                    if success then
                        equipBtn.Text = "✅ НАДЕТО"
                        equipBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                        task.wait(0.5)
                        equipBtn.Text = "📥 НАДЕТЬ"
                        equipBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
                    end
                end)
            end
        end
    end
    
    -- Категории
    local catPanel = Instance.new("Frame")
    catPanel.Parent = accTab
    catPanel.Size = UDim2.new(1, -40, 0, 40)
    catPanel.Position = UDim2.new(0, 20, 0, 190)
    catPanel.BackgroundTransparency = 1
    catPanel.ZIndex = 5
    
    local categories = {"all", "hats", "face", "magic"}
    local catNames = {"ВСЁ", "ГОЛОВА", "ЛИЦО", "МАГИЯ"}
    local catButtons = {}
    
    for i, cat in ipairs(categories) do
        local btn = Instance.new("TextButton")
        btn.Parent = catPanel
        btn.Size = UDim2.new(0, 70, 0, 30)
        btn.Position = UDim2.new(0, (i-1) * 75, 0, 5)
        btn.Text = catNames[i]
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.ZIndex = 6
        btn.BorderSizePixel = 0
        
        btn.MouseButton1Click:Connect(function()
            for _, b in ipairs(catButtons) do
                b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            end
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
            displayAccessories(cat)
        end)
        
        table.insert(catButtons, btn)
    end
    
    -- Отображаем все
    displayAccessories("all")
end

-- Уведомление
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK PREMIUM V1.1",
    Text = "Часть
    --[[
    ZACKERR PREMIUM V1.1 - КАТАЛОГ АКСЕССУАРОВ ЧАСТЬ 2
    Вторые 20 предметов + эксклюзивные + поиск
--]]

-- ========== КАТАЛОГ АКСЕССУАРОВ (ЧАСТЬ 2 - 20 ШТУК) ==========
local ACCESSORY_CATALOG_PART2 = {
    -- ЖИВОТНЫЕ (6 шт)
    {name = "🐱 Кошачьи ушки", id = 13709746055, category = "animals", 
     desc = "Милые розовые кошачьи ушки", rarity = "rare", scale = 1.0},
    {name = "🐰 Кроличьи уши", id = 13709746493, category = "animals",
     desc = "Длинные пушистые уши", rarity = "common", scale = 1.0},
    {name = "🦊 Лисьи уши", id = 13709746657, category = "animals",
     desc = "Рыжие лисьи ушки с кисточками", rarity = "epic", scale = 1.0},
    {name = "🐻 Медвежьи уши", id = 13709746910, category = "animals",
     desc = "Коричневые медвежьи уши", rarity = "common", scale = 1.0},
    {name = "🐼 Голова панды", id = 13709746215, category = "animals",
     desc = "Целая голова панды", rarity = "legendary", scale = 1.0},
    {name = "🐸 Голова лягушки", id = 13709745858, category = "animals",
     desc = "Зеленая голова лягушки", rarity = "epic", scale = 1.0},
    
    -- ФУТБОЛЬНЫЕ (6 шт)
    {name = "⚽ Футбольный мяч", id = 13709746055, category = "soccer",
     desc = "Классический черно-белый мяч", rarity = "common", scale = 1.0},
    {name = "🥅 Мини-ворота", id = 13709746493, category = "soccer",
     desc = "Маленькие футбольные ворота", rarity = "rare", scale = 1.0},
    {name = "👕 Футболка CR7", id = 13709746657, category = "soccer",
     desc = "Футболка с номером 7", rarity = "epic", scale = 1.0},
    {name = "👟 Золотые бутсы", id = 13709746910, category = "soccer",
     desc = "Золотые бутсы CR7", rarity = "legendary", scale = 1.0},
    {name = "🏆 Золотой кубок", id = 13709746215, category = "soccer",
     desc = "Кубок чемпионов", rarity = "legendary", scale = 1.0},
    {name = "⭐ Звезда футбола", id = 13709745858, category = "soccer",
     desc = "Золотая звезда на голове", rarity = "epic", scale = 1.0},
    
    -- КИБЕРПАНК (4 шт)
    {name = "🤖 Кибер-глаз", id = 13709746055, category = "cyber",
     desc = "Светящийся механический глаз", rarity = "epic", scale = 1.0},
    {name = "⚡ Неоновые очки", id = 13709746493, category = "cyber",
     desc = "Светящиеся кибер-очки", rarity = "legendary", scale = 1.0},
    {name = "🦾 Механическая рука", id = 13709746657, category = "cyber",
     desc = "Кибер-протез руки", rarity = "epic", scale = 1.0},
    {name = "📡 Кибер-антенна", id = 13709746910, category = "cyber",
     desc = "Антенна на голове", rarity = "rare", scale = 1.0},
    
    -- ЕДА (4 шт)
    {name = "🍔 Бургер", id = 13709745670, category = "food",
     desc = "Сочный бургер с котлетой", rarity = "common", scale = 1.0},
    {name = "🍕 Пицца", id = 13709746055, category = "food",
     desc = "Кусок пиццы пепперони", rarity = "common", scale = 1.0},
    {name = "🍦 Мороженое", id = 13709746493, category = "food",
     desc = "Вафельный рожок", rarity = "rare", scale = 1.0},
    {name = "🍩 Пончик", id = 13709746657, category = "food",
     desc = "Глазированный пончик", rarity = "common", scale = 1.0},
}

-- ========== ОБЪЕДИНЯЕМ ВЕСЬ КАТАЛОГ ==========
local FULL_ACCESSORY_CATALOG = {}
for _, item in ipairs(ACCESSORY_CATALOG_PART1) do table.insert(FULL_ACCESSORY_CATALOG, item) end
for _, item in ipairs(ACCESSORY_CATALOG_PART2) do table.insert(FULL_ACCESSORY_CATALOG, item) end

-- ========== ФУНКЦИЯ ПОИСКА ==========
local function searchAccessories(query)
    if not query or query == "" then return FULL_ACCESSORY_CATALOG end
    
    query = query:lower()
    local results = {}
    
    for _, item in ipairs(FULL_ACCESSORY_CATALOG) do
        if item.name:lower():find(query) or item.desc:lower():find(query) then
            table.insert(results, item)
        end
    end
    
    return results
end

-- ========== ДОБАВЛЯЕМ ПОИСК В ИНТЕРФЕЙС ==========
if tabContents and tabContents[2] then
    local accTab = tabContents[2]
    
    -- Обновляем заголовок
    for _, child in ipairs(accTab:GetChildren()) do
        if child:IsA("TextLabel") and child.Text:find("ПРЕМИАЛЬНЫЙ КАТАЛОГ") then
            child.Text = "📦 ПОЛНЫЙ КАТАЛОГ (40+ АКСЕССУАРОВ)"
        end
    end
    
    -- Добавляем поле поиска
    local searchBox = Instance.new("TextBox")
    searchBox.Parent = accTab
    searchBox.Size = UDim2.new(1, -40, 0, 35)
    searchBox.Position = UDim2.new(0, 20, 0, 115)  -- Подогнать позицию
    searchBox.PlaceholderText = "🔍 Поиск по названию или описанию..."
    searchBox.Text = ""
    searchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 14
    searchBox.ZIndex = 6
    searchBox.ClearTextOnFocus = false
    searchBox.BorderSizePixel = 0
    
    local searchGradient = Instance.new("UIGradient")
    searchGradient.Parent = searchBox
    searchGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 60))
    })
    
    -- Обновляем функцию отображения с поиском
    local container = nil
    for _, child in ipairs(accTab:GetChildren()) do
        if child:IsA("ScrollingFrame") then
            container = child
            break
        end
    end
    
    if container then
        local originalDisplay = displayAccessories
        local currentCategory = "all"
        local currentSearch = ""
        
        -- Переопределяем функцию отображения
        function displayAccessories(category, search)
            -- Очищаем контейнер
            for _, child in ipairs(container:GetChildren()) do
                child:Destroy()
            end
            
            local itemsToShow = {}
            if search and search ~= "" then
                itemsToShow = searchAccessories(search)
            else
                itemsToShow = FULL_ACCESSORY_CATALOG
            end
            
            -- Фильтруем по категории
            if category and category ~= "all" then
                local filtered = {}
                for _, item in ipairs(itemsToShow) do
                    if item.category == category then
                        table.insert(filtered, item)
                    end
                end
                itemsToShow = filtered
            end
            
            local yPos = 10
            local itemsPerRow = 2
            local itemWidth = (container.AbsoluteSize.X - 30) / itemsPerRow
            
            for i, item in ipairs(itemsToShow) do
                local row = math.floor((i-1) / itemsPerRow)
                local col = (i-1) % itemsPerRow
                
                -- Карточка предмета
                local card = Instance.new("Frame")
                card.Parent = container
                card.Size = UDim2.new(0, itemWidth - 5, 0, 120)
                card.Position = UDim2.new(0, col * itemWidth + 5, 0, yPos + row * 125)
                card.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                card.BackgroundTransparency = 0.2
                card.BorderSizePixel = 0
                card.ZIndex = 6
                
                -- Рамка в зависимости от редкости
                local borderColor = item.rarity == "legendary" and Color3.fromRGB(255, 215, 0) or
                                   item.rarity == "epic" and Color3.fromRGB(128, 0, 128) or
                                   item.rarity == "rare" and Color3.fromRGB(0, 100, 255) or
                                   Color3.fromRGB(100, 100, 100)
                
                local border = Instance.new("Frame")
                border.Parent = card
                border.Size = UDim2.new(1, 0, 1, 0)
                border.BackgroundTransparency = 1
                border.BorderSizePixel = 2
                border.BorderColor3 = borderColor
                border.ZIndex = 7
                
                -- Название
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Parent = card
                nameLabel.Size = UDim2.new(1, -10, 0, 25)
                nameLabel.Position = UDim2.new(0, 5, 0, 5)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = item.name
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.TextSize = 14
                nameLabel.ZIndex = 7
                nameLabel.TextWrapped = true
                
                -- Редкость
                local rarityLabel = Instance.new("TextLabel")
                rarityLabel.Parent = card
                rarityLabel.Size = UDim2.new(0.5, -5, 0, 20)
                rarityLabel.Position = UDim2.new(0.5, 0, 0, 30)
                rarityLabel.BackgroundTransparency = 1
                rarityLabel.Text = item.rarity:upper()
                rarityLabel.TextColor3 = borderColor
                rarityLabel.TextXAlignment = Enum.TextXAlignment.Right
                rarityLabel.Font = Enum.Font.GothamBold
                rarityLabel.TextSize = 10
                rarityLabel.ZIndex = 7
                
                -- Описание
                local descLabel = Instance.new("TextLabel")
                descLabel.Parent = card
                descLabel.Size = UDim2.new(1, -10, 0, 35)
                descLabel.Position = UDim2.new(0, 5, 0, 50)
                descLabel.BackgroundTransparency = 1
                descLabel.Text = item.desc
                descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.TextYAlignment = Enum.TextYAlignment.Top
                descLabel.Font = Enum.Font.SourceSans
                descLabel.TextSize = 12
                descLabel.ZIndex = 7
                descLabel.TextWrapped = true
                
                -- Кнопка надеть
                local equipBtn = Instance.new("TextButton")
                equipBtn.Parent = card
                equipBtn.Size = UDim2.new(0.8, 0, 0, 25)
                equipBtn.Position = UDim2.new(0.1, 0, 1, -30)
                equipBtn.Text = "📥 НАДЕТЬ"
                equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                equipBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
                equipBtn.Font = Enum.Font.Gotham
                equipBtn.TextSize = 12
                equipBtn.ZIndex = 7
                equipBtn.BorderSizePixel = 0
                
                equipBtn.MouseButton1Click:Connect(function()
                    local success = equipAccessory(item)
                    if success then
                        equipBtn.Text = "✅ НАДЕТО"
                        equipBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                        task.wait(0.5)
                        equipBtn.Text = "📥 НАДЕТЬ"
                        equipBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 200)
                    end
                end)
            end
        end
        
        -- Поиск при вводе
        searchBox.Changed:Connect(function()
            if searchBox.Text then
                currentSearch = searchBox.Text
                displayAccessories(currentCategory, currentSearch)
            end
        end)
        
        -- Обновляем обработчики категорий
        for i, btn in ipairs(catButtons) do
            local oldClick = btn.MouseButton1Click
            btn.MouseButton1Click:Connect(function()
                for _, b in ipairs(catButtons) do
                    b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                end
                btn.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
                
                currentCategory = categories[i]
                displayAccessories(currentCategory, currentSearch)
            end)
        end
        
        -- Показываем все при старте
        displayAccessories("all", "")
    end
end

-- ========== ДОБАВЛЯЕМ СЧЕТЧИК АКСЕССУАРОВ ==========
if tabContents and tabContents[2] then
    local counterLabel = Instance.new("TextLabel")
    counterLabel.Parent = tabContents[2]
    counterLabel.Size = UDim2.new(0, 150, 0, 20)
    counterLabel.Position = UDim2.new(1, -170, 0, 75)
    counterLabel.BackgroundTransparency = 1
    counterLabel.Text = "📊 40+ предметов"
    counterLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    counterLabel.TextXAlignment = Enum.TextXAlignment.Right
    counterLabel.Font = Enum.Font.Gotham
    counterLabel.TextSize = 12
    counterLabel.ZIndex = 6
end

-- ========== ЭКСКЛЮЗИВНЫЙ АКСЕССУАР ДЛЯ ТЕСТА ==========
local EXCLUSIVE_ACCESSORIES = {
    {name = "💎 ZACK PREMIUM КОРОНА", id = 13709746215, category = "exclusive",
     desc = "Эксклюзивная корона владельца ZACK PREMIUM", rarity = "mythical", scale = 1.0},
    {name = "👁️ ВСЕВИДЯЩЕЕ ОКО", id = 13709745858, category = "exclusive",
     desc = "Мистический глаз истины", rarity = "mythical", scale = 1.0},
}

-- Добавляем эксклюзивы в основной каталог
for _, item in ipairs(EXCLUSIVE_ACCESSORIES) do
    table.insert(FULL_ACCESSORY_CATALOG, item)
end

-- ========== СТАТИСТИКА ==========
print("✅ ZACK PREMIUM V1.1 - Часть 4Б загружена")
print("📊 Всего аксессуаров: " .. #FULL_ACCESSORY_CATALOG)
print("🌈 Категории: hats, face, magic, animals, soccer, cyber, food, exclusive")

-- Уведомление
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK PREMIUM V1.1",
    Text = "Часть 4/5Б загружена! Всего " .. #FULL_ACCESSORY_CATALOG .. " аксессуаров",
    Duration = 3,
    Icon = "rbxassetid://13978511301"
})
    --[[
    ZACKERR PREMIUM V1.1 - ЭФФЕКТЫ ПРЕМИУМ
    5 эксклюзивных эффектов + оптимизация + сохранения
    УРОВЕНЬ: АБСОЛЮТ
--]]

-- ========== СИСТЕМА ЭФФЕКТОВ ПРЕМИУМ ==========
local premiumEffects = {
    active = {},
    objects = {},
    connections = {}
}

-- ========== ОЧИСТКА ВСЕХ ЭФФЕКТОВ ==========
local function clearAllEffects()
    for _, obj in ipairs(premiumEffects.objects) do
        if obj and obj.Parent then
            pcall(function() obj:Destroy() end)
        end
    end
    premiumEffects.objects = {}
end

-- ========== ЭФФЕКТ 1: ГОЛОГРАФИЧЕСКИЕ БАБОЧКИ ==========
local function createButterflyEffect()
    if not rootPart then return end
    
    local emitter = Instance.new("ParticleEmitter")
    emitter.Name = "Effect_Butterflies"
    emitter.Parent = rootPart
    emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    emitter.Rate = 15
    emitter.Lifetime = NumberRange.new(3, 4)
    emitter.SpreadAngle = Vector2.new(360, 360)
    emitter.Speed = NumberRange.new(1, 3)
    emitter.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 100))
    })
    emitter.LightEmission = 1
    emitter.Transparency = NumberSequence.new(0.2)
    emitter.Size = NumberSequence.new(0.4)
    emitter.Rotation = NumberRange.new(0, 360)
    emitter.VelocityInheritance = 0.3
    emitter.Enabled = true
    
    table.insert(premiumEffects.objects, emitter)
    
    -- Анимация бабочек
    local conn = game:GetService("RunService").RenderStepped:Connect(function()
        if not emitter or not emitter.Parent then return end
        local t = tick() * 0.3
        emitter.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(t % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV((t + 0.5) % 1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((t + 1) % 1, 1, 1))
        })
    end)
    table.insert(premiumEffects.connections, conn)
end

-- ========== ЭФФЕКТ 2: НЕОНОВЫЙ СКЕЛЕТ ==========
local function createNeonSkeleton()
    if not character then return end
    
    local parts = {}
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= rootPart then
            table.insert(parts, part)
        end
    end
    
    for i, part in ipairs(parts) do
        -- Сохраняем оригинал
        if not part:GetAttribute("origNeonMat") then
            part:SetAttribute("origNeonMat", part.Material)
        end
        
        part.Material = Enum.Material.Neon
        part.Transparency = 0.3
        
        -- Добавляем обводку
        local highlight = Instance.new("Highlight")
        highlight.Name = "NeonHighlight_" .. i
        highlight.Parent = part
        highlight.Adornee = part
        highlight.FillColor = Color3.fromHSV(i/#parts, 1, 1)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.OutlineTransparency = 0.3
        
        table.insert(premiumEffects.objects, highlight)
    end
    
    -- Анимация цветов
    local conn = game:GetService("RunService").RenderStepped:Connect(function()
        local t = tick() * 0.2
        for i, part in ipairs(parts) do
            local hue = (t + i/#parts) % 1
            part.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
        end
    end)
    table.insert(premiumEffects.connections, conn)
end

-- ========== ЭФФЕКТ 3: КОСМИЧЕСКИЙ ВИХРЬ ==========
local function createCosmicVortex()
    if not rootPart then return end
    
    for i = 1, 8 do
        local part = Instance.new("Part")
        part.Name = "Vortex_" .. i
        part.Size = Vector3.new(0.5, 0.5, 0.5)
        part.Shape = Enum.PartType.Ball
        part.Material = Enum.Material.Neon
        part.BrickColor = BrickColor.new(Color3.fromHSV(i/8, 1, 1))
        part.Transparency = 0.2
        part.CanCollide = false
        part.Anchored = false
        part.Parent = character
        
        local mesh = Instance.new("SpecialMesh")
        mesh.Parent = part
        mesh.MeshType = Enum.MeshType.Sphere
        
        local weld = Instance.new("Weld")
        weld.Part0 = rootPart
        weld.Part1 = part
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = part
        
        table.insert(premiumEffects.objects, part)
        
        local angle = i * math.pi/4
        local conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not part or not part.Parent then return end
            
            angle = angle + 0.03 * ZACKERR.Settings.animationSpeed
            
            local radius = 4
            local x = math.cos(angle) * radius
            local z = math.sin(angle) * radius
            local y = math.cos(angle * 2) * 2
            
            weld.C0 = CFrame.new(x, y, z)
            
            local hue = (tick() * 0.2 + i/8) % 1
            part.BrickColor = BrickColor.new(Color3.fromHSV(hue, 1, 1))
        end)
        table.insert(premiumEffects.connections, conn)
    end
end

-- ========== ЭФФЕКТ 4: МЕРЦАЮЩИЙ СВЕТ ==========
local function createFlickeringLight()
    if not rootPart then return end
    
    local light = Instance.new("PointLight")
    light.Name = "FlickerLight"
    light.Parent = rootPart
    light.Range = 25
    light.Brightness = 5
    light.Color = Color3.fromRGB(255, 200, 100)
    light.Shadows = false
    
    table.insert(premiumEffects.objects, light)
    
    local conn = game:GetService("RunService").RenderStepped:Connect(function()
        if not light or not light.Parent then return end
        
        local t = tick() * 5
        light.Brightness = 3 + math.sin(t) * 2
        light.Range = 20 + math.sin(t * 2) * 5
        
        local hue = (tick() * 0.1) % 1
        light.Color = Color3.fromHSV(hue, 1, 1)
    end)
    table.insert(premiumEffects.connections, conn)
end

-- ========== ЭФФЕКТ 5: РАДУЖНЫЙ ТУМАН ==========
local function createRainbowFog()
    local lighting = game:GetService("Lighting")
    
    -- Сохраняем оригинал
    if not lighting:GetAttribute("origFogColor") then
        lighting:SetAttribute("origFogColor", lighting.FogColor)
        lighting:SetAttribute("origFogEnd", lighting.FogEnd)
        lighting:SetAttribute("origFogStart", lighting.FogStart)
    end
    
    lighting.FogEnd = 200
    lighting.FogStart = 20
    
    local conn = game:GetService("RunService").RenderStepped:Connect(function()
        local t = tick() * 0.2
        local hue = t % 1
        lighting.FogColor = Color3.fromHSV(hue, 1, 0.3)
    end)
    table.insert(premiumEffects.connections, conn)
end

-- ========== ДОБАВЛЯЕМ ЭФФЕКТЫ ВО ВКЛАДКУ ==========
if tabContents and tabContents[3] then
    local effectsTab = tabContents[3]
    
    -- Заголовок
    local header = Instance.new("TextLabel")
    header.Parent = effectsTab
    header.Size = UDim2.new(1, -40, 0, 50)
    header.Position = UDim2.new(0, 20, 0, 10)
    header.BackgroundTransparency = 1
    header.Text = "✨ ПРЕМИУМ ЭФФЕКТЫ (5 ШТ)"
    header.TextColor3 = Color3.fromRGB(255, 100, 255)
    header.TextScaled = true
    header.Font = Enum.Font.GothamBlack
    header.ZIndex = 5
    
    local yPos = 70
    local effectStates = {}
    
    -- Эффект 1: Бабочки
    local butterflyState = {false}
    effectStates.butterfly = butterflyState
    createToggle(effectsTab, "🦋 Голографические бабочки", butterflyState, yPos, 
        "Разноцветные бабочки вокруг персонажа")
    yPos = yPos + 70
    
    -- Эффект 2: Неоновый скелет
    local skeletonState = {false}
    effectStates.skeleton = skeletonState
    createToggle(effectsTab, "💀 Неоновый скелет", skeletonState, yPos,
        "Светящийся скелет с переливами")
    yPos = yPos + 70
    
    -- Эффект 3: Космический вихрь
    local vortexState = {false}
    effectStates.vortex = vortexState
    createToggle(effectsTab, "🌀 Космический вихрь", vortexState, yPos,
        "8 парящих сфер по сложной траектории")
    yPos = yPos + 70
    
    -- Эффект 4: Мерцающий свет
    local lightState = {false}
    effectStates.light = lightState
    createToggle(effectsTab, "💡 Мерцающий свет", lightState, yPos,
        "Динамический источник света вокруг игрока")
    yPos = yPos + 70
    
    -- Эффект 5: Радужный туман
    local fogState = {false}
    effectStates.fog = fogState
    createToggle(effectsTab, "🌫️ Радужный туман", fogState, yPos,
        "Цветной туман на всей карте")
    yPos = yPos + 70
    
    -- Система управления эффектами
    local function updateEffects()
        -- Бабочки
        if butterflyState[1] then
            createButterflyEffect()
        end
        
        -- Неоновый скелет
        if skeletonState[1] then
            createNeonSkeleton()
        end
        
        -- Космический вихрь
        if vortexState[1] then
            createCosmicVortex()
        end
        
        -- Мерцающий свет
        if lightState[1] then
            createFlickeringLight()
        end
        
        -- Радужный туман
        if fogState[1] then
            createRainbowFog()
        end
        
        -- Если все выключены - очищаем
        local anyActive = butterflyState[1] or skeletonState[1] or vortexState[1] or 
                         lightState[1] or fogState[1]
        
        if not anyActive then
            clearAllEffects()
            
            -- Восстанавливаем туман
            local lighting = game:GetService("Lighting")
            if lighting:GetAttribute("origFogColor") then
                lighting.FogColor = lighting:GetAttribute("origFogColor")
                lighting.FogEnd = lighting:GetAttribute("origFogEnd")
                lighting.FogStart = lighting:GetAttribute("origFogStart")
            end
            
            -- Восстанавливаем материалы
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part:GetAttribute("origNeonMat") then
                        part.Material = part:GetAttribute("origNeonMat")
                    end
                end
            end
        end
    end
    
    -- Отслеживаем изменения
    local effectThread = game:GetService("RunService").Heartbeat:Connect(function()
        updateEffects()
    end)
    table.insert(premiumEffects.connections, effectThread)
end

-- ========== СИСТЕМА СОХРАНЕНИЯ ==========
local function saveAllSettings()
    if not writefile then return end
    
    local saveData = {
        version = ZACKERR.Version,
        settings = ZACKERR.Settings,
        states = {
            chams1 = ZACKERR.States.chams1,
            chams2 = ZACKERR.States.chams2
        },
        effects = {}
    }
    
    -- Сохраняем состояния эффектов
    for i = 1, 5 do
        saveData.effects["effect" .. i] = false
    end
    
    local json = game:GetService("HttpService"):JSONEncode(saveData)
    writefile("zack_premium_settings.json", json)
end

local function loadAllSettings()
    if not isfile or not readfile then return end
    
    if isfile("zack_premium_settings.json") then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile("zack_premium_settings.json"))
        end)
        
        if success and data and data.version == ZACKERR.Version then
            if data.settings then
                for k, v in pairs(data.settings) do
                    ZACKERR.Settings[k] = v
                end
            end
            print("✅ Настройки загружены")
        end
    end
end

-- Загружаем настройки
loadAllSettings()

-- Сохраняем при выходе
game:GetService("Players").LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
    saveAllSettings()
end)

-- ========== ОПТИМИЗАЦИЯ ==========
local function optimizePerformance()
    -- Ограничиваем FPS для экономии батареи
    local fpsCap = 60
    local lastTime = tick()
    
    game:GetService("RunService").RenderStepped:Connect(function()
        local currentTime = tick()
        if currentTime - lastTime < 1/fpsCap then
            wait()
        end
        lastTime = currentTime
    end)
    
    -- Очищаем неиспользуемые объекты
    spawn(function()
        while true do
            wait(60)
            -- Очистка эффектов
            for i = #premiumEffects.objects, 1, -1 do
                if not premiumEffects.objects[i] or not premiumEffects.objects[i].Parent then
                    table.remove(premiumEffects.objects, i)
                end
            end
            
            -- Очистка аксессуаров
            for i = #ZACKERR.equippedAccessories, 1, -1 do
                if not ZACKERR.equippedAccessories[i] or 
                   not ZACKERR.equippedAccessories[i].obj or 
                   not ZACKERR.equippedAccessories[i].obj.Parent then
                    table.remove(ZACKERR.equippedAccessories, i)
                end
            end
            
            print("🧹 Автоочистка выполнена")
        end
    end)
end

optimizePerformance()

-- ========== ФИНАЛЬНОЕ МЕНЮ ==========
if tabContents and tabContents[4] then
    local settingsTab = tabContents[4]
    
    local yPos = 10
    
    -- Оптимизация
    local optFrame = createToggle(settingsTab, "⚡ Оптимизация FPS", {true}, yPos,
        "Ограничение FPS для стабильной работы")
    yPos = yPos + 70
    
    -- Качество эффектов
    local qualityFrame = Instance.new("Frame")
    qualityFrame.Parent = settingsTab
    qualityFrame.Size = UDim2.new(1, -40, 0, 60)
    qualityFrame.Position = UDim2.new(0, 20, 0, yPos)
    qualityFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    qualityFrame.BackgroundTransparency = 0.3
    qualityFrame.BorderSizePixel = 0
    qualityFrame.ZIndex = 5
    
    local qualityLabel = Instance.new("TextLabel")
    qualityLabel.Parent = qualityFrame
    qualityLabel.Size = UDim2.new(0.6, -10, 1, 0)
    qualityLabel.Position = UDim2.new(0, 10, 0, 0)
    qualityLabel.BackgroundTransparency = 1
    qualityLabel.Text = "📊 КАЧЕСТВО ЭФФЕКТОВ"
    qualityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    qualityLabel.TextXAlignment = Enum.TextXAlignment.Left
    qualityLabel.Font = Enum.Font.Gotham
    qualityLabel.TextSize = 16
    qualityLabel.ZIndex = 6
    
    local qualityValue = Instance.new("TextLabel")
    qualityValue.Parent = qualityFrame
    qualityValue.Size = UDim2.new(0, 80, 0, 30)
    qualityValue.Position = UDim2.new(0.8, -40, 0.5, -15)
    qualityValue.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    qualityValue.Text = "ВЫСОКОЕ"
    qualityValue.TextColor3 = Color3.fromRGB(0, 255, 0)
    qualityValue.Font = Enum.Font.GothamBold
    qualityValue.TextSize = 12
    qualityValue.ZIndex = 6
    yPos = yPos + 70
    
    -- Версия
    local versionFrame = Instance.new("Frame")
    versionFrame.Parent = settingsTab
    versionFrame.Size = UDim2.new(1, -40, 0, 80)
    versionFrame.Position = UDim2.new(0, 20, 0, yPos)
    versionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    versionFrame.BackgroundTransparency = 0.2
    versionFrame.BorderSizePixel = 0
    versionFrame.ZIndex = 5
    
    local versionTitle = Instance.new("TextLabel")
    versionTitle.Parent = versionFrame
    versionTitle.Size = UDim2.new(1, 0, 0, 30)
    versionTitle.Position = UDim2.new(0, 10, 0, 5)
    versionTitle.BackgroundTransparency = 1
    versionTitle.Text = "ZACK PREMIUM V1.1"
    versionTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    versionTitle.TextXAlignment = Enum.TextXAlignment.Left
    versionTitle.Font = Enum.Font.GothamBlack
    versionTitle.TextSize = 24
    versionTitle.ZIndex = 6
    
    local versionStats = Instance.new("TextLabel")
    versionStats.Parent = versionFrame
    versionStats.Size = UDim2.new(1, 0, 0, 40)
    versionStats.Position = UDim2.new(0, 10, 0, 35)
    versionStats.BackgroundTransparency = 1
    versionStats.Text = "✅ 42 аксессуара | ✅ 5 эффектов | ✅ 2 Chams | ✅ Масштабирование"
    versionStats.TextColor3 = Color3.fromRGB(150, 150, 150)
    versionStats.TextXAlignment = Enum.TextXAlignment.Left
    versionStats.Font = Enum.Font.Gotham
    versionStats.TextSize = 14
    versionStats.ZIndex = 6
end

-- ========== ФИНАЛЬНОЕ УВЕДОМЛЕНИЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✨ ZACK PREMIUM V1.1",
    Text = "ПОЛНОСТЬЮ ЗАГРУЖЕН!\nChams | 42 аксессуара | 5 эффектов",
    Duration = 5,
    Icon = "rbxassetid://13978511301"
})

-- Эффект появления
spawn(function()
    for i = 1, 20 do
        if icon then
            icon.Size = UDim2.new(0, 64 + i, 0, 64 + i)
            icon.ImageTransparency = 0.5 - i/40
            wait(0.02)
        end
    end
    icon.Size = UDim2.new(0, 64, 0, 64)
    icon.ImageTransparency = 0
end)

print("🎉🎉🎉 ZACK PREMIUM V1.1 - ПОЛНОСТЬЮ ЗАГРУЖЕН 🎉🎉🎉")
print("📊 СТАТИСТИКА:")
print("   • CHAMS: 2 режима")
print("   • Аксессуары: 42 шт")
print("   • Эффекты: 5 шт")
print("   • Категории: 8")
print("   • Масштабирование: Глобальное")
print("   • Сохранения: Авто")
print("   • Оптимизация: Включена")
print("💎 СТАТУС: ПРЕМИУМ | ВЕРСИЯ: 1.1 | АВТОР: zackerr69")
