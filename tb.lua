-- TRIGGERBOT MODERNO - DA HOOD CON RANGO
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local enabled = false
local precision = 50
local wallCheck = false
local knifeMode = true
local cooldown = 0
local range = 1000 -- Rango por defecto

-- Servicios
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- GUI Principal
local gui = Instance.new("ScreenGui")
gui.Name = "TriggerBotModern"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

-- Frame principal con diseño moderno
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 380) -- Más grande para el rango
main.Position = UDim2.new(0, 50, 0, 50)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.ClipsDescendants = true
main.Parent = gui

-- Sombra y efecto de borde
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(40, 40, 40)
stroke.Thickness = 1
stroke.Parent = main

-- Título con gradiente
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 45)
titleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TRIGGERBOT PRO"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleFrame

-- Botón de cerrar moderno
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = titleFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- Contenedor principal de controles
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -30, 1, -60)
container.Position = UDim2.new(0, 15, 0, 50)
container.BackgroundTransparency = 1
container.Parent = main

-- Layout automático
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 15)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = container

-- ===== TOGGLE PRINCIPAL =====
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, 0, 0, 50)
toggleFrame.BackgroundTransparency = 1
toggleFrame.LayoutOrder = 1
toggleFrame.Parent = container

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(0.5, 0, 1, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "TB STATUS"
toggleLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
toggleLabel.Font = Enum.Font.Gotham
toggleLabel.TextSize = 14
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = toggleFrame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 80, 0, 35)
toggleBtn.Position = UDim2.new(1, -80, 0, 7)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
toggleBtn.Text = "OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Parent = toggleFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleBtn

-- ===== PRECISIÓN =====
local precisionFrame = Instance.new("Frame")
precisionFrame.Size = UDim2.new(1, 0, 0, 45)
precisionFrame.BackgroundTransparency = 1
precisionFrame.LayoutOrder = 2
precisionFrame.Parent = container

local precisionLabel = Instance.new("TextLabel")
precisionLabel.Size = UDim2.new(1, 0, 0, 20)
precisionLabel.BackgroundTransparency = 1
precisionLabel.Text = "🎯 Precisión 50%"
precisionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
precisionLabel.Font = Enum.Font.Gotham
precisionLabel.TextSize = 13
precisionLabel.TextXAlignment = Enum.TextXAlignment.Left
precisionLabel.Parent = precisionFrame

local precisionSlider = Instance.new("Frame")
precisionSlider.Size = UDim2.new(1, 0, 0, 6)
precisionSlider.Position = UDim2.new(0, 0, 0, 25)
precisionSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
precisionSlider.Parent = precisionFrame

local precisionSliderCorner = Instance.new("UICorner")
precisionSliderCorner.CornerRadius = UDim.new(1, 0)
precisionSliderCorner.Parent = precisionSlider

local precisionFill = Instance.new("Frame")
precisionFill.Size = UDim2.new(0.5, 0, 1, 0)
precisionFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
precisionFill.Parent = precisionSlider

local precisionFillCorner = Instance.new("UICorner")
precisionFillCorner.CornerRadius = UDim.new(1, 0)
precisionFillCorner.Parent = precisionFill

local precisionButton = Instance.new("TextButton")
precisionButton.Size = UDim2.new(1, 0, 1, 0)
precisionButton.BackgroundTransparency = 1
precisionButton.Text = ""
precisionButton.Parent = precisionSlider

-- ===== RANGO =====
local rangeFrame = Instance.new("Frame")
rangeFrame.Size = UDim2.new(1, 0, 0, 45)
rangeFrame.BackgroundTransparency = 1
rangeFrame.LayoutOrder = 3
rangeFrame.Parent = container

local rangeLabel = Instance.new("TextLabel")
rangeLabel.Size = UDim2.new(1, 0, 0, 20)
rangeLabel.BackgroundTransparency = 1
rangeLabel.Text = "📏 Rango 1000"
rangeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
rangeLabel.Font = Enum.Font.Gotham
rangeLabel.TextSize = 13
rangeLabel.TextXAlignment = Enum.TextXAlignment.Left
rangeLabel.Parent = rangeFrame

-- Slider rango
local rangeSlider = Instance.new("Frame")
rangeSlider.Size = UDim2.new(1, 0, 0, 6)
rangeSlider.Position = UDim2.new(0, 0, 0, 25)
rangeSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
rangeSlider.Parent = rangeFrame

local rangeSliderCorner = Instance.new("UICorner")
rangeSliderCorner.CornerRadius = UDim.new(1, 0)
rangeSliderCorner.Parent = rangeSlider

local rangeFill = Instance.new("Frame")
rangeFill.Size = UDim2.new(0.1, 0, 1, 0) -- 1000 de 10000 = 10%
rangeFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
rangeFill.Parent = rangeSlider

local rangeFillCorner = Instance.new("UICorner")
rangeFillCorner.CornerRadius = UDim.new(1, 0)
rangeFillCorner.Parent = rangeFill

local rangeButton = Instance.new("TextButton")
rangeButton.Size = UDim2.new(1, 0, 1, 0)
rangeButton.BackgroundTransparency = 1
rangeButton.Text = ""
rangeButton.Parent = rangeSlider

-- ===== COOLDOWN =====
local cooldownFrame = Instance.new("Frame")
cooldownFrame.Size = UDim2.new(1, 0, 0, 45)
cooldownFrame.BackgroundTransparency = 1
cooldownFrame.LayoutOrder = 4
cooldownFrame.Parent = container

local cooldownLabel = Instance.new("TextLabel")
cooldownLabel.Size = UDim2.new(1, 0, 0, 20)
cooldownLabel.BackgroundTransparency = 1
cooldownLabel.Text = "⚡ Cooldown 0.000s"
cooldownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
cooldownLabel.Font = Enum.Font.Gotham
cooldownLabel.TextSize = 13
cooldownLabel.TextXAlignment = Enum.TextXAlignment.Left
cooldownLabel.Parent = cooldownFrame

local cooldownSlider = Instance.new("Frame")
cooldownSlider.Size = UDim2.new(1, 0, 0, 6)
cooldownSlider.Position = UDim2.new(0, 0, 0, 25)
cooldownSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
cooldownSlider.Parent = cooldownFrame

local cooldownSliderCorner = Instance.new("UICorner")
cooldownSliderCorner.CornerRadius = UDim.new(1, 0)
cooldownSliderCorner.Parent = cooldownSlider

local cooldownFill = Instance.new("Frame")
cooldownFill.Size = UDim2.new(0, 0, 1, 0)
cooldownFill.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
cooldownFill.Parent = cooldownSlider

local cooldownFillCorner = Instance.new("UICorner")
cooldownFillCorner.CornerRadius = UDim.new(1, 0)
cooldownFillCorner.Parent = cooldownFill

local cooldownButton = Instance.new("TextButton")
cooldownButton.Size = UDim2.new(1, 0, 1, 0)
cooldownButton.BackgroundTransparency = 1
cooldownButton.Text = ""
cooldownButton.Parent = cooldownSlider

-- ===== BOTONES DE OPCIONES =====
local optionsFrame = Instance.new("Frame")
optionsFrame.Size = UDim2.new(1, 0, 0, 100)
optionsFrame.BackgroundTransparency = 1
optionsFrame.LayoutOrder = 5
optionsFrame.Parent = container

-- Grid layout para los botones
local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0.5, -5, 0, 40)
gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
gridLayout.FillDirection = Enum.FillDirection.Horizontal
gridLayout.Parent = optionsFrame

-- Función para crear botones modernos
local function createModernButton(text, color, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    return btn
end

-- Crear botones
local wallBtn = createModernButton("🧱 WALL CHECK", Color3.fromRGB(40, 40, 40), optionsFrame)
local knifeBtn = createModernButton("🔪 KNIFE MODE", Color3.fromRGB(40, 40, 40), optionsFrame)

-- ===== FUNCIONALIDAD DE LAS BARRAS =====
local draggingPrecision = false
local draggingCooldown = false
local draggingRange = false

-- Actualizar precisión
local function updatePrecision(mouseX)
    local bgPos = precisionSlider.AbsolutePosition.X
    local bgSize = precisionSlider.AbsoluteSize.X
    local percent = (mouseX - bgPos) / bgSize
    percent = math.clamp(percent, 0, 1)
    
    precisionFill.Size = UDim2.new(percent, 0, 1, 0)
    precision = math.floor(percent * 100)
    precisionLabel.Text = "🎯 Precisión " .. precision .. "%"
end

-- Actualizar rango (100 a 10000)
local function updateRange(mouseX)
    local bgPos = rangeSlider.AbsolutePosition.X
    local bgSize = rangeSlider.AbsoluteSize.X
    local percent = (mouseX - bgPos) / bgSize
    percent = math.clamp(percent, 0, 1)
    
    rangeFill.Size = UDim2.new(percent, 0, 1, 0)
    range = math.floor(100 + (percent * 9900)) -- 100 a 10000
    rangeLabel.Text = "📏 Rango " .. range
end

-- Actualizar cooldown
local function updateCooldown(mouseX)
    local bgPos = cooldownSlider.AbsolutePosition.X
    local bgSize = cooldownSlider.AbsoluteSize.X
    local percent = (mouseX - bgPos) / bgSize
    percent = math.clamp(percent, 0, 1)
    
    cooldownFill.Size = UDim2.new(percent, 0, 1, 0)
    cooldown = percent
    cooldownLabel.Text = "⚡ Cooldown " .. string.format("%.3f", cooldown) .. "s"
end

-- Eventos precisión
precisionButton.MouseButton1Down:Connect(function(input)
    draggingPrecision = true
    updatePrecision(input.Position.X)
end)

-- Eventos rango
rangeButton.MouseButton1Down:Connect(function(input)
    draggingRange = true
    updateRange(input.Position.X)
end)

-- Eventos cooldown
cooldownButton.MouseButton1Down:Connect(function(input)
    draggingCooldown = true
    updateCooldown(input.Position.X)
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        if draggingPrecision then
            updatePrecision(mousePos.X)
        end
        if draggingRange then
            updateRange(mousePos.X)
        end
        if draggingCooldown then
            updateCooldown(mousePos.X)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingPrecision = false
        draggingRange = false
        draggingCooldown = false
    end
end)

precisionButton.MouseButton1Click:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    updatePrecision(mousePos.X)
end)

rangeButton.MouseButton1Click:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    updateRange(mousePos.X)
end)

cooldownButton.MouseButton1Click:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    updateCooldown(mousePos.X)
end)

-- ===== FUNCIONALIDAD DE BOTONES =====
toggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        toggleBtn.Text = "ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        toggleBtn.Text = "OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    end
end)

wallBtn.MouseButton1Click:Connect(function()
    wallCheck = not wallCheck
    wallBtn.BackgroundColor3 = wallCheck and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(40, 40, 40)
    wallBtn.Text = wallCheck and "🧱 WALL CHECK ON" or "🧱 WALL CHECK"
end)

knifeBtn.MouseButton1Click:Connect(function()
    knifeMode = not knifeMode
    knifeBtn.BackgroundColor3 = knifeMode and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(40, 40, 40)
    knifeBtn.Text = knifeMode and "🔪 KNIFE MODE ON" or "🔪 KNIFE MODE"
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    enabled = false
end)

-- ===== FUNCIÓN DE VISIBILIDAD =====
local function isTargetVisible(targetPart)
    if not wallCheck then return true end
    
    local character = player.Character
    if not character or not character:FindFirstChild("Head") then return false end
    
    local camera = workspace.CurrentCamera
    local origin = character.Head.Position
    local direction = (targetPart.Position - origin).Unit * range -- Usar el rango del slider
    
    local ray = Ray.new(origin, direction)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {character, camera})
    
    return hit and hit:IsDescendantOf(targetPart.Parent)
end

-- ===== FUNCIÓN PARA DETECTAR CUCHILLO =====
local function hasKnifeEquipped()
    local character = player.Character
    if not character then return false end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if tool then
        local toolName = tool.Name:lower()
        if toolName:find("knife") or toolName == "Knife" then
            return true
        end
    end
    return false
end

-- ===== VARIABLE PARA CONTROLAR EL LTIMO DISPARO =====
local lastShotTime = 0

-- ===== FUNCIoN PRINCIPAL DEL TRIGGERBOT =====
RunService.Heartbeat:Connect(function()
    if not enabled then return end
    
    local currentTime = tick()
    if currentTime - lastShotTime < cooldown then
        return
    end
    
    local target = mouse.Target
    if not target then return end
    
    local model = target.Parent
    if not model then return end
    
    -- Verificar distancia
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local distance = (character.HumanoidRootPart.Position - target.Position).Magnitude
        if distance > range then
            return
        end
    end
    
    local hum = model:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    
    local plr = game:GetService("Players"):GetPlayerFromCharacter(model)
    if not plr or plr == player then return end
    
    if not isTargetVisible(target) then return end
    
    if knifeMode and hasKnifeEquipped() then
        return
    end
    
    if math.random(1, 100) <= precision then
        mouse1click()
        lastShotTime = currentTime
    end
end)
