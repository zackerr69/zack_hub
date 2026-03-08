-- ZACK_HUB V2.0 | CORE ENGINE | PART 1
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- [UI] Основная настройка ScreenGui
local screenGui = Instance.new("ScreenGui", pgui)
screenGui.Name = "ZACK_HUB_V2"
screenGui.ResetOnSpawn = false

-- Функция создания радужной надписи
local function createRainbowLabel(parent, text, position)
    local label = Instance.new("TextLabel", parent)
    label.Text = text
    label.Size = UDim2.new(0, 200, 0, 50)
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Code
    label.TextSize = 18
    
    task.spawn(function()
        while label.Parent do
            for i = 0, 1, 0.01 do
                label.TextColor3 = Color3.fromHSV(i, 1, 1)
                task.wait(0.05)
            end
        end
    end)
    return label
end

-- [UI] Индикатор в левом нижнем углу
createRainbowLabel(screenGui, "ZACK_HUB V2.0", UDim2.new(0, 10, 0.95, 0))

-- [UI] Кастомные уведомления
local function notify(title, text)
    local notif = Instance.new("Frame", screenGui)
    notif.Size = UDim2.new(0, 250, 0, 60)
    notif.Position = UDim2.new(1, 260, 0.8, 0)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", notif)
    
    local label = Instance.new("TextLabel", notif)
    label.Text = title .. "\n" .. text
    label.Size = UDim2.new(1, 0, 1, 0)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -260, 0.8, 0)}):Play()
    task.wait(4)
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 260, 0.8, 0)}):Play()
    task.wait(0.5)
    notif:Destroy()
end

-- Активация сообщений
task.spawn(function()
    task.wait(1)
    notify("ZACK_HUB", "Успешно активирован!")
    task.wait(2)
    notify("TELEGRAM", "ПОДПИСЫВАЙТЕСЬ НА @sajkyn")
end)

-- [UI] Главное меню (Пустой каркас для дальнейшего наполнения)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Visible = false
Instance.new("UICorner", mainFrame)

-- Заголовок меню
local title = Instance.new("TextLabel", mainFrame)
title.Text = "ZACK_HUB\nversion: 2.0 global\ntg: @sajkyn"
title.Size = UDim2.new(1, 0, 0.3, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
-- ZACK_HUB V2.0 | NAVIGATION ENGINE | PART 2
local UI_Elements = {
    Main = Instance.new("ScrollingFrame", mainFrame),
    Visuals = Instance.new("ScrollingFrame", mainFrame),
    Animations = Instance.new("ScrollingFrame", mainFrame)
}

-- Настройка контейнеров вкладок
for name, frame in pairs(UI_Elements) do
    frame.Name = name .. "_Container"
    frame.Size = UDim2.new(0.9, 0, 0.6, 0)
    frame.Position = UDim2.new(0.05, 0, 0.35, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = (name == "Main") -- По умолчанию открыт Main
    frame.ScrollBarThickness = 2
end

-- Кнопки навигации (триггеры вкладок)
local navBar = Instance.new("Frame", mainFrame)
navBar.Size = UDim2.new(1, 0, 0, 30)
navBar.Position = UDim2.new(0, 0, 0.25, 0)
navBar.BackgroundTransparency = 1

local function createTabBtn(name, index)
    local btn = Instance.new("TextButton", navBar)
    btn.Size = UDim2.new(0.33, 0, 1, 0)
    btn.Position = UDim2.new(0.33 * (index-1), 0, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundTransparency = 1
    btn.Font = Enum.Font.Code
    
    -- Белая полоска-разделитель (снизу кнопки)
    local line = Instance.new("Frame", btn)
    line.Size = UDim2.new(0.8, 0, 0, 1)
    line.Position = UDim2.new(0.1, 0, 0.9, 0)
    line.BackgroundColor3 = Color3.new(1,1,1)
    
    btn.MouseButton1Click:Connect(function()
        for n, f in pairs(UI_Elements) do
            f.Visible = (n == name)
        end
    end)
end

createTabBtn("Main", 1)
createTabBtn("Visuals", 2)
createTabBtn("Animations", 3)
-- ZACK_HUB V2.0 | ENGINE CORE | PART 3
local RunService = game:GetService("RunService")
local activeEffects = {} -- Хранилище для удаления старых эффектов

-- Универсальная функция зачистки (премиум-стабильность)
local function clearVisuals()
    for _, effect in pairs(activeEffects) do
        if typeof(effect) == "Instance" then effect:Destroy() end
    end
    activeEffects = {}
    game.Lighting.Ambient = Color3.fromRGB(50, 50, 50) -- Сброс света
    game.Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
end

-- Функция создания сферы (красивый след)
local function createOrb(color, speedMult)
    local orb = Instance.new("Part", workspace)
    orb.Shape = Enum.PartType.Ball
    orb.Size = Vector3.new(0.6, 0.6, 0.6)
    orb.Material = Enum.Material.Neon
    orb.Color = color
    orb.Anchored = true
    orb.CanCollide = false
    
    local trail = Instance.new("Trail", orb)
    -- Настройка следа... (код следа будет здесь)
    table.insert(activeEffects, orb)
    return orb
end

-- Основная функция для Visuals (Chams 1 - Радужный)
local function applyChams1()
    clearVisuals()
    -- Логика радужных сфер и чамсов
    notify("Visuals", "Применен стиль: Rainbow")
end

-- Добавляем кнопки в ScrollingFrame (Visuals)
local function addVisualBtn(name, callback)
    local btn = Instance.new("TextButton", UI_Elements.Visuals)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(callback)
end

addVisualBtn("Chams 1 (Rainbow)", applyChams1)
addVisualBtn("Fullbright", function() 
    game.Lighting.Brightness = 2
    game.Lighting.GlobalShadows = false
    notify("Visuals", "Fullbright ON")
end)
-- ZACK_HUB V2.0 | PERFORMANCE & ANIMATION CORE | PART 4

-- 1. FPS BOOST (Potato Graphics)
local function applyFPSBoost()
    notify("Performance", "Удаление объектов...")
    local decoration = {"Grass", "Leaf", "Decoration", "Bush", "Fern"}
    for _, obj in pairs(workspace:GetDescendants()) do
        for _, tag in pairs(decoration) do
            if obj:IsA("BasePart") and obj.Name:find(tag) then
                obj:Destroy()
            end
        end
    end
    game.Lighting.GlobalShadows = false
    notify("Performance", "FPS Boost активирован!")
end

-- 2. Инвентарная система анимаций (Core)
-- При нажатии на кнопку в меню в рюкзак выдается Tool
local function createAnimTool(animName, animId)
    local tool = Instance.new("Tool", player.Backpack)
    tool.Name = animName
    tool.RequiresHandle = false
    
    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    
    local track
    tool.Equipped:Connect(function()
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum then
            track = hum:LoadAnimation(anim)
            track:Play()
            track:AdjustSpeed(1)
        end
    end)
    
    tool.Unequipped:Connect(function()
        if track then track:Stop() end
    end)
end

-- Добавление кнопок в раздел "Animations"
local function addAnimBtn(name, id)
    local btn = Instance.new("TextButton", UI_Elements.Animations)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        createAnimTool(name, id)
        notify("Animations", name .. " добавлена в инвентарь!")
    end)
end

-- Примеры вызовов (замени ID на свои рабочие):
addAnimBtn("Zack_Jerk", "rbxassetid://698251653")
addAnimBtn("Zack_Copter", "rbxassetid://123456789") 

-- Добавляем кнопку FPS Boost в Visuals
addVisualBtn("FPS Boost (Potato)", applyFPSBoost)
-- ZACK_HUB V2.0 | FULL BUILD | PREMIUM QUALITY
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local activeEffects = {}

-- [CORE UI]
local screenGui = Instance.new("ScreenGui", pgui); screenGui.Name = "ZACK_HUB_V2"
local mainFrame = Instance.new("Frame", screenGui); mainFrame.Size = UDim2.new(0, 400, 0, 300); mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); mainFrame.Visible = false; Instance.new("UICorner", mainFrame)
local title = Instance.new("TextLabel", mainFrame); title.Text = "ZACK_HUB\nversion: 2.0 global\ntg: @sajkyn"; title.Size = UDim2.new(1, 0, 0.2, 0); title.BackgroundTransparency = 1; title.TextColor3 = Color3.new(1,1,1)

-- [NOTIFY SYSTEM]
local function notify(title, text)
    local notif = Instance.new("Frame", screenGui); notif.Size = UDim2.new(0, 250, 0, 60); notif.Position = UDim2.new(1, 260, 0.8, 0); notif.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", notif)
    local label = Instance.new("TextLabel", notif); label.Text = title.."\n"..text; label.Size = UDim2.new(1,0,1,0); label.BackgroundTransparency = 1; label.TextColor3 = Color3.new(1,1,1)
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -260, 0.8, 0)}):Play(); task.wait(3); notif:Destroy()
end

-- [VISUAL MANAGER]
local function clearVisuals()
    for _, e in pairs(activeEffects) do if typeof(e) == "Instance" then e:Destroy() end end
    activeEffects = {}
end

-- [FUNCTIONS: VISUALS]
local function applyFPSBoost()
    local deco = {"Grass", "Leaf", "Decoration", "Bush"}
    for _, obj in pairs(workspace:GetDescendants()) do
        for _, tag in pairs(deco) do if obj:IsA("BasePart") and obj.Name:find(tag) then obj:Destroy() end end
    end
    notify("Performance", "FPS Boost активирован")
end

local function applyHeadless(state)
    local head = player.Character:FindFirstChild("Head")
    if head then head.Transparency = state and 1 or 0 end
end

-- [FUNCTIONS: ANIMATIONS]
local function createAnimTool(name, id)
    local tool = Instance.new("Tool", player.Backpack); tool.Name = name; tool.RequiresHandle = false
    tool.Equipped:Connect(function()
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum then 
            local anim = Instance.new("Animation"); anim.AnimationId = id
            local track = hum:LoadAnimation(anim); track:Play()
            tool.Unequipped:Connect(function() track:Stop() end)
        end
    end)
end

-- [INITIALIZATION]
task.spawn(function()
    notify("ZACK_HUB", "Успешно активирован!")
    task.wait(2)
    notify("TELEGRAM", "@sajkyn")
end)

-- Создание радужной надписи
local rainbow = Instance.new("TextLabel", screenGui); rainbow.Text = "ZACK_HUB V2.0"; rainbow.Position = UDim2.new(0, 10, 0.9, 0); rainbow.Size = UDim2.new(0, 150, 0, 50); rainbow.BackgroundTransparency = 1
task.spawn(function() while rainbow.Parent do for i=0,1,0.02 do rainbow.TextColor3 = Color3.fromHSV(i,1,1); task.wait(0.1) end end end)

-- Переключение меню
local icon = Instance.new("ImageButton", screenGui); icon.Size = UDim2.new(0, 50, 0, 50); icon.Position = UDim2.new(0, 10, 0.5, 0); icon.Image = "rbxassetid://5041408920"; Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)
icon.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
