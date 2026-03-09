-- Использование локального окружения для защиты данных
local _G = {} 
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Обход проверки на наличие модификаций (Anti-Tamper Bypass)
local function spoofInstances()
    -- Скрываем объекты от сканирования анти-читом
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldIndex = mt.__index
    mt.__index = newcclosure(function(self, key)
        if key == "Parent" and self:IsA("Script") then
            return nil -- Скрываем структуру скрипта
        end
        return oldIndex(self, key)
    end)
end
spoofInstances()
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "ZACK_HUB"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true -- Нативный метод перетаскивания

local UIGradient = Instance.new("UIGradient", MainFrame)
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0,0,0)), ColorSequenceKeypoint.new(1, Color3.new(0.2,0.2,0.2))})
local VisualModule = {}
VisualModule.Objects = {}

function VisualModule:Cleanup()
    for _, obj in pairs(self.Objects) do
        if obj then obj:Destroy() end
    end
    self.Objects = {}
end

-- Сферы с орбитой (Chams 1)
function VisualModule:RunAura()
    local player = LocalPlayer
    local center = player.Character.HumanoidRootPart
    for i = 1, 3 do
        local sphere = Instance.new("Part", workspace)
        sphere.Shape = "Ball"
        sphere.Size = Vector3.new(2, 2, 2)
        sphere.Material = "Neon"
        sphere.Color = Color3.new(1, 1, 1)
        table.insert(self.Objects, sphere)
        
        task.spawn(function()
            while table.find(self.Objects, sphere) do
                local t = tick() * 2
                sphere.Position = center.Position + Vector3.new(math.sin(t+i)*5, math.cos(t)*2, math.cos(t+i)*5)
                RunService.RenderStepped:Wait()
            end
        end)
    end
end
local Utility = {}

function Utility:Fly(speed)
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local bv = Instance.new("BodyVelocity", hrp)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    
    local keys = {W=false, A=false, S=false, D=false}
    -- Система ввода скорости
    RunService.RenderStepped:Connect(function()
        bv.Velocity = (workspace.CurrentCamera.CFrame.LookVector * speed)
    end)
end

function Utility:PotatoMode()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("MeshPart") or obj:IsA("Part") then
            obj.Material = "Plastic"
            obj.Reflectance = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj:Destroy()
        end
    end
end
local AccessoryModule = {}
local InsertService = game:GetService("InsertService")

function AccessoryModule:EquipSamuraiHat()
    local character = LocalPlayer.Character
    if not character then return end
    
    -- ID модели японского шлема (Jingasa)
    local HAT_ID = 12345678 -- Вставь сюда реальный ID объекта из Roblox Library
    
    local success, hatModel = pcall(function()
        return InsertService:LoadAsset(HAT_ID)
    end)
    
    if success and hatModel then
        local hat = hatModel:GetChildren()[1]
        hat.Parent = character
        
        -- Создание сварки (Weld) для фиксации на голове
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = hat.Handle
        weld.Part1 = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")
        weld.Parent = hat.Handle
        
        table.insert(VisualModule.Objects, hat) -- Добавляем в список для очистки
    end
end
