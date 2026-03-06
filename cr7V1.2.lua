--[[
    ZACKERR HUB - 3D ГОЛОВА CR7
    ID: 14528502758 (как Mesh)
--]]

repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local character = player.Character

local function createCR7Head3D()
    -- Удаляем старую голову если есть
    for _, item in pairs(character:GetChildren()) do
        if item.Name == "CR7_Head" then
            item:Destroy()
        end
    end
    
    -- Создаем основу (Part)
    local headPart = Instance.new("Part")
    headPart.Name = "CR7_Head"
    headPart.Size = Vector3.new(1.2, 1.2, 1.2)
    headPart.BrickColor = BrickColor.new("Bright red")
    headPart.Material = Enum.Material.SmoothPlastic
    headPart.Transparency = 0.2
    headPart.Anchored = false
    headPart.CanCollide = false
    headPart.TopSurface = Enum.SurfaceType.Smooth
    headPart.BottomSurface = Enum.SurfaceType.Smooth
    headPart.Parent = character
    
    -- Пытаемся загрузить Mesh (3D модель) по ID
    local meshSuccess, mesh = pcall(function()
        local m = Instance.new("SpecialMesh")
        m.MeshId = "rbxassetid://14528502758"  -- ID как Mesh
        m.TextureId = "rbxassetid://14528502758" -- ID как текстура
        m.MeshType = Enum.MeshType.FileMesh
        m.Scale = Vector3.new(1, 1, 1)
        return m
    end)
    
    if meshSuccess then
        mesh.Parent = headPart
    else
        -- Если mesh не загрузился, делаем простую сферу с лицом
        local sphereMesh = Instance.new("SpecialMesh")
        sphereMesh.MeshType = Enum.MeshType.Sphere
        sphereMesh.Parent = headPart
        
        local decal = Instance.new("Decal")
        decal.Face = Enum.NormalId.Front
        decal.Texture = "rbxassetid://14528502758"
        decal.Parent = headPart
    end
    
    -- Прикрепляем к персонажу (вместо головы или сверху)
    local weld = Instance.new("Weld")
    weld.Part0 = character.Head
    weld.Part1 = headPart
    weld.C0 = CFrame.new(0, 0.5, 0) -- Над головой
    weld.Parent = headPart
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZACKERR HUB",
        Text = "3D голова CR7 создана!",
        Duration = 2
    })
end

createCR7Head3D()
