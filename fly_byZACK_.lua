--[[
    ███████╗ █████╗  ██████╗██╗  ██╗   ██╗
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝   ██║
      ███╔╝ ███████║██║     █████╔╝    ██║
     ███╔╝  ██╔══██║██║     ██╔═██╗    ██║
    ███████╗██║  ██║╚██████╗██║  ██╗   ██║
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝
    
    ██╗  ██╗██╗   ██╗██████╗ 
    ██║  ██║██║   ██║██╔══██╗
    ███████║██║   ██║██████╔╝
    ██╔══██║██║   ██║██╔══██╗
    ██║  ██║╚██████╔╝██████╔╝
    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
    
    TG: @sajkyn
    BUILD: HYDRA_V1
--]]

-- ОСНОВНОЙ GUI
local a = Instance.new("ScreenGui")
a.Name = "ZH"
a.Parent = game:GetService("CoreGui")
a.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
a.ResetOnSpawn = false
a.DisplayOrder = 999

-- ГЛАВНЫЙ ФРЕЙМ
local b = Instance.new("Frame")
b.Parent = a
b.BackgroundColor3 = Color3.fromRGB(3,3,3)
b.BackgroundTransparency = 0.05
b.BorderSizePixel = 3
b.BorderColor3 = Color3.fromRGB(255,255,255)
b.Position = UDim2.new(0.3,0,0.2,0)
b.Size = UDim2.new(0,550,0,400)
b.Active = true
b.Draggable = true

-- ЗАГОЛОВОК
local c = Instance.new("TextLabel")
c.Parent = b
c.BackgroundTransparency = 1
c.BorderSizePixel = 2
c.BorderColor3 = Color3.fromRGB(255,255,255)
c.Position = UDim2.new(0,15,0,10)
c.Size = UDim2.new(0,150,0,30)
c.Font = Enum.Font.GothamBold
c.Text = "ZACK_HUB"
c.TextColor3 = Color3.fromRGB(225,225,225)
c.TextScaled = true

-- КНОПКА ЗАКРЫТИЯ
local d = Instance.new("TextButton")
d.Parent = b
d.BackgroundTransparency = 1
d.BorderSizePixel = 2
d.BorderColor3 = Color3.fromRGB(255,255,255)
d.Size = UDim2.new(0,30,0,30)
d.Position = UDim2.new(1,-70,0,10)
d.Text = "X"
d.TextColor3 = Color3.fromRGB(225,225,225)
d.Font = Enum.Font.GothamBold
d.TextScaled = true

-- ТЕПЕРЬ ЗАГРУЗКА ОСНОВНОГО СКРИПТА С GITHUB
local success, result = pcall(function()
    local content = game:HttpGet("https://github.com/zackerr69/zack_hub/raw/main/universal_zack_Vglobal.lua")
    if content and #content > 100 then
        loadstring(content)()
    else
        warn("Ошибка загрузки: файл пустой")
    end
end)

if not success then
    warn("Не удалось загрузить основной скрипт")
end
