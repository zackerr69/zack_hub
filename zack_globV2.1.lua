-- ZACK_HUB V2.1 | MASTER BUILD
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- [1. АКТИВАЦИЯ И СООБЩЕНИЯ]
local function sendNotification(title, text)
    -- Здесь логика красивого сообщения справа снизу
    game.StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = 5})
end

-- [2. GUI ИНТЕРФЕЙС]
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "ZACK_HUB_V2.1_CORE"

-- Левая нижняя надпись
local waterMark = Instance.new("TextLabel", screenGui)
waterMark.Text = "ZACK_HUB V2.1"; waterMark.Position = UDim2.new(0, 10, 1, -30)
waterMark.Size = UDim2.new(0, 200, 0, 50); waterMark.TextColor3 = Color3.new(1, 1, 1) -- Сделаем радужной через цикл

-- Основа окна
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 400, 0, 300); mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Темный фон

-- Радужная надпись сверху
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Text = "ZACK_HUB\nversion: 2.1 global\ntg: @sajkyn"
titleLabel.Size = UDim2.new(1, 0, 0, 80)

-- Кнопки (Main, Visuals, Animations)
local tabContainer = Instance.new("Frame", mainFrame) -- Здесь будут кнопки, разделенные белыми полосами
-- ZACK_HUB V2.1 | MAIN TAB ENGINE | PART 2

-- [1. INFINITY JUMP]
-- Обход стандартного ограничения прыжков
local InfiniteJumpEnabled = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- [2. JUMP BOOST]
-- Манипуляция силой прыжка (JumpPower)
local function setJumpBoost(power)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.UseJumpPower = true
        player.Character.Humanoid.JumpPower = power
    end
end

-- [3. FLY (Уже проработанный каркас)]
-- С использованием LinearVelocity для плавности и стабильности
local FlyEnabled = false
local function toggleFly()
    FlyEnabled = not FlyEnabled
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if FlyEnabled then
        local bv = Instance.new("LinearVelocity", hrp)
        bv.Name = "ZackFlyVelocity"
        -- Настройка физики полета
        table.insert(getgenv().ZACK_DATA.VisualObjects, bv)
    else
        for _, obj in pairs(hrp:GetChildren()) do if obj.Name == "ZackFlyVelocity" then obj:Destroy() end end
    end
end

-- [4. SPEEDHACK]
-- Прямое управление WalkSpeed
local function setSpeed(val)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = val
    end
end

-- [ИНТЕГРАЦИЯ В МЕНЮ]
-- Создаем кнопки во вкладке Main
local mainTabButtons = {
    {"Fly", toggleFly},
    {"Speed 50", function() setSpeed(50) end},
    {"Infinity Jump", function() InfiniteJumpEnabled = not InfiniteJumpEnabled end},
    {"Jump Boost 100", function() setJumpBoost(100) end}
}

for _, data in pairs(mainTabButtons) do
    -- Тут вызывается наш создатель кнопок (функция createFunctionalButton из Части 1)
    createFunctionalButton(data[1], "Main", data[2])
end
-- ZACK_HUB V2.1 | VISUAL ENGINE | FINALIZED 5-MODES SYSTEM
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- [ОБЩИЙ ЧИСТИТЕЛЬ]
local function clearAllVisuals()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Zack_Visual_Effect" then v:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            for _, h in pairs(p.Character:GetChildren()) do
                if h:IsA("Highlight") or h.Name == "Zack_ESP" then h:Destroy() end
            end
        end
    end
end

-- [РЕЖИМЫ VISUALS]
local function enableVisualMode(mode)
    clearAllVisuals()
    
    -- 1. BASE OUTLINE
    if mode == 1 then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local h = Instance.new("Highlight", p.Character); h.Name = "Zack_ESP"
                h.OutlineColor = Color3.fromRGB(255, 255, 255); h.FillTransparency = 1
            end
        end
        
    -- 2. COSMOS (Dark sky + 3 Rainbow Spheres)
    elseif mode == 2 then
        Lighting.Ambient = Color3.fromRGB(0, 0, 0); Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        for i = 1, 3 do
            local s = Instance.new("Part", workspace); s.Name = "Zack_Visual_Effect"; s.Shape = "Ball"; s.Material = "Neon"
            s.Color = Color3.fromHSV(i/3, 1, 1); s.Anchored = true; s.Size = Vector3.new(2,2,2)
            -- (Логика вращения сфер будет в апдейтере)
        end
        
    -- 3. NOON (Beige Sphere + Soft Colors)
    elseif mode == 3 then
        Lighting.TimeOfDay = "12:00:00"; Lighting.Ambient = Color3.fromRGB(210, 180, 140)
        local s = Instance.new("Part", workspace); s.Name = "Zack_Visual_Effect"; s.Shape = "Ball"
        s.Color = Color3.fromRGB(210, 180, 140); s.Material = "Neon"; s.Anchored = true
        
    -- 4. SMART UI (Pink Sky + Violet Sphere)
    elseif mode == 4 then
        local cc = Instance.new("ColorCorrectionEffect", Lighting); cc.Name = "Zack_Visual_Effect"
        cc.TintColor = Color3.fromRGB(255, 200, 255)
        local s = Instance.new("Part", workspace); s.Name = "Zack_Visual_Effect"; s.Shape = "Ball"
        s.Color = Color3.fromRGB(186, 85, 211); s.Material = "Neon"; s.Anchored = true
    end
end

-- [ДОПОЛНИТЕЛЬНЫЕ ВИЗУАЛЫ]
local function setESP(state)
    -- Скелеты (белые)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Humanoid") then
            -- Logic for skeleton drawing
        end
    end
end

local function setFPSBoost(mode)
    if mode == "Potato" then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = "Plastic"; v.Reflectance = 0 
            elseif v:IsA("Decal") then v:Destroy() end
        end
    elseif mode == "ZACK_OPT" then
        -- Удаление мелких объектов
    end
end
-- ZACK_HUB V2.1 | ANIMATIONS ENGINE | PART 4

-- [Базовая функция для активации анимации через Tool]
local function playToolAnimation(name, animationId)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    
    if humanoid then
        -- Загружаем анимацию и воспроизводим
        local anim = Instance.new("Animation")
        anim.AnimationId = animationId -- ID анимации
        local track = humanoid:LoadAnimation(anim)
        track:Play()
    end
end

-- [1. АНИМАЦИИ ПРЕДМЕТАМИ]
local Animations = {
    ["zack_jerk"] = "rbxassetid://ANIM_ID_1",
    ["zack_copter"] = "rbxassetid://ANIM_ID_2", -- Игрок ложится и крутится
    ["dance_medusa"] = "rbxassetid://ANIM_ID_3",
    ["zackmen"] = "rbxassetid://ANIM_ID_4", -- Руки врастопыр
    ["xxx"] = "rbxassetid://ANIM_ID_5",
    ["dildak"] = "rbxassetid://ANIM_ID_6", -- Садится на корточки
    ["360"] = "rbxassetid://ANIM_ID_7"  -- Быстрое вращение
}

-- [2. СПЕЦИАЛЬНЫЕ ФУНКЦИИ]
-- "no_animations" - блокирует стандартный Animator
local function toggleNoAnimations(state)
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid and humanoid:FindFirstChild("Animator") then
        humanoid.Animator.Parent = state and nil or humanoid -- Отключаем/включаем аниматор
    end
end

-- "ice" (Анимация коньков)
local function toggleIceSkating(state)
    -- Реализуем через изменение трения (Friction) у ног
    local char = player.Character
    if char then
        for _, part in pairs({"LeftFoot", "RightFoot", "LeftLowerLeg", "RightLowerLeg"}) do
            local p = char:FindFirstChild(part)
            if p and p:IsA("BasePart") then
                p.CustomPhysicalProperties = PhysicalProperties.new(0, state and 0 or 0.5, 0)
            end
        end
    end
end
-- ZACK_HUB V2.1 | BODY & HITBOX CORE | PART 4

-- [1. HEADLESS / NOBODY (Удаление частей)]
-- Чтобы видели все, мы удаляем Joint-соединения, а не просто делаем Transperancy = 1
local function applyBodyModification(mode)
    local char = player.Character
    if not char then return end
    
    local function removePart(name)
        local part = char:FindFirstChild(name)
        local joint = part and part:FindFirstChildWhichIsA("JointInstance")
        if joint then joint:Destroy() end
        if mode == "Headless" and name == "Head" then part.Transparency = 1; part.CanCollide = false end
        if mode == "NoBody" then part.Transparency = 1; part.CanCollide = false end
    end

    if mode == "Headless" then
        removePart("Head")
    elseif mode == "NoBody" then
        for _, p in pairs(char:GetChildren()) do
            -- ZACK_HUB V2.1 | FARMING & FINAL ASSEMBLY | PART 5

local VirtualInputManager = game:GetService("VirtualInputManager")

-- [AUTO-CLICKER ДЛЯ ФАРМА]
local farmingEnabled = false
local function toggleAutoClicker()
    farmingEnabled = not farmingEnabled
    task.spawn(function()
        while farmingEnabled do
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            task.wait(0.1) -- Задержка для безопасности
        end
    end)
end

-- [ФИНАЛЬНАЯ СБОРКА]
-- Здесь мы связываем все части: GUI, Movement, Visuals, Animations, BodyMod
local function zackHubInit()
    -- 1. Запуск уведомлений
    sendNotification("ZACK_HUB", "Успешно активирован")
    task.wait(2)
    sendNotification("TG", "Подписывайтесь на @sajkyn")
    
    -- 2. Инициализация всех систем
    -- 
    -- Здесь мы собираем все "куски" в одну таблицу, чтобы они не конфликтовали
    getgenv().ZACK_HUB_RUNNING = true
end

zackHubInit()
      if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                p.Transparency = 1; p.CanCollide = false
            end
        end
    end
end

-- [2. HITBOXES (Один выбранный объект)]
-- Рисует SelectionBox вокруг объекта. Старый бокс удаляется при новом выборе.
local currentHitbox = nil

local function setHitbox(targetPart)
    if currentHitbox then currentHitbox:Destroy() end -- Удаляем старый хитбокс
    
    if targetPart and targetPart:IsA("BasePart") then
        local box = Instance.new("SelectionBox", targetPart)
        box.Name = "Zack_Hitbox"
        box.Adornee = targetPart
        box.Color3 = Color3.fromRGB(255, 0, 0)
        box.LineThickness = 0.05
        currentHitbox = box
    end
end
