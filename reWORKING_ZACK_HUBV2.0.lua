-- ZACK_HUB V2.0 | RE-BUILD | PART 1: CORE UI
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Очистка старого мусора
if pgui:FindFirstChild("ZACK_HUB_V2") then pgui.ZACK_HUB_V2:Destroy() end

local screenGui = Instance.new("ScreenGui", pgui)
screenGui.Name = "ZACK_HUB_V2"
screenGui.IgnoreGuiInset = true

-- Главный контейнер (Стекло)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BackgroundTransparency = 0.3 -- Эффект стекла
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Радужный заголовок (Работает через UIGradient)
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 80)
title.Text = "ZACK_HUB\nversion: 2.0 global\ntg: @sajkyn"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)

local grad = Instance.new("UIGradient", title)
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})

-- Анимация радуги
task.spawn(function()
    while true do
        TweenService:Create(grad, TweenInfo.new(5, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)}):Play()
        task.wait(5)
        grad.Offset = Vector2.new(-1, 0)
    end
end)
-- ZACK_HUB V2.0 | NAVIGATION & BUTTONS | PART 2
-- Создаем контейнер для вкладок
local navBar = Instance.new("Frame", mainFrame)
navBar.Size = UDim2.new(1, 0, 0, 40)
navBar.Position = UDim2.new(0, 0, 0.25, 0)
navBar.BackgroundTransparency = 1

-- Функция для создания премиум-кнопки
local function createButton(name, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Text = name
    btn.Font = Enum.Font.Code
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.new(0, 0, 0)
    btn.BackgroundTransparency = 0.8 -- Полная прозрачность ячейки
    
    -- Обводка (Хакерский стиль)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Вкладки (Main, Visuals, Animations)
local tabContainer = Instance.new("Frame", mainFrame)
tabContainer.Size = UDim2.new(1, 0, 0.65, 0)
tabContainer.Position = UDim2.new(0, 0, 0.35, 0)
tabContainer.BackgroundTransparency = 1

local tabs = {
    Main = Instance.new("ScrollingFrame", tabContainer),
    Visuals = Instance.new("ScrollingFrame", tabContainer),
    Animations = Instance.new("ScrollingFrame", tabContainer)
}

for name, frame in pairs(tabs) do
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = (name == "Main")
    frame.ScrollBarThickness = 2
    Instance.new("UIListLayout", frame).Padding = UDim.new(0, 5)
end
-- ZACK_HUB V2.0 | NAVIGATION & ANIMATION ENGINE | PART 3

-- Логика переключения вкладок
local function switchTab(tabName)
    for name, frame in pairs(tabs) do
        frame.Visible = (name == tabName)
    end
end

-- Создаем кнопки навигации вверху
local navButtons = {"Main", "Visuals", "Animations"}
for i, name in pairs(navButtons) do
    local btn = Instance.new("TextButton", navBar)
    btn.Size = UDim2.new(0.33, 0, 1, 0)
    btn.Position = UDim2.new(0.33 * (i-1), 0, 0, 0)
    btn.Text = name
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Code
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end

-- [ANIMATION CORE] Функция выдачи предмета-анимации
local function addAnimButton(name, animId)
    local btn = createButton(name, tabs.Animations, function()
        local tool = Instance.new("Tool", player.Backpack)
        tool.Name = name
        tool.RequiresHandle = false
        
        local anim = Instance.new("Animation")
        anim.AnimationId = animId
        
        local track
        tool.Equipped:Connect(function()
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                track = hum:LoadAnimation(anim)
                track:Play()
            end
        end)
        
        tool.Unequipped:Connect(function()
            if track then track:Stop() end
        end)
        
        notify("ZACK_HUB", name .. " готов к использованию!")
    end)
end

-- Пример добавления твоих анимаций
addAnimButton("zack_jerk", "rbxassetid://ВАШ_ID_СЮДА")
addAnimButton("zack_copter", "rbxassetid://ВАШ_ID_СЮДА")
-- ZACK_HUB V2.0 | VISUAL ENGINE | PART 4

-- 1. Движок перемещения меню (Draggable)
local dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragInput = input; dragStart = input.Position; startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and mainFrame.Visible then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 2. Глобальный менеджер эффектов
local activeVisuals = {} 
local function cleanupVisuals()
    for _, v in pairs(activeVisuals) do if typeof(v) == "Instance" then v:Destroy() end end
    activeVisuals = {}
end

-- 3. Функции Визуалов
local function addVisualButton(name, callback)
    createButton(name, tabs.Visuals, function()
        cleanupVisuals() -- Чистим всё старое перед включением нового
        callback()
        notify("ZACK_HUB", name .. " применен")
    end)
end

-- Реализация FPS Boost (Умное удаление декора)
addVisualButton("FPS Boost (Potato)", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "Grass" or obj.Name == "Leaf") then
            obj:Destroy()
        end
    end
    game.Lighting.GlobalShadows = false
end)

-- Пример: Сферы вокруг игрока
addVisualButton("Orb Effect", function()
    for i = 1, 3 do
        local orb = Instance.new("Part", workspace)
        orb.Shape = Enum.PartType.Ball; orb.Size = Vector3.new(1,1,1); orb.Anchored = true
        table.insert(activeVisuals, orb)
        -- Тут можно добавить Tween для вращения
    end
end)
-- ZACK_HUB V2.0 | BODY MANIPULATION MODULE
local Character = player.Character or player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- 1. Headless (Убирает голову)
local function setHeadless(state)
    local head = Character:FindFirstChild("Head")
    if head then head.Transparency = state and 1 or 0 end
    -- Если есть аксессуары на голове, тоже их скрываем
    for _, obj in pairs(Character:GetChildren()) do
        if obj:IsA("Accessory") and obj.Handle:FindFirstChild("HatAttachment") then
            obj.Handle.Transparency = state and 1 or 0
        end
    end
end

-- 2. No Body (Убирает конечности, оставляя торс)
local function setNoBody(state)
    local parts = {"Left Arm", "Right Arm", "Left Leg", "Right Leg", "Head"}
    for _, pName in pairs(parts) do
        local part = Character:FindFirstChild(pName)
        if part then part.Transparency = state and 1 or 0 end
    end
end

-- 3. No Animations (Останавливает все текущие треки анимаций)
local function stopAllAnimations()
    for _, track in pairs(Humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end
end
-- ZACK_HUB V2.0 | ANIMATION ENGINE | PART 5
-- Хранилище треков, чтобы мы могли их принудительно останавливать
local activeAnimTracks = {}

local function createAnimTool(toolName, animationId, loopAnim)
    -- Проверка на наличие предмета в инвентаре
    if player.Backpack:FindFirstChild(toolName) or player.Character:FindFirstChild(toolName) then
        return -- Уже есть
    end

    local tool = Instance.new("Tool", player.Backpack)
    tool.Name = toolName
    tool.RequiresHandle = false -- Анимации работают без детали (Handle)
    
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. animationId
    
    tool.Equipped:Connect(function()
        local hum = player.Character:FindFirstChild("Humanoid")
        if hum then
            local track = hum:LoadAnimation(anim)
            track.Looped = loopAnim
            track:Play()
            activeAnimTracks[toolName] = track -- Запоминаем для контроля
        end
    end)
    
    tool.Unequipped:Connect(function()
        if activeAnimTracks[toolName] then
            activeAnimTracks[toolName]:Stop()
            activeAnimTracks[toolName] = nil
        end
    end)
end

-- Пример инициализации (добавление кнопки в меню)
local function addAnimTabButton(name, id, isLoop)
    createButton(name, tabs.Animations, function()
        createAnimTool(name, id, isLoop)
        notify("Animations", "Предмет " .. name .. " выдан!")
    end)
end

-- ВЫЗОВЫ:
addAnimTabButton("zack_jerk", "ТВОЙ_ID_1", true)
addAnimTabButton("zack_copter", "ТВОЙ_ID_2", true)
addAnimTabButton("dance_medusa", "ТВОЙ_ID_3", true)
-- ZACK_HUB V2.0 | SPECIAL MOVEMENTS ENGINE | PART 5

-- 1. Движение: 360° (Плавный, но быстрый поворот персонажа)
local isRotating = false
local function toggle360()
    isRotating = not isRotating
    if isRotating then
        task.spawn(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            while isRotating and root do
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(20), 0) -- Скорость вращения
                RunService.RenderStepped:Wait()
            end
        end)
    end
end

-- 2. Движение: Dildak (Имитация приседа)
-- Используем Humanoid:ChangeState для принудительного состояния Sit
local function toggleDildak()
    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.Sit = not hum.Sit
    end
end

-- 3. Добавление кнопок в раздел Animations
addVisualButton("360° Rotation", toggle360)
addVisualButton("Dildak (Sit)", toggleDildak)
-- ZACK_HUB V2.0 | VISUALS ENGINE (ESP/CHAMS) | PART 6

-- Функция создания подсветки (Chams)
local function applyChams()
    cleanupVisuals() -- Очищаем предыдущие эффекты
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight", player.Character)
            highlight.FillColor = Color3.fromRGB(255, 0, 255) -- Твой фирменный цвет
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            
            table.insert(activeVisuals, highlight) -- Добавляем в менеджер очистки
        end
    end
    notify("Visuals", "ESP (Chams) активирован")
end

-- Добавляем кнопку в Visuals
addVisualButton("ESP Chams (Highlight)", applyChams)

-- 4. Визуальные пресеты освещения (Lighting)
local function setLightingPreset(name, brightness, ambient)
    cleanupVisuals()
    game.Lighting.Brightness = brightness
    game.Lighting.Ambient = ambient
    notify("Visuals", "Пресет " .. name .. " применен")
end

addVisualButton("Preset: Night Vision", 0.5, Color3.fromRGB(0, 100, 200))
addVisualButton("Preset: Bright Day", 3, Color3.fromRGB(200, 200, 200))
-- ZACK_HUB V2.0 | HITBOX ENGINE | PART 7
local HitboxSize = Vector3.new(6, 6, 6) -- Размер хитбокса
local activeHitboxes = {}

local function toggleHitboxes(state)
    if not state then
        for _, obj in pairs(activeHitboxes) do if obj then obj.Size = Vector3.new(2, 2, 1) end end
        activeHitboxes = {}
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.Size = HitboxSize
                root.Transparency = 0.8
                root.BrickColor = BrickColor.new("Bright red")
                table.insert(activeHitboxes, root)
            end
        end
    end
end

-- Добавляем в Main
addVisualButton("Hitbox (Expand)", function() toggleHitboxes(true) end)
addVisualButton("Reset Hitbox", function() toggleHitboxes(false) end)
-- ZACK_HUB V2.0 | LOCAL PLAYER MANAGER | PART 8

-- 1. Fly (Базовая механика)
local flying = false
local function toggleFly()
    flying = not flying
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0, 0)
    
    if not flying then bv:Destroy() end
end

-- 2. SpeedHack
local function setSpeed(val)
    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = val end
end
-- ZACK_HUB V2.0 | FULL SOURCE CODE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local activeVisuals = {}

-- [CORE UI ENGINE]
local screenGui = Instance.new("ScreenGui", pgui); screenGui.Name = "ZACK_HUB_V2"
local mainFrame = Instance.new("Frame", screenGui); mainFrame.Size = UDim2.new(0, 400, 0, 400); mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200); mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); mainFrame.BackgroundTransparency = 0.3; Instance.new("UICorner", mainFrame)

-- [MOVE ENGINE]
mainFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then local dragStart = i.Position; local startPos = mainFrame.Position; UserInputService.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + (i.Position.X - dragStart.X), startPos.Y.Scale, startPos.Y.Offset + (i.Position.Y - dragStart.Y)) end end) end end)

-- [VISUAL MANAGER]
local function cleanupVisuals() for _, v in pairs(activeVisuals) do if typeof(v) == "Instance" then v:Destroy() end end; activeVisuals = {} end

-- [FUNCTIONS: MAIN]
local function setSpeed(val) if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = val end end

local flyEnabled = false
local function toggleFly()
    flyEnabled = not flyEnabled
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if flyEnabled then
        local bv = Instance.new("BodyVelocity", hrp); bv.Name = "ZACK_FLY"; bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bv.Velocity = Vector3.new(0,0,0)
        table.insert(activeVisuals, bv)
    else cleanupVisuals() end
end

-- [FUNCTIONS: VISUALS]
local function applyChams()
    cleanupVisuals()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local h = Instance.new("Highlight", p.Character); h.FillColor = Color3.fromRGB(255, 0, 255); table.insert(activeVisuals, h)
        end
    end
end

-- [BUTTON GENERATOR]
local function addButton(name, parent, callback)
    local btn = Instance.new("TextButton", parent); btn.Size = UDim2.new(0.9, 0, 0, 40); btn.Text = name; btn.BackgroundColor3 = Color3.new(0,0,0); btn.BackgroundTransparency = 0.5; btn.TextColor3 = Color3.new(1,1,1); Instance.new("UIStroke", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- [TAB STRUCTURE]
local tabs = {Main = Instance.new("ScrollingFrame", mainFrame), Visuals = Instance.new("ScrollingFrame", mainFrame)}
for n, f in pairs(tabs) do f.Size = UDim2.new(1,0,0.8,0); f.Position = UDim2.new(0,0,0.2,0); f.BackgroundTransparency = 1; f.Visible = (n == "Main") end

-- ИНИЦИАЛИЗАЦИЯ КНОПОК
addButton("Speed Hack (50)", tabs.Main, function() setSpeed(50) end)
addButton("Fly Toggle", tabs.Main, function() toggleFly() end)
addButton("ESP Chams", tabs.Visuals, applyChams)
addButton("Clear All Visuals", tabs.Visuals, cleanupVisuals)

-- [TITLE]
local title = Instance.new("TextLabel", mainFrame); title.Size = UDim2.new(1,0,0.2,0); title.Text = "ZACK_HUB V2.0"; title.TextColor3 = Color3.new(1,1,1); title.BackgroundTransparency = 1
