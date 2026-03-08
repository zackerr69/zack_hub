-- ZACK_HUB V3.0 - ФИНАЛЬНЫЙ АПГРЕЙД
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("ZACK_HUB_Jerk") then pgui.ZACK_HUB_Jerk:Destroy() end

local screenGui = Instance.new("ScreenGui", pgui)
screenGui.Name = "ZACK_HUB_Jerk"
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 200, 0, 150)
main.Position = UDim2.new(0.5, -100, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "ZACK_HUB \"jerk\""
title.TextScaled = true
title.BackgroundTransparency = 1

local startBtn = Instance.new("TextButton", main)
startBtn.Text = "Start"
startBtn.Size = UDim2.new(0.8, 0, 0, 40)
startBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
startBtn.BackgroundColor3 = Color3.fromRGB(192, 192, 192)

-- Логика сфер (Вверх-Вниз + Расширение)
local function startOrbit(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    for i = 1, 2 do
        local ball = Instance.new("Part", hrp)
        ball.Shape = "Ball"; ball.Size = Vector3.new(0.8,0.8,0.8); ball.Material = "Neon"
        ball.CanCollide = false
        
        local trail = Instance.new("Trail", ball)
        trail.Attachment0 = Instance.new("Attachment", ball)
        trail.Attachment1 = Instance.new("Attachment", ball); trail.Attachment1.Position = Vector3.new(0, -1, 0)
        
        task.spawn(function()
            local timeOffset = i * math.pi
            while ball.Parent do
                local t = tick() + timeOffset
                -- Эффект: Движение по всему телу + расширение орбиты
                local x = math.cos(t) * 4
                local y = math.sin(t * 1.5) * 3
                local z = math.sin(t) * 4
                ball.CFrame = hrp.CFrame * CFrame.new(x, y, z)
                RunService.RenderStepped:Wait()
            end
        end)
    end
end

-- Выдача предмета Jerk
local function giveJerkTool()
    local tool = Instance.new("Tool", player.Backpack)
    tool.Name = "Jerk_Tool"
    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
end

startBtn.MouseButton1Click:Connect(function()
    giveJerkTool()
    startOrbit(player.Character)
    -- Эффект неба без ошибок (Atmosphere)
    local l = game:GetService("Lighting")
    if not l:FindFirstChild("Atmosphere") then Instance.new("Atmosphere", l) end
    l.Atmosphere.Haze = 10
    l.Atmosphere.Density = 0.5
    startBtn.Text = "ACTIVE"
end)
