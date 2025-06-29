-- XY GUI v3.1 – Fly butonu özel GUI (FLY_GUI_V3) açar

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "XY_GUI"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Name = "MainFrame"
frame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
frame.Size = UDim2.new(0, 280, 0, 250)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Text = "🔴 XY GUI"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local function createButton(name, text, yPos)
	local btn = Instance.new("TextButton", frame)
	btn.Name = name
	btn.Text = text
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, yPos, 0)
	btn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 6)
	return btn
end

-- FLY BUTTON – FlyGuiV3'i çağırır
local flyBtn = createButton("FlyBtn", "✈️ Uçma Panelini Aç", 0.15)
flyBtn.MouseButton1Click:Connect(function()
	loadstring([[
-- FLY_GUI_V3 içeriği (kısaltılmış örnek)
-- Buraya senin tam FLY_GUI_V3.txt kodun gelecek
-- Örnek olarak basit bir print komutu:
print("FLY_GUI_V3 Açıldı!")

]])()
end)

-- Teleport Tool
local tpBtn = createButton("TPBtn", "🧭 Teleport Aracı", 0.35)
tpBtn.MouseButton1Click:Connect(function()
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

-- Max Health
local hpBtn = createButton("HPBtn", "❤️ Canı 99999 Yap", 0.55)
hpBtn.MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = 99999
		hum.Health = 99999
	end
end)
