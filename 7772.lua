local part = Instance.new("Part")
part.Parent = workspace
part.Size = Vector3.new(10, 1, 10)
part.Position = Vector3.new(0, 10, 0)
part.Anchored = true
part.BrickColor = BrickColor.new("Bright red")

local billboard = Instance.new("SurfaceGui")
billboard.Parent = part
billboard.Face = Enum.NormalId.Top
billboard.Size = UDim2.new(1, 0, 1, 0)

local btn = Instance.new("TextButton")
btn.Parent = billboard
btn.Size = UDim2.new(1, 0, 1, 0)
btn.BackgroundColor3 = Color3.fromRGB(255,0,0)
btn.Text = "Z_H"
btn.TextScaled = true
btn.TextColor3 = Color3.fromRGB(255,255,255)
