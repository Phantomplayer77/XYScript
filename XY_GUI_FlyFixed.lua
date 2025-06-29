-- XY GUI v3.0 - Fly mod düzeltilmiş, tam entegre GUI scripti

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local flying = false
local flySpeed = 100
local bodyGyro, bodyVelocity
local connection

-- UI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "XY_GUI"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Name = "MainFrame"
frame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
frame.Size = UDim2.new(0, 280, 0, 320)
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

local function createTextBox(name, placeholder, yPos)
	local box = Instance.new("TextBox", frame)
	box.Name = name
	box.PlaceholderText = placeholder
	box.Size = UDim2.new(0.9, 0, 0, 30)
	box.Position = UDim2.new(0.05, 0, yPos, 0)
	box.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
	box.TextColor3 = Color3.new(1, 1, 1)
	box.Font = Enum.Font.Gotham
	box.TextSize = 14
	local corner = Instance.new("UICorner", box)
	corner.CornerRadius = UDim.new(0, 6)
	return box
end

local function startFly()
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")

	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.P = 10000
	bodyGyro.CFrame = hrp.CFrame
	bodyGyro.Parent = hrp

	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVelocity.Velocity = Vector3.new(0, 0, 0)
	bodyVelocity.Parent = hrp

	connection = RunService.RenderStepped:Connect(function()
		local direction = Vector3.new(0,0,0)
		local camCF = workspace.CurrentCamera.CFrame
		local lookVector = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z)
		local rightVector = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z)

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction = direction + lookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			direction = direction - lookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			direction = direction - rightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			direction = direction + rightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			direction = direction + Vector3.new(0, 1, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			direction = direction - Vector3.new(0, 1, 0)
		end

		if direction.Magnitude > 0 then
			direction = direction.Unit * flySpeed
		end

		bodyVelocity.Velocity = direction
		bodyGyro.CFrame = camCF
	end)
end

local function stopFly()
	if connection then
		connection:Disconnect()
		connection = nil
	end
	if bodyGyro then
		bodyGyro:Destroy()
		bodyGyro = nil
	end
	if bodyVelocity then
		bodyVelocity:Destroy()
		bodyVelocity = nil
	end
end

local flyBtn = createButton("FlyBtn", "✈️ Uçuşu Aç/Kapat", 0.15)
flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		startFly()
		flyBtn.Text = "🛑 Uçuşu Durdur"
	else
		stopFly()
		flyBtn.Text = "✈️ Uçuşu Aç/Kapat"
	end
end)

local speedBox = createTextBox("SpeedBox", "Speed (16-300)", 0.25)
speedBox.FocusLost:Connect(function()
	local value = tonumber(speedBox.Text)
	if value and value >= 16 and value <= 300 then
		flySpeed = value
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = value
		end
	end
end)

local tpButton = createButton("TeleportTool", "🧭 Teleport Aracı Al", 0.4)
tpButton.MouseButton1Click:Connect(function()
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

local hpButton = createButton("MaxHealth", "❤️ Canı 99999 Yap", 0.55)
hpButton.MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.MaxHealth = 99999
		hum.Health = 99999
	end
end)
