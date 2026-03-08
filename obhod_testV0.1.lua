-- ZACK_HUB Jerk Edition - ЧАСТЬ 1: UI & ANTI-DUPE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Очистка перед запуском
if pgui:FindFirstChild("ZACK_HUB_Jerk") then pgui.ZACK_HUB_Jerk:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZACK_HUB_Jerk"
screenGui.Parent = pgui
screenGui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 200, 0, 150)
main.Position = UDim2.new(0.5, -100, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
main.Parent = screenGui

-- Фон - Небо с облаками (ImageLabel)
local bg = Instance.new("ImageLabel")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Image = "rbxassetid://152632296" -- Красивое небо с облаками
bg.Parent = main

-- Заголовок ZACK_HUB "jerk" (Радужный перелив)
local title = Instance.new("TextLabel")
title.Text = "ZACK_HUB \"jerk\""
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = main

task.spawn(function()
    local hue = 0
    while main.Parent do
        title.TextColor3 = Color3.fromHSV(hue, 1, 1)
        hue = (hue + 0.01) % 1
        task.wait(0.05)
    end
end)

-- Кнопка Start (Серебряный эффект)
local startBtn = Instance.new("TextButton")
startBtn.Text = "Start"
startBtn.Size = UDim2.new(0.8, 0, 0, 40)
startBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(192, 192, 192) -- Серебро
startBtn.TextColor3 = Color3.fromRGB(50, 50, 50)
startBtn.Font = Enum.Font.SourceSansBold
startBtn.TextScaled = true
startBtn.Parent = main
-- ZACK_HUB Jerk Edition - ЧАСТЬ 2: МЕХАНИКА И ВИЗУАЛ
local started = false
local spheres = {}
local trails = {}

local function createOrbiters(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    for i = 1, 2 do
        local ball = Instance.new("Part")
        ball.Shape = Enum.PartType.Ball
        ball.Size = Vector3.new(0.8, 0.8, 0.8)
        ball.Color = Color3.fromRGB(255, 255, 255)
        ball.Material = Enum.Material.Neon
        ball.CanCollide = false
        ball.Parent = hrp
        
        -- Создаем след (Trail)
        local attachment0 = Instance.new("Attachment", ball)
        local attachment1 = Instance.new("Attachment", ball)
        attachment1.Position = Vector3.new(0, -1, 0)
        
        local trail = Instance.new("Trail", ball)
        trail.Attachment0 = attachment0
        trail.Attachment1 = attachment1
        trail.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        trail.Transparency = NumberSequence.new(0, 1)
        
        table.insert(spheres, ball)
        table.insert(trails, trail)
        
        task.spawn(function()
            while started and ball.Parent do
                local angle = (tick() * 2) + (i * math.pi)
                ball.CFrame = hrp.CFrame * CFrame.new(math.cos(angle) * 3, 0, math.sin(angle) * 3)
                RunService.RenderStepped:Wait()
            end
        end)
    end
end

startBtn.MouseButton1Click:Connect(function()
    if started then return end
    started = true
    
    -- Активация Chams и Эффектов
    local char = player.Character or player.CharacterAdded:Wait()
    createOrbiters(char)
    
    -- Здесь можно добавить логику "Jerk" (например, специфическую анимацию)
    -- и смену неба на аниме (с учетом защиты от ошибок через pcall)
    print("ZACK_HUB: Jerk mode activated!")
end)
-- ZACK_HUB Jerk Edition - ЧАСТЬ 3: АНИМЕ-НЕБО & LIFE-SUPPORT

local function setAnimeSky()
    local Lighting = game:GetService("Lighting")
    -- Удаляем старое небо, чтобы не было конфликтов
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    
    local animeSky = Instance.new("Sky", Lighting)
    animeSky.SkyboxBk = "rbxassetid://14451457100" -- Твой аниме-ID
    animeSky.SkyboxDn = "rbxassetid://14451457100"
    animeSky.SkyboxFt = "rbxassetid://14451457100"
    animeSky.SkyboxLf = "rbxassetid://14451457100"
    animeSky.SkyboxRt = "rbxassetid://14451457100"
    animeSky.SkyboxUp = "rbxassetid://14451457100"
end

-- Привязка к возрождению, чтобы всё работало после смерти
player.CharacterAdded:Connect(function(newChar)
    if started then
        -- Автоматически перезапускаем сферы, если игрок умер
        task.wait(1)
        createOrbiters(newChar)
    end
end)

-- Финальный апгрейд кнопки:
startBtn.MouseButton1Click:Connect(function()
    if started then return end
    started = true
    
    -- Активируем всё сразу
    pcall(setAnimeSky)
    local char = player.Character or player.CharacterAdded:Wait()
    createOrbiters(char)
    
    startBtn.Text = "ACTIVE"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый сигнал
end)
