-- ── TRIGGERBOT MODERNO | DA HOOD ──
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Variables principales
local settings = {
    enabled = false,
    knifeCheck = true,
    forceFieldCheck = false,
    holdMode = true,
    precision = 50,
    triggerDelay = 1,
    maxDistance = 500,
    holdKey = Enum.UserInputType.MouseButton2,
    keyPressed = false,
    triggerActive = false,
    isSelectingKey = false
}

-- GUI Principal con diseño moderno
local gui = Instance.new("ScreenGui")
gui.Name = "TriggerBotGUI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Función para crear sombras
local function addShadow(parent, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    shadow.Parent = parent
    shadow.ZIndex = parent.ZIndex - 1
    return shadow
end

-- Main Container
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 500)
main.Position = UDim2.new(0, 50, 0, 50)
main.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
main.ClipsDescendants = true

-- Sombra principal
addShadow(main, 0.5)

-- Bordes redondeados modernos
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

-- Gradient superior
local topGradient = Instance.new("UIGradient")
topGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 32, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 20, 25))
})
topGradient.Rotation = 90
topGradient.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Título con icono
local titleIcon = Instance.new("ImageLabel")
titleIcon.Size = UDim2.new(0, 24, 0, 24)
titleIcon.Position = UDim2.new(0, 15, 0.5, -12)
titleIcon.BackgroundTransparency = 1
titleIcon.Image = "rbxassetid://6031082836"
titleIcon.ImageColor3 = Color3.fromRGB(0, 170, 255)
titleIcon.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 45, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TRIGGERBOT ELITE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 40, 0, 20)
version.Position = UDim2.new(0, 200, 0.5, -10)
version.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
version.BackgroundTransparency = 0.8
version.Text = "v2.0"
version.TextColor3 = Color3.fromRGB(0, 170, 255)
version.Font = Enum.Font.GothamBold
version.TextSize = 10
version.Parent = header

local versionCorner = Instance.new("UICorner")
versionCorner.CornerRadius = UDim.new(1, 0)
versionCorner.Parent = version

-- Botones de control
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0.5, -16)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(1, -82, 0.5, -16)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = header

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeBtn

-- Contenedor con scroll
local container = Instance.new("Frame")
container.Size = UDim2.new(1, 0, 1, -60)
container.Position = UDim2.new(0, 0, 0, 60)
container.BackgroundColor3 = Color3.fromRGB(18, 20, 25)
container.BorderSizePixel = 0
container.Parent = main

local containerPadding = Instance.new("UIPadding")
containerPadding.PaddingLeft = UDim.new(0, 15)
containerPadding.PaddingRight = UDim.new(0, 15)
containerPadding.PaddingTop = UDim.new(0, 15)
containerPadding.Parent = container

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 4
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.Parent = container

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 15)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrollingFrame

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end)

-- Función para crear secciones
local function createSection(title)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 25)
    section.BackgroundTransparency = 1
    section.Parent = scrollingFrame
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    line.BackgroundTransparency = 0.7
    line.Parent = section
    
    local lineGlow = Instance.new("Frame")
    lineGlow.Size = UDim2.new(1, 0, 0, 2)
    lineGlow.Position = UDim2.new(0, 0, 1, -2)
    lineGlow.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    lineGlow.BackgroundTransparency = 0.9
    lineGlow.BorderSizePixel = 0
    lineGlow.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(0, 170, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    return section
end

-- Función moderna para checkboxes
local function createCheckbox(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
    frame.Parent = scrollingFrame
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 22, 0, 22)
    checkbox.Position = UDim2.new(0, 10, 0.5, -11)
    checkbox.BackgroundColor3 = default and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 47, 55)
    checkbox.BorderSizePixel = 0
    checkbox.Text = ""
    checkbox.Parent = frame
    checkbox.AutoButtonColor = false
    
    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 6)
    checkCorner.Parent = checkbox
    
    local checkMark = Instance.new("ImageLabel")
    checkMark.Size = UDim2.new(0, 14, 0, 14)
    checkMark.Position = UDim2.new(0.5, -7, 0.5, -7)
    checkMark.BackgroundTransparency = 1
    checkMark.Image = "rbxassetid://6031094662"
    checkMark.ImageColor3 = Color3.fromRGB(255, 255, 255)
    checkMark.ImageTransparency = default and 0 or 1
    checkMark.Parent = checkbox
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -45, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 240)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local value = default
    
    checkbox.MouseButton1Click:Connect(function()
        value = not value
        local goal = {
            BackgroundColor3 = value and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 47, 55)
        }
        local tween = TweenService:Create(checkbox, TweenInfo.new(0.2), goal)
        tween:Play()
        checkMark.ImageTransparency = value and 0 or 1
        if callback then callback(value) end
    end)
    
    return {frame = frame, getValue = function() return value end}
end

-- Función moderna para sliders
local function createSlider(text, min, max, default, suffix, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 65)
    frame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
    frame.Parent = scrollingFrame
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 0, 25)
    label.Position = UDim2.new(0, 15, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 240)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.5, -15, 0, 25)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 8)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = default .. suffix
    valueLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -30, 0, 6)
    sliderBg.Position = UDim2.new(0, 15, 0, 40)
    sliderBg.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
    sliderBg.Parent = frame
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(1, 0)
    sliderBgCorner.Parent = sliderBg
    
    local percent = (default - min) / (max - min)
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(percent, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    sliderFill.Parent = sliderBg
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(1, 0)
    sliderFillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(1, 0, 1, 0)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Text = ""
    sliderButton.Parent = sliderBg
    
    local dragging = false
    local currentValue = default
    
    sliderButton.MouseButton1Down:Connect(function(input)
        dragging = true
        local mouseX = input.Position.X
        local bgPos = sliderBg.AbsolutePosition.X
        local bgSize = sliderBg.AbsoluteSize.X
        local percent = math.clamp((mouseX - bgPos) / bgSize, 0, 1)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        currentValue = math.floor(min + (max - min) * percent)
        valueLabel.Text = currentValue .. suffix
        if callback then callback(currentValue) end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local mousePos = UserInputService:GetMouseLocation()
            local bgPos = sliderBg.AbsolutePosition.X
            local bgSize = sliderBg.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - bgPos) / bgSize, 0, 1)
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            currentValue = math.floor(min + (max - min) * percent)
            valueLabel.Text = currentValue .. suffix
            if callback then callback(currentValue) end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return {getValue = function() return currentValue end}
end

-- Secciones
local triggerSection = createSection("⚡ TRIGGER CONTROL")
local configSection = createSection("⚙️ CONFIGURACIÓN")
local keySection = createSection("🔑 KEYBIND")
local infoSection = createSection("📊 ESTADÍSTICAS")

-- Checkboxes
createCheckbox("Trigger Bot", false, function(v) settings.enabled = v end)
createCheckbox("Knife Check", true, function(v) settings.knifeCheck = v end)
createCheckbox("Force Field Check", false, function(v) settings.forceFieldCheck = v end)

-- Modo selector
local modeFrame = Instance.new("Frame")
modeFrame.Size = UDim2.new(1, 0, 0, 50)
modeFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
modeFrame.Parent = scrollingFrame

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 8)
modeCorner.Parent = modeFrame

local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(0, 100, 1, 0)
modeLabel.Position = UDim2.new(0, 15, 0, 0)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "Modo:"
modeLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
modeLabel.Font = Enum.Font.Gotham
modeLabel.TextSize = 14
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.Parent = modeFrame

local modeBtn = Instance.new("TextButton")
modeBtn.Size = UDim2.new(0, 100, 0, 32)
modeBtn.Position = UDim2.new(1, -115, 0.5, -16)
modeBtn.BackgroundColor3 = settings.holdMode and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 100, 100)
modeBtn.Text = settings.holdMode and "HOLD" or "TOGGLE"
modeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
modeBtn.Font = Enum.Font.GothamBold
modeBtn.TextSize = 12
modeBtn.Parent = modeFrame
modeBtn.AutoButtonColor = false

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 6)
modeCorner.Parent = modeBtn

modeBtn.MouseButton1Click:Connect(function()
    settings.holdMode = not settings.holdMode
    modeBtn.Text = settings.holdMode and "HOLD" or "TOGGLE"
    modeBtn.BackgroundColor3 = settings.holdMode and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 100, 100)
end)

-- Key selector moderno
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(1, 0, 0, 50)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
keyFrame.Parent = scrollingFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyFrame

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(0, 100, 1, 0)
keyLabel.Position = UDim2.new(0, 15, 0, 0)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Tecla:"
keyLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextSize = 14
keyLabel.TextXAlignment = Enum.TextXAlignment.Left
keyLabel.Parent = keyFrame

local keySelectBtn = Instance.new("TextButton")
keySelectBtn.Size = UDim2.new(0, 150, 0, 32)
keySelectBtn.Position = UDim2.new(1, -165, 0.5, -16)
keySelectBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
keySelectBtn.Text = "CLICK DERECHO"
keySelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keySelectBtn.Font = Enum.Font.Gotham
keySelectBtn.TextSize = 12
keySelectBtn.Parent = keyFrame

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.CornerRadius = UDim.new(0, 6)
keyBtnCorner.Parent = keySelectBtn

-- Sliders
local precisionSlider = createSlider("Precisión", 0, 100, 50, "%", function(v) settings.precision = v end)
local delaySlider = createSlider("Delay", 0, 100, 1, "ms", function(v) settings.triggerDelay = v end)
local distanceSlider = createSlider("Distancia", 0, 5000, 500, "", function(v) settings.maxDistance = v end)

-- Key selection
keySelectBtn.MouseButton1Click:Connect(function()
    settings.isSelectingKey = true
    keySelectBtn.Text = "Presiona una tecla..."
    keySelectBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
end)

UserInputService.InputBegan:Connect(function(input)
    if settings.isSelectingKey then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            settings.holdKey = input.KeyCode
            keySelectBtn.Text = input.KeyCode.Name
            keySelectBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            settings.holdKey = Enum.UserInputType.MouseButton1
            keySelectBtn.Text = "CLICK IZQUIERDO"
            keySelectBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            settings.holdKey = Enum.UserInputType.MouseButton2
            keySelectBtn.Text = "CLICK DERECHO"
            keySelectBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
            settings.holdKey = Enum.UserInputType.MouseButton3
            keySelectBtn.Text = "CLICK MEDIO"
            keySelectBtn.BackgroundColor3 = Color3.fromRGB(45, 47, 55)
        end
        settings.isSelectingKey = false
    end
end)

-- Control de visibilidad con CTRL
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightControl then
        gui.Enabled = not gui.Enabled
    end
end)

-- Minimizar/Cerrar
minimizeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    settings.enabled = false
end)

-- Key state management
local function isKeyPressed(input)
    if typeof(settings.holdKey) == "EnumItem" then
        return input.UserInputType == settings.holdKey
    else
        return input.KeyCode == settings.holdKey
    end
end

UserInputService.InputBegan:Connect(function(input)
    if isKeyPressed(input) then
        settings.keyPressed = true
        if settings.holdMode then
            settings.triggerActive = true
        else
            settings.triggerActive = not settings.triggerActive
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if isKeyPressed(input) then
        settings.keyPressed = false
        if settings.holdMode then
            settings.triggerActive = false
        end
    end
end)

-- Funciones de utilidad
local function hasKnifeEquipped()
    local character = player.Character
    if not character then return false end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        local toolName = tool.Name:lower()
        local knifeNames = {"knife", "cuchillo", "cutter", "blade"}
        for _, name in ipairs(knifeNames) do
            if toolName:find(name) then return true end
        end
    end
    return false
end

local function getDistanceFromTarget(targetPart)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return math.huge end
    local rootPart = character.HumanoidRootPart
    return (rootPart.Position - targetPart.Position).Magnitude
end

-- Main loop
local lastShotTime = 0

RunService.Heartbeat:Connect(function()
    if not (settings.enabled and settings.triggerActive) then return end
    
    local currentTime = tick()
    if currentTime - lastShotTime < (settings.triggerDelay / 1000) then return end
    
    local target = mouse.Target
    if not target then return end
    
    local model = target.Parent
    if not model then return end
    
    local distance = getDistanceFromTarget(target)
    if distance > settings.maxDistance then return end
    
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    
    local plr = Players:GetPlayerFromCharacter(model)
    if not plr or plr == player then return end
    
    if settings.knifeCheck and hasKnifeEquipped() then return end
    
    if math.random(1, 100) <= settings.precision then
        mouse1click()
        lastShotTime = currentTime
    end
end)
