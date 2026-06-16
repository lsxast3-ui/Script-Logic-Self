local KEY_URL = "https://raw.githubusercontent.com/lsxast3-ui/Script-Logic-Self/main/keysystem.lua"
local SCRIPT_URL = "https://raw.githubusercontent.com/lsxast3-ui/Script-Logic-Self/main/NexusMenu.lua"

-- load keys dari github
local keys = loadstring(game:HttpGet(KEY_URL))()

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,300,0,180)
frame.Position = UDim2.new(0.5,-150,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0,260,0,40)
box.Position = UDim2.new(0,20,0,40)
box.PlaceholderText = "Enter Key"

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0,260,0,40)
btn.Position = UDim2.new(0,20,0,100)
btn.Text = "UNLOCK"

btn.MouseButton1Click:Connect(function()
    local input = box.Text
    local valid = false

    for _, key in pairs(keys) do
        if input == key then
            valid = true
        end
    end

    if valid then
        shared.AUTHORIZED = true

        local script = game:HttpGet(SCRIPT_URL)
        loadstring(script)()

        frame:Destroy()
    else
        btn.Text = "WRONG KEY"
        task.wait(1)
        btn.Text = "UNLOCK"
    end
end)
