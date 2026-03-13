--[[
    ███████╗ █████╗  ██████╗██╗  ██╗   ██╗
    ╚══███╔╝██╔══██╗██╔════╝██║ ██╔╝   ██║
      ███╔╝ ███████║██║     █████╔╝    ██║
     ███╔╝  ██╔══██║██║     ██╔═██╗    ██║
    ███████╗██║  ██║╚██████╗██║  ██╗   ██║
    ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝
    
    TG: @sajkyn
--]]

local speaker = game.Players.LocalPlayer
local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
local backpack = speaker:FindFirstChildWhichIsA("Backpack")
if not humanoid or not backpack then return end

local function r15()
    return speaker.Character.Humanoid.RigType == Enum.HumanoidRigType.R15
end

local tool = Instance.new("Tool")
tool.Name = "ZACK_HUB"
tool.ToolTip = "👑"
tool.RequiresHandle = false
tool.Parent = backpack

-- Радужное свечение
spawn(function()
    local hue = 0
    while tool and tool.Parent do
        hue = (hue + 0.01) % 1
        tool.GripColor = Color3.fromHSV(hue, 1, 1)
        wait(0.05)
    end
end)

local jorkin = false
local track = nil

local function stop()
    jorkin = false
    if track then
        track:Stop()
        track = nil
    end
end

tool.Equipped:Connect(function() jorkin = true end)
tool.Unequipped:Connect(stop)
humanoid.Died:Connect(stop)

while task.wait() do
    if not jorkin then continue end

    local isR15 = r15()
    if not track then
        local anim = Instance.new("Animation")
        anim.AnimationId = not isR15 and "rbxassetid://72042024" or "rbxassetid://698251653"
        track = humanoid:LoadAnimation(anim)
    end

    track:Play()
    track:AdjustSpeed(isR15 and 0.7 or 0.65)
    track.TimePosition = 0.6
    task.wait(0.1)
    while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do task.wait(0.1) end
    if track then
        track:Stop()
        track = nil
    end
end
