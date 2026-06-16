-- Script Logic Self | Auto Update Loader

local SCRIPT_URL = "https://raw.githubusercontent.com/lsxast3-ui/Script-Logic-Self/main/NexusMenu.lua"
local KEY_URL = "https://raw.githubusercontent.com/lsxast3-ui/Script-Logic-Self/main/keysystem.lua"

-- Simple Key Check Function
local function checkKey(key)
    local success, result = pcall(function()
        return game:HttpGet(KEY_URL)
    end)

    if success then
        local validKeys = loadstring(result)()
        for _, v in pairs(validKeys) do
            if v == key then
                return true
            end
        end
    end
    return false
end

-- MAIN LOADER UI (simple)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)

Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0, 20, 0, 40)
TextBox.PlaceholderText = "Enter Key"

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0, 260, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "Execute"

Button.MouseButton1Click:Connect(function()
    local key = TextBox.Text

    if checkKey(key) then
        local script = game:HttpGet(SCRIPT_URL)
        loadstring(script)()
    else
        Button.Text = "Invalid Key"
        wait(1)
        Button.Text = "Execute"
    end
end)
