--[[
    ZACKERR HUB - УНИВЕРСАЛЬНЫЙ ЗАГРУЗЧИК (автономный)
    Загружает: аксессуары, анимации, модели
    Без внешних библиотек, простое меню
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")
local playerGui = player:WaitForChild("PlayerGui")

-- Удаляем старую версию если есть
if playerGui:FindFirstChild("UniversalLoader") then
    playerGui.UniversalLoader:Destroy()
end

-- СОЗДАЁМ GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UniversalLoader"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 350, 0, 300)
frame.Position = UDim2.new(0.5, -175, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
frame.Active = true
frame.Draggable = true

-- Заголовок
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "ZACKERR УНИВЕРСАЛЬНЫЙ ЗАГРУЗЧИК"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Поле для ID
local idBox = Instance.new("TextBox")
idBox.Parent = frame
idBox.Size = UDim2.new(0.9, 0, 0, 40)
idBox.Position = UDim2.new(0.05, 0, 0, 45)
idBox.PlaceholderText = "ВВЕДИ ID АССЕТА (число)"
idBox.Text = ""
idBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
idBox.TextColor3 = Color3.fromRGB(255, 255, 255)
idBox.Font = Enum.Font.SourceSans
idBox.TextSize = 18

-- Статус
local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0, 265)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255, 255, 0)
status.Text = "Готов"
status.Font = Enum.Font.SourceSans
status.TextSize = 16

-- Функция обновления статуса
local function setStatus(text, color)
    status.Text = text
    status.TextColor3 = color or Color3.fromRGB(255, 255, 0)
end

-- КНОПКА 1: Аксессуар
local btn1 = Instance.new("TextButton")
btn1.Parent = frame
btn1.Size = UDim2.new(0.8, 0, 0, 40)
btn1.Position = UDim2.new(0.1, 0, 0, 95)
btn1.Text = "📦 ЗАГРУЗИТЬ КАК АКСЕССУАР"
btn1.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
btn1.Font = Enum.Font.Gotham
btn1.TextSize = 16

btn1.MouseButton1Click:Connect(function()
    local id = tonumber(idBox.Text)
    if not id then
        setStatus("❌ Введи ID", Color3.fromRGB(255, 0, 0))
        return
    end
    
    setStatus("⏳ Загрузка аксессуара...", Color3.fromRGB(255, 255, 0))
    
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. id)[1]
    end)
    
    if success and obj then
        obj.Parent = character
        obj.Name = "LoadedAccessory"
        
        if obj:IsA("Accessory") and obj.Handle then
            -- Удаляем старый такой же если есть
            for _, v in pairs(character:GetChildren()) do
                if v:IsA("Accessory") and v.Name == "LoadedAccessory" and v ~= obj then
                    v:Destroy()
                end
            end
            
            -- Прикрепляем к голове
            local weld = Instance.new("Weld")
            weld.Part0 = character.Head
            weld.Part1 = obj.Handle
            weld.C0 = CFrame.new(0, 0.5, 0)
            weld.Parent = obj.Handle
            
            setStatus("✅ Аксессуар загружен!", Color3.fromRGB(0, 255, 0))
        else
            setStatus("⚠️ Это не аксессуар", Color3.fromRGB(255, 165, 0))
        end
    else
        setStatus("❌ Ошибка загрузки (404 или неверный ID)", Color3.fromRGB(255, 0, 0))
    end
end)

-- КНОПКА 2: Анимация
local btn2 = Instance.new("TextButton")
btn2.Parent = frame
btn2.Size = UDim2.new(0.8, 0, 0, 40)
btn2.Position = UDim2.new(0.1, 0, 0, 140)
btn2.Text = "💃 ЗАГРУЗИТЬ КАК АНИМАЦИЮ"
btn2.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
btn2.Font = Enum.Font.Gotham
btn2.TextSize = 16

btn2.MouseButton1Click:Connect(function()
    local id = tonumber(idBox.Text)
    if not id then
        setStatus("❌ Введи ID", Color3.fromRGB(255, 0, 0))
        return
    end
    
    if not humanoid then
        setStatus("❌ Нет Humanoid", Color3.fromRGB(255, 0, 0))
        return
    end
    
    setStatus("⏳ Загрузка анимации...", Color3.fromRGB(255, 255, 0))
    
    local success, animTrack = pcall(function()
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. id
        return humanoid:LoadAnimation(anim)
    end)
    
    if success and animTrack then
        animTrack:Play()
        setStatus("✅ Анимация проигрывается", Color3.fromRGB(0, 255, 0))
        
        -- Останавливаем через 10 секунд (чтоб не бесконечно)
        task.delay(10, function()
            if animTrack and animTrack.IsPlaying then
                animTrack:Stop()
                setStatus("⏹️ Анимация остановлена", Color3.fromRGB(255, 255, 255))
            end
        end)
    else
        setStatus("❌ Ошибка загрузки анимации", Color3.fromRGB(255, 0, 0))
    end
end)

-- КНОПКА 3: Модель
local btn3 = Instance.new("TextButton")
btn3.Parent = frame
btn3.Size = UDim2.new(0.8, 0, 0, 40)
btn3.Position = UDim2.new(0.1, 0, 0, 185)
btn3.Text = "🏗️ ЗАГРУЗИТЬ КАК МОДЕЛЬ"
btn3.BackgroundColor3 = Color3.fromRGB(150, 75, 0)
btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
btn3.Font = Enum.Font.Gotham
btn3.TextSize = 16

btn3.MouseButton1Click:Connect(function()
    local id = tonumber(idBox.Text)
    if not id then
        setStatus("❌ Введи ID", Color3.fromRGB(255, 0, 0))
        return
    end
    
    setStatus("⏳ Загрузка модели...", Color3.fromRGB(255, 255, 0))
    
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. id)[1]
    end)
    
    if success and obj then
        obj.Parent = workspace
        obj.Name = "LoadedModel_" .. id
        
        -- Перемещаем перед игроком
        if character and character:FindFirstChild("HumanoidRootPart") then
            obj:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame * CFrame.new(0, 2, -5))
        end
        
        setStatus("✅ Модель загружена", Color3.fromRGB(0, 255, 0))
    else
        setStatus("❌ Ошибка загрузки модели", Color3.fromRGB(255, 0, 0))
    end
end)

-- Кнопка очистки
local clearBtn = Instance.new("TextButton")
clearBtn.Parent = frame
clearBtn.Size = UDim2.new(0.4, 0, 0, 35)
clearBtn.Position = UDim2.new(0.1, 0, 0, 230)
clearBtn.Text = "🧹 ОЧИСТИТЬ"
clearBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

clearBtn.MouseButton1Click:Connect(function()
    -- Удаляем загруженные аксессуары
    for _, v in pairs(character:GetChildren()) do
        if v.Name == "LoadedAccessory" then
            v:Destroy()
        end
    end
    
    -- Удаляем модели из workspace
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name and v.Name:find("LoadedModel_") then
            v:Destroy()
        end
    end
    
    setStatus("🧹 Очищено", Color3.fromRGB(255, 255, 255))
end)

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = frame
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

setStatus("✅ Загрузчик готов", Color3.fromRGB(0, 255, 0))
