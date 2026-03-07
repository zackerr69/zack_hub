--[[
    ZACKERR HUB - УНИВЕРСАЛЬНЫЙ ЗАГРУЗЧИК
    Загружает: аксессуары, анимации, модели, звуки, декали
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:FindFirstChildOfClass("Humanoid")

-- СОЗДАЁМ GUI
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/zackerr69/zack_hub/main/ui_lib.lua"))() or {
    CreateWindow = function(...)
        local screenGui = Instance.new("ScreenGui")
        local frame = Instance.new("Frame")
        -- упрощённая версия
        return {
            CreateTab = function() 
                return {
                    CreateButton = function() end,
                    CreateTextBox = function() end
                }
            end
        }
    end
}

local window = lib.CreateWindow("ZACKERR HUB - ЗАГРУЗЧИК", Color3.fromRGB(0, 255, 255))

local tab = window.CreateTab("ЗАГРУЗЧИК")

tab.CreateTextBox("ID АССЕТА", "Введи число", function(value)
    _G.AssetID = tonumber(value)
end)

tab.CreateButton("ЗАГРУЗИТЬ КАК АКСЕССУАР", function()
    local id = _G.AssetID
    if not id then return end
    
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. id)[1]
    end)
    
    if success and obj then
        obj.Parent = character
        if obj:IsA("Accessory") and obj.Handle then
            local weld = Instance.new("Weld")
            weld.Part0 = character.Head
            weld.Part1 = obj.Handle
            weld.C0 = CFrame.new(0, 0.5, 0)
            weld.Parent = obj.Handle
        end
    end
end)

tab.CreateButton("ЗАГРУЗИТЬ КАК АНИМАЦИЮ", function()
    local id = _G.AssetID
    if not id or not humanoid then return end
    
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    local track = humanoid:LoadAnimation(anim)
    track:Play()
end)

tab.CreateButton("ЗАГРУЗИТЬ КАК МОДЕЛЬ", function()
    local id = _G.AssetID
    if not id then return end
    
    local success, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. id)[1]
    end)
    
    if success and obj then
        obj.Parent = workspace
        obj:MoveTo(character.Head.Position + Vector3.new(0, 5, 0))
    end
end)
