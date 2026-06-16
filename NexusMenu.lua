if not shared.AUTHORIZED then
    return
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- CONSTANTS (Color Palette)
local BG_MAIN = Color3.fromRGB(20, 20, 23)
local BG_TOPBAR = Color3.fromRGB(28, 28, 32)
local BG_TAB_ACTIVE = Color3.fromRGB(40, 40, 45)
local BG_TAB_INACTIVE = Color3.fromRGB(24, 24, 28)
local ACCENT_COLOR = Color3.fromRGB(0, 162, 255) -- Neon Blue Accent
local TEXT_MAIN = Color3.fromRGB(255, 255, 255)
local TEXT_DARK = Color3.fromRGB(150, 150, 155)

-- GUI ROOT
local gui = Instance.new("ScreenGui")
gui.Name = "CustomMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- MINIMIZED ICON
local miniButton = Instance.new("TextButton")
miniButton.Size = UDim2.new(0, 50, 0, 50)
miniButton.Position = UDim2.new(0, 30, 0.5, -25)
miniButton.Text = "⚡"
miniButton.TextColor3 = ACCENT_COLOR
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 20
miniButton.BackgroundColor3 = BG_TOPBAR
miniButton.Visible = false
miniButton.Parent = gui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 12)
miniCorner.Parent = miniButton

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = ACCENT_COLOR
miniStroke.Thickness = 1.5
miniStroke.Parent = miniButton

-- MAIN FRAME
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 550, 0, 380)
main.Position = UDim2.new(0.5, -275, 0.5, -190)
main.BackgroundColor3 = BG_MAIN
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 50)
mainStroke.Thickness = 1
mainStroke.Parent = main

-- TOP BAR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundColor3 = BG_TOPBAR
topBar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 12)
topCorner.Parent = topBar

-- Sembunyikan corner bawah topBar agar menyatu dengan main frame
local topBarHideBottom = Instance.new("Frame")
topBarHideBottom.Size = UDim2.new(1, 0, 0, 10)
topBarHideBottom.Position = UDim2.new(0, 0, 1, -10)
topBarHideBottom.BackgroundColor3 = BG_TOPBAR
topBarHideBottom.BorderSizePixel = 0
topBarHideBottom.ZIndex = 1
topBarHideBottom.Parent = topBar

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "NEXUS MENU"
title.TextColor3 = TEXT_MAIN
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.ZIndex = 2
title.Parent = topBar

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0.5, -20)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BackgroundTransparency = 1
closeBtn.ZIndex = 2
closeBtn.Parent = topBar

-- MINIMIZE BUTTON
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 40, 0, 40)
minBtn.Position = UDim2.new(1, -85, 0.5, -20)
minBtn.Text = "─"
minBtn.TextColor3 = TEXT_DARK
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.BackgroundTransparency = 1
minBtn.ZIndex = 2
minBtn.Parent = topBar

-- SIDEBAR / TAB CONTAINER (Pindah ke kiri agar lebih modern daripada di atas)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 140, 1, -50)
tabContainer.Position = UDim2.new(0, 0, 0, 50)
tabContainer.BackgroundColor3 = BG_TAB_INACTIVE
tabContainer.BorderSizePixel = 0
tabContainer.Parent = main

local tabs = {"Visual", "Combat", "Player", "Misc"}
local tabFrames = {}
local tabButtons = {}

for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, 15 + (i-1)*45)
	btn.Text = "  " .. name
	btn.TextColor3 = TEXT_DARK
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
	btn.BackgroundTransparency = 1
	btn.Parent = tabContainer

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn

	tabButtons[name] = btn

	-- Tab content frame
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -160, 1, -70)
	frame.Position = UDim2.new(0, 150, 0, 60)
	frame.BackgroundColor3 = BG_MAIN
	frame.BackgroundTransparency = 1
	frame.Visible = false
	frame.Parent = main

	tabFrames[name] = frame

	btn.MouseButton1Click:Connect(function()
		for tName, f in pairs(tabFrames) do
			f.Visible = false
			TweenService:Create(tabButtons[tName], TweenInfo.new(0.2), {
				BackgroundTransparency = 1,
				TextColor3 = TEXT_DARK
			}):Play()
		end
		frame.Visible = true
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundTransparency = 0,
			BackgroundColor3 = BG_TAB_ACTIVE,
			TextColor3 = ACCENT_COLOR
		}):Play()
	end)
end

-- SET DEFAULT TAB ACTIVATION WITH TWEEN
tabFrames["Visual"].Visible = true
tabButtons["Visual"].BackgroundTransparency = 0
tabButtons["Visual"].BackgroundColor3 = BG_TAB_ACTIVE
tabButtons["Visual"].TextColor3 = ACCENT_COLOR

-- DRAG SYSTEM (SMOOTH LERP DRAG)
local dragging = false
local dragStart
local startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

topBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		local targetPos = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		-- Menggunakan Tween agar pergerakan GUI saat di-drag terasa halus (Smooth)
		TweenService:Create(main, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
	end
end)

-- DRAG SYSTEM for MINI BUTTON
local miniDragging = false
local miniDragStart
local miniStartPos

miniButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		miniDragging = true
		miniDragStart = input.Position
		miniStartPos = miniButton.Position
	end
end)

miniButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		miniDragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if miniDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - miniDragStart
		local targetPos = UDim2.new(
			miniStartPos.X.Scale,
			miniStartPos.X.Offset + delta.X,
			miniStartPos.Y.Scale,
			miniStartPos.Y.Offset + delta.Y
		)
		TweenService:Create(miniButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
	end
end)

-- CLOSE ANIMATION
closeBtn.MouseButton1Click:Connect(function()
	TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}):Play()
	task.wait(0.2)
	main.Visible = false
	miniButton.Visible = false
	main.Size = UDim2.new(0, 550, 0, 380) -- Reset size untuk pemakaian berikutnya
end)

-- MINIMIZE ANIMATION
minBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	miniButton.Visible = true
end)

-- RESTORE ANIMATION
miniButton.MouseButton1Click:Connect(function()
	main.Visible = true
	miniButton.Visible = false
end)

-- MINIMIZE SHORTCUT WITH KEY "K"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.K then
		if main.Visible then
			main.Visible = false
			miniButton.Visible = true
		else
			main.Visible = true
			miniButton.Visible = false
		end
	end
end)
