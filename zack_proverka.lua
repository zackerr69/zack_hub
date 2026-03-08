-- ZACK_HUB V4.0 - ЧАСТЬ 1: UI ENGINE
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Полная очистка перед стартом
if pgui:FindFirstChild("ZACK_HUB_Main") then pgui.ZACK_HUB_Main:Destroy() end

local screenGui = Instance.new("ScreenGui", pgui)
screenGui.Name = "ZACK_HUB_Main"
screenGui.IgnoreGuiInset = true

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 220, 0, 180)
main.Position = UDim2.new(0.5, -110, 0.4, -90)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Active = true
main.Draggable = true -- Теперь окно можно двигать мышкой/пальцем

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "ZACK_HUB \"jerk\""
title.TextScaled = true
title.BackgroundTransparency = 1
-- Радужный цикл для заголовка
task.spawn(function()
    local h = 0
    while main.Parent do
        title.TextColor3 = Color3.fromHSV(h, 1, 1)
        h = (h + 0.005) % 1
        task.wait(0.05)
    end
end)

local startBtn = Instance.new("TextButton", main)
startBtn.Size = UDim2.new(0.8, 0, 0, 40)
startBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
startBtn.Text = "ACTIVATE"
startBtn.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
-- ZACK_HUB V4.0 - ЧАСТЬ 2: TOOL LOGIC
local active = false
local tool = nil

local function activateJerk()
    local backpack = player:FindFirstChildWhichIsA("Backpack")
    if not backpack then return end
    
    tool = Instance.new("Tool")
    tool.Name = "Zack Hub"
    tool.ToolTip = "💦"
    tool.RequiresHandle = false -- Убрали кирпич!
    tool.Parent = backpack
    
    local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        local track = nil
        tool.Equipped:Connect(function()
            local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
            local anim = Instance.new("Animation")
            anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
            track = humanoid:LoadAnimation(anim)
            track:Play()
            track:AdjustSpeed(isR15 and 0.7 or 0.65)
        end)
        
        tool.Unequipped:Connect(function()
            if track then track:Stop() end
        end)
    end
end

startBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        activateJerk()
        startBtn.Text = "DEACTIVATE"
    else
        if tool then tool:Destroy() end
        startBtn.Text = "ACTIVATE"
    end
end)
-- ZACK_HUB V4.0 - ЧАСТЬ 3: ORBITAL SYSTEM
local orbiters = {}

local function startOrbitalSystem(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    for i = 1, 2 do
        local ball = Instance.new("Part", hrp)
        ball.Shape = "Ball"
        ball.Size = Vector3.new(0.6, 0.6, 0.6)
        ball.Material = "Neon"
        ball.Color = Color3.fromRGB(255, 255, 255)
        ball.CanCollide = false
        ball.Anchored = true -- Фиксируем для плавности
        
        -- Добавляем след (Trail)
        local att0 = Instance.new("Attachment", ball)
        local att1 = Instance.new("Attachment", ball)
        att1.Position = Vector3.new(0, -1, 0)
        
        local trail = Instance.new("Trail", ball)
        trail.Attachment0 = att0
        trail.Attachment1 = att1
        trail.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
        
        table.insert(orbiters, ball)
        
        task.spawn(function()
            local speed = 2
            local radius = 3
            while ball.Parent do
                local t = tick() * speed + (i * math.pi)
                -- Сложная траектория: XYZ синусоиды дают эффект "восьмерки" и расширения
                local x = math.cos(t) * radius
                local y = math.sin(t * 0.7) * 2 -- Движение вверх-вниз
                local z = math.sin(t) * radius
                
                ball.CFrame = hrp.CFrame * CFrame.new(x, y, z)
                RunService.RenderStepped:Wait()
            end
        end)
    end
end

-- Обновляем кнопку активации:
startBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        activateJerk()
        startOrbitalSystem(player.Character) -- Запуск сфер
        startBtn.Text = "DEACTIVATE"
    else
        if tool then tool:Destroy() end
        for _, v in pairs(orbiters) do v:Destroy() end
        orbiters = {}
        startBtn.Text = "ACTIVATE"
    end
end)
-- ZACK_HUB V4.0 - ЧАСТЬ 4: ANIME ENVIRONMENT
local Lighting = game:GetService("Lighting")
local originalSettings = {Haze = Lighting.Atmosphere and Lighting.Atmosphere.Haze or 0, Density = Lighting.Atmosphere and Lighting.Atmosphere.Density or 0.3}

local function setAnimeEnvironment(enabled)
    if enabled then
        -- Создаем или настраиваем атмосферу для аниме-эффекта
        local atmos = Lighting:FindFirstChild("Atmosphere") or Instance.new("Atmosphere", Lighting)
        atmos.Haze = 5 -- Эффект мягкого свечения
        atmos.Density = 0.2
        atmos.Color = Color3.fromRGB(200, 230, 255) -- Легкий голубоватый оттенок
        atmos.Decay = Color3.fromRGB(150, 150, 200)
    else
        -- Возвращаем настройки назад
        if Lighting:FindFirstChild("Atmosphere") then
            Lighting.Atmosphere.Haze = originalSettings.Haze
            Lighting.Atmosphere.Density = originalSettings.Density
        end
    end
end

-- Обновляем кнопку активации с учетом неба:
startBtn.MouseButton1Click:Connect(function()
    active = not active
    if active then
        activateJerk()
        startOrbitalSystem(player.Character)
        setAnimeEnvironment(true) -- Включаем аниме-небо
        startBtn.Text = "DEACTIVATE"
    else
        if tool then tool:Destroy() end
        for _, v in pairs(orbiters) do v:Destroy() end
        orbiters = {}
        setAnimeEnvironment(false) -- Выключаем аниме-небо
        startBtn.Text = "ACTIVATE"
    end
end)
