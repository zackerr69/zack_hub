--[[
    ZACKERR HUB - ЧЕСТНЫЙ ДЕТЕКТОР ID
    Покажет, что на самом деле лежит по ID
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("IDDetector") then
    playerGui.IDDetector:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "IDDetector"
gui.Parent = playerGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 400, 0, 350)
frame.Position = UDim2.new(0.5, -200, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🔍 ЧЕСТНЫЙ ДЕТЕКТОР ID"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50, 0, 0)

local idBox = Instance.new("TextBox", frame)
idBox.Size = UDim2.new(0.9, 0, 0, 35)
idBox.Position = UDim2.new(0.05, 0, 0, 40)
idBox.PlaceholderText = "ВВЕДИ ID"
idBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
idBox.TextColor3 = Color3.fromRGB(255, 255, 255)

local result = Instance.new("TextLabel", frame)
result.Size = UDim2.new(0.9, 0, 0, 150)
result.Position = UDim2.new(0.05, 0, 0, 85)
result.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
result.TextColor3 = Color3.fromRGB(200, 200, 200)
result.TextWrapped = true
result.TextXAlignment = Enum.TextXAlignment.Left
result.TextYAlignment = Enum.TextYAlignment.Top
result.Text = "Ожидание ID..."

local checkBtn = Instance.new("TextButton", frame)
checkBtn.Size = UDim2.new(0.4, 0, 0, 35)
checkBtn.Position = UDim2.new(0.3, 0, 0, 245)
checkBtn.Text = "🔍 ПРОВЕРИТЬ"
checkBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local function addLine(text, color)
    result.Text = result.Text .. "\n" .. text
end

checkBtn.MouseButton1Click:Connect(function()
    local id = tonumber(idBox.Text)
    if not id then
        result.Text = "❌ Введи число!"
        return
    end
    
    result.Text = "⏳ Загружаем ID: " .. id .. "..."
    
    local start = os.clock()
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. id)[1]
    end)
    local loadTime = math.floor((os.clock() - start) * 1000)
    
    if not success or not obj then
        result.Text = result.Text .. "\n❌ Ошибка загрузки (HTTP 404 или недоступен)"
        return
    end
    
    result.Text = "✅ ЗАГРУЖЕНО за " .. loadTime .. "ms\n"
    result.Text = result.Text .. "━━━━━━━━━━━━━━━━━━\n"
    result.Text = result.Text .. "📦 Тип: " .. obj.ClassName .. "\n"
    result.Text = result.Text .. "📛 Имя: " .. obj.Name .. "\n"
    
    if obj:IsA("Accessory") then
        result.Text = result.Text .. "🎭 Это АКСЕССУАР\n"
        if obj.Handle then
            result.Text = result.Text .. "✅ Есть Handle\n"
            result.Text = result.Text .. "📐 Размер Handle: " .. tostring(obj.Handle.Size) .. "\n"
            
            -- Пробуем надеть
            obj.Parent = character
            local weld = Instance.new("Weld")
            weld.Part0 = character.Head
            weld.Part1 = obj.Handle
            weld.C0 = CFrame.new(0, 0.5, 0)
            weld.Parent = obj.Handle
            result.Text = result.Text .. "🟢 Аксессуар НАДЕТ (смотри на голову)\n"
        else
            result.Text = result.Text .. "❌ Нет Handle — не надеть\n"
        end
        
    elseif obj:IsA("Animation") then
        result.Text = result.Text .. "💃 Это АНИМАЦИЯ\n"
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local track = humanoid:LoadAnimation(obj)
            track:Play()
            result.Text = result.Text .. "🟢 Анимация ЗАПУЩЕНА\n"
        else
            result.Text = result.Text .. "❌ Нет Humanoid\n"
        end
        
    elseif obj:IsA("Part") or obj:IsA("MeshPart") then
        result.Text = result.Text .. "🧱 Это 3D ОБЪЕКТ\n"
        obj.Parent = workspace
        obj.Position = character.Head.Position + Vector3.new(0, 3, 0)
        result.Text = result.Text .. "🟢 Объект ПОЯВИЛСЯ рядом\n"
        
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        result.Text = result.Text .. "🖼️ Это ТЕКСТУРА/DECAL\n"
        -- Создаём часть с этой текстурой
        local p = Instance.new("Part", workspace)
        p.Size = Vector3.new(2, 2, 0.2)
        p.Position = character.Head.Position + Vector3.new(2, 1, 0)
        obj.Parent = p
        result.Text = result.Text .. "🟢 Текстура на части СПРАВА\n"
        
    elseif obj:IsA("Model") then
        result.Text = result.Text .. "🏗️ Это МОДЕЛЬ\n"
        obj.Parent = workspace
        obj:SetPrimaryPartCFrame(character.Head.CFrame * CFrame.new(0, 2, -3))
        result.Text = result.Text .. "🟢 Модель ЗАГРУЖЕНА\n"
        
    elseif obj:IsA("Sound") then
        result.Text = result.Text .. "🔊 Это ЗВУК\n"
        obj.Parent = character.Head
        obj:Play()
        result.Text = result.Text .. "🟢 Звук ИГРАЕТ\n"
        
    else
        result.Text = result.Text .. "❓ НЕИЗВЕСТНЫЙ ТИП\n"
    end
    
    result.Text = result.Text .. "━━━━━━━━━━━━━━━━━━\n✅ Анализ завершён"
end)
