--[[
    ZACKERR HUB - CORE V1
    Совместимость: Delta Executor (Mobile 2026)
    Функции: Иконка, меню с тянкой, система состояний, drag
--]]

-- Система состояний (все функции будут сюда записываться)
local ZACK_STATES = {
    -- Часть 2
    fly = false,
    noclip = false,
    esp = false,
    invisible = false,
    
    -- Часть 3
    invisfling = false,
    d rocking = false,
    
    -- Часть 4 (Chams)
    chams1 = false,
    chams2 = false,
    chams3 = false,
    chams4 = false,
    chams5 = false,
    
    -- Часть 5 (Аксессуары) - пока пусто, добавим позже
}

-- Создание иконки (прямоугольник с 0101)
local icon = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local text = Instance.new("TextLabel")

icon.Name = "ZACKERR_Icon"
icon.Parent = game.CoreGui
icon.ResetOnSpawn = false

frame.Parent = icon
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderColor3 = Color3.fromRGB(192, 192, 192) -- серебро
frame.BorderSizePixel = 2
frame.Position = UDim2.new(0, 50, 0, 50)
frame.Size = UDim2.new(0, 120, 0, 40)
frame.Active = true
frame.Draggable = true -- Drag functionality встроенная

-- Текст "ZACK HUB" серебряный
text.Parent = frame
text.BackgroundTransparency = 1
text.Size = UDim2.new(1, 0, 0.5, 0)
text.Position = UDim2.new(0, 0, 0, 0)
text.Text = "ZACK HUB"
text.TextColor3 = Color3.fromRGB(192, 192, 192)
text.TextScaled = true
text.Font = Enum.Font.GothamBold

-- Текст "0101"
local binaryText = Instance.new("TextLabel")
binaryText.Parent = frame
binaryText.BackgroundTransparency = 1
binaryText.Size = UDim2.new(1, 0, 0.5, 0)
binaryText.Position = UDim2.new(0, 0, 0.5, 0)
binaryText.Text = "0101 0101"
binaryText.TextColor3 = Color3.fromRGB(0, 255, 0)
binaryText.TextScaled = true
binaryText.Font = Enum.Font.Code

-- Главное меню (появится при клике на иконку)
local menu = Instance.new("Frame")
local background = Instance.new("ImageLabel")
local closeButton = Instance.new("TextButton")

menu.Name = "Menu"
menu.Parent = icon
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
menu.BorderSizePixel = 0
menu.Position = UDim2.new(0, 140, 0, 0)
menu.Size = UDim2.new(0, 300, 0, 400)
menu.Visible = false
menu.Active = true
menu.Draggable = true

-- Фон с тянкой (вставь свою ссылку)
background.Parent = menu
background.Size = UDim2.new(1, 0, 1, 0)
background.Image = "http://www.roblox.com/asset/?id=123456789" -- ЗАМЕНИ НА СВОЮ КАРТИНКУ
background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
background.BackgroundTransparency = 0.3

-- Кнопка закрытия
closeButton.Parent = menu
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

-- Заголовок меню
local title = Instance.new("TextLabel")
title.Parent = menu
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "ZACKERR HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.BackgroundTransparency = 0.5
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.Font = Enum.Font.GothamBlack

-- Открытие меню по клику на иконку
frame.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- Создаем контейнер для кнопок функций
local function createToggle(name, stateKey, yPos)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = menu
    toggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
    toggleFrame.Position = UDim2.new(0.05, 0, 0, 50 + yPos)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.BackgroundTransparency = 0.3
    toggleFrame.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel")
    label.Parent = toggleFrame
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = toggleFrame
    toggleBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
    toggleBtn.Position = UDim2.new(0.75, 0, 0.15, 0)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggleBtn.BorderSizePixel = 0
    
    toggleBtn.MouseButton1Click:Connect(function()
        ZACK_STATES[stateKey] = not ZACK_STATES[stateKey]
        if ZACK_STATES[stateKey] then
            toggleBtn.Text = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggleBtn.Text = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
end

-- Добавляем кнопки для функций (пока заглушки, позже подключим реальный код)
createToggle("Полет (Fly)", "fly", 0)
createToggle("Noclip", "noclip", 40)
createToggle("ESP", "esp", 80)
createToggle("Невидимость", "invisible", 120)
createToggle("InvisFling", "invisfling", 160)
createToggle("Дрочка", "d rocking", 200)
createToggle("Chams 1", "chams1", 240)
createToggle("Chams 2", "chams2", 280)

-- Уведомление о загрузке
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACKERR HUB",
    Text = "Ядро загружено! Иконка слева вверху",
    Duration = 3
})
