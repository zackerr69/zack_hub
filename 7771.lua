--[[
    ███████╗ █████╗  ██████╗██╗  ██╗   ██╗
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝   ██║
      ███╔╝ ███████║██║     █████╔╝    ██║
     ███╔╝  ██╔══██║██║     ██╔═██╗    ██║
    ███████╗██║  ██║╚██████╗██║  ██╗   ██║
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝
    
    TG: @sajkyn
    VERSION: UI_FORCE_VISIBLE
--]]

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenSize = workspace.CurrentCamera.ViewportSize

print("СКРИПТ ЗАПУЩЕН")
print("Размер экрана:", screenSize.X, screenSize.Y)

-- ==================== ИКОНКА ====================
local icon = Instance.new("TextButton")
icon.Parent = playerGui  -- Вместо CoreGui используем PlayerGui
icon.BackgroundTransparency = 0
icon.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Ярко-красный фон
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255, 255, 255)
icon.Size = UDim2.new(0, 100, 0, 100)  -- Крупная иконка
icon.Position = UDim2.new(0.1, 0, 0.4, 0)  -- Чуть выше центра слева
icon.Font = Enum.Font.GothamBold
icon.Text = "Z_H"
icon.TextColor3 = Color3.fromRGB(0, 255, 0)  -- Ярко-зеленый текст
icon.TextScaled = true
icon.Draggable = true
icon.Active = true
icon.ZIndex = 999  -- Максимальный слой

print("Иконка создана в PlayerGui")
print("Позиция иконки:", icon.Position.X.Scale, icon.Position.Y.Scale)

-- ==================== МЕНЮ ====================
local menu = Instance.new("Frame")
menu.Parent = playerGui
menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menu.BackgroundTransparency = 0.2
menu.BorderSizePixel = 3
menu.BorderColor3 = Color3.fromRGB(255, 255, 255)
menu.Position = UDim2.new(0.2, 0, 0.1, 0)
menu.Size = UDim2.new(0, 400, 0, 400)
menu.Active = true
menu.Draggable = true
menu.Visible = true  -- Сразу видно для проверки
menu.ZIndex = 998

-- Заголовок для проверки
local testText = Instance.new("TextLabel")
testText.Parent = menu
testText.Size = UDim2.new(1, 0, 1, 0)
testText.BackgroundTransparency = 1
testText.Text = "МЕНЮ ВИДНО?"
testText.TextColor3 = Color3.fromRGB(255, 255, 255)
testText.TextScaled = true
testText.ZIndex = 999

print("✅ ВСЁ СОЗДАНО")
print("Если ты видишь это сообщение, но не видишь иконку - скриншот экрана в студию")
