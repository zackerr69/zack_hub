-- Ждём, пока игрок появится
repeat wait() until game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local player = game:GetService("Players").LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
-- ============================================================
--  DELTA X / ROBLOX EXPLOIT · АДАПТИРОВАННАЯ ВЕРСИЯ
--  Исходник: StyleMenu (Claude, Roblox Studio)
--  Адаптация: ручная, для офлайн-тестирования
--  Фишки: меню, Fly, 3 вращающиеся сферы, 5 стилей
-- ============================================================

-- ──────────────────────────────────────────────
--  ГЛОБАЛЬНЫЕ ТАБЛИЦЫ (всё доступно в Delta X)
-- ──────────────────────────────────────────────
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local lighting       = game:GetService("Lighting")
local CoreGui        = game:GetService("CoreGui")      -- вместо PlayerGui

local player    = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid  = character:WaitForChild("Humanoid")
local rootPart  = character:WaitForChild("HumanoidRootPart")

-- ──────────────────────────────────────────────
--  СТИЛИ (Chams + ауры)
-- ──────────────────────────────────────────────
local STYLES = {
    {
        name           = "Огонь",
        ambient        = Color3.fromRGB(80, 20, 10),
        outdoorAmbient = Color3.fromRGB(120, 40, 10),
        fogColor       = Color3.fromRGB(60, 15, 5),
        fogEnd         = 300,
        auraColor      = Color3.fromRGB(255, 80, 10),
        auraTransp     = 0.35,
        auraMaterial   = Enum.Material.Neon,
    },
    {
        name           = "Вода",
        ambient        = Color3.fromRGB(10, 40, 90),
        outdoorAmbient = Color3.fromRGB(20, 80, 140),
        fogColor       = Color3.fromRGB(10, 30, 70),
        fogEnd         = 400,
        auraColor      = Color3.fromRGB(30, 160, 255),
        auraTransp     = 0.30,
        auraMaterial   = Enum.Material.Glass,
    },
    {
        name           = "Лес",
        ambient        = Color3.fromRGB(15, 55, 15),
        outdoorAmbient = Color3.fromRGB(30, 100, 30),
        fogColor       = Color3.fromRGB(10, 40, 10),
        fogEnd         = 350,
        auraColor      = Color3.fromRGB(50, 220, 50),
        auraTransp     = 0.25,
        auraMaterial   = Enum.Material.Neon,
  }
      {
        name           = "Тень",
        ambient        = Color3.fromRGB(30, 5, 60),
        outdoorAmbient = Color3.fromRGB(50, 10, 90),
        fogColor       = Color3.fromRGB(20, 0, 40),
        fogEnd         = 200,
        auraColor      = Color3.fromRGB(160, 30, 255),
        auraTransp     = 0.20,
        auraMaterial   = Enum.Material.Neon,
    },
    {
        name           = "Сталь",
        ambient        = Color3.fromRGB(55, 60, 70),
        outdoorAmbient = Color3.fromRGB(90, 100, 115),
        fogColor       = Color3.fromRGB(140, 150, 160),
        fogEnd         = 500,
        auraColor      = Color3.fromRGB(200, 210, 230),
        auraTransp     = 0.40,
        auraMaterial   = Enum.Material.Metal,
    },
}

-- ──────────────────────────────────────────────
--  СОСТОЯНИЕ
-- ──────────────────────────────────────────────
local state = {
    menuOpen  = false,
    flyActive = false,
    styleIdx  = nil,
    auras     = {},
    flyConn   = nil,
    auraConn  = nil,
}

-- Сохраняем оригинальные настройки Lighting
local origLighting = {
    ambient        = lighting.Ambient,
    outdoorAmbient = lighting.OutdoorAmbient,
    fogColor       = lighting.FogColor,
    fogEnd         = lighting.FogEnd,
}

-- ──────────────────────────────────────────────
--  LIGHTING (плавная смена)
-- ──────────────────────────────────────────────
local function applyLighting(style)
    lighting.Ambient        = style.ambient
    lighting.OutdoorAmbient = style.outdoorAmbient
    lighting.FogColor       = style.fogColor
    lighting.FogEnd         = style.fogEnd
end

local function resetLighting()
    lighting.Ambient        = origLighting.ambient
    lighting.OutdoorAmbient = origLighting.outdoorAmbient
    lighting.FogColor       = origLighting.fogColor
    lighting.FogEnd         = origLighting.fogEnd
end
-- ──────────────────────────────────────────────
--  АУРЫ (3 сферы вокруг игрока)
-- ──────────────────────────────────────────────
local ORBIT_PARAMS = {
    { yOffset = -2.5, orbitTilt =  0.4, phase = 0 },
    { yOffset =  0.0, orbitTilt = -0.3, phase = math.pi * 2 / 3 },
    { yOffset =  2.5, orbitTilt =  0.6, phase = math.pi * 4 / 3 },
}

local function createAuras(style)
    for _, part in ipairs(state.auras) do part:Destroy() end
    state.auras = {}
    if state.auraConn then state.auraConn:Disconnect(); state.auraConn = nil end

    for i, orb in ipairs(ORBIT_PARAMS) do
        local sphere = Instance.new("Part")
        sphere.Name         = "Aura_" .. i
        sphere.Shape        = Enum.PartType.Ball
        sphere.Size         = Vector3.new(1.2, 1.2, 1.2)
        sphere.Color        = style.auraColor
        sphere.Material     = style.auraMaterial
        sphere.Transparency = style.auraTransp
        sphere.CanCollide   = false
        sphere.Anchored     = false
        sphere.CastShadow   = false
        sphere.Parent       = workspace
        table.insert(state.auras, sphere)
    end

    local startTime = tick()
    state.auraConn = RunService.Heartbeat:Connect(function()
        if not rootPart or not rootPart.Parent then
            state.auraConn:Disconnect()
            return
        end

        local t      = tick() - startTime
        local center = rootPart.Position
        local radius = 2.8

        for i, sphere in ipairs(state.auras) do
            if not sphere.Parent then continue end
            local orb   = ORBIT_PARAMS[i]
            local angle = t * 1.5 + orb.phase
            local dx    = math.cos(angle) * radius
            local dz    = math.sin(angle) * radius
            local dy    = orb.yOffset

            local tiltedY = dy * math.cos(orb.orbitTilt) - dz * math.sin(orb.orbitTilt)
            local tiltedZ = dy * math.sin(orb.orbitTilt) + dz * math.cos(orb.orbitTilt)

            sphere.CFrame = CFrame.new(center + Vector3.new(dx, tiltedY, tiltedZ))
        end
    end)
end

local function removeAuras()
    if state.auraConn then state.auraConn:Disconnect(); state.auraConn = nil end
    for _, part in ipairs(state.auras) do part:Destroy() end
    state.auras = {}
end

-- ──────────────────────────────────────────────
--  FLY
-- ──────────────────────────────────────────────
local FLY_SPEED = 40

local function stopFly()
    if state.flyConn then state.flyConn:Disconnect(); state.flyConn = nil end
    local bv = rootPart:FindFirstChild("FlyVelocity")
    local bg = rootPart:FindFirstChild("FlyGyro")
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    if humanoid and humanoid.Parent then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

local function startFly()
    stopFly() -- защита от двойного запуска

    local bodyVelocity      = Instance.new("BodyVelocity")
    bodyVelocity.Name       = "FlyVelocity"
    bodyVelocity.Velocity   = Vector3.zero
    bodyVelocity.MaxForce   = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Parent     = rootPart

    local bodyGyro          = Instance.new("BodyGyro")
    bodyGyro.Name           = "FlyGyro"
    bodyGyro.MaxTorque      = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.D              = 100
    bodyGyro.Parent         = rootPart

    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0

    state.flyConn = RunService.Heartbeat:Connect(function()
        if not rootPart or not rootPart.Parent then
            stopFly()
            return
        end

        local camera  = workspace.CurrentCamera
        local moveDir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end

        bodyVelocity.Velocity = moveDir.Magnitude > 0
            and moveDir.Unit * FLY_SPEED
            or Vector3.zero

        bodyGyro.CFrame = camera.CFrame
    end)
end
-- ──────────────────────────────────────────────
--  GUI (ВЕШАЕМ НА COREGUI ДЛЯ DELTA X)
-- ──────────────────────────────────────────────
local screenGui = Instance.new("ScreenGui")
screenGui.Name           = "StyleMenu"
screenGui.ResetOnSpawn   = false
screenGui.IgnoreGuiInset = true
screenGui.Parent         = CoreGui  -- В Delta X используем CoreGui

-- Иконка-гамбургер
local iconBtn = Instance.new("ImageButton")
iconBtn.Name             = "MenuIcon"
iconBtn.Size             = UDim2.new(0, 48, 0, 48)
iconBtn.Position         = UDim2.new(0, 16, 0, 16)
iconBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
iconBtn.BorderSizePixel  = 0
iconBtn.Image            = ""
iconBtn.Parent           = screenGui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 10)
iconCorner.Parent       = iconBtn

local hamburger = Instance.new("TextLabel")
hamburger.Size                   = UDim2.new(1, 0, 1, 0)
hamburger.BackgroundTransparency = 1
hamburger.Text                   = "≡"
hamburger.TextColor3             = Color3.fromRGB(220, 220, 235)
hamburger.TextScaled             = true
hamburger.Font                   = Enum.Font.GothamBold
hamburger.Parent                 = iconBtn

-- Панель меню
local panel = Instance.new("Frame")
panel.Name                       = "Panel"
panel.Size                       = UDim2.new(0, 220, 0, 0)
panel.Position                   = UDim2.new(0, 72, 0, 10)
panel.BackgroundColor3           = Color3.fromRGB(14, 14, 22)
panel.BackgroundTransparency     = 0.08
panel.BorderSizePixel            = 0
panel.ClipsDescendants           = true
panel.Visible                    = false
panel.Parent                     = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent       = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color        = Color3.fromRGB(70, 70, 100)
panelStroke.Transparency = 0.5
panelStroke.Thickness    = 1
panelStroke.Parent       = panel

local title = Instance.new("TextLabel")
title.Size               = UDim2.new(1, -16, 0, 28)
title.Position           = UDim2.new(0, 12, 0, 6)
title.BackgroundTransparency = 1
title.Text               = "СТИЛИ И ЭФФЕКТЫ"
title.TextColor3         = Color3.fromRGB(160, 160, 190)
title.TextSize           = 13
title.Font               = Enum.Font.GothamBold
title.TextXAlignment     = Enum.TextXAlignment.Left
title.Parent             = panel

-- Функция создания кнопок
local function makeButton(labelText, yPos)
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1, -20, 0, 36)
    btn.Position         = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(26, 26, 38)
    btn.BorderSizePixel  = 0
    btn.Text             = labelText
    btn.TextColor3       = Color3.fromRGB(180, 180, 200)
    btn.TextSize         = 13
    btn.Font             = Enum.Font.Gotham
    btn.TextXAlignment   = Enum.TextXAlignment.Left

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.Parent      = btn

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent       = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color        = Color3.fromRGB(60, 60, 90)
    stroke.Transparency = 0.6
    stroke.Thickness    = 1
    stroke.Parent       = btn

    btn.Parent = panel
    return btn, stroke
end

-- Создаём кнопки
local flyBtn, flyStroke    = makeButton("Полёт  [выкл]", 36)
local styleBtns, styleStrokes = {}, {}

for i, s in ipairs(STYLES) do
    local yPos = 36 + i * (36 + 6)
    local btn, stroke = makeButton(s.name, yPos)
    styleBtns[i]   = btn
    styleStrokes[i] = stroke
end
-- ──────────────────────────────────────────────
--  ОБНОВЛЕНИЕ КНОПОК
-- ──────────────────────────────────────────────
local function updateStyleButtons()
    for i, btn in ipairs(styleBtns) do
        if i == state.styleIdx then
            btn.BackgroundColor3    = Color3.fromRGB(35, 30, 55)
            styleStrokes[i].Color   = STYLES[i].auraColor
            styleStrokes[i].Transparency = 0.1
            btn.TextColor3          = Color3.new(1, 1, 1)
        else
            btn.BackgroundColor3    = Color3.fromRGB(26, 26, 38)
            styleStrokes[i].Color   = Color3.fromRGB(60, 60, 90)
            styleStrokes[i].Transparency = 0.6
            btn.TextColor3          = Color3.fromRGB(180, 180, 200)
        end
    end
end

local function updateFlyButton()
    if state.flyActive then
        flyBtn.Text             = "Полёт  [ВКЛ]"
        flyBtn.BackgroundColor3 = Color3.fromRGB(20, 50, 30)
        flyStroke.Color         = Color3.fromRGB(60, 200, 100)
        flyStroke.Transparency  = 0.1
        flyBtn.TextColor3       = Color3.fromRGB(100, 255, 140)
    else
        flyBtn.Text             = "Полёт  [выкл]"
        flyBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 38)
        flyStroke.Color         = Color3.fromRGB(60, 60, 90)
        flyStroke.Transparency  = 0.6
        flyBtn.TextColor3       = Color3.fromRGB(180, 180, 200)
    end
end

-- ──────────────────────────────────────────────
--  АНИМАЦИЯ МЕНЮ (Heartbeat)
-- ──────────────────────────────────────────────
local function easeInOut(t)
    return t * t * (3 - 2 * t)
end

local PANEL_HEIGHT   = 300
local ANIM_DURATION  = 0.22
local menuAnim = { active = false, progress = 0, direction = 1 }

RunService.Heartbeat:Connect(function(dt)
    if not menuAnim.active then return end

    menuAnim.progress = math.clamp(
        menuAnim.progress + (dt / ANIM_DURATION) * menuAnim.direction,
        0, 1
    )

    local t = easeInOut(menuAnim.progress)
    panel.Size = UDim2.new(0, 220, 0, math.floor(PANEL_HEIGHT * t))

    if menuAnim.progress <= 0 then
        panel.Visible  = false
        menuAnim.active = false
    elseif menuAnim.progress >= 1 then
        menuAnim.active = false
    end
end)

iconBtn.MouseButton1Click:Connect(function()
    state.menuOpen     = not state.menuOpen
    menuAnim.direction = state.menuOpen and 1 or -1
    menuAnim.active    = true

    if state.menuOpen then
        panel.Visible = true
        if menuAnim.progress >= 1 then menuAnim.progress = 0 end
    end
end)

-- ──────────────────────────────────────────────
--  ЛОГИКА КНОПОК
-- ──────────────────────────────────────────────
flyBtn.MouseButton1Click:Connect(function()
    state.flyActive = not state.flyActive
    if state.flyActive then startFly() else stopFly() end
    updateFlyButton()
end)

for i, btn in ipairs(styleBtns) do
    btn.MouseButton1Click:Connect(function()
        if state.styleIdx == i then
            state.styleIdx = nil
            resetLighting()
            removeAuras()
        else
            state.styleIdx = i
            applyLighting(STYLES[i])
            createAuras(STYLES[i])
        end
        updateStyleButtons()
    end)
end

updateFlyButton()
updateStyleButtons()

-- ──────────────────────────────────────────────
--  RESPAWN (для новых персонажей)
-- ──────────────────────────────────────────────
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid", 10)
    rootPart = newChar:WaitForChild("HumanoidRootPart", 10)

    if not humanoid or not rootPart then
        warn("[StyleMenu] Персонаж не загрузился")
        return
    end

    if state.flyConn then state.flyConn:Disconnect(); state.flyConn = nil end
    state.flyActive = false
    updateFlyButton()

    if state.styleIdx then
        createAuras(STYLES[state.styleIdx])
    end
end)

print("[StyleMenu] Адаптировано для Delta X. Иконка в левом верхнем углу.")
