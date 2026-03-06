--[[
    ТЕСТ 3D ID — СМОТРИ СПРАВА ОТ ГОЛОВЫ
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local head = character:FindFirstChild("Head")
if not head then return end

local TEST_ID = 6216619875  -- 👈 МЕНЯЙ ТУТ

for _, v in pairs(character:GetChildren()) do
    if v.Name:find("TEST_3D") then v:Destroy() end
end

-- Создаём 3D объект справа
local part = Instance.new("Part", character)
part.Name = "TEST_3D_Head"
part.Size = Vector3.new(1, 1, 1)
part.BrickColor = BrickColor.new("White")
part.Transparency = 0.2
part.CanCollide = false

local mesh = Instance.new("SpecialMesh")
mesh.MeshType = Enum.MeshType.FileMesh
mesh.MeshId = "rbxassetid://" .. TEST_ID
mesh.TextureId = "rbxassetid://" .. TEST_ID
mesh.Scale = Vector3.new(1, 1, 1)
mesh.Parent = part

local weld = Instance.new("Weld")
weld.Part0 = head
weld.Part1 = part
weld.C0 = CFrame.new(2, 0.5, 0)  -- справа
weld.Parent = part

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ТЕСТ 3D ID",
    Text = "Смотри справа от головы",
    Duration = 3
})
