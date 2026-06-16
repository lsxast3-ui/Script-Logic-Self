--// LOGIC MENU | SYNAPSE STYLE PREMIUM LOADER

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LogicSynapseLoader"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// THEME
local BG = Color3.fromRGB(15,15,18)
local CARD = Color3.fromRGB(22,22,26)
local ACCENT = Color3.fromRGB(0,170,255)
local TEXT = Color3.fromRGB(255,255,255)
local SUB = Color3.fromRGB(160,160,170)

--// MAIN CONTAINER
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 0, 0, 0)
main.Position = UDim2.new(0.5,0,0.5,0)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(40,40,50)
stroke.Thickness = 1
stroke.Parent = main

TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {
	Size = UDim2.new(0, 460,0, 260),
	Position = UDim2.new(0.5,-230,0.5,-130)
}):Play()

--// TOP BAR
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,50)
top.BackgroundColor3 = CARD
top.Parent = main

Instance.new("UICorner", top).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,1,0)
title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1
title.Text = "LOGIC SYNAPSE"
title.TextColor3 = TEXT
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

--// CLOSE
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0.5,-20)
close.BackgroundTransparency = 1
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255,90,90)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.Parent = top

close.MouseButton1Click:Connect(function()
	TweenService:Create(main, TweenInfo.new(0.25), {
		Size = UDim2.new(0,0,0,0)
	}):Play()
	task.wait(0.25)
	gui:Destroy()
end)

--// SUB TEXT
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,0,0,20)
sub.Position = UDim2.new(0,0,0,70)
sub.BackgroundTransparency = 1
sub.Text = "Secure Access Required"
sub.TextColor3 = SUB
sub.Font = Enum.Font.Gotham
sub.TextSize = 13
sub.Parent = main

--// KEY BOX
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.82,0,0,40)
keyBox.Position = UDim2.new(0.09,0,0.42,0)
keyBox.PlaceholderText = "Enter License Key..."
keyBox.Text = ""
keyBox.BackgroundColor3 = CARD
keyBox.TextColor3 = TEXT
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.Parent = main

Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,10)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(35,35,45)
keyStroke.Parent = keyBox

--// BUTTON
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.82,0,0,40)
button.Position = UDim2.new(0.09,0,0.67,0)
button.BackgroundColor3 = ACCENT
button.Text = "AUTHENTICATE"
button.TextColor3 = TEXT
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.Parent = main

Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)

--// STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,20)
status.Position = UDim2.new(0,0,0,210)
status.BackgroundTransparency = 1
status.Text = "Waiting for input..."
status.TextColor3 = SUB
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = main

--// MINI ICON (SYNAPSE STYLE L)
local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0,52,0,52)
mini.Position = UDim2.new(0,25,0.5,-26)
mini.BackgroundColor3 = CARD
mini.Text = ""
mini.Visible = false
mini.Parent = gui

Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = ACCENT
miniStroke.Thickness = 2
miniStroke.Parent = mini

-- neon L icon
local l1 = Instance.new("Frame")
l1.Size = UDim2.new(0,4,0.6,0)
l1.Position = UDim2.new(0.35,0,0.2,0)
l1.BackgroundColor3 = ACCENT
l1.BorderSizePixel = 0
l1.Parent = mini

local l2 = Instance.new("Frame")
l2.Size = UDim2.new(0.35,0,0,4)
l2.Position = UDim2.new(0.35,0,0.8,0)
l2.BackgroundColor3 = ACCENT
l2.BorderSizePixel = 0
l2.Parent = mini

--// KEY SYSTEM
local VALID_KEYS = {
	["123"] = true,
	["VIP"] = true,
	["999"] = true
}

button.MouseButton1Click:Connect(function()

	local key = string.gsub(keyBox.Text, " ", "")

	status.Text = "Authenticating..."
	status.TextColor3 = ACCENT

	TweenService:Create(status, TweenInfo.new(0.2), {
		TextTransparency = 0
	}):Play()

	task.wait(0.6)

	if VALID_KEYS[key] then
		status.Text = "Access Granted"
		status.TextColor3 = Color3.fromRGB(120,255,120)

		task.wait(0.5)

		mini.Visible = true
		main.Visible = false

	else
		status.Text = "Invalid Key"
		status.TextColor3 = Color3.fromRGB(255,80,80)
	end
end)

-- restore
mini.MouseButton1Click:Connect(function()
	main.Visible = true
	mini.Visible = false
end)

-- drag
local dragging, start, startPos

top.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		start = i.Position
		startPos = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = i.Position - start
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
