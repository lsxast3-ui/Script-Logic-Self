local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- CONFIG
local SCRIPT_URL = "https://raw.githubusercontent.com/lsxast3-ui/Script-Logic-Self/main/NexusMenu.lua"

local VALID_KEYS = {
	["NEXUS-123"] = true,
	["VIP-ACCESS"] = true,
	["ADMIN-999"] = true
}

-- COLORS
local BG_MAIN = Color3.fromRGB(20,20,23)
local BG_TOPBAR = Color3.fromRGB(28,28,32)
local BG_INPUT = Color3.fromRGB(24,24,28)

local ACCENT = Color3.fromRGB(0,162,255)

local TEXT_MAIN = Color3.fromRGB(255,255,255)
local TEXT_DARK = Color3.fromRGB(150,150,155)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptLogicSelfLoader"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- MAIN
local main = Instance.new("Frame")
main.Size = UDim2.new(0,0,0,0)
main.Position = UDim2.new(0.5,0,0.5,0)
main.BackgroundColor3 = BG_MAIN
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(45,45,50)
stroke.Parent = main

-- OPEN ANIMATION
TweenService:Create(
	main,
	TweenInfo.new(0.3, Enum.EasingStyle.Back),
	{
		Size = UDim2.new(0,420,0,230),
		Position = UDim2.new(0.5,-210,0.5,-115)
	}
):Play()

-- TOPBAR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,45)
topBar.BackgroundColor3 = BG_TOPBAR
topBar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0,12)
topCorner.Parent = topBar

local hideBottom = Instance.new("Frame")
hideBottom.Size = UDim2.new(1,0,0,10)
hideBottom.Position = UDim2.new(0,0,1,-10)
hideBottom.BackgroundColor3 = BG_TOPBAR
hideBottom.BorderSizePixel = 0
hideBottom.Parent = topBar

-- TITLE
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,-50,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "SCRIPT LOGIC SELF"
title.TextColor3 = TEXT_MAIN
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,40,0,40)
closeBtn.Position = UDim2.new(1,-45,0.5,-20)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,100,100)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = topBar

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- SUBTITLE
local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.new(1,0,0,25)
subtitle.Position = UDim2.new(0,0,0,65)

subtitle.Text = "Authentication Required"
subtitle.TextColor3 = TEXT_DARK
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.Parent = main

-- INPUT
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85,0,0,42)
keyBox.Position = UDim2.new(0.075,0,0.45,0)

keyBox.BackgroundColor3 = BG_INPUT
keyBox.TextColor3 = TEXT_MAIN

keyBox.PlaceholderText = "Enter Access Key..."
keyBox.PlaceholderColor3 = TEXT_DARK

keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14

keyBox.Parent = main

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0,8)
keyCorner.Parent = keyBox

-- BUTTON
local unlockBtn = Instance.new("TextButton")
unlockBtn.Size = UDim2.new(0.85,0,0,40)
unlockBtn.Position = UDim2.new(0.075,0,0.67,0)

unlockBtn.BackgroundColor3 = ACCENT
unlockBtn.TextColor3 = TEXT_MAIN

unlockBtn.Text = "UNLOCK"
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.TextSize = 14

unlockBtn.Parent = main

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0,8)
btnCorner.Parent = unlockBtn

-- STATUS
local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1

status.Size = UDim2.new(0.85,0,0,20)
status.Position = UDim2.new(0.075,0,0.88,0)

status.Text = "Status : Waiting Key"
status.TextColor3 = TEXT_DARK

status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left

status.Parent = main

-- DRAG
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

		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- CHECK KEY
unlockBtn.MouseButton1Click:Connect(function()

	local key = keyBox.Text

	status.Text = "Status : Checking..."
	status.TextColor3 = ACCENT

	task.wait(1)

	if VALID_KEYS[key] then

		status.Text = "Status : Access Granted"
		status.TextColor3 = Color3.fromRGB(100,255,100)

		shared.AUTHORIZED = true

		task.wait(0.5)

		local source = game:HttpGet(SCRIPT_URL)

		TweenService:Create(
			main,
			TweenInfo.new(0.25),
			{
				Size = UDim2.new(0,0,0,0)
			}
		):Play()

		task.wait(0.25)

		gui:Destroy()

		loadstring(source)()

	else

		status.Text = "Status : Invalid Key"
		status.TextColor3 = Color3.fromRGB(255,100,100)

	end
end)
