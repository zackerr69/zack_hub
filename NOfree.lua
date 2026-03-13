local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Создаём парт, который всегда привязан к камере
local part = Instance.new("Part")
part.Parent = workspace
part.Size = Vector3.new(0.1, 0.1, 0.1)  -- почти невидимый
part.Anchored = true
part.CanCollide = false
part.Transparency = 1  -- полностью прозрачный
part.BrickColor = BrickColor.new("White")

-- BillboardGui на этом парте
local billboard = Instance.new("BillboardGui")
billboard.Parent = part
billboard.Size = UDim2.new(0, 100, 0, 100)
billboard.StudsOffset = Vector3.new(0, 0, 0)
billboard.AlwaysOnTop = true

local icon = Instance.new("TextButton")
icon.Parent = billboard
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 0.2
icon.BackgroundColor3 = Color3.fromRGB(10,10,10)
icon.BorderSizePixel = 3
icon.BorderColor3 = Color3.fromRGB(255,255,255)
icon.Text = "Z_H"
icon.TextColor3 = Color3.fromRGB(255,255,255)
icon.TextScaled = true
icon.Font = Enum.Font.GothamBold

-- Привязываем парт к камере (чтобы всегда был перед глазами)
game:GetService("RunService").RenderStepped:Connect(function()
    part.CFrame = camera.CFrame * CFrame.new(0, 0, -5)  -- всегда в 5 метрах перед камерой
end)

print("Иконка будет перед глазами")
