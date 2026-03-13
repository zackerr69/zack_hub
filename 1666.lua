--[[
    ███████╗ █████╗  ██████╗██╗  ██╗   ██╗
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝   ██║
      ███╔╝ ███████║██║     █████╔╝    ██║
     ███╔╝  ██╔══██║██║     ██╔═██╗    ██║
    ███████╗██║  ██║╚██████╗██║  ██╗   ██║
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝
    
    TG: @sajkyn
    VERSION: NO_VISIBLE_FIX
--]]

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

-- Невидимый парт, который будет всегда перед камерой
local part = Instance.new("Part")
part.Parent = workspace
part.Size = Vector3.new(0.1, 0.1, 0.1)
part.Anchored = true
part.CanCollide = false
part.Transparency = 1

-- ИКОНКА (всегда видна)
local iconBillboard = Instance.new("BillboardGui")
iconBillboard.Parent = part
iconBillboard.Size = UDim2.new(0, 80, 0, 80)
iconBillboard.StudsOffset = Vector3.new(0, 0, 0)
iconBillboard.AlwaysOnTop = true

local icon = Instance.new("TextButton")
icon.Parent = iconBillboard
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 0.2
icon.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255, 255, 255)
icon.Text = "Z_H"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextScaled = true
icon.Font = Enum.Font.GothamBold

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

-- Переменная для меню
local menuBillboard = nil

-- Функция создания меню
local function createMenu()
    if menuBillboard then
        menuBillboard:Destroy()
        menuBillboard = nil
        return
    end

    menuBillboard = Instance.new("BillboardGui")
    menuBillboard.Parent = part
    menuBillboard.Size = UDim2.new(0, 400, 0, 450)
    menuBillboard.StudsOffset = Vector3.new(3, 0, 0)
    menuBillboard.AlwaysOnTop = true

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

    closeBtn.MouseButton1Click:Connect(function()
        if menuBillboard then
            menuBillboard:Destroy()
            menuBillboard = nil
        end
    end)

    -- Аккордеоны (можно потом добавить)
    local testText = Instance.new("TextLabel")
    testText.Parent = menu
    testText.Position = UDim2.new(0.1, 0, 0.2, 0)
    testText.Size = UDim2.new(0.8, 0, 0.6, 0)
    testText.BackgroundTransparency = 1
    testText.Text = "МЕНЮ РАБОТАЕТ"
    testText.TextColor3 = Color3.fromRGB(0, 255, 0)
    testText.TextScaled = true
    testText.Font = Enum.Font.GothamBold
end

-- Клик по иконке
icon.MouseButton1Click:Connect(createMenu)

-- Привязка к камере
runService.RenderStepped:Connect(function()
    part.CFrame = camera.CFrame * CFrame.new(2, 0, -5)
end)

print("✅ Биллборд без Visible загружен")
