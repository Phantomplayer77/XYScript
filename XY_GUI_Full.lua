-- XY GUI – Siyah Kare Logo + Sayfa Sistemi + Tıklayınca Aç/Kapanır

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "XY_GUI"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 280, 0, 320)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Visible = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Text = "🔴 XY GUI"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local page1 = Instance.new("Frame", frame)
page1.Size = UDim2.new(1, 0, 1, -40)
page1.Position = UDim2.new(0, 0, 0, 30)
page1.BackgroundTransparency = 1

local page2 = Instance.new("Frame", frame)
page2.Size = page1.Size
page2.Position = page1.Position
page2.BackgroundTransparency = 1
page2.Visible = false

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

createButton(page1, "FlyBtn", "✈️ Uçuş GUI Aç", 0.05).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

createButton(page1, "TeleportBtn", "🧭 Teleport Aracı", 0.25).MouseButton1Click:Connect(function()
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

createButton(page1, "MaxHealth", "❤️ Canı 99999 Yap", 0.45).MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = 99999
		hum.Health = 99999
	end
end)

createButton(page2, "TargetFly", "🛸 Kişiyi Uçur", 0.05).MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://pastebin.com/raw/e8KTvWr9"))()
end)

local nextPage = createButton(frame, "NextPage", "➡️ Sonraki Sayfa", 0.88)
local prevPage = createButton(frame, "PrevPage", "⬅️ Önceki Sayfa", 0.88)
prevPage.Visible = false

nextPage.MouseButton1Click:Connect(function()
	page1.Visible = false
	page2.Visible = true
	nextPage.Visible = false
	prevPage.Visible = true
end)

prevPage.MouseButton1Click:Connect(function()
	page1.Visible = true
	page2.Visible = false
	nextPage.Visible = true
	prevPage.Visible = false
end)

-- Kodla oluşturulan siyah kare (logo yerine)
local logo = Instance.new("TextButton", screenGui)
logo.Size = UDim2.new(0, 80, 0, 80)
logo.Position = UDim2.new(0.02, 0, 0.05, 0)
logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logo.Text = ""
logo.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

page1.Parent = frame
page2.Parent = frame
