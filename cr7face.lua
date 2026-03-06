--[[
    ZACKERR HUB - МАСКА РОНАЛДО
    Asset ID: 14528502758
    Функция: Надевает аксессуар "Ronaldo's face" как маску
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")

if not humanoid then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZACKERR HUB",
        Text = "Ошибка: нет персонажа",
        Duration = 2
    })
    return
end

-- ID аксессуара (который ты дал)
local ASSET_ID = "14528502758"
local ACCESSORY_NAME = "RonaldoFace"

-- Функция для удаления старого такого же аксессуара
local function removeOldAccessory()
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Accessory") and item.Name == ACCESSORY_NAME then
            item:Destroy()
        end
    end
end

-- Функция для надевания нового
local function equipRonaldoFace()
    removeOldAccessory()
    
    -- Загружаем аксессуар по Asset ID
    local success, loadedAsset = pcall(function()
        -- Используем game:GetObjects для загрузки ассета
        return game:GetObjects("rbxassetid://" .. ASSET_ID)[1]
    end)
    
    if success and loadedAsset and loadedAsset:IsA("Accessory") then
        loadedAsset.Name = ACCESSORY_NAME
        loadedAsset.Parent = character
        
        -- Настраиваем его положение как маску
        local handle = loadedAsset:FindFirstChild("Handle")
        if handle and character:FindFirstChild("Head") then
            -- Создаем сварку (Weld), чтобы прикрепить к голове
            local weld = Instance.new("Weld")
            weld.Part0 = character.Head
            weld.Part1 = handle
            -- Подгоняем положение (C0 смещение). Для 2D-маски нужно точечно подогнать.
            -- Пробуем немного сместить вперед от лица.
            weld.C0 = CFrame.new(0, -0.1, 0.3) -- X, Y, Z подгоняй, если нужно
            weld.Parent = handle
            
            -- Делаем handle невидимым, если это просто крепление
            handle.Transparency = 1
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ZACKERR HUB",
            Text = "Маска Роналдо надета!",
            Duration = 2
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "ZACKERR HUB",
            Text = "Ошибка загрузки аксессуара (ID: " .. ASSET_ID .. ")",
            Duration = 3
        })
        print("ZACKERR HUB: Ошибка загрузки ассета", loadedAsset)
    end
end

-- Запускаем
equipRonaldoFace()
