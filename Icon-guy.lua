-- АБСОЛЮТНЫЙ МИНИМУМ для теста GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
gui.DisplayOrder = 999999
gui.ResetOnSpawn = false
gui.Name = "ZACK_HUB"

local frame = Instance.new("Frame")
frame.Parent = gui
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Active = true
frame.Draggable = true
frame.Visible = true

local text = Instance.new("TextLabel")
text.Parent = frame
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "РАБОТАЕТ?"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true
text.Font = Enum.Font.GothamBold

print("GUI создан, ищи окно")
