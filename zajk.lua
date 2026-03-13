--[[
    ███████╗ █████╗  ██████╗██╗  ██╗   ██╗
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝   ██║
      ███╔╝ ███████║██║     █████╔╝    ██║
     ███╔╝  ██╔══██║██║     ██╔═██╗    ██║
    ███████╗██║  ██║╚██████╗██║  ██╗   ██║
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝
    
    TG: @sajkyn
    VERSION: BILLBOARD_UI
--]]

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")

-- ==================== НЕВИДИМЫЙ ПАРТ ====================
local part = Instance.new("Part")
part.Parent = workspace
part.Size = Vector3.new(0.1, 0.1, 0.1)
part.Anchored = true
part.CanCollide = false
part.Transparency = 1
part.BrickColor = BrickColor.new("White")

-- ==================== БИЛЛБОРД (ИКОНКА) ====================
local billboard = Instance.new("BillboardGui")
billboard.Parent = part
billboard.Size = UDim2.new(0, 80, 0, 80)
billboard.StudsOffset = Vector3.new(0, 0, 0)
billboard.AlwaysOnTop = true
billboard.Active = true

local icon = Instance.new("TextButton")
icon.Parent = billboard
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 0.2
icon.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255, 255, 255)
icon.Text = "Z_H"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextScaled = true
icon.Font = Enum.Font.GothamBold

-- Закругление иконки (визуально)
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Радужный текст
spawn(function()
    local hue = 0
    while icon and icon.Parent do
        hue = (hue + 0.01) % 1
        icon.TextColor3 = Color3.fromHSV(hue, 1, 1)
        icon.BorderColor3 = Color3.fromHSV(hue, 1, 1)
        wait(0.05)
    end
end)

-- ==================== МЕНЮ (тоже Billboard) ====================
local menuBillboard = Instance.new("BillboardGui")
menuBillboard.Parent = part
menuBillboard.Size = UDim2.new(0, 400, 0, 450)
menuBillboard.StudsOffset = Vector3.new(2, 0, 0)  -- справа от иконки
menuBillboard.AlwaysOnTop = true
menuBillboard.Active = true
menuBillboard.Visible = false

local menu = Instance.new("Frame")
menu.Parent = menuBillboard
menu.Size = UDim2.new(1, 0, 1, 0)
menu.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
menu.BackgroundTransparency = 0.05
menu.BorderSizePixel = 3
menu.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Заголовок
local title = Instance.new("TextLabel")
title.Parent = menu
title.BackgroundTransparency = 1
title.BorderSizePixel = 2
title.BorderColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0, 15, 0, 10)
title.Size = UDim2.new(0, 200, 0, 35)
title.Font = Enum.Font.GothamBold
title.Text = "ZACK_HUB"
title.TextColor3 = Color3.fromRGB(230, 230, 230)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = menu
closeBtn.BackgroundTransparency = 1
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -70, 0, 10)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
closeBtn.TextScaled = true

-- ==================== АККОРДЕОНЫ ====================
local function makeAccordion(parent, name, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name .. " >"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextScaled = true

    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Position = UDim2.new(0.1, 0, yPos + 0.06, 0)
    container.Size = UDim2.new(0.8, 0, 0, 200)
    container.Visible = false

    return btn, container
end

local mainBtn, mainContainer = makeAccordion(menu, "MAIN", 0.12)
local visualBtn, visualContainer = makeAccordion(menu, "VISUAL", 0.3)
local boxesBtn, boxesContainer = makeAccordion(menu, "BOXES", 0.48)

-- ==================== КНОПКИ ВНУТРИ ====================
local function makeSubButton(parent, text, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    btn.Position = UDim2.new(0, 0, yPos, 0)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    return btn
end

makeSubButton(mainContainer, "FLY", 0)
makeSubButton(mainContainer, "NO CLIP", 0.1)
makeSubButton(mainContainer, "AIM", 0.2)
makeSubButton(mainContainer, "CLICKER", 0.3)

makeSubButton(visualContainer, "CHAMS", 0)
makeSubButton(visualContainer, "HEADLESS", 0.1)
makeSubButton(visualContainer, "JERK", 0.2)

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
    menuBillboard.Visible = not menuBillboard.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    menuBillboard.Visible = false
end)

-- ==================== ПРИВЯЗКА К КАМЕРЕ ====================
runService.RenderStepped:Connect(function()
    part.CFrame = camera.CFrame * CFrame.new(2, 0, -5)  -- справа перед камерой
end)

print("✅ БИЛЛБОРД UI ЗАГРУЖЕН")
print("📍 Иконка всегда перед глазами")
