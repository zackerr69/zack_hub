-- ZACK_HUB_UNIVERSAL V2.1 | CORE ENGINE
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

getgenv().ZACK_DATA = {
    VisualsFolder = Instance.new("Folder", workspace),
    ActiveMode = nil
}
getgenv().ZACK_DATA.VisualsFolder.Name = "Zack_Runtime_Effects"

-- Глобальный очиститель: сносит все эффекты текущего режима
local function clearVisuals()
    for _, v in pairs(getgenv().ZACK_DATA.VisualsFolder:GetChildren()) do
        v:Destroy()
    end
    -- Возврат графики в норму (убираем ColorCorrection, если есть)
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("ColorCorrectionEffect") or obj:IsA("Atmosphere") then obj:Destroy() end
    end
end
-- ZACK_HUB_UNIVERSAL | CHAMS 1 MODULE
local function startChams1()
    clearVisuals()
    
    -- Розовое небо
    local atmos = Instance.new("Atmosphere", Lighting)
    atmos.Color = Color3.fromRGB(255, 200, 255)
    
    -- Шапка самурая (Jingasa)
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local hat = Instance.new("Part", getgenv().ZACK_DATA.VisualsFolder)
        hat.Shape = Enum.PartType.Cylinder; hat.Size = Vector3.new(0.5, 2, 2)
        local weld = Instance.new("WeldConstraint", hat)
        weld.Part0 = hat; weld.Part1 = char.Head
        hat.CFrame = char.Head.CFrame * CFrame.new(0, 1, 0)
    end
    
    -- Сферы с динамической высотой
    RunService.RenderStepped:Connect(function()
        if not getgenv().ZACK_DATA.ActiveMode == 1 then return end
        -- Логика движения сфер вокруг HRP с учетом высоты
    end)
end
-- ZACK_HUB_UNIVERSAL | CHAMS 2 MODULE
local function startChams2()
    clearVisuals()
    -- Темное небо
    Lighting.Ambient = Color3.fromRGB(0,0,0)
    
    -- Удаление головы
    local head = Players.LocalPlayer.Character:FindFirstChild("Head")
    if head then head.Transparency = 1 end
    
    -- Эффект: книжки/луны (создаем через Part и удаляем через 1.5с)
    task.spawn(function()
        while getgenv().ZACK_DATA.ActiveMode == 2 do
            local effect = Instance.new("Part", getgenv().ZACK_DATA.VisualsFolder)
            effect.Size = Vector3.new(0.5, 0.5, 0.1); effect.Shape = Enum.PartType.Ball
            task.delay(1.5, function() effect:Destroy() end)
            task.wait(0.5)
        end
    end)
end
-- ZACK_HUB_UNIVERSAL | UTILS MODULE
local function togglePotatoMode(state)
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if state then
        -- Картофельный режим
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.Plastic end
        end
    else
        -- Возврат графики
    end
end
