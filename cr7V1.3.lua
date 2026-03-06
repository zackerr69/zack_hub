--[[
    ZACKERR HUB — ТЕСТЕР ЛЮБОГО ID
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character
local head = character:FindFirstChild("Head")
if not head then return end

-- 👇 ВОТ СЮДА СТАВИШЬ НОВЫЙ ID
local TEST_ID = 13978511301

local function testID()
    for _, v in pairs(character:GetChildren()) do
        if v.Name:find("TEST_") then v:Destroy() end
    end

    -- СПОСОБ 1: Accessory
    local success1, obj = pcall(function()
        return game:GetObjects("rbxassetid://" .. TEST_ID)[1]
    end)
    if success1 and obj then
        obj.Name = "TEST_Accessory"
        obj.Parent = character
        if obj:IsA("Accessory") and obj.Handle then
            local w = Instance.new("Weld")
            w.Part0 = head
            w.Part1 = obj.Handle
            w.C0 = CFrame.new(0, 0.5, 0)
            w.Parent = obj.Handle
            print("[OK] Аксессуар")
        end
    else
        print("[X] Аксессуар не сработал")
    end

    -- СПОСОБ 2: Part + Decal
    local p2 = Instance.new("Part", character)
    p2.Name = "TEST_Decal"
    p2.Size = Vector3.new(1.2, 0.8, 0.1)
    p2.BrickColor = BrickColor.new("Really red")
    p2.Material = Enum.Material.SmoothPlastic
    p2.CanCollide = false
    local decal = Instance.new("Decal")
    decal.Face = Enum.NormalId.Front
    decal.Texture = "rbxassetid://" .. TEST_ID
    decal.Parent = p2
    local w2 = Instance.new("Weld")
    w2.Part0 = head
    w2.Part1 = p2
    w2.C0 = CFrame.new(0, 0.2, 0.35)
    w2.Parent = p2
    print("[OK] Decal-объект")

    -- СПОСОБ 3: Part + Mesh
    local p3 = Instance.new("Part", character)
    p3.Name = "TEST_Mesh"
    p3.Size = Vector3.new(1, 1, 1)
    p3.BrickColor = BrickColor.new("White")
    p3.Transparency = 0.2
    p3.CanCollide = false
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://" .. TEST_ID
    mesh.TextureId = "rbxassetid://" .. TEST_ID
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Parent = p3
    local w3 = Instance.new("Weld")
    w3.Part0 = head
    w3.Part1 = p3
    w3.C0 = CFrame.new(1.5, 0.5, 0)
    w3.Parent = p3
    print("[OK] Mesh-объект")

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ТЕСТ ID",
        Text = "Объекты созданы, смотри",
        Duration = 4
    })
end

testID()
