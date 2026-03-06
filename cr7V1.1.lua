--[[
    ZACKERR HUB - МАСКА CR7
    ID: 14528502758
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character

-- Функция создания маски (без загрузки с каталога)
local function createCR7Mask()
    -- Удаляем старую маску если есть
    for _, item in pairs(character:GetChildren()) do
        if item.Name == "CR7Mask" then
            item:Destroy()
        end
    end
    
    -- Создаем простую часть (Part) которая будет маской
    local mask = Instance.new("Part")
    mask.Name = "CR7Mask"
    mask.Size = Vector3.new(1.2, 0.8, 0.1)
    mask.BrickColor = BrickColor.new("Bright red")
    mask.Material = Enum.Material.SmoothPlastic
    mask.Transparency = 0
    mask.Anchored = false
    mask.CanCollide = false
    mask.Parent = character
    
    -- Создаем текстуру лица (приблизительную)
    local decal = Instance.new("Decal")
    decal.Name = "FaceDecal"
    decal.Face = Enum.NormalId.Front
    decal.Texture = "rbxassetid://14528502758"  -- Твой ID как текстура
    decal.Parent = mask
    
    -- Прикрепляем к голове
    local weld = Instance.new("Weld")
    weld.Part0 = character.Head
    weld.Part1 = mask
    weld.C0 = CFrame.new(0, 0, 0.3) -- Перед лицом
    weld.Parent = mask
    
    -- Делаем голову полупрозрачной чтобы маска была видна
    if character.Head then
        character.Head.Transparency = 0.5
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZACKERR HUB",
        Text = "Маска CR7 создана!",
        Duration = 2
    })
end

-- Запускаем
createCR7Mask()
