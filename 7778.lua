-- Абсолютно примитивный тест GUI
local part = Instance.new("Part")
part.Parent = workspace
part.Size = Vector3.new(5, 0.5, 5)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.BrickColor = BrickColor.new("Bright red")

local billboard = Instance.new("BillboardGui")
billboard.Parent = part
billboard.Size = UDim2.new(0, 200, 0, 100)
billboard.StudsOffset = Vector3.new(0, 3, 0)
billboard.AlwaysOnTop = true

local btn = Instance.new("TextButton")
btn.Parent = billboard
btn.Size = UDim2.new(1, 0, 1, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
btn.Text = "Z_H"
btn.TextColor3 = Color3.fromRGB(0, 0, 0)
btn.TextScaled = true

print("Тест запущен, ищи красную платформу с кнопкой")
