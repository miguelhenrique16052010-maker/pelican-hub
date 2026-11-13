-- PELICAN HUB - painel demonstrativo para uma experiência sua no Roblox Studio
-- Instale como LocalScript em StarterPlayer > StarterPlayerScripts.
-- Não é um exploit nem um ESP para jogos de terceiros.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "PelicanHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local purple = Color3.fromRGB(135, 65, 230)
local dark = Color3.fromRGB(27, 19, 42)
local white = Color3.fromRGB(245, 240, 255)
local panel = Color3.fromRGB(55, 37, 78)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(330, 300)
main.Position = UDim2.new(0.5, -165, 0.5, -150)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local outline = Instance.new("UIStroke")
outline.Color = purple
outline.Thickness = 2
outline.Parent = main

local top = Instance.new("Frame")
top.Name = "Header"
top.Size = UDim2.new(1, 0, 0, 42)
top.BackgroundColor3 = purple
top.BorderSizePixel = 0
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -85, 1, 0)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "💜 PELICAN HUB"
title.TextColor3 = white
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35, 30)
minimize.Position = UDim2.new(1, -42, 0, 6)
minimize.Text = "−"
minimize.TextSize = 23
minimize.Font = Enum.Font.GothamBold
minimize.TextColor3 = white
minimize.BackgroundColor3 = dark
minimize.Parent = top
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 7)

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -55)
content.Position = UDim2.fromOffset(10, 50)
content.BackgroundTransparency = 1
content.Parent = main

local info = Instance.new("TextLabel")
info.Name = "Info"
info.Size = UDim2.new(1, 0, 0, 85)
info.Position = UDim2.fromOffset(0, 0)
info.BackgroundTransparency = 1
info.TextColor3 = white
info.TextWrapped = true
info.TextYAlignment = Enum.TextYAlignment.Center
info.Font = Enum.Font.Gotham
info.TextSize = 13
info.Text = "Bem-vindo ao PELICAN HUB!\nEscolha uma opção abaixo."
info.Parent = content

local function makeButton(label, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 38)
    button.Position = UDim2.fromOffset(0, y)
    button.BackgroundColor3 = panel
    button.TextColor3 = white
    button.Text = label
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = content
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
    button.Activated:Connect(callback)
    return button
end

makeButton("👥 Lista de jogadores", 95, function()
    local names = {}
    for _, target in ipairs(Players:GetPlayers()) do
        table.insert(names, target.Name)
    end
    info.Text = "JOGADORES NA EXPERIÊNCIA:\n" .. table.concat(names, "\n")
end)

makeButton("📡 Radar demonstrativo", 140, function()
    info.Text = "RADAR\nJogadores conectados: " .. tostring(#Players:GetPlayers()) ..
        "\nEste painel demonstra a contagem, sem rastrear jogadores."
end)

makeButton("🎒 Painel de itens", 185, function()
    info.Text = "PAINEL DE ITENS\nAdicione aqui os itens e atributos definidos no seu próprio jogo."
end)

makeButton("❌ Fechar interface", 230, function()
    gui:Destroy()
end)

local minimized = false
minimize.Activated:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    main.Size = minimized and UDim2.fromOffset(330, 42) or UDim2.fromOffset(330, 300)
    minimize.Text = minimized and "+" or "−"
end)

-- Arrastar pelo cabeçalho (mouse ou toque)
local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                     input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
