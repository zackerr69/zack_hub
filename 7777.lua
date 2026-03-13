--[[
    ███████╗ █████╗  ██████╗██╗  ██╗   ██╗
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝   ██║
      ███╔╝ ███████║██║     █████╔╝    ██║
     ███╔╝  ██╔══██║██║     ██╔═██╗    ██║
    ███████╗██║  ██║╚██████╗██║  ██╗   ██║
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝
    
    TG: @sajkyn
    VERSION: UI_TEST_MOBILE
--]]

local player = game.Players.LocalPlayer
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local screenSize = runService:GetAttribute("ScreenSize") or Vector2.new(800, 600)

print("Начинаю создание GUI")

-- ==================== ИКОНКА Z_H ====================
local icon = Instance.new("TextButton")
icon.Parent = coreGui
icon.BackgroundTransparency = 0.2
icon.BackgroundColor3 = Color3.fromRGB(10,10,10)
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255,255,255)
icon.Size = UDim2.new(0, 80, 0, 80)
icon.Position = UDim2.new(0.1, 0, 0.5, -40)  -- Слева по центру
icon.Font = Enum.Font.GothamBold
icon.Text = "Z_H"
icon.TextColor3 = Color3.fromRGB(255,255,255)
icon.TextScaled = true
icon.Draggable = true
icon.Active = true
icon.ZIndex = 10

print("Иконка создана, позиция:", icon.Position)

-- Временная яркая подсветка чтобы точно увидеть
icon.BackgroundColor3 = Color3.fromRGB(255,0,0)
icon.TextColor3 = Color3.fromRGB(0,255,0)

-- Радужное свечение иконки (запустится через 3 секунды)
spawn(function()
    wait(3)
    icon.BackgroundColor3 = Color3.fromRGB(10,10,10)
    local hue = 0
    while icon and icon.Parent do
        hue = (hue + 0.01) % 1
        icon.TextColor3 = Color3.fromHSV(hue, 1, 1)
        icon.BorderColor3 = Color3.fromHSV(hue, 1, 1)
        wait(0.05)
    end
end)

-- ==================== ГЛАВНОЕ МЕНЮ ====================
local menu = Instance.new("Frame")
menu.Parent = coreGui
menu.BackgroundColor3 = Color3.fromRGB(5,5,5)
menu.BackgroundTransparency = 0.05
menu.BorderSizePixel = 3
menu.BorderColor3 = Color3.fromRGB(255,255,255)
menu.Position = UDim2.new(0.2, 0, 0.15, 0)  -- Чуть левее для телефона
menu.Size = UDim2.new(0, 450, 0, 450)  -- Чуть меньше для телефона
menu.Active = true
menu.Draggable = true
menu.Visible = false
menu.ZIndex = 5

-- Заголовок
local title = Instance.new("TextLabel")
title.Parent = menu
title.BackgroundTransparency = 1
title.BorderSizePixel = 2
title.BorderColor3 = Color3.fromRGB(255,255,255)
title.Position = UDim2.new(0, 15, 0, 10)
title.Size = UDim2.new(0, 200, 0, 35)
title.Font = Enum.Font.GothamBold
title.Text = "ZACK_HUB"
title.TextColor3 = Color3.fromRGB(230,230,230)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 6

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = menu
closeBtn.BackgroundTransparency = 1
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(255,255,255)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -70, 0, 10)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(230,230,230)
closeBtn.TextScaled = true
closeBtn.ZIndex = 6

-- Кнопка свернуть
local miniBtn = Instance.new("TextButton")
miniBtn.Parent = menu
miniBtn.BackgroundTransparency = 1
miniBtn.BorderSizePixel = 2
miniBtn.BorderColor3 = Color3.fromRGB(255,255,255)
miniBtn.Size = UDim2.new(0, 35, 0, 35)
miniBtn.Position = UDim2.new(1, -35, 0, 10)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.Text = "−"
miniBtn.TextColor3 = Color3.fromRGB(230,230,230)
miniBtn.TextScaled = true
miniBtn.ZIndex = 6

-- ==================== КНОПКИ-АККОРДЕОНЫ ====================
local function makeAccordion(parent, name, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(255,255,255)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name .. " >"
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.TextScaled = true
    btn.ZIndex = 6
    
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Position = UDim2.new(0.1, 0, yPos + 0.06, 0)
    container.Size = UDim2.new(0.8, 0, 0, 220)
    container.Visible = false
    container.ZIndex = 6
    
    return btn, container
end

-- MAIN аккордеон
local mainBtn, mainContainer = makeAccordion(menu, "MAIN", 0.12)

-- VISUAL аккордеон
local visualBtn, visualContainer = makeAccordion(menu, "VISUAL", 0.3)

-- BOXES аккордеон
local boxesBtn, boxesContainer = makeAccordion(menu, "BOXES", 0.48)

-- ==================== КНОПКИ ВНУТРИ ====================
local function makeSubButton(parent, text, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(255,255,255)
    btn.Position = UDim2.new(0, 0, yPos, 0)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.TextScaled = true
    btn.ZIndex = 7
    return btn
end

-- MAIN кнопки
makeSubButton(mainContainer, "FLY", 0)
makeSubButton(mainContainer, "NO CLIP", 0.1)
makeSubButton(mainContainer, "AIM", 0.2)
makeSubButton(mainContainer, "CLICKER", 0.3)

-- VISUAL кнопки
makeSubButton(visualContainer, "CHAMS", 0)
makeSubButton(visualContainer, "HEADLESS", 0.1)
makeSubButton(visualContainer, "JERK", 0.2)

-- BOXES кнопки
makeSubButton(boxesContainer, "WH", 0)
makeSubButton(boxesContainer, "SKELETON", 0.1)
makeSubButton(boxesContainer, "HITBOXES", 0.2)
makeSubButton(boxesContainer, "ESP", 0.3)
makeSubButton(boxesContainer, "LINES", 0.4)
makeSubButton(boxesContainer, "COMPASS", 0.5)

-- ==================== ЛОГИКА ====================
mainBtn.MouseButton1Click:Connect(function()
    mainContainer.Visible = not mainContainer.Visible
    mainBtn.Text = mainContainer.Visible and "MAIN v" or "MAIN >"
end)

visualBtn.MouseButton1Click:Connect(function()
    visualContainer.Visible = not visualContainer.Visible
    visualBtn.Text = visualContainer.Visible and "VISUAL v" or "VISUAL >"
end)

boxesBtn.MouseButton1Click:Connect(function()
    boxesContainer.Visible = not boxesContainer.Visible
    boxesBtn.Text = boxesContainer.Visible and "BOXES v" or "BOXES >"
end)

icon.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    print("Меню:", menu.Visible and "открыто" or "закрыто")
end)

closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

miniBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

print("✅ UI TEST LOADED | Иконка слева по центру")
