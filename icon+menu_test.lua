-- ZACK_HUB V5.0 - ЧАСТЬ 1: UI ENGINE
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("ZACK_HUB_Main") then pgui.ZACK_HUB_Main:Destroy() end
local screenGui = Instance.new("ScreenGui", pgui); screenGui.Name = "ZACK_HUB_Main"

-- Круглая кнопка-иконка
local iconBtn = Instance.new("ImageButton", screenGui)
iconBtn.Size = UDim2.new(0, 60, 0, 60); iconBtn.Position = UDim2.new(0.05, 0, 0.5, -30)
iconBtn.Image = "rbxassetid://5041408920"; iconBtn.BackgroundColor3 = Color3.new(0,0,0)
Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(1, 0)

-- Полупрозрачное меню
local main = Instance.new("Frame", screenGui); main.Size = UDim2.new(0, 250, 0, 300)
main.Position = UDim2.new(0.2, 0, 0.3, 0); main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BackgroundTransparency = 0.3; main.Visible = false; main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- Логотип внутри меню (твоя картинка 6685608764)
local logo = Instance.new("ImageLabel", main); logo.Size = UDim2.new(1, 0, 0.3, 0)
logo.Image = "rbxassetid://6685608764"; logo.BackgroundTransparency = 1

-- Логика открытия/закрытия
iconBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
-- ZACK_HUB V5.0 - ЧАСТЬ 2: FUNCTION LIST
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(0.9, 0, 0.6, 0); scroll.Position = UDim2.new(0.05, 0, 0.35, 0)
scroll.BackgroundTransparency = 0.5; scroll.BackgroundColor3 = Color3.new(0,0,0)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)

local function addButton(name, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 30); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1); btn.AutomaticSize = Enum.AutomaticSize.Y
    btn.MouseButton1Click:Connect(callback)
end
-- ZACK_HUB V5.0 - ЧАСТЬ 3: LOGIC
-- Jerk (твой код в функции)
local function runJerk()
    local hum = player.Character:FindFirstChildWhichIsA("Humanoid")
    local tool = Instance.new("Tool", player.Backpack); tool.Name = "Zack Hub Jerk"; tool.RequiresHandle = false
    tool.Equipped:Connect(function() 
        local anim = Instance.new("Animation"); anim.AnimationId = (hum.RigType == Enum.HumanoidRigType.R15) and "rbxassetid://698251653" or "rbxassetid://72042024"
        local track = hum:LoadAnimation(anim); track:Play(); track:AdjustSpeed(0.7)
        tool.Unequipped:Connect(function() track:Stop() end)
    end)
end

-- 3 Сферы
local function startSpheres()
    for i = 1, 3 do
        local ball = Instance.new("Part", player.Character.HumanoidRootPart); ball.Shape = "Ball"; ball.Size = Vector3.new(0.5, 0.5, 0.5); ball.Material = "Neon"
        task.spawn(function()
            while ball.Parent do
                local t = tick() * 4.5
                ball.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos(t + i*2)*1.2, math.sin(t*2)*0.5, math.sin(t + i*2)*1.2)
                game:GetService("RunService").RenderStepped:Wait()
            end
        end)
    end
end

-- Вращение головы
local function rotateHead()
    task.spawn(function()
        while true do
            player.Character.Head.Neck.C0 = player.Character.Head.Neck.C0 * CFrame.Angles(0, 0.1, 0)
            task.wait()
        end
    end)
end

-- Активация всего в списке
addButton("Jerk", runJerk)
addButton("Start Spheres", startSpheres)
addButton("Rotate Head", rotateHead)
addButton("Anime Sky", function() 
    local sky = Instance.new("Sky", game.Lighting); sky.SkyboxBk = "rbxassetid://99290769119028"; sky.SkyboxDn = "rbxassetid://99290769119028"; sky.SkyboxFt = "rbxassetid://99290769119028"; sky.SkyboxLf = "rbxassetid://99290769119028"; sky.SkyboxRt = "rbxassetid://99290769119028"; sky.SkyboxUp = "rbxassetid://99290769119028"
end)
