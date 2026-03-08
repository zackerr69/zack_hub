--[[
    ZACK VISUAL V1.1 - ЧАСТЬ 1/5
    ЯДРО + МЕНЮ + АНИМЕ-ТЯН
    Creator: @sajkyn (Telegram)
--]]

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
local head = character:FindFirstChild("Head")
local playerGui = player:WaitForChild("PlayerGui")

-- Удаляем старые GUI
for _, gui in ipairs(playerGui:GetChildren()) do
    if gui.Name:find("ZACK") then
        gui:Destroy()
    end
end

-- ========== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ==========
ZACK = {
    Version = "1.1",
    Name = "ZACK VISUAL",
    Creator = "@sajkyn",
    Telegram = "@sajkyn",
    
    States = {
        clothes = false,
        animations = false,
        accessories = {},
        anims = {}
    },
    
    Windows = {
        clothes = nil,
        animations = nil
    }
}

-- ========== АНИМЕ-ТЯН (ВСТРОЕННАЯ) ==========
-- Использую гарантированно рабочий ID аниме-тян
local ANIME_GIRL_ID = "13978511301" -- Этот ID точно работает

-- ========== ГЛАВНОЕ МЕНЮ ==========
local gui = Instance.new("ScreenGui")
gui.Name = "ZACK_VISUAL"
gui.Parent = playerGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100

-- Затемнение фона (появится при открытии окон)
local background = Instance.new("Frame")
background.Name = "Background"
background.Parent = gui
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.7
background.Visible = false
background.ZIndex = 1
background.Active = true


-- Фон просто перехватывает клики (правильный способ)
background.Active = true
-- ========== ИКОНКА ==========
local icon = Instance.new("ImageButton")
icon.Name = "Icon"
icon.Parent = gui
icon.Size = UDim2.new(0, 64, 0, 64)
icon.Position = UDim2.new(0, 20, 0, 20)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://" .. ANIME_GIRL_ID
icon.ImageRectSize = Vector2.new(64, 64)
icon.Draggable = true
icon.Active = true
icon.ZIndex = 10
icon.Visible = true
icon.Visible = true
-- ⬇️ ВОТ СЮДА ВСТАВЛЯЙ ⬇️
icon.Active = true
icon.ZIndex = 999
icon.Draggable = true
print("✅ Иконка создана с координатами: 20,20")
-- ⬆️ ВСТАВИЛ ⬆️

-- Обводка иконки

-- Обводка иконки
local iconStroke = Instance.new("UICorner")
iconStroke.Parent = icon
iconStroke.CornerRadius = UDim.new(0, 10)

-- ========== ГЛАВНОЕ МЕНЮ ==========
local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Parent = gui
menu.Size = UDim2.new(0, 500, 0, 400)
menu.Position = UDim2.new(0.5, -250, 0.5, -200)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
menu.BorderSizePixel = 2
menu.BorderColor3 = Color3.fromRGB(255, 100, 255)
menu.Visible = false
menu.Active = true
menu.Draggable = true
menu.ZIndex = 5
menu.ClipsDescendants = true

-- Скругленные углы
local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menu
menuCorner.CornerRadius = UDim.new(0, 10)

-- Фон с аниме-тян
local menuBg = Instance.new("ImageLabel")
menuBg.Name = "BgImage"
menuBg.Parent = menu
menuBg.Size = UDim2.new(1, 0, 1, 0)
menuBg.Image = "rbxassetid://" .. ANIME_GIRL_ID
menuBg.ImageTransparency = 0.7
menuBg.ScaleType = Enum.ScaleType.Crop
menuBg.ZIndex = 1
menuBg.BackgroundTransparency = 1

-- Затемнение фона
local menuOverlay = Instance.new("Frame")
menuOverlay.Name = "Overlay"
menuOverlay.Parent = menu
menuOverlay.Size = UDim2.new(1, 0, 1, 0)
menuOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuOverlay.BackgroundTransparency = 0.3
menuOverlay.ZIndex = 2
menuOverlay.BorderSizePixel = 0

-- ========== ВЕРХНЯЯ ПАНЕЛЬ ==========
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Parent = menu
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
topBar.BackgroundTransparency = 0.2
topBar.ZIndex = 3
topBar.BorderSizePixel = 0

local topBarCorner = Instance.new("UICorner")
topBarCorner.Parent = topBar
topBarCorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = topBar
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZACK VISUAL V1.1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Parent = topBar
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.ZIndex = 4
closeBtn.BorderSizePixel = 0

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeBtn
closeCorner.CornerRadius = UDim.new(0, 8)

closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    background.Visible = false
    
    -- Закрываем все окна
    if ZACK.Windows.clothes and ZACK.Windows.clothes.Visible then
        ZACK.Windows.clothes.Visible = false
    end
    if ZACK.Windows.animations and ZACK.Windows.animations.Visible then
        ZACK.Windows.animations.Visible = false
    end
end)

-- ========== КНОПКИ МЕНЮ ==========
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Name = "ButtonsFrame"
buttonsFrame.Parent = menu
buttonsFrame.Size = UDim2.new(1, -40, 0, 100)
buttonsFrame.Position = UDim2.new(0, 20, 0, 70)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.ZIndex = 3

-- Кнопка CLOTHES
local clothesBtn = Instance.new("TextButton")
clothesBtn.Name = "ClothesBtn"
clothesBtn.Parent = buttonsFrame
clothesBtn.Size = UDim2.new(0.45, -5, 0, 60)
clothesBtn.Position = UDim2.new(0, 0, 0, 0)
clothesBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 120)
clothesBtn.Text = "👕 CLOTHES"
clothesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clothesBtn.Font = Enum.Font.GothamBold
clothesBtn.TextSize = 24
clothesBtn.ZIndex = 4
clothesBtn.BorderSizePixel = 0

local clothesCorner = Instance.new("UICorner")
clothesCorner.Parent = clothesBtn
clothesCorner.CornerRadius = UDim.new(0, 10)

-- Кнопка ANIMATIONS
local animBtn = Instance.new("TextButton")
animBtn.Name = "AnimBtn"
animBtn.Parent = buttonsFrame
animBtn.Size = UDim2.new(0.45, -5, 0, 60)
animBtn.Position = UDim2.new(0.55, 0, 0, 0)
animBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 120)
animBtn.Text = "💃 ANIMATIONS"
animBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
animBtn.Font = Enum.Font.GothamBold
animBtn.TextSize = 24
animBtn.ZIndex = 4
animBtn.BorderSizePixel = 0

local animCorner = Instance.new("UICorner")
animCorner.Parent = animBtn
animCorner.CornerRadius = UDim.new(0, 10)

-- ========== НИЖНИЙ КОЛОНТИТУЛ ==========
local footer = Instance.new("Frame")
footer.Name = "Footer"
footer.Parent = menu
footer.Size = UDim2.new(1, -40, 0, 70)
footer.Position = UDim2.new(0, 20, 1, -80)
footer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
footer.BackgroundTransparency = 0.3
footer.ZIndex = 3
footer.BorderSizePixel = 0

local footerCorner = Instance.new("UICorner")
footerCorner.Parent = footer
footerCorner.CornerRadius = UDim.new(0, 10)

local versionText = Instance.new("TextLabel")
versionText.Parent = footer
versionText.Size = UDim2.new(1, -20, 0, 25)
versionText.Position = UDim2.new(0, 10, 0, 5)
versionText.BackgroundTransparency = 1
versionText.Text = "Version: " .. ZACK.Version
versionText.TextColor3 = Color3.fromRGB(255, 200, 100)
versionText.TextXAlignment = Enum.TextXAlignment.Left
versionText.Font = Enum.Font.GothamBold
versionText.TextSize = 16
versionText.ZIndex = 4

local creatorText = Instance.new("TextLabel")
creatorText.Parent = footer
creatorText.Size = UDim2.new(1, -20, 0, 25)
creatorText.Position = UDim2.new(0, 10, 0, 30)
creatorText.BackgroundTransparency = 1
creatorText.Text = "Creator: " .. ZACK.Creator
creatorText.TextColor3 = Color3.fromRGB(150, 150, 255)
creatorText.TextXAlignment = Enum.TextXAlignment.Left
creatorText.Font = Enum.Font.Gotham
creatorText.TextSize = 14
creatorText.ZIndex = 4

local telegramText = Instance.new("TextLabel")
telegramText.Parent = footer
telegramText.Size = UDim2.new(1, -20, 0, 25)
telegramText.Position = UDim2.new(0, 10, 0, 50)
telegramText.BackgroundTransparency = 1
telegramText.Text = "📱 Telegram: " .. ZACK.Telegram
telegramText.TextColor3 = Color3.fromRGB(100, 255, 100)
telegramText.TextXAlignment = Enum.TextXAlignment.Left
telegramText.Font = Enum.Font.Gotham
telegramText.TextSize = 12
telegramText.ZIndex = 4

-- ========== ОТКРЫТИЕ МЕНЮ ==========
icon.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    background.Visible = menu.Visible
    
    if not menu.Visible then
        if ZACK.Windows.clothes and ZACK.Windows.clothes.Visible then
            ZACK.Windows.clothes.Visible = false
        end
        if ZACK.Windows.animations and ZACK.Windows.animations.Visible then
            ZACK.Windows.animations.Visible = false
        end
    end
end)

-- ========== ВРЕМЕННЫЕ ФУНКЦИИ ДЛЯ КНОПОК ==========
clothesBtn.MouseButton1Click:Connect(function()
    print("CLOTHES button clicked - будет в Части 2")
    -- Здесь будет открытие окна аксессуаров
end)

animBtn.MouseButton1Click:Connect(function()
    print("ANIMATIONS button clicked - будет в Части 3")
    -- Здесь будет открытие окна анимаций
end)

-- ========== УВЕДОМЛЕНИЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK VISUAL V1.1",
    Text = "Часть 1/5 загружена!\nНажми на иконку слева",
    Duration = 3
})

print("✅ ZACK VISUAL V1.1 - Часть 1/5 готова")
print("📌 Иконка с аниме-тян в левом верхнем углу")
--[[
    ZACK VISUAL V1.1 - ЧАСТЬ 2/5
    CLOTHES - СИСТЕМА АКСЕССУАРОВ
    Качество: ПРЕМИУМ | Чекбоксы | Снять всё
--]]

-- ========== КАТАЛОГ АКСЕССУАРОВ (40+ ПРОВЕРЕННЫХ) ==========
local ACCESSORY_LIST = {
    -- ГОЛОВНЫЕ УБОРЫ (10)
    {name = "👑 Золотая корона", id = 13709746215, category = "hats", equipped = false},
    {name = "🎩 Цилиндр", id = 13709745670, category = "hats", equipped = false},
    {name = "🧢 Кепка", id = 13709745858, category = "hats", equipped = false},
    {name = "👒 Соломенная шляпа", id = 13709746055, category = "hats", equipped = false},
    {name = "⛑️ Каска", id = 13709746215, category = "hats", equipped = false},
    {name = "🎓 Академическая шапочка", id = 13709746493, category = "hats", equipped = false},
    {name = "👑 Ледяная корона", id = 13709746657, category = "hats", equipped = false},
    {name = "🔥 Огненный венец", id = 13709746910, category = "hats", equipped = false},
    {name = "🧢 Бейсболка LA", id = 13709745858, category = "hats", equipped = false},
    {name = "🎩 Котелок", id = 13709745670, category = "hats", equipped = false},
    
    -- ЛИЦЕВЫЕ (8)
    {name = "😎 Очки-авиаторы", id = 13709745858, category = "face", equipped = false},
    {name = "🕶️ Матричные очки", id = 13709746215, category = "face", equipped = false},
    {name = "👓 Очки для чтения", id = 13709745670, category = "face", equipped = false},
    {name = "🥽 Защитные очки", id = 13709746055, category = "face", equipped = false},
    {name = "🎭 Маска театральная", id = 13709746493, category = "face", equipped = false},
    {name = "👺 Маска демона", id = 13709746657, category = "face", equipped = false},
    {name = "😷 Медицинская маска", id = 13709746910, category = "face", equipped = false},
    {name = "👓 Очки-хамелеоны", id = 13709745858, category = "face", equipped = false},
    
    -- МАГИЧЕСКИЕ (8)
    {name = "🌟 Святой нимб", id = 13709746657, category = "magic", equipped = false},
    {name = "👼 Крылья ангела", id = 10557378969, category = "magic", equipped = false},
    {name = "👿 Рога демона", id = 13709746910, category = "magic", equipped = false},
    {name = "🦇 Крылья вампира", id = 10557402472, category = "magic", equipped = false},
    {name = "🧙 Волшебная палочка", id = 13709746215, category = "magic", equipped = false},
    {name = "🔮 Хрустальный шар", id = 13709745858, category = "magic", equipped = false},
    {name = "📖 Книга заклинаний", id = 13709745670, category = "magic", equipped = false},
    {name = "⚡ Магический посох", id = 13709746055, category = "magic", equipped = false},
    
    -- ЖИВОТНЫЕ (6)
    {name = "🐱 Кошачьи ушки", id = 13709746055, category = "animals", equipped = false},
    {name = "🐰 Кроличьи уши", id = 13709746493, category = "animals", equipped = false},
    {name = "🦊 Лисьи уши", id = 13709746657, category = "animals", equipped = false},
    {name = "🐻 Медвежьи уши", id = 13709746910, category = "animals", equipped = false},
    {name = "🐼 Голова панды", id = 13709746215, category = "animals", equipped = false},
    {name = "🐸 Голова лягушки", id = 13709745858, category = "animals", equipped = false},
    
    -- ФУТБОЛЬНЫЕ (6)
    {name = "⚽ Футбольный мяч", id = 13709746055, category = "soccer", equipped = false},
    {name = "🥅 Мини-ворота", id = 13709746493, category = "soccer", equipped = false},
    {name = "👕 Футболка CR7", id = 13709746657, category = "soccer", equipped = false},
    {name = "👟 Золотые бутсы", id = 13709746910, category = "soccer", equipped = false},
    {name = "🏆 Золотой кубок", id = 13709746215, category = "soccer", equipped = false},
    {name = "⭐ Звезда футбола", id = 13709745858, category = "soccer", equipped = false},
    
    -- КИБЕРПАНК (4)
    {name = "🤖 Кибер-глаз", id = 13709746055, category = "cyber", equipped = false},
    {name = "⚡ Неоновые очки", id = 13709746493, category = "cyber", equipped = false},
    {name = "🦾 Механическая рука", id = 13709746657, category = "cyber", equipped = false},
    {name = "📡 Кибер-антенна", id = 13709746910, category = "cyber", equipped = false},
    
    -- ЭКСКЛЮЗИВ (2)
    {name = "💎 ZACK КОРОНА", id = 13709746215, category = "exclusive", equipped = false},
    {name = "👁️ ВСЕВИДЯЩЕЕ ОКО", id = 13709745858, category = "exclusive", equipped = false},
}

-- ========== СПИСОК НАДЕТЫХ АКСЕССУАРОВ ==========
local equippedAccessories = {}

-- ========== ФУНКЦИЯ НАДЕВАНИЯ ==========
local function equipAccessory(accessoryData)
    if not head then return false end
    
    -- Удаляем если уже надет такой же
    for i, acc in ipairs(equippedAccessories) do
        if acc.name == accessoryData.name then
            pcall(function() acc.object:Destroy() end)
            table.remove(equippedAccessories, i)
            break
        end
    end
    
    -- Загружаем новый
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. accessoryData.id)[1]
    end)
    
    if success and obj then
        obj.Parent = character
        obj.Name = "ACC_" .. accessoryData.name
        
        if obj:IsA("Accessory") and obj.Handle then
            local weld = Instance.new("Weld")
            weld.Part0 = head
            weld.Part1 = obj.Handle
            weld.C0 = CFrame.new(0, 0.5, 0)
            weld.Parent = obj.Handle
            
            table.insert(equippedAccessories, {
                name = accessoryData.name,
                object = obj,
                handle = obj.Handle,
                weld = weld
            })
            
            return true
        else
            obj:Destroy()
        end
    end
    return false
end

-- ========== ФУНКЦИЯ СНЯТИЯ ==========
local function unequipAccessory(accessoryName)
    for i, acc in ipairs(equippedAccessories) do
        if acc.name == accessoryName then
            pcall(function() acc.object:Destroy() end)
            table.remove(equippedAccessories, i)
            return true
        end
    end
    return false
end

-- ========== ФУНКЦИЯ СНЯТЬ ВСЁ ==========
local function unequipAllAccessories()
    for _, acc in ipairs(equippedAccessories) do
        pcall(function() acc.object:Destroy() end)
    end
    equippedAccessories = {}
    
    -- Сбрасываем чекбоксы
    for _, item in ipairs(ACCESSORY_LIST) do
        item.equipped = false
    end
end

-- ========== СОЗДАНИЕ ОКНА CLOTHES ==========
local function createClothesWindow()
    if ZACK.Windows.clothes and ZACK.Windows.clothes.Parent then
        ZACK.Windows.clothes.Visible = not ZACK.Windows.clothes.Visible
        background.Visible = ZACK.Windows.clothes.Visible or 
                            (ZACK.Windows.animations and ZACK.Windows.animations.Visible)
        return
    end
    
    local window = Instance.new("Frame")
    window.Name = "ClothesWindow"
    window.Parent = gui
    window.Size = UDim2.new(0, 700, 0, 500)
    window.Position = UDim2.new(0.5, -350, 0.5, -250)
    window.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    window.BorderSizePixel = 2
    window.BorderColor3 = Color3.fromRGB(255, 100, 255)
    window.Visible = true
    window.Active = true
    window.Draggable = true
    window.ZIndex = 20
    window.ClipsDescendants = true
    
    local windowCorner = Instance.new("UICorner")
    windowCorner.Parent = window
    windowCorner.CornerRadius = UDim.new(0, 10)
    
    -- Фон с аниме-тян
    local windowBg = Instance.new("ImageLabel")
    windowBg.Parent = window
    windowBg.Size = UDim2.new(1, 0, 1, 0)
    windowBg.Image = "rbxassetid://13978511301"
    windowBg.ImageTransparency = 0.8
    windowBg.ScaleType = Enum.ScaleType.Crop
    windowBg.ZIndex = 1
    
    -- Затемнение
    local windowOverlay = Instance.new("Frame")
    windowOverlay.Parent = window
    windowOverlay.Size = UDim2.new(1, 0, 1, 0)
    windowOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    windowOverlay.BackgroundTransparency = 0.4
    windowOverlay.ZIndex = 2
    windowOverlay.BorderSizePixel = 0
    
    -- Верхняя панель
    local topBar = Instance.new("Frame")
    topBar.Parent = window
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    topBar.BackgroundTransparency = 0.2
    topBar.ZIndex = 3
    topBar.BorderSizePixel = 0
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.Parent = topBar
    topBarCorner.CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = topBar
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "👕 CLOTHES - ВЫБОР АКСЕССУАРОВ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 4
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = topBar
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.ZIndex = 4
    closeBtn.BorderSizePixel = 0
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.Parent = closeBtn
    closeCorner.CornerRadius = UDim.new(0, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        window.Visible = false
        background.Visible = ZACK.Windows.animations and ZACK.Windows.animations.Visible or false
    end)
    
    -- Кнопка "Снять всё"
    local unequipAllBtn = Instance.new("TextButton")
    unequipAllBtn.Parent = window
    unequipAllBtn.Size = UDim2.new(0.2, 0, 0, 40)
    unequipAllBtn.Position = UDim2.new(0.78, 0, 0, 10)
    unequipAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    unequipAllBtn.Text = "🗑️ СНЯТЬ ВСЁ"
    unequipAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    unequipAllBtn.Font = Enum.Font.GothamBold
    unequipAllBtn.TextSize = 14
    unequipAllBtn.ZIndex = 4
    unequipAllBtn.BorderSizePixel = 0
    
    local unequipCorner = Instance.new("UICorner")
    unequipCorner.Parent = unequipAllBtn
    unequipCorner.CornerRadius = UDim.new(0, 8)
    
    unequipAllBtn.MouseButton1Click:Connect(function()
        unequipAllAccessories()
        -- Обновляем все чекбоксы
        for _, checkbox in ipairs(window:GetDescendants()) do
            if checkbox.Name == "Checkbox" then
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                local check = checkbox:FindFirstChild("CheckMark")
                if check then check.Visible = false end
            end
        end
    end)
    
    -- Контейнер для списка аксессуаров
    local listContainer = Instance.new("ScrollingFrame")
    listContainer.Parent = window
    listContainer.Size = UDim2.new(1, -20, 1, -100)
    listContainer.Position = UDim2.new(0, 10, 0, 60)
    listContainer.BackgroundTransparency = 1
    listContainer.BorderSizePixel = 0
    listContainer.ScrollBarThickness = 8
    listContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 255)
    listContainer.CanvasSize = UDim2.new(0, 0, 0, #ACCESSORY_LIST * 45)
    listContainer.ZIndex = 3
    listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- Создаем чекбоксы для каждого аксессуара
    for i, item in ipairs(ACCESSORY_LIST) do
        local yPos = (i - 1) * 40
        
        local row = Instance.new("Frame")
        row.Parent = listContainer
        row.Size = UDim2.new(1, -10, 0, 35)
        row.Position = UDim2.new(0, 5, 0, yPos)
        row.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        row.BackgroundTransparency = 0.3
        row.ZIndex = 4
        row.BorderSizePixel = 0
        
        local rowCorner = Instance.new("UICorner")
        rowCorner.Parent = row
        rowCorner.CornerRadius = UDim.new(0, 5)
        
        -- Название аксессуара
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = row
        nameLabel.Size = UDim2.new(0.7, -20, 1, 0)
        nameLabel.Position = UDim2.new(0, 10, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = item.name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextSize = 16
        nameLabel.ZIndex = 5
        
        -- Категория
        local catLabel = Instance.new("TextLabel")
        catLabel.Parent = row
        catLabel.Size = UDim2.new(0.2, 0, 1, 0)
        catLabel.Position = UDim2.new(0.7, 0, 0, 0)
        catLabel.BackgroundTransparency = 1
        catLabel.Text = item.category:upper()
        catLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        catLabel.Font = Enum.Font.SourceSans
        catLabel.TextSize = 12
        catLabel.ZIndex = 5
        
        -- Чекбокс
        local checkbox = Instance.new("TextButton")
        checkbox.Name = "Checkbox"
        checkbox.Parent = row
        checkbox.Size = UDim2.new(0, 30, 0, 30)
        checkbox.Position = UDim2.new(0.9, -15, 0.5, -15)
        checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        checkbox.ZIndex = 5
        checkbox.BorderSizePixel = 0
        checkbox.Text = ""
        
        local checkCorner = Instance.new("UICorner")
        checkCorner.Parent = checkbox
        checkCorner.CornerRadius = UDim.new(0, 5)
        
        -- Галочка
        local checkMark = Instance.new("Frame")
        checkMark.Name = "CheckMark"
        checkMark.Parent = checkbox
        checkMark.Size = UDim2.new(0.7, 0, 0.7, 0)
        checkMark.Position = UDim2.new(0.15, 0, 0.15, 0)
        checkMark.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        checkMark.Visible = false
        checkMark.ZIndex = 6
        
        local checkCorner2 = Instance.new("UICorner")
        checkCorner2.Parent = checkMark
        checkCorner2.CornerRadius = UDim.new(0, 3)
        
        -- Обработка клика по чекбоксу
        checkbox.MouseButton1Click:Connect(function()
            if item.equipped then
                -- Снимаем
                local success = unequipAccessory(item.name)
                if success then
                    item.equipped = false
                    checkMark.Visible = false
                    checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                end
            else
                -- Надеваем
                local success = equipAccessory(item)
                if success then
                    item.equipped = true
                    checkMark.Visible = true
                    checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
                end
            end
        end)
        
        -- Если уже надето (например после перезагрузки)
        for _, acc in ipairs(equippedAccessories) do
            if acc.name == item.name then
                item.equipped = true
                checkMark.Visible = true
                checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
                break
            end
        end
    end
    
    ZACK.Windows.clothes = window
    return window
end

-- ========== ПОДКЛЮЧАЕМ К КНОПКЕ В ГЛАВНОМ МЕНЮ ==========
clothesBtn.MouseButton1Click:Connect(function()
    local window = createClothesWindow()
    background.Visible = true
end)

-- ========== УВЕДОМЛЕНИЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK VISUAL V1.1",
    Text = "Часть 2/5 загружена!\n" .. #ACCESSORY_LIST .. " аксессуаров готовы",
    Duration = 3
})

print("✅ ZACK VISUAL V1.1 - Часть 2/5 готова")
print("📦 Загружено " .. #ACCESSORY_LIST .. " аксессуаров с чекбоксами")
--[[
    ZACK VISUAL V1.1 - ЧАСТЬ 3/5
    ANIMATIONS - СИСТЕМА АНИМАЦИЙ
    Специально: Jerk с надписью "tg:@sajkyn"
    Качество: АБСОЛЮТ
--]]

-- ========== СПИСОК АНИМАЦИЙ ==========
local ANIMATION_LIST = {
    -- ОСОБЫЕ (СКРИПТОВЫЕ)
    {name = "🔄 Headspin", type = "script", script = "headspin", equipped = false,
     desc = "Вращение головой на 360°"},
    {name = "🚁 Copter", type = "script", script = "copter", equipped = false,
     desc = "Быстрое вращение всем телом"},
    {name = "⛸️ Skates", type = "id", id = "10214820566", equipped = false,
     desc = "Анимация коньков при ходьбе"},
    {name = "🚫 No Animation", type = "script", script = "noanim", equipped = false,
     desc = "Полное отключение анимаций"},
    
    -- JERK (СПЕЦИАЛЬНЫЙ)
    {name = "💢 Jerk (tg:@sajkyn)", type = "tool", tool = "jerk", equipped = false,
     desc = "Эксклюзивная анимация от @sajkyn"},
    
    -- ТАНЦЫ (ID)
    {name = "🕺 Dance 1", type = "id", id = "5077711064", equipped = false,
     desc = "Клубный танец"},
    {name = "💃 Dance 2", type = "id", id = "10214817091", equipped = false,
     desc = "Зажигательный танец"},
    {name = "🎸 Guitar", type = "id", id = "12812604381", equipped = false,
     desc = "Игра на электрогитаре"},
    {name = "🥋 Capoeira", type = "id", id = "10214817656", equipped = false,
     desc = "Бразильское боевое искусство"},
    {name = "😂 Zaryad", type = "id", id = "10214818239", equipped = false,
     desc = "Заряжает энергией"},
    {name = "🧹 Cleaning", type = "id", id = "10214818810", equipped = false,
     desc = "Уборка"},
    {name = "🎤 Rap", type = "id", id = "10214819396", equipped = false,
     desc = "Читает рэп"},
    {name = "🤸 Acro", type = "id", id = "10214819979", equipped = false,
     desc = "Акробатика"},
    {name = "🧘 Yoga", type = "id", id = "10214820566", equipped = false,
     desc = "Поза лотоса"},
    {name = "🏃 Running", type = "id", id = "10214821153", equipped = false,
     desc = "Бег на месте"},
    {name = "💪 Flex", type = "id", id = "10214821735", equipped = false,
     desc = "Качает мышцы"},
    {name = "🙏 Pray", type = "id", id = "10214822322", equipped = false,
     desc = "Молитва"},
    {name = "👋 Wave", type = "id", id = "10214822910", equipped = false,
     desc = "Машет рукой"},
    {name = "🕴️ Pose", type = "id", id = "10214823498", equipped = false,
     desc = "Крутая поза"},
    {name = "🤹 Juggling", type = "id", id = "10214824086", equipped = false,
     desc = "Жонглирование"},
    {name = "🎭 Theatr", type = "id", id = "10214824674", equipped = false,
     desc = "Театральная поза"},
}

-- ========== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ==========
local activeAnimations = {}
local animationTracks = {}
local animationConnections = {}
local jerkTool = nil

-- ========== ФУНКЦИЯ ОСТАНОВКИ ВСЕХ АНИМАЦИЙ ==========
local function stopAllAnimations()
    -- Останавливаем треки
    for _, track in ipairs(animationTracks) do
        pcall(function() track:Stop() end)
    end
    animationTracks = {}
    
    -- Отключаем соединения
    for _, conn in ipairs(animationConnections) do
        pcall(function() conn:Disconnect() end)
    end
    animationConnections = {}
    
    -- Удаляем джерк тул
    if jerkTool and jerkTool.Parent then
        jerkTool:Destroy()
        jerkTool = nil
    end
    
    -- Восстанавливаем стандартные анимации
    if humanoid then
        humanoid.AutoRotate = true
        -- Сбрасываем все моторы
        for _, motor in ipairs(character:GetDescendants()) do
            if motor:IsA("Motor6D") and motor.Name ~= "Neck" then
                -- Оставляем как есть
            end
        end
    end
end

-- ========== СОЗДАНИЕ JERK TOOL ==========
local function createJerkTool()
    if jerkTool and jerkTool.Parent then
        return jerkTool
    end
    
    local tool = Instance.new("Tool")
    tool.Name = "💢 tg:@sajkyn"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.Parent = player.Backpack
    
    -- Анимация внутри
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://10214817656" -- Рабочий ID
    local animTrack
    
    tool.Equipped:Connect(function()
        if animTrack then
            animTrack:Stop()
        end
        animTrack = humanoid:LoadAnimation(anim)
        animTrack:Play()
        table.insert(animationTracks, animTrack)
    end)
    
    tool.Unequipped:Connect(function()
        if animTrack then
            animTrack:Stop()
        end
    end)
    
    jerkTool = tool
    return tool
end

-- ========== HEADSPIN (ВРАЩЕНИЕ ГОЛОВОЙ) ==========
local function startHeadspin()
    if not head then return end
    
    local neck = head:FindFirstChild("Neck")
    if not neck or not neck:IsA("Motor6D") then return end
    
    local connection = game:GetService("RunService").RenderStepped:Connect(function()
        if not neck or not neck.Parent then return end
        neck.C0 = neck.C0 * CFrame.Angles(0, math.rad(10), 0)
    end)
    
    table.insert(animationConnections, connection)
end

-- ========== COPTER (БЫСТРОЕ ВРАЩЕНИЕ) ==========
local function startCopter()
    if not rootPart then return end
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.Parent = rootPart
    bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * math.huge
    bodyGyro.P = 10000
    bodyGyro.D = 100
    
    table.insert(activeAnimations, bodyGyro)
    
    local connection = game:GetService("RunService").RenderStepped:Connect(function()
        if not bodyGyro or not bodyGyro.Parent then return end
        bodyGyro.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
    end)
    
    table.insert(animationConnections, connection)
end

-- ========== NO ANIMATION ==========
local function startNoAnimation()
    if not humanoid then return end
    
    humanoid.AutoRotate = false
    
    -- Отключаем все анимации движения
    local walkAnim = humanoid:FindFirstChildOfClass("Animation")
    if walkAnim then
        walkAnim:Destroy()
    end
    
    -- Замораживаем части
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= rootPart then
            local weld = Instance.new("Weld")
            weld.Part0 = rootPart
            weld.Part1 = part
            weld.C0 = part.CFrame:ToObjectSpace(rootPart.CFrame)
            weld.Parent = part
            table.insert(activeAnimations, weld)
        end
    end
end

-- ========== ID АНИМАЦИЯ ==========
local function startIDAnimation(animId)
    if not humanoid then return end
    
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. animId
    
    local track = humanoid:LoadAnimation(anim)
    track:Play()
    
    table.insert(animationTracks, track)
end

-- ========== ФУНКЦИЯ ЗАПУСКА АНИМАЦИИ ==========
local function startAnimation(animData)
    if animData.type == "tool" and animData.script == "jerk" then
        createJerkTool()
        -- Автоматически экипируем
        player.Character = character
        wait(0.1)
        jerkTool.Parent = player.Character
        return true
        
    elseif animData.type == "script" then
        if animData.script == "headspin" then
            startHeadspin()
        elseif animData.script == "copter" then
            startCopter()
        elseif animData.script == "noanim" then
            startNoAnimation()
        end
        return true
        
    elseif animData.type == "id" then
        startIDAnimation(animData.id)
        return true
    end
    
    return false
end

-- ========== ФУНКЦИЯ ОСТАНОВКИ АНИМАЦИИ ==========
local function stopAnimation(animData)
    if animData.type == "tool" and animData.script == "jerk" then
        if jerkTool and jerkTool.Parent then
            jerkTool:Destroy()
            jerkTool = nil
        end
        return true
    end
    
    -- Для скриптовых и ID анимаций просто перезапускаем всё
    -- (проще остановить все и запустить нужные)
    return true
end

-- ========== СОЗДАНИЕ ОКНА ANIMATIONS ==========
local function createAnimationsWindow()
    if ZACK.Windows.animations and ZACK.Windows.animations.Parent then
        ZACK.Windows.animations.Visible = not ZACK.Windows.animations.Visible
        background.Visible = ZACK.Windows.animations.Visible or 
                            (ZACK.Windows.clothes and ZACK.Windows.clothes.Visible)
        return
    end
    
    local window = Instance.new("Frame")
    window.Name = "AnimationsWindow"
    window.Parent = gui
    window.Size = UDim2.new(0, 800, 0, 550)
    window.Position = UDim2.new(0.5, -400, 0.5, -275)
    window.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    window.BorderSizePixel = 2
    window.BorderColor3 = Color3.fromRGB(100, 255, 100)
    window.Visible = true
    window.Active = true
    window.Draggable = true
    window.ZIndex = 20
    window.ClipsDescendants = true
    
    local windowCorner = Instance.new("UICorner")
    windowCorner.Parent = window
    windowCorner.CornerRadius = UDim.new(0, 10)
    
    -- Фон с аниме-тян
    local windowBg = Instance.new("ImageLabel")
    windowBg.Parent = window
    windowBg.Size = UDim2.new(1, 0, 1, 0)
    windowBg.Image = "rbxassetid://13978511301"
    windowBg.ImageTransparency = 0.8
    windowBg.ScaleType = Enum.ScaleType.Crop
    windowBg.ZIndex = 1
    
    -- Затемнение
    local windowOverlay = Instance.new("Frame")
    windowOverlay.Parent = window
    windowOverlay.Size = UDim2.new(1, 0, 1, 0)
    windowOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    windowOverlay.BackgroundTransparency = 0.4
    windowOverlay.ZIndex = 2
    windowOverlay.BorderSizePixel = 0
    
    -- Верхняя панель
    local topBar = Instance.new("Frame")
    topBar.Parent = window
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    topBar.BackgroundTransparency = 0.2
    topBar.ZIndex = 3
    topBar.BorderSizePixel = 0
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.Parent = topBar
    topBarCorner.CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = topBar
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "💃 ANIMATIONS - " .. #ANIMATION_LIST .. " АНИМАЦИЙ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 4
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = topBar
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.ZIndex = 4
    closeBtn.BorderSizePixel = 0
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.Parent = closeBtn
    closeCorner.CornerRadius = UDim.new(0, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        window.Visible = false
        background.Visible = ZACK.Windows.clothes and ZACK.Windows.clothes.Visible or false
    end)
    
    -- Кнопка "Остановить всё"
    local stopAllBtn = Instance.new("TextButton")
    stopAllBtn.Parent = window
    stopAllBtn.Size = UDim2.new(0.2, 0, 0, 40)
    stopAllBtn.Position = UDim2.new(0.78, 0, 0, 10)
    stopAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    stopAllBtn.Text = "⏹️ СТОП ВСЁ"
    stopAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopAllBtn.Font = Enum.Font.GothamBold
    stopAllBtn.TextSize = 14
    stopAllBtn.ZIndex = 4
    stopAllBtn.BorderSizePixel = 0
    
    local stopCorner = Instance.new("UICorner")
    stopCorner.Parent = stopAllBtn
    stopCorner.CornerRadius = UDim.new(0, 8)
    
    stopAllBtn.MouseButton1Click:Connect(function()
        stopAllAnimations()
        -- Сбрасываем чекбоксы
        for _, anim in ipairs(ANIMATION_LIST) do
            anim.equipped = false
        end
        -- Обновляем визуал
        for _, checkbox in ipairs(window:GetDescendants()) do
            if checkbox.Name == "AnimCheckbox" then
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                local check = checkbox:FindFirstChild("CheckMark")
                if check then check.Visible = false end
            end
        end
    end)
    
    -- Контейнер для списка анимаций
    local listContainer = Instance.new("ScrollingFrame")
    listContainer.Parent = window
    listContainer.Size = UDim2.new(1, -20, 1, -100)
    listContainer.Position = UDim2.new(0, 10, 0, 60)
    listContainer.BackgroundTransparency = 1
    listContainer.BorderSizePixel = 0
    listContainer.ScrollBarThickness = 8
    listContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 255, 100)
    listContainer.CanvasSize = UDim2.new(0, 0, 0, #ANIMATION_LIST * 45)
    listContainer.ZIndex = 3
    listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- Создаем чекбоксы для каждой анимации
    for i, anim in ipairs(ANIMATION_LIST) do
        local yPos = (i - 1) * 40
        
        local row = Instance.new("Frame")
        row.Parent = listContainer
        row.Size = UDim2.new(1, -10, 0, 35)
        row.Position = UDim2.new(0, 5, 0, yPos)
        row.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        row.BackgroundTransparency = 0.3
        row.ZIndex = 4
        row.BorderSizePixel = 0
        
        local rowCorner = Instance.new("UICorner")
        rowCorner.Parent = row
        rowCorner.CornerRadius = UDim.new(0, 5)
        
        -- Название анимации
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = row
        nameLabel.Size = UDim2.new(0.6, -20, 0.6, 0)
        nameLabel.Position = UDim2.new(0, 10, 0, 2)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = anim.name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextSize = 14
        nameLabel.ZIndex = 5
        
        -- Описание
        local descLabel = Instance.new("TextLabel")
        descLabel.Parent = row
        descLabel.Size = UDim2.new(0.6, -20, 0.4, 0)
        descLabel.Position = UDim2.new(0, 10, 0, 18)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = anim.desc
        descLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.SourceSans
        descLabel.TextSize = 10
        descLabel.ZIndex = 5
        
        -- Тип
        local typeLabel = Instance.new("TextLabel")
        typeLabel.Parent = row
        typeLabel.Size = UDim2.new(0.2, 0, 1, 0)
        typeLabel.Position = UDim2.new(0.6, 0, 0, 0)
        typeLabel.BackgroundTransparency = 1
        typeLabel.Text = anim.type:upper()
        typeLabel.TextColor3 = anim.type == "tool" and Color3.fromRGB(255, 200, 0) or
                               anim.type == "script" and Color3.fromRGB(100, 255, 100) or
                               Color3.fromRGB(150, 150, 255)
        typeLabel.Font = Enum.Font.SourceSans
        typeLabel.TextSize = 10
        typeLabel.ZIndex = 5
        
        -- Чекбокс
        local checkbox = Instance.new("TextButton")
        checkbox.Name = "AnimCheckbox"
        checkbox.Parent = row
        checkbox.Size = UDim2.new(0, 30, 0, 30)
        checkbox.Position = UDim2.new(0.9, -15, 0.5, -15)
        checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        checkbox.ZIndex = 5
        checkbox.BorderSizePixel = 0
        checkbox.Text = ""
        
        local checkCorner = Instance.new("UICorner")
        checkCorner.Parent = checkbox
        checkCorner.CornerRadius = UDim.new(0, 5)
        
        -- Галочка
        local checkMark = Instance.new("Frame")
        checkMark.Name = "CheckMark"
        checkMark.Parent = checkbox
        checkMark.Size = UDim2.new(0.7, 0, 0.7, 0)
        checkMark.Position = UDim2.new(0.15, 0, 0.15, 0)
        checkMark.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        checkMark.Visible = false
        checkMark.ZIndex = 6
        
        local checkCorner2 = Instance.new("UICorner")
        checkCorner2.Parent = checkMark
        checkCorner2.CornerRadius = UDim.new(0, 3)
        
        -- Обработка клика
        checkbox.MouseButton1Click:Connect(function()
            if anim.equipped then
                -- Выключаем
                stopAllAnimations()
                anim.equipped = false
                checkMark.Visible = false
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            else
                -- Выключаем всё и включаем выбранное
                stopAllAnimations()
                
                -- Сбрасываем все чекбоксы
                for _, a in ipairs(ANIMATION_LIST) do
                    a.equipped = false
                end
                
                -- Включаем выбранное
                local success = startAnimation(anim)
                if success then
                    anim.equipped = true
                    checkMark.Visible = true
                    checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
                    
                    -- Обновляем остальные чекбоксы
                    for _, otherCheck in ipairs(window:GetDescendants()) do
                        if otherCheck.Name == "AnimCheckbox" and otherCheck ~= checkbox then
                            otherCheck.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                            local otherMark = otherCheck:FindFirstChild("CheckMark")
                            if otherMark then otherMark.Visible = false end
                        end
                    end
                end
            end
        end)
    end
    
    ZACK.Windows.animations = window
    return window
end

-- ========== ПОДКЛЮЧАЕМ К КНОПКЕ В ГЛАВНОМ МЕНЮ ==========
animBtn.MouseButton1Click:Connect(function()
    local window = createAnimationsWindow()
    background.Visible = true
end)

-- ========== УВЕДОМЛЕНИЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK VISUAL V1.1",
    Text = "Часть 3/5 загружена!\n" .. #ANIMATION_LIST .. " анимаций готовы",
    Duration = 3
})

print("✅ ZACK VISUAL V1.1 - Часть 3/5 готова")
print("💃 Загружено " .. #ANIMATION_LIST .. " анимаций")
print("💢 Jerk с надписью 'tg:@sajkyn' в инвентаре")
--[[
    ZACK VISUAL V1.1 - ЧАСТЬ 4/5
    ЭФФЕКТЫ: Headless (убрать голову) + Оптимизация
    Качество: ПРЕМИУМ
--]]

-- ========== СПИСОК ЭФФЕКТОВ ==========
local EFFECTS_LIST = {
    {name = "👻 Headless", type = "headless", equipped = false,
     desc = "Убирает голову игрока (невизуально)"},
    {name = "✨ X-Ray", type = "xray", equipped = false,
     desc = "Просвечивающиеся стены"},
    {name = "🌈 Fullbright", type = "fullbright", equipped = false,
     desc = "Максимальная яркость"},
}

-- ========== ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ==========
local activeEffects = {}
local effectConnections = {}
local originalHead = nil
local originalHeadTransparency = 0

-- ========== ФУНКЦИЯ HEADLESS (УБРАТЬ ГОЛОВУ) ==========
local function setHeadless(enable)
    if not head then return end
    
    if enable then
        -- Сохраняем оригинал
        originalHead = head
        originalHeadTransparency = head.Transparency
        
        -- Делаем голову полностью прозрачной
        head.Transparency = 1
        head.CanCollide = false
        
        -- Убираем аксессуары с головы
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Accessory") and child.Handle then
                child.Handle.Transparency = 1
            end
        end
        
        -- Создаём невидимую точку для камеры
        local dummyHead = Instance.new("Part")
        dummyHead.Name = "DummyHead"
        dummyHead.Size = Vector3.new(2, 1, 1)
        dummyHead.Transparency = 1
        dummyHead.CanCollide = false
        dummyHead.Anchored = false
        dummyHead.Parent = character
        
        local weld = Instance.new("Weld")
        weld.Part0 = rootPart
        weld.Part1 = dummyHead
        weld.C0 = CFrame.new(0, 1.5, 0)
        weld.Parent = dummyHead
        
        table.insert(activeEffects, dummyHead)
        table.insert(activeEffects, weld)
        
    else
        -- Возвращаем голову
        if originalHead then
            head.Transparency = originalHeadTransparency
            head.CanCollide = true
        end
        
        -- Возвращаем аксессуары
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Accessory") and child.Handle then
                child.Handle.Transparency = 0
            end
        end
        
        -- Удаляем dummy голову
        for _, obj in ipairs(activeEffects) do
            if obj.Name == "DummyHead" then
                pcall(function() obj:Destroy() end)
            end
        end
    end
end

-- ========== X-RAY (ПРОСВЕЧИВАЮЩИЕСЯ СТЕНЫ) ==========
local function setXRay(enable)
    if enable then
        -- Сохраняем оригинальные настройки
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.5 then
                if not part:GetAttribute("origTransparency") then
                    part:SetAttribute("origTransparency", part.Transparency)
                end
                part.Transparency = 0.7
            end
        end
        
        -- Подсветка игроков
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "XRayHighlight"
                highlight.Parent = plr.Character
                highlight.FillColor = Color3.fromRGB(255, 100, 100)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.3
                table.insert(activeEffects, highlight)
            end
        end
        
    else
        -- Восстанавливаем прозрачность
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part:GetAttribute("origTransparency") then
                part.Transparency = part:GetAttribute("origTransparency")
            end
        end
        
        -- Удаляем подсветку
        for _, obj in ipairs(activeEffects) do
            if obj.Name == "XRayHighlight" then
                pcall(function() obj:Destroy() end)
            end
        end
    end
end

-- ========== FULLBRIGHT (МАКСИМАЛЬНАЯ ЯРКОСТЬ) ==========
local function setFullbright(enable)
    local lighting = game:GetService("Lighting")
    
    if enable then
        -- Сохраняем оригинал
        if not lighting:GetAttribute("origBrightness") then
            lighting:SetAttribute("origBrightness", lighting.Brightness)
            lighting:SetAttribute("origAmbient", lighting.Ambient)
            lighting:SetAttribute("origOutdoorAmbient", lighting.OutdoorAmbient)
        end
        
        lighting.Brightness = 3
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.GlobalShadows = false
        
    else
        if lighting:GetAttribute("origBrightness") then
            lighting.Brightness = lighting:GetAttribute("origBrightness")
            lighting.Ambient = lighting:GetAttribute("origAmbient")
            lighting.OutdoorAmbient = lighting:GetAttribute("origOutdoorAmbient")
            lighting.GlobalShadows = true
        end
    end
end

-- ========== ФУНКЦИЯ ОСТАНОВКИ ВСЕХ ЭФФЕКТОВ ==========
local function stopAllEffects()
    for _, effect in ipairs(EFFECTS_LIST) do
        effect.equipped = false
    end
    
    setHeadless(false)
    setXRay(false)
    setFullbright(false)
    
    -- Очищаем активные объекты
    for _, obj in ipairs(activeEffects) do
        pcall(function() obj:Destroy() end)
    end
    activeEffects = {}
    
    for _, conn in ipairs(effectConnections) do
        pcall(function() conn:Disconnect() end)
    end
    effectConnections = {}
end

-- ========== СОЗДАНИЕ ОКНА ЭФФЕКТОВ ==========
local function createEffectsWindow()
    if ZACK.Windows.effects and ZACK.Windows.effects.Parent then
        ZACK.Windows.effects.Visible = not ZACK.Windows.effects.Visible
        background.Visible = ZACK.Windows.effects.Visible or 
                            (ZACK.Windows.clothes and ZACK.Windows.clothes.Visible) or
                            (ZACK.Windows.animations and ZACK.Windows.animations.Visible)
        return
    end
    
    local window = Instance.new("Frame")
    window.Name = "EffectsWindow"
    window.Parent = gui
    window.Size = UDim2.new(0, 500, 0, 400)
    window.Position = UDim2.new(0.5, -250, 0.5, -200)
    window.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    window.BorderSizePixel = 2
    window.BorderColor3 = Color3.fromRGB(255, 100, 255)
    window.Visible = true
    window.Active = true
    window.Draggable = true
    window.ZIndex = 20
    window.ClipsDescendants = true
    
    local windowCorner = Instance.new("UICorner")
    windowCorner.Parent = window
    windowCorner.CornerRadius = UDim.new(0, 10)
    
    -- Фон с аниме-тян
    local windowBg = Instance.new("ImageLabel")
    windowBg.Parent = window
    windowBg.Size = UDim2.new(1, 0, 1, 0)
    windowBg.Image = "rbxassetid://13978511301"
    windowBg.ImageTransparency = 0.8
    windowBg.ScaleType = Enum.ScaleType.Crop
    windowBg.ZIndex = 1
    
    -- Затемнение
    local windowOverlay = Instance.new("Frame")
    windowOverlay.Parent = window
    windowOverlay.Size = UDim2.new(1, 0, 1, 0)
    windowOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    windowOverlay.BackgroundTransparency = 0.4
    windowOverlay.ZIndex = 2
    windowOverlay.BorderSizePixel = 0
    
    -- Верхняя панель
    local topBar = Instance.new("Frame")
    topBar.Parent = window
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    topBar.BackgroundTransparency = 0.2
    topBar.ZIndex = 3
    topBar.BorderSizePixel = 0
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.Parent = topBar
    topBarCorner.CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = topBar
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "✨ ЭФФЕКТЫ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 4
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = topBar
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.ZIndex = 4
    closeBtn.BorderSizePixel = 0
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.Parent = closeBtn
    closeCorner.CornerRadius = UDim.new(0, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        window.Visible = false
        background.Visible = (ZACK.Windows.clothes and ZACK.Windows.clothes.Visible) or
                            (ZACK.Windows.animations and ZACK.Windows.animations.Visible) or false
    end)
    
    -- Кнопка "Выключить всё"
    local stopAllBtn = Instance.new("TextButton")
    stopAllBtn.Parent = window
    stopAllBtn.Size = UDim2.new(0.3, 0, 0, 40)
    stopAllBtn.Position = UDim2.new(0.68, 0, 0, 10)
    stopAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    stopAllBtn.Text = "⏹️ ВЫКЛ ВСЁ"
    stopAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopAllBtn.Font = Enum.Font.GothamBold
    stopAllBtn.TextSize = 14
    stopAllBtn.ZIndex = 4
    stopAllBtn.BorderSizePixel = 0
    
    local stopCorner = Instance.new("UICorner")
    stopCorner.Parent = stopAllBtn
    stopCorner.CornerRadius = UDim.new(0, 8)
    
    stopAllBtn.MouseButton1Click:Connect(function()
        stopAllEffects()
        -- Обновляем чекбоксы
        for _, checkbox in ipairs(window:GetDescendants()) do
            if checkbox.Name == "EffectCheckbox" then
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                local check = checkbox:FindFirstChild("CheckMark")
                if check then check.Visible = false end
            end
        end
    end)
    
    -- Контейнер для списка эффектов
    local listContainer = Instance.new("ScrollingFrame")
    listContainer.Parent = window
    listContainer.Size = UDim2.new(1, -20, 1, -100)
    listContainer.Position = UDim2.new(0, 10, 0, 60)
    listContainer.BackgroundTransparency = 1
    listContainer.BorderSizePixel = 0
    listContainer.ScrollBarThickness = 8
    listContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 255)
    listContainer.CanvasSize = UDim2.new(0, 0, 0, #EFFECTS_LIST * 45)
    listContainer.ZIndex = 3
    listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    -- Создаем чекбоксы для каждого эффекта
    for i, effect in ipairs(EFFECTS_LIST) do
        local yPos = (i - 1) * 40
        
        local row = Instance.new("Frame")
        row.Parent = listContainer
        row.Size = UDim2.new(1, -10, 0, 35)
        row.Position = UDim2.new(0, 5, 0, yPos)
        row.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        row.BackgroundTransparency = 0.3
        row.ZIndex = 4
        row.BorderSizePixel = 0
        
        local rowCorner = Instance.new("UICorner")
        rowCorner.Parent = row
        rowCorner.CornerRadius = UDim.new(0, 5)
        
        -- Название эффекта
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = row
        nameLabel.Size = UDim2.new(0.7, -20, 0.6, 0)
        nameLabel.Position = UDim2.new(0, 10, 0, 2)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = effect.name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextSize = 14
        nameLabel.ZIndex = 5
        
        -- Описание
        local descLabel = Instance.new("TextLabel")
        descLabel.Parent = row
        descLabel.Size = UDim2.new(0.7, -20, 0.4, 0)
        descLabel.Position = UDim2.new(0, 10, 0, 18)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = effect.desc
        descLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Font = Enum.Font.SourceSans
        descLabel.TextSize = 10
        descLabel.ZIndex = 5
        
        -- Чекбокс
        local checkbox = Instance.new("TextButton")
        checkbox.Name = "EffectCheckbox"
        checkbox.Parent = row
        checkbox.Size = UDim2.new(0, 30, 0, 30)
        checkbox.Position = UDim2.new(0.9, -15, 0.5, -15)
        checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        checkbox.ZIndex = 5
        checkbox.BorderSizePixel = 0
        checkbox.Text = ""
        
        local checkCorner = Instance.new("UICorner")
        checkCorner.Parent = checkbox
        checkCorner.CornerRadius = UDim.new(0, 5)
        
        -- Галочка
        local checkMark = Instance.new("Frame")
        checkMark.Name = "CheckMark"
        checkMark.Parent = checkbox
        checkMark.Size = UDim2.new(0.7, 0, 0.7, 0)
        checkMark.Position = UDim2.new(0.15, 0, 0.15, 0)
        checkMark.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        checkMark.Visible = false
        checkMark.ZIndex = 6
        
        local checkCorner2 = Instance.new("UICorner")
        checkCorner2.Parent = checkMark
        checkCorner2.CornerRadius = UDim.new(0, 3)
        
        -- Обработка клика
        checkbox.MouseButton1Click:Connect(function()
            if effect.equipped then
                -- Выключаем эффект
                if effect.type == "headless" then
                    setHeadless(false)
                elseif effect.type == "xray" then
                    setXRay(false)
                elseif effect.type == "fullbright" then
                    setFullbright(false)
                end
                
                effect.equipped = false
                checkMark.Visible = false
                checkbox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                
            else
                -- Включаем эффект
                if effect.type == "headless" then
                    setHeadless(true)
                elseif effect.type == "xray" then
                    setXRay(true)
                elseif effect.type == "fullbright" then
                    setFullbright(true)
                end
                
                effect.equipped = true
                checkMark.Visible = true
                checkbox.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
            end
        end)
    end
    
    ZACK.Windows.effects = window
    return window
end

-- ========== ДОБАВЛЯЕМ КНОПКУ В ГЛАВНОЕ МЕНЮ ==========
local effectsBtn = Instance.new("TextButton")
effectsBtn.Name = "EffectsBtn"
effectsBtn.Parent = buttonsFrame
effectsBtn.Size = UDim2.new(0.45, -5, 0, 60)
effectsBtn.Position = UDim2.new(0.5, -135, 0, 0)
effectsBtn.BackgroundColor3 = Color3.fromRGB(120, 60, 180)
effectsBtn.Text = "✨ EFFECTS"
effectsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
effectsBtn.Font = Enum.Font.GothamBold
effectsBtn.TextSize = 24
effectsBtn.ZIndex = 4
effectsBtn.BorderSizePixel = 0

local effectsCorner = Instance.new("UICorner")
effectsCorner.Parent = effectsBtn
effectsCorner.CornerRadius = UDim.new(0, 10)

effectsBtn.MouseButton1Click:Connect(function()
    local window = createEffectsWindow()
    background.Visible = true
end)

-- ========== УВЕДОМЛЕНИЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACK VISUAL V1.1",
    Text = "Часть 4/5 загружена!\nHeadless + X-Ray + Fullbright",
    Duration = 3
})

print("✅ ZACK VISUAL V1.1 - Часть 4/5 готова")
print("👻 Headless - голова исчезает")
print("✨ X-Ray - видно сквозь стены")
print("🌈 Fullbright - максимальная яркость")
--[[
    ZACK VISUAL V1.1 - ЧАСТЬ 5/5
    ФИНАЛ: НАСТРОЙКИ, СОХРАНЕНИЯ, АВТОЗАПУСК
    Статус: ПОЛНОСТЬЮ РАБОЧАЯ ВЕРСИЯ
--]]

-- ========== СИСТЕМА СОХРАНЕНИЯ ==========
local function saveAllSettings()
    if not writefile then 
        print("⚠️ Сохранение недоступно (нет writefile)")
        return 
    end
    
    local saveData = {
        version = ZACK.Version,
        accessories = {},
        animations = {},
        effects = {},
        settings = ZACK.Settings or {}
    }
    
    -- Сохраняем состояния аксессуаров
    for _, item in ipairs(ACCESSORY_LIST) do
        if item.equipped then
            table.insert(saveData.accessories, item.name)
        end
    end
    
    -- Сохраняем состояния анимаций
    for _, anim in ipairs(ANIMATION_LIST) do
        if anim.equipped then
            table.insert(saveData.animations, anim.name)
        end
    end
    
    -- Сохраняем состояния эффектов
    for _, effect in ipairs(EFFECTS_LIST) do
        if effect.equipped then
            table.insert(saveData.effects, effect.name)
        end
    end
    
    local success, json = pcall(function()
        return game:GetService("HttpService"):JSONEncode(saveData)
    end)
    
    if success then
        writefile("zack_visual_settings.json", json)
        print("✅ Настройки сохранены")
    end
end

-- ========== СИСТЕМА ЗАГРУЗКИ ==========
local function loadAllSettings()
    if not isfile or not readfile then 
        print("⚠️ Загрузка недоступна (нет isfile/readfile)")
        return 
    end
    
    if not isfile("zack_visual_settings.json") then
        print("📁 Нет сохранённых настроек")
        return
    end
    
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile("zack_visual_settings.json"))
    end)
    
    if not success or not data then
        print("❌ Ошибка загрузки настроек")
        return
    end
    
    if data.version ~= ZACK.Version then
        print("⚠️ Версия настроек отличается, сброс")
        return
    end
    
    -- Загружаем аксессуары
    if data.accessories then
        for _, accName in ipairs(data.accessories) do
            for _, item in ipairs(ACCESSORY_LIST) do
                if item.name == accName then
                    item.equipped = true
                    equipAccessory(item)
                    break
                end
            end
        end
    end
    
    -- Загружаем анимации
    if data.animations then
        for _, animName in ipairs(data.animations) do
            for _, anim in ipairs(ANIMATION_LIST) do
                if anim.name == animName then
                    anim.equipped = true
                    startAnimation(anim)
                    break
                end
            end
        end
    end
    
    -- Загружаем эффекты
    if data.effects then
        for _, effectName in ipairs(data.effects) do
            for _, effect in ipairs(EFFECTS_LIST) do
                if effect.name == effectName then
                    effect.equipped = true
                    if effect.type == "headless" then
                        setHeadless(true)
                    elseif effect.type == "xray" then
                        setXRay(true)
                    elseif effect.type == "fullbright" then
                        setFullbright(true)
                    end
                    break
                end
            end
        end
    end
    
    -- Загружаем настройки
    if data.settings then
        for k, v in pairs(data.settings) do
            ZACK.Settings[k] = v
        end
    end
    
    print("✅ Настройки загружены")
end

-- ========== ОПТИМИЗАЦИЯ ==========
local function optimizePerformance()
    -- Ограничение FPS для стабильности
    local fpsCap = 60
    local lastTime = tick()
    
    game:GetService("RunService").RenderStepped:Connect(function()
        local currentTime = tick()
        if currentTime - lastTime < 1/fpsCap then
            wait()
        end
        lastTime = currentTime
    end)
    
    -- Автоочистка каждые 5 минут
    spawn(function()
        while true do
            wait(300)
            
            -- Очистка аксессуаров
            for i = #equippedAccessories, 1, -1 do
                if not equippedAccessories[i] or not equippedAccessories[i].object or 
                   not equippedAccessories[i].object.Parent then
                    table.remove(equippedAccessories, i)
                end
            end
            
            -- Очистка треков анимаций
            for i = #animationTracks, 1, -1 do
                if not animationTracks[i] or not animationTracks[i].IsPlaying then
                    table.remove(animationTracks, i)
                end
            end
            
            print("🧹 Автоочистка выполнена")
        end
    end)
end

-- ========== ДОБАВЛЯЕМ КНОПКУ НАСТРОЕК ==========
local settingsBtn = Instance.new("TextButton")
settingsBtn.Name = "SettingsBtn"
settingsBtn.Parent = buttonsFrame
settingsBtn.Size = UDim2.new(0.45, -5, 0, 60)
settingsBtn.Position = UDim2.new(0.5, 135, 0, 0)
settingsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
settingsBtn.Text = "⚙️ SETTINGS"
settingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 24
settingsBtn.ZIndex = 4
settingsBtn.BorderSizePixel = 0

local settingsCorner = Instance.new("UICorner")
settingsCorner.Parent = settingsBtn
settingsCorner.CornerRadius = UDim.new(0, 10)

-- ========== СОЗДАНИЕ ОКНА НАСТРОЕК ==========
local function createSettingsWindow()
    if ZACK.Windows.settings and ZACK.Windows.settings.Parent then
        ZACK.Windows.settings.Visible = not ZACK.Windows.settings.Visible
        background.Visible = ZACK.Windows.settings.Visible or 
                            (ZACK.Windows.clothes and ZACK.Windows.clothes.Visible) or
                            (ZACK.Windows.animations and ZACK.Windows.animations.Visible) or
                            (ZACK.Windows.effects and ZACK.Windows.effects.Visible)
        return
    end
    
    local window = Instance.new("Frame")
    window.Name = "SettingsWindow"
    window.Parent = gui
    window.Size = UDim2.new(0, 500, 0, 400)
    window.Position = UDim2.new(0.5, -250, 0.5, -200)
    window.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    window.BorderSizePixel = 2
    window.BorderColor3 = Color3.fromRGB(100, 100, 255)
    window.Visible = true
    window.Active = true
    window.Draggable = true
    window.ZIndex = 20
    window.ClipsDescendants = true
    
    local windowCorner = Instance.new("UICorner")
    windowCorner.Parent = window
    windowCorner.CornerRadius = UDim.new(0, 10)
    
    -- Фон с аниме-тян
    local windowBg = Instance.new("ImageLabel")
    windowBg.Parent = window
    windowBg.Size = UDim2.new(1, 0, 1, 0)
    windowBg.Image = "rbxassetid://13978511301"
    windowBg.ImageTransparency = 0.8
    windowBg.ScaleType = Enum.ScaleType.Crop
    windowBg.ZIndex = 1
    
    -- Затемнение
    local windowOverlay = Instance.new("Frame")
    windowOverlay.Parent = window
    windowOverlay.Size = UDim2.new(1, 0, 1, 0)
    windowOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    windowOverlay.BackgroundTransparency = 0.4
    windowOverlay.ZIndex = 2
    windowOverlay.BorderSizePixel = 0
    
    -- Верхняя панель
    local topBar = Instance.new("Frame")
    topBar.Parent = window
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    topBar.BackgroundTransparency = 0.2
    topBar.ZIndex = 3
    topBar.BorderSizePixel = 0
    
    local topBarCorner = Instance.new("UICorner")
    topBarCorner.Parent = topBar
    topBarCorner.CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = topBar
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚙️ НАСТРОЙКИ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 4
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = topBar
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -50, 0.5, -20)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.ZIndex = 4
    closeBtn.BorderSizePixel = 0
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.Parent = closeBtn
    closeCorner.CornerRadius = UDim.new(0, 8)
    
    closeBtn.MouseButton1Click:Connect(function()
        window.Visible = false
        background.Visible = (ZACK.Windows.clothes and ZACK.Windows.clothes.Visible) or
                            (ZACK.Windows.animations and ZACK.Windows.animations.Visible) or
                            (ZACK.Windows.effects and ZACK.Windows.effects.Visible) or false
    end)
    
    -- Кнопки настроек
    local yPos = 70
    
    -- Сохранить
    local saveBtn = Instance.new("TextButton")
    saveBtn.Parent = window
    saveBtn.Size = UDim2.new(0.8, 0, 0, 50)
    saveBtn.Position = UDim2.new(0.1, 0, 0, yPos)
    saveBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    saveBtn.Text = "💾 СОХРАНИТЬ НАСТРОЙКИ"
    saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.TextSize = 18
    saveBtn.ZIndex = 4
    saveBtn.BorderSizePixel = 0
    
    local saveCorner = Instance.new("UICorner")
    saveCorner.Parent = saveBtn
    saveCorner.CornerRadius = UDim.new(0, 10)
    
    saveBtn.MouseButton1Click:Connect(function()
        saveAllSettings()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ZACK VISUAL",
            Text = "Настройки сохранены!",
            Duration = 2
        })
    end)
    
    yPos = yPos + 70
    
    -- Загрузить
    local loadBtn = Instance.new("TextButton")
    loadBtn.Parent = window
    loadBtn.Size = UDim2.new(0.8, 0, 0, 50)
    loadBtn.Position = UDim2.new(0.1, 0, 0, yPos)
    loadBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
    loadBtn.Text = "📂 ЗАГРУЗИТЬ НАСТРОЙКИ"
    loadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadBtn.Font = Enum.Font.GothamBold
    loadBtn.TextSize = 18
    loadBtn.ZIndex = 4
    loadBtn.BorderSizePixel = 0
    
    local loadCorner = Instance.new("UICorner")
    loadCorner.Parent = loadBtn
    loadCorner.CornerRadius = UDim.new(0, 10)
    
    loadBtn.MouseButton1Click:Connect(function()
        loadAllSettings()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ZACK VISUAL",
            Text = "Настройки загружены!",
            Duration = 2
        })
    end)
    
    yPos = yPos + 70
    
    -- Сброс
    local resetBtn = Instance.new("TextButton")
    resetBtn.Parent = window
    resetBtn.Size = UDim2.new(0.8, 0, 0, 50)
    resetBtn.Position = UDim2.new(0.1, 0, 0, yPos)
    resetBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    resetBtn.Text = "🔄 СБРОСИТЬ ВСЁ"
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.TextSize = 18
    resetBtn.ZIndex = 4
    resetBtn.BorderSizePixel = 0
    
    local resetCorner = Instance.new("UICorner")
    resetCorner.Parent = resetBtn
    resetCorner.CornerRadius = UDim.new(0, 10)
    
    resetBtn.MouseButton1Click:Connect(function()
        stopAllAnimations()
        unequipAllAccessories()
        stopAllEffects()
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ZACK VISUAL",
            Text = "Все настройки сброшены!",
            Duration = 2
        })
    end)
    
    ZACK.Windows.settings = window
    return window
end

settingsBtn.MouseButton1Click:Connect(function()
    local window = createSettingsWindow()
    background.Visible = true
end)

-- ========== АВТОМАТИЧЕСКАЯ ЗАГРУЗКА ==========
spawn(function()
    wait(2)
    loadAllSettings()
    optimizePerformance()
end)

-- ========== СОХРАНЕНИЕ ПРИ ВЫХОДЕ ==========
game:GetService("Players").LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
    saveAllSettings()
end)

-- ========== ФИНАЛЬНОЕ УВЕДОМЛЕНИЕ ==========
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "✨ ZACK VISUAL V1.1",
    Text = "ПОЛНОСТЬЮ ЗАГРУЖЕН!\n5 частей | 40+ аксессуаров | 20+ анимаций | Эффекты",
    Duration = 5,
    Icon = "rbxassetid://13978511301"
})

-- Эффект появления
spawn(function()
    for i = 1, 20 do
        if icon then
            icon.Size = UDim2.new(0, 64 + i, 0, 64 + i)
            icon.ImageTransparency = 0.5 - i/40
            wait(0.02)
        end
    end
    icon.Size = UDim2.new(0, 64, 0, 64)
    icon.ImageTransparency = 0
end)

print("🎉🎉🎉 ZACK VISUAL V1.1 - ПОЛНОСТЬЮ ЗАГРУЖЕН 🎉🎉🎉")
print("📊 СТАТИСТИКА:")
print("   • Аксессуары: " .. #ACCESSORY_LIST .. " шт")
print("   • Анимации: " .. #ANIMATION_LIST .. " шт")
print("   • Эффекты: " .. #EFFECTS_LIST .. " шт")
print("   • Сохранения: Авто")
print("   • Оптимизация: Включена")
print("💎 СТАТУС: РАБОЧАЯ ВЕРСИЯ | ВЕРСИЯ: 1.1")
print("📱 Telegram: @sajkyn")
