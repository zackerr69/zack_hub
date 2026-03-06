--[[
    ZACKERR HUB — ТЕСТОВОЕ МЕНЮ ВЫБОРА ID
    Кнопки 1–5, каждая со своим ID
    Ты потом скажешь, какая кнопка дала 3D голову
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local head = character:FindFirstChild("Head")
local playerGui = player:FindFirstChild("PlayerGui") or Instance.new("PlayerGui", player)

if not head then return end

-- Удаляем старое меню если есть
local oldGui = playerGui:FindFirstChild("IDSelector")
if oldGui then oldGui:Destroy() end

-- Создаём GUI
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "IDSelector"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(0.5, -110, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.Active = true
frame.Draggable = true

-- Заголовок
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "ВЫБЕРИ ID ДЛЯ ТЕСТА"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Поле для подсказки
local hint = Instance.new("TextLabel", frame)
hint.Size = UDim2.new(1, 0, 0, 40)
hint.Position = UDim2.new(0, 0, 0, 250)
hint.Text = "Нажимай кнопки →\nсмотри справа от головы"
hint.TextColor3 = Color3.fromRGB(200, 200, 200)
hint.BackgroundTransparency = 1
hint.Font = Enum.Font.SourceSans
hint.TextScaled = true

-- Таблица ID (ты потом скажешь, какой куда вписать)
local idList = {
    [1] = 6216619875,   -- кнопка 1
    [2] = 5572371052,   -- кнопка 2
    [3] = 4793443338,   -- кнопка 3
    [4] = 5126894361,   -- кнопка 4
    [5] = 6869065598,   -- кнопка 5
}

-- Функция создания 3D объекта справа от головы
local function spawn3DHead(id, btnIndex)
    -- Удаляем предыдущий тестовый объект
    for _, v in pairs(character:GetChildren()) do
        if v.Name:find("TEST_3D_") then
            v:Destroy()
        end
    end

    local part = Instance.new("Part", character)
    part.Name = "TEST_3D_" .. btnIndex
    part.Size = Vector3.new(1, 1, 1)
    part.BrickColor = BrickColor.new("White")
    part.Transparency = 0.2
    part.CanCollide = false
    part.Anchored = false

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://" .. id
    mesh.TextureId = "rbxassetid://" .. id
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = part

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = part
    weld.C0 = CFrame.new(2, 0.5, 0)  -- справа
    weld.Parent = part

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ТЕСТ ID",
        Text = "ID " .. id .. " (кнопка " .. btnIndex .. ") — справа",
        Duration = 2
    })
end

-- Создаём кнопки 1–5
for i = 1, 5 do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.Position = UDim2.new(0.1, 0, 0, 35 + (i-1) * 40)
    btn.Text = "Кнопка " .. i .. " (ID " .. idList[i] .. ")"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 215, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true

    btn.MouseButton1Click:Connect(function()
        spawn3DHead(idList[i], i)
    end)
end

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0.2, 0, 0, 25)
closeBtn.Position = UDim2.new(0.78, 0, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.BorderSizePixel = 0
closeBtn.Font = Enum.Font.GothamBold
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Уведомление
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ZACKERR HUB",
    Text = "Меню выбора ID открыто",
    Duration = 2
})
