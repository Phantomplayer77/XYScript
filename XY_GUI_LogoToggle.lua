-- XY GUI Panel – Logo ile Aç/Kapat

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI ana yapı
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "XY_GUI"
screenGui.ResetOnSpawn = false

-- Açılır pencere (panel)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 280, 0, 320)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Text = "🔴 XY GUI"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Sayfa çerçevesi
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, 0, 1, -40)
content.Position = UDim2.new(0, 0, 0, 30)
content.BackgroundTransparency = 1

local function createButton(parent, name, text, yPos)
	local btn = Instance.new("TextButton", parent)
	btn.Name = name
	btn.Text = text
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, yPos, 0)
	btn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

-- Butonlar
createButton(content, "FlyBtn", "✈️ Uçuş GUI Aç", 0.05).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

createButton(content, "TeleportBtn", "🧭 Teleport Aracı", 0.25).MouseButton1Click:Connect(function()
	if player.Backpack:FindFirstChild("XY_TeleportTool") then return end
	local tool = Instance.new("Tool", player.Backpack)
	tool.RequiresHandle = false
	tool.Name = "XY_TeleportTool"
	tool.Activated:Connect(function()
		local pos = mouse.Hit.Position
		local character = player.Character or player.CharacterAdded:Wait()
		character:MoveTo(pos)
	end)
end)

createButton(content, "MaxHealth", "❤️ Canı 99999 Yap", 0.45).MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = 99999
		hum.Health = 99999
	end
end)

createButton(content, "TargetFly", "🛸 Kişiyi Uçur", 0.65).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://pastebin.com/raw/e8KTvWr9"))()
end)

-- Logo (tıklanabilir)
local logo = Instance.new("ImageButton", screenGui)
logo.Size = UDim2.new(0, 80, 0, 80)
logo.Position = UDim2.new(0.02, 0, 0.05, 0)
logo.Image = "rbxassetid://80116374530887"
logo.BackgroundTransparency = 1
logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Parent ayarları
content.Parent = frame
