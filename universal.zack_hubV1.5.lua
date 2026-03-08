-- ZACK_HUB V2.0 - ЧАСТЬ 1: ИНТЕРФЕЙС
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Удаление старой версии
if pgui:FindFirstChild("ZackHub_V2") then pgui.ZackHub_V2:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZackHub_V2"
screenGui.Parent = pgui
screenGui.ResetOnSpawn = false

-- Главное окно
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 350)
main.Position = UDim2.new(0.5, -125, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true 
main.ClipsDescendants = true
main.Parent = screenGui

-- Аниме-фон (ImageLabel)
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.Image = "rbxassetid://14451457100" -- ID аниме-тян (можно сменить)
bgImage.ImageTransparency = 0.6 -- Чтобы текст был виден
bgImage.ScaleType = Enum.ScaleType.Fill
bgImage.Parent = main

-- Радужный заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "ZACK_HUB"
title.TextScaled = true
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.Parent = main

task.spawn(function()
    local hue = 0
    while true do
        title.TextColor3 = Color3.fromHSV(hue, 1, 1)
        hue = hue + 0.01
        if hue >= 1 then hue = 0 end
        task.wait(0.05)
    end
end)

-- Контейнер для функций (Скролл)
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 2, 0) -- Высота для всех кнопок
scroll.ScrollBarThickness = 4
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
-- ZACK_HUB V2.0 - ЧАСТЬ 2: СКОРОСТЬ, ПРЫЖОК И ПОЛЕТ
local UIS = game:GetService("UserInputService")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Вспомогательная функция для создания кнопок и полей
local function createInput(placeholder, callback)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 35)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextScaled = true
    box.Parent = scroll
    
    box.FocusLost:Connect(function()
        callback(box.Text, box)
    end)
end

local function createToggle(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Parent = scroll
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
        callback(state)
    end)
end

-- 1. ФУНКЦИЯ SPEED
createInput("Speed (max 60)", function(val, box)
    local num = tonumber(val)
    if num then
        if num > 60 or num < -10 then
            box.Text = "Не поддерживается"
            task.wait(1)
            box.Text = ""
        else
            humanoid.WalkSpeed = num
        end
    end
end)

-- 2. ФУНКЦИЯ JUMP_V1.0
createInput("Jump Power (1-20)", function(val, box)
    local num = tonumber(val)
    if num then
        if num > 20 or num < 1 then
            box.Text = "Не поддерживается"
            task.wait(1)
            box.Text = ""
        else
            humanoid.JumpPower = num * 10 -- Умножаем для ощутимости в Roblox
            humanoid.UseJumpPower = true
        end
    end
end)

-- 3. ФУНКЦИЯ FlyV1.5
local flySpeed = 40
createInput("Fly Speed", function(val)
    flySpeed = tonumber(val) or 40
end)

local flying = false
local bv, bg
createToggle("FlyV1.5", function(state)
    flying = state
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if flying then
        humanoid.PlatformStand = true
        bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bv = Instance.new("BodyVelocity", root)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            while flying do
                RunService.RenderStepped:Wait()
                bv.velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                bg.cframe = workspace.CurrentCamera.CFrame
            end
        end)
    else
        humanoid.PlatformStand = false
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)
-- ZACK_HUB V2.0 - ЧАСТЬ 3: FINAL TOUCHES (Noclip, Jump, Chams & Visuals)

-- 1. NOCLIP (прохождение сквозь стены)
local noclip = false
createToggle("Noclip", function(state)
    noclip = state
    while noclip do
        RunService.Stepped:Wait()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then part.CanCollide = true end
    end
end)

-- 2. INFINITE JUMP
local infJump = false
createToggle("Inf Jump", function(state)
    infJump = state
end)

UIS.JumpRequest:Connect(function()
    if infJump then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- 3. CHAMS_byZACK (Сферы, Черное небо, Эффект коньков)
local chamsActive = false
createToggle("Chams_byZACK", function(state)
    chamsActive = state
    local sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky")
    
    if state then
        -- Черное небо
        if sky then sky.Enabled = false end
        game:GetService("Lighting").Ambient = Color3.fromRGB(0, 0, 0)
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        
        -- Сферы вокруг головы
        for i = 1, 3 do
            local ball = Instance.new("Part", character.Head)
            ball.Shape = Enum.PartType.Ball
            ball.Size = Vector3.new(0.5, 0.5, 0.5)
            ball.Material = Enum.Material.Neon
            ball.Name = "ZackSphere"
            task.spawn(function()
                while chamsActive do
                    ball.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    ball.CFrame = character.Head.CFrame * CFrame.Angles(0, tick() * 2 + (i * 2), 0) * CFrame.new(2, 0, 0)
                    RunService.RenderStepped:Wait()
                end
            end)
        end
        
        -- Анимация "на коньках" (делаем плавным трение)
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0) end
        end
    else
        -- Возврат к нормальному состоянию
        if sky then sky.Enabled = true end
        game:GetService("Lighting").Ambient = Color3.fromRGB(128, 128, 128)
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        for _, obj in pairs(character.Head:GetChildren()) do
            if obj.Name == "ZackSphere" then obj:Destroy() end
        end
    end
end)
