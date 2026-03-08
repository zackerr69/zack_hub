-- ЧАСТЬ 1: Твой Jerk (без изменений)
local function runJerk()
    local speaker = game.Players.LocalPlayer
    local humanoid = speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid")
    local backpack = speaker:FindFirstChildWhichIsA("Backpack")
    if not humanoid or not backpack then return end

    local tool = Instance.new("Tool", backpack)
    tool.Name = "Zack Hub Jerk"
    tool.RequiresHandle = false
    
    local jorkin = false
    local track = nil

    tool.Equipped:Connect(function() jorkin = true end)
    tool.Unequipped:Connect(function() jorkin = false; if track then track:Stop() end end)

    task.spawn(function()
        while true do task.wait(0.1)
            if jorkin then
                local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
                if not track then
                    local anim = Instance.new("Animation")
                    anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
                    track = humanoid:LoadAnimation(anim)
                end
                track:Play(); track:AdjustSpeed(isR15 and 0.7 or 0.65)
            end
        end
    end)
end
-- ЧАСТЬ 2: Интерфейс
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local frame = Instance.new("Frame", gui); frame.Size = UDim2.new(0, 200, 0, 150); frame.Position = UDim2.new(0.5, -100, 0.5, -75); frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); frame.Draggable = true
local btn = Instance.new("TextButton", frame); btn.Size = UDim2.new(1, 0, 0, 50); btn.Text = "START HUB"
-- ЧАСТЬ 3: Сферы
local function startSpheres()
    local char = game.Players.LocalPlayer.Character
    for i = 1, 3 do
        local ball = Instance.new("Part", char.HumanoidRootPart); ball.Shape = "Ball"; ball.Size = Vector3.new(0.5, 0.5, 0.5); ball.Material = "Neon"; ball.CanCollide = false
        local trail = Instance.new("Trail", ball); trail.Attachment0 = Instance.new("Attachment", ball); trail.Attachment1 = Instance.new("Attachment", ball); trail.Attachment1.Position = Vector3.new(0, -1, 0)
        task.spawn(function()
            while ball.Parent do
                local t = tick() * 3 -- 1.5x скорость
                ball.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(math.cos(t)*1.5, math.sin(t*2), math.sin(t)*1.5) -- Ближе к телу
                game:GetService("RunService").RenderStepped:Wait()
            end
        end)
    end
end
-- ЧАСТЬ 4: Голова и Небо
local function spinHead()
    local neck = game.Players.LocalPlayer.Character.Head:FindFirstChild("Neck")
    if neck then
        task.spawn(function()
            while neck do neck.C0 = neck.C0 * CFrame.Angles(0.1, 0, 0); task.wait() end
        end)
    end
end

-- Активация всего
btn.MouseButton1Click:Connect(function()
    runJerk()
    startSpheres()
    spinHead()
    -- Небо (через Sky, максимально простой метод)
    local sky = Instance.new("Sky", game.Lighting); sky.SkyboxBk = "rbxassetid://14451457100"; sky.SkyboxDn = "rbxassetid://14451457100"; sky.SkyboxFt = "rbxassetid://14451457100"; sky.SkyboxLf = "rbxassetid://14451457100"; sky.SkyboxRt = "rbxassetid://14451457100"; sky.SkyboxUp = "rbxassetid://14451457100"
end)
