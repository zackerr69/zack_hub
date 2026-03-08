-- Очистка старых версий интерфейса перед запуском
local oldGui = game.CoreGui:FindFirstChild("ZackHubMobile") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("ZackHubMobile")
if oldGui then oldGui:Destroy() end

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local flying = false
local speed = 40

-- Создаем GUI (используем PlayerGui для лучшей совместимости с Delta)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZackHubMobile"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 130, 0, 90)
mainFrame.Position = UDim2.new(0.5, -65, 0.2, 0) -- По центру сверху
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 2
mainFrame.Active = true
mainFrame.Draggable = true 
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "ZACK_HUB"
title.Size = UDim2.new(1, 0, 0.4, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = mainFrame

local startBtn = Instance.new("TextButton")
startBtn.Text = "START"
startBtn.Size = UDim2.new(0.9, 0, 0.5, 0)
startBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.TextScaled = true
startBtn.Parent = mainFrame

local bv, bg

local function toggleFly()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local root = character.HumanoidRootPart
    
    if flying then
        flying = false
        startBtn.Text = "START"
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        character.Humanoid.PlatformStand = false
    else
        flying = true
        startBtn.Text = "STOP"
        startBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        character.Humanoid.PlatformStand = true
        
        bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame
        bg.Parent = root
        
        bv = Instance.new("BodyVelocity")
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.velocity = Vector3.new(0,0,0)
        bv.Parent = root
        
        task.spawn(function()
            while flying do
                game:GetService("RunService").RenderStepped:Wait()
                bv.velocity = camera.CFrame.LookVector * speed
                bg.cframe = camera.CFrame
            end
        end)
    end
end

startBtn.MouseButton1Click:Connect(toggleFly)
