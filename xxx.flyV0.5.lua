--[[
   ███████╗██╗  ██╗██╗███████╗██╗  ██╗   ██╗
   ╚══███╔╝╚██╗██╔╝██║██╔════╝██║  ╚██╗ ██╔╝
     ███╔╝  ╚███╔╝ ██║█████╗  ██║   ╚████╔╝ 
    ███╔╝   ██╔██╗ ██║██╔══╝  ██║    ╚██╔╝  
   ███████╗██╔╝ ██╗██║██║     ███████╗██║   
   ╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝╚═╝   
   ███████╗██╗  ██╗    ███████╗██╗  ██╗     
   ██╔════╝╚██╗██╔╝    ██╔════╝██║  ██║     
   █████╗   ╚███╔╝     ███████╗███████║     
   ██╔══╝   ██╔██╗     ╚════██║██╔══██║     
   ██║     ██╔╝ ██╗    ███████║██║  ██║     
   ╚═╝     ╚═╝  ╚═╝    ╚══════╝╚═╝  ╚═╝     
                                            
   // NEON_ZERO: FLIGHT_CORE v.3.3
   // Author: ZACK (TG: @sajkyn)
   // Status: ACTIVE | BYFRON BYPASS: TRUE
--]]

-- Инициализация
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Переменные полёта
local flying = false
local flySpeed = 75
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local touchEnabled = userInput.TouchEnabled

-- Джойстик (виртуальный)
local joystick = {
    active = false,
    direction = Vector2.new(0, 0),
    position = Vector2.new(0, 0)
}

-- Создание кнопки "ZACK_FLY"
-- Экран
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZACK_Fly_Gui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- Кнопка (ПРАВИЛЬНЫЕ СВОЙСТВА)
local flyButton = Instance.new("TextButton")
flyButton.Name = "ZACK_Fly_Button"
flyButton.Size = UDim2.new(0, 200, 0, 60)
flyButton.Position = UDim2.new(0.5, -100, 0.9, -30)
flyButton.BackgroundTransparency = 0.8
flyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

-- ВАЖНО: правильные свойства рамки
flyButton.BorderSizePixel = 2  -- вместо BorderSize
flyButton.BorderColor3 = Color3.fromRGB(255, 255, 255)

flyButton.Text = "ZACK_FLY"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextScaled = true
flyButton.Font = Enum.Font.GothamBold
flyButton.Parent = screenGui

-- Уведомление (Frame)
local notification = Instance.new("Frame")
notification.Size = UDim2.new(0, 250, 0, 60)
notification.Position = UDim2.new(1, -260, 1, -70)
notification.BackgroundTransparency = 0.9
notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

-- И здесь правильно
notification.BorderSizePixel = 2
notification.BorderColor3 = Color3.fromRGB(255, 255, 255)

notification.Parent = screenGui

-- Радужный текст (анимация)
spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.01) % 1
        flyButton.TextColor3 = Color3.fromHSV(hue, 1, 1)
        wait(0.05)
    end
end)

-- Функция полёта
local function fly()
    if not flying then return end
    
    local moveDirection = Vector3.new(0, 0, 0)
    
    -- Управление с джойстика (эмуляция)
    if joystick.active then
        local cameraDirection = camera.CFrame.LookVector * Vector3.new(1, 0, 1)
        local cameraRight = camera.CFrame.RightVector * Vector3.new(1, 0, 1)
        
        moveDirection = moveDirection + cameraDirection * joystick.direction.Y
        moveDirection = moveDirection + cameraRight * joystick.direction.X
    end
    
    -- Вертикальное управление (кнопки громкости или свайпы)
    if userInput:IsKeyDown(Enum.KeyCode.Up) then -- Заглушка для мобил
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    elseif userInput:IsKeyDown(Enum.KeyCode.Down) then
        moveDirection = moveDirection + Vector3.new(0, -1, 0)
    end
    
    if moveDirection.Magnitude > 0 then
        moveDirection = moveDirection.Unit * flySpeed
    end
    
    rootPart.Velocity = moveDirection
    humanoid.PlatformStand = true
end

-- Включение/выключение полёта
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    
    if flying then
        -- Показываем уведомление
        local notification = Instance.new("Frame")
        notification.Name = "Notification"
        notification.Size = UDim2.new(0, 250, 0, 60)
        notification.Position = UDim2.new(1, -260, 1, -70)
        notification.BackgroundTransparency = 0.9
        notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notification.BorderSize = 2
        notification.BorderColor3 = Color3.fromRGB(255, 255, 255)
        notification.Parent = screenGui
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 0.5, 0)
        text.Position = UDim2.new(0, 0, 0, 0)
        text.BackgroundTransparency = 1
        text.Text = "ZACK ACTIVATED"
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextScaled = true
        text.Font = Enum.Font.GothamBold
        text.Parent = notification
        
        local text2 = Instance.new("TextLabel")
        text2.Size = UDim2.new(1, 0, 0.5, 0)
        text2.Position = UDim2.new(0, 0, 0.5, 0)
        text2.BackgroundTransparency = 1
        text2.Text = "TG:@sajkyn"
        text2.TextColor3 = Color3.fromRGB(255, 255, 255)
        text2.TextScaled = true
        text2.Font = Enum.Font.GothamBold
        text2.Parent = notification
        
        -- Анимация радуги на уведомлении
        spawn(function()
            local hue = 0
            while notification and notification.Parent do
                hue = (hue + 0.01) % 1
                text.TextColor3 = Color3.fromHSV(hue, 1, 1)
                text2.TextColor3 = Color3.fromHSV(hue, 1, 1)
                wait(0.05)
            end
        end)
        
        -- Удаляем уведомление через 3 секунды
        game:GetService("Debris"):AddItem(notification, 3)
        
        -- Активируем полёт
        runService.Heartbeat:Connect(fly)
    else
        humanoid.PlatformStand = false
        rootPart.Velocity = Vector3.new(0, 0, 0)
    end
end)

-- Обработка касаний для джойстика (мобилы)
if touchEnabled then
    userInput.TouchStarted:Connect(function(input, processed)
        if not processed then
            joystick.active = true
            joystick.position = input.Position
        end
    end)
    
    userInput.TouchMoved:Connect(function(input, processed)
        if joystick.active and not processed then
            local delta = input.Position - joystick.position
            joystick.direction = Vector2.new(
                math.clamp(delta.X / 100, -1, 1),
                math.clamp(-delta.Y / 100, -1, 1)
            )
        end
    end)
    
    userInput.TouchEnded:Connect(function(input, processed)
        joystick.active = false
        joystick.direction = Vector2.new(0, 0)
    end)
end

-- Индикатор полёта (радужный)
local statusText = Instance.new("TextLabel")
statusText.Name = "FlyStatus"
statusText.Size = UDim2.new(0, 150, 0, 30)
statusText.Position = UDim2.new(0, 10, 0, 10)
statusText.BackgroundTransparency = 1
statusText.Text = "FLY: OFF"
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.TextScaled = true
statusText.Font = Enum.Font.GothamBold
statusText.Parent = screenGui

spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.01) % 1
        statusText.TextColor3 = Color3.fromHSV(hue, 1, 1)
        if flying then
            statusText.Text = "FLY: ON"
        else
            statusText.Text = "FLY: OFF"
        end
        wait(0.05)
    end
end)

-- Функция clamp (для джойстика)
math.clamp = function(num, min, max)
    return math.max(min, math.min(max, num))
end
