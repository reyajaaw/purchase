-- Axolta Fake Purchase GUI V14.0 - ULTRA FAST LOOP (MAX 1000/sec possible)

-- Delay min 0.001, batch skip fetch, notif limit

local Players = game:GetService("Players")

local MarketplaceService = game:GetService("MarketplaceService")

local TweenService = game:GetService("TweenService")

local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

-- MAIN GUI

local gui = Instance.new("ScreenGui", playerGui)

gui.Name = "AxoltaPurchase"

gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)

frame.Size = UDim2.new(0,300,0,215)

frame.Position = UDim2.new(0.35,0,0.35,0)

frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

frame.BorderSizePixel = 0

frame.Active = true

frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- TITLE

local title = Instance.new("TextLabel", frame)

title.Text = "Axolta Ultra Fast Purchase"

title.Size = UDim2.new(1,-40,0,30)

title.Position = UDim2.new(0,10,0,6)

title.BackgroundTransparency = 1

title.Font = Enum.Font.GothamBold

title.TextSize = 16

title.TextColor3 = Color3.fromRGB(255,255,255)

title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE BUTTON

local closeBtn = Instance.new("TextButton", frame)

closeBtn.Size = UDim2.new(0,30,0,30)

closeBtn.Position = UDim2.new(1,-34,0,4)

closeBtn.BackgroundTransparency = 1

closeBtn.Text = "❌"

closeBtn.Font = Enum.Font.GothamBold

closeBtn.TextSize = 20

closeBtn.TextColor3 = Color3.fromRGB(255,120,120)

-- INPUT BOX

local function makeBox(text,y)

	local b = Instance.new("TextBox", frame)	b.Text = text

	b.ClearTextOnFocus = false

	b.Size = UDim2.new(1,-20,0,30)

	b.Position = UDim2.new(0,10,0,y)

	b.BackgroundColor3 = Color3.fromRGB(50,50,50)

	b.TextColor3 = Color3.fromRGB(255,255,255)

	b.Font = Enum.Font.Gotham

	b.TextSize = 14

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

	b.Focused:Connect(function()

		if b.Text == text then b.Text = "" end

	end)

	b.FocusLost:Connect(function()

		if b.Text == "" then b.Text = text end

	end)

	return b

end

local idBox = makeBox("Enter UGC ID (e.g. 82120626157139)",42)

local timeBox = makeBox("Delay sec (min 0.001 = ultra fast)",82)

-- INFO DISPLAY

local infoFrame = Instance.new("Frame", frame)

infoFrame.Size = UDim2.new(1,-20,0,48)

infoFrame.Position = UDim2.new(0,10,0,118)

infoFrame.BackgroundTransparency = 1

local itemName = Instance.new("TextLabel", infoFrame)

itemName.Size = UDim2.new(1,0,1,0)

itemName.BackgroundTransparency = 1

itemName.Font = Enum.Font.GothamBold

itemName.TextSize = 12

itemName.TextWrapped = true

itemName.TextXAlignment = Enum.TextXAlignment.Left

itemName.TextYAlignment = Enum.TextYAlignment.Top

itemName.TextColor3 = Color3.fromRGB(255,255,255)

itemName.Text = "Item: -"

local itemPrice = Instance.new("TextLabel", infoFrame)

itemPrice.Position = UDim2.new(0,0,1,-14)

itemPrice.BackgroundTransparency = 1

itemPrice.Font = Enum.Font.Gotham

itemPrice.TextSize = 12

itemPrice.TextColor3 = Color3.fromRGB(150,255,150)

itemPrice.TextXAlignment = Enum.TextXAlignment.Left

itemPrice.Text = "Price: - R$"

-- BUTTON

local function makeButton(text,pos)

	local b = Instance.new("TextButton", frame)

	b.Size = UDim2.new(0,130,0,30)

	b.Position = pos

	b.BackgroundColor3 = Color3.fromRGB(70,70,70)

	b.Text = text

	b.Font = Enum.Font.GothamBold

	b.TextSize = 14

	b.TextColor3 = Color3.fromRGB(255,255,255)

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

	return b

end

local purchaseButton = makeButton("Purchase Once", UDim2.new(0,10,0,170))

local autoPurchaseButton = makeButton("Ultra Loop 1000x", UDim2.new(0,160,0,170))

-- NOTIF SYSTEM (limited to 10 active biar ga lag)

local NOTIF_LIFETIME = 1.2

local NOTIF_MOVE = 0.15

local activeNotifs = 0

local MAX_NOTIFS = 10

local function showNotification(assetId, name, success)

	if activeNotifs >= MAX_NOTIFS then return end

	activeNotifs += 1

	local notif = Instance.new("Frame", gui)

	notif.Size = UDim2.new(0,300,0,60)

	notif.BackgroundColor3 = success and Color3.fromRGB(40,100,40) or Color3.fromRGB(100,40,40)

	notif.BorderSizePixel = 0

	notif.ZIndex = 50

	Instance.new("UICorner", notif).CornerRadius = UDim.new(0,12)

	local startY = 0.82

	notif.Position = UDim2.new(0.5, -150, startY, 0)

	local thumb = Instance.new("ImageLabel", notif)

	thumb.Size = UDim2.new(0,46,0,46)

	thumb.Position = UDim2.new(0,8,0.5,-23)

	thumb.BackgroundTransparency = 1

	thumb.Image = "rbxthumb://type=Asset&id="..tostring(assetId).."&w=420&h=420"

	thumb.ZIndex = 51

	Instance.new("UICorner", thumb).CornerRadius = UDim.new(0,8)

	local lbl = Instance.new("TextLabel", notif)

	lbl.Size = UDim2.new(1,-66,1,-12)

	lbl.Position = UDim2.new(0,62,0,6)

	lbl.BackgroundTransparency = 1

	lbl.Font = Enum.Font.GothamBold

	lbl.TextSize = 14

	lbl.TextWrapped = true

	lbl.TextXAlignment = Enum.TextXAlignment.Left

	lbl.TextYAlignment = Enum.TextYAlignment.Center

	lbl.TextColor3 = Color3.fromRGB(255,255,255)

	lbl.ZIndex = 51

	lbl.Text = (success and "Purchased: " or "Failed: ") .. tostring(name)

	for _,child in ipairs(notif:GetChildren()) do

		if child:IsA("GuiObject") then child.ZIndex = 51 end

	end

	local targetPos = UDim2.new(0.5, -150, startY - NOTIF_MOVE, 0)

	local tween = TweenService:Create(notif, TweenInfo.new(NOTIF_LIFETIME, Enum.EasingStyle.Linear), {Position = targetPos})

	tween:Play()

	task.delay(NOTIF_LIFETIME, function()

		if notif and notif.Parent then 

			notif:Destroy() 

			activeNotifs -= 1

		end

	end)

end

-- PURCHASE FUNCTION (optimized for speed)

local lastId = nil

local cachedName = "Unknown"

local cachedPrice = "-"

local function purchaseUGC()

	local idStr = idBox.Text:gsub("%s+", "")

	local id = tonumber(idStr)

	if not id then 

		showNotification(0, "Invalid ID!", false)

		return 

	end

	local name = cachedName

	local price = cachedPrice

	if id ~= lastId then

		local success, info = pcall(function()

			return MarketplaceService:GetProductInfo(id)

		end)

		if success and info then

			name = info.Name

			price = (info.PriceInRobux or 0) .. " R$"

			cachedName = name

			cachedPrice = price

			itemName.Text = "Item: " .. name

			itemPrice.Text = "Price: " .. price

		else

			itemName.Text = "Item: Fetch failed"

			itemPrice.Text = "Price: -"

		end

		lastId = id

	end

	pcall(function()

		MarketplaceService:SignalPromptPurchaseFinished(player, id, true)

	end)

	showNotification(id, name, true)

end

purchaseButton.MouseButton1Click:Connect(purchaseUGC)

-- ULTRA FAST AUTO LOOP

local running = false

autoPurchaseButton.MouseButton1Click:Connect(function()

	running = not running

	autoPurchaseButton.Text = running and "Stop Ultra" or "Ultra Loop 1000x"

	if running then

		task.spawn(function()

			while running do

				purchaseUGC()

				local rawDelay = tonumber(timeBox.Text) or 0.001

				local delay = math.max(0.001, rawDelay)  -- MAX SPEED: 1000 calls/sec teorinya

				task.wait(delay)

			end

		end)

	end

end)

-- MINIMIZE (sama kayak sebelumnya)

local mini = Instance.new("TextButton", gui)

mini.Size = UDim2.new(0,45,0,45)

mini.Text = "🪐"

mini.Font = Enum.Font.GothamBold

mini.TextSize = 28

mini.TextColor3 = Color3.fromRGB(255,255,255)

mini.BackgroundColor3 = Color3.fromRGB(45,45,45)

mini.Visible = false

mini.Draggable = true

Instance.new("UICorner", mini).CornerRadius = UDim.new(0,12)

local dragStart, dragging

mini.MouseButton1Down:Connect(function()

	dragStart = UserInputService:GetMouseLocation()

	dragging = false

end)

mini.MouseMoved:Connect(function()

	if dragStart and (UserInputService:GetMouseLocation() - dragStart).Magnitude > 6 then

		dragging = true

	end

end)

mini.MouseButton1Up:Connect(function()

	if not dragging then

		frame.Position = mini.Position

		frame.Visible = true

		mini.Visible = false

	end

	dragStart = nil

end)

closeBtn.MouseButton1Click:Connect(function()

	frame.Visible = false

	mini.Position = frame.Position

	mini.Visible = true

end)

print("[Axolta ULTRA FAST] Gaspol! Set delay 0.001, auto loop bakal kenceng banget (sampai 1000x/sec kalo executor lu kuat). Kalo lag/crash, naikin delay ke 0.01-0.05.")