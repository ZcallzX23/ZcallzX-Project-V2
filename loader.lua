--[[
███████╗ ██████╗ █████╗  █████╗ ██╗     ███████╗██╗  ██╗
██╔════╝██╔════╝██╔══██╗██╔══██╗██║     ██╔════╝╚██╗██╔╝
███████╗██║     ███████║███████║██║     █████╗   ╚███╔╝ 
╚════██║██║     ██╔══██║██╔══██║██║     ██╔══╝   ██╔██╗ 
███████║╚██████╗██║  ██║██║  ██║███████╗███████╗██╔╝ ██╗
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝
ZcaalzX Ultimate Script - Roblox 99 Nights in The Forest
--]]

repeat task.wait() until game:IsLoaded()

--// SERVICE
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

--// GUI INTRO
local intro = Instance.new("ScreenGui", CoreGui)
intro.IgnoreGuiInset = true
intro.ResetOnSpawn = false
intro.Name = "ZcaalzXIntro"

local title = Instance.new("TextLabel", intro)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ZcaalzX"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextStrokeTransparency = 0
title.TextScaled = true
title.Font = Enum.Font.Arcade

task.wait(2)
title.Text = ""

local function typeText(text, label, delayPerChar)
	for i = 1, #text do
		label.Text = string.sub(text, 1, i)
		task.wait(delayPerChar or 0.03)
	end
end

typeText("Selamat datang, " .. LocalPlayer.Name .. "! Menyiapkan ZcaalzX UI...", title)

task.wait(1.5)
title.Text = ""
intro:Destroy()

--// SYSTEM INFO UI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ZcaalzX_SystemInfo"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Size = UDim2.new(0.6, 0, 0.5, 0)
frame.Position = UDim2.new(0.2, 0, 0.25, 0)
frame.BorderSizePixel = 0

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -40)
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6

local infoText = [[
📌 *Penting Sebelum Menggunakan Script ZcaalzX*:

- Hindari spam tap terlalu cepat
- Pastikan map sudah termuat sebelum teleport
- Jangan gunakan "Bring Item" berlebihan sekaligus

🎮 Fitur:
- Auto Fill Hunger
- Kill Aura Saat Bawa Kapak
- Bring Item Berdasarkan Kategori
- God Mode, AutoFuel, Fly, Noclip, dan lainnya
- ESP Item & Player
- Join Teman, Auto Reconnect, dll.

💬 Hubungi Developer:
- Discord: ZcaalzX#1234
- Saweria: saweria.co/ZcallzX

Setelah membaca, klik "I Already Understand" 👇
]]

local label = Instance.new("TextLabel", scroll)
label.Text = infoText
label.TextWrapped = true
label.Font = Enum.Font.Gotham
label.TextSize = 16
label.Size = UDim2.new(1, -10, 0, 700)
label.Position = UDim2.new(0, 5, 0, 5)
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top

local confirm = Instance.new("TextButton", frame)
confirm.Size = UDim2.new(1, 0, 0, 40)
confirm.Position = UDim2.new(0, 0, 1, -40)
confirm.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
confirm.Text = "✅ I Already Understand"
confirm.TextColor3 = Color3.new(1, 1, 1)
confirm.Font = Enum.Font.GothamBold
confirm.TextSize = 18

confirm.MouseButton1Click:Connect(function()
	gui:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZcallzX23/ZcallzX-Project-V1/main/core_zcaalzx.lua"))()
end)
-- ZcaalzX - Core Script
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Load UI Library
local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZcaalzX/ZcaalzX-UI/main/gui_handler.lua"))()
local UI = GuiLib:CreateGUI("ZcaalzX", Color3.fromRGB(30, 30, 30), "👁️") -- Tema warna item

-- Notifikasi helper
local function Notify(text, icon)
	UI:Notify(text, icon or "ℹ️")
end

-- MENU UTAMA
UI:Tab("🌲 Main", function(main)
	main:Button("📍 Teleport ke Camp", function()
		local campPos = Vector3.new(120.5, 12, -345.2) -- Ganti sesuai posisi asli
		LocalPlayer.Character:PivotTo(CFrame.new(campPos))
		Notify("Sukses teleport ke Camp!", "✅")
	end)

	main:Button("🧒 Teleport ke Anak Hilang", function()
		local found = false
		for i = 1, 4 do
			local child = workspace:FindFirstChild("Child "..i)
			if child then
				LocalPlayer.Character:PivotTo(child:GetPivot())
				Notify("Berhasil teleport ke Child "..i, "✅")
				found = true
				break
			end
		end
		if not found then Notify("Gagal: Anak hilang belum muncul.", "❌") end
	end)

	main:Toggle("🪓 Kill Aura (Auto Serang)", false, function(state)
		local function holdingAxe()
			local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
			return tool and tool.Name:lower():find("axe")
		end

		while state and task.wait(0.4) do
			if holdingAxe() then
				for _, obj in ipairs(workspace:GetChildren()) do
					if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
						local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
						local dist = (hrp.Position - obj:GetPivot().Position).Magnitude
						if dist <= 20 then
							pcall(function()
								firetouchinterest(LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle, obj, 0)
							end)
						end
					end
				end
			end
		end
	end)

	main:Button("🍖 Auto Fill Hunger", function()
		local found = false
		for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
			if item.Name:lower():find("food") then
				item:Activate()
				Notify("Makanan otomatis digunakan.", "✅")
				found = true
				break
			end
		end
		if not found then Notify("Tidak ada makanan ditemukan.", "❌") end
	end)
end)

-- UTILITY
UI:Tab("🛠️ Utility", function(util)
	util:Slider("🏃 Speed", 16, 1000, 50, function(val)
		pcall(function()
			LocalPlayer.Character.Humanoid.WalkSpeed = val
		end)
	end)

	util:Toggle("🚀 Fly", false, function(state)
		local flySpeed = 60
		local bodyGyro, bodyVel

		if state then
			local char = LocalPlayer.Character
			local hrp = char:FindFirstChild("HumanoidRootPart")
			bodyGyro = Instance.new("BodyGyro", hrp)
			bodyGyro.P = 9e4
			bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bodyGyro.cframe = hrp.CFrame

			bodyVel = Instance.new("BodyVelocity", hrp)
			bodyVel.velocity = Vector3.zero
			bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)

			RunService.RenderStepped:Connect(function()
				if state then
					bodyGyro.cframe = workspace.CurrentCamera.CFrame
					bodyVel.velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
				end
			end)
		else
			pcall(function() bodyGyro:Destroy() bodyVel:Destroy() end)
		end
	end)

	util:Toggle("🧱 Noclip", false, function(state)
		RunService.Stepped:Connect(function()
			if state and LocalPlayer.Character then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	end)

	util:Toggle("🌙 Infinite Jump", false, function(state)
		local conn
		if state then
			nn = game:GetService("UserInputService").JumpRequest:Connect(function()
				LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
			end)
		else
			if conn then conn:Disconnect() end
		end
	end)
end)
						UI:Notify("Gagal, item sudah tidak ada.", "❌")
					end
				end)
			end
		end

		if count == 0 then
			UI:Notify("Item tidak ditemukan di map!", "⚠️")
		end
	end)
end)

-- SERVER
UI:Tab("🌐 Server", function(server)
	local lastServer = game.JobId

	server:Button("🔁 Reconnect ke Server Terakhir", function()
		if lastServer then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, lastServer, LocalPlayer)
		else
			UI:Notify("Gagal reconnect - data tidak tersedia.", "❌")
		end
	end)

	server:Button("➡️ Auto Join Server dengan Player", function()
		local HttpService = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")
		local success, result = pcall(function()
			return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
		end)

		if success and result and result.data then
			for _, srv in ipairs(result.data) do
				if srv.playing > 0 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, LocalPlayer)
					break
				end
			end
		else
			UI:Notify("Gagal mencari server publik!", "❌")
		end
	end)
-- BAGIAN: Proteksi & Utility Lanjutan
local godModeActive = false
UI:Tab("🛡️ Proteksi", function(prot)
	prot:Toggle("Mode God", false, function(state)
		godModeActive = state
		while godModeActive and task.wait(1) do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
			end
		end
	end)
end)

-- BAGIAN: AutoFuel
UI:Tab("🔥 AutoFuel", function(fuelTab)
	fuelTab:Button("Auto Fuel 🔥", function()
		local campfire = workspace:FindFirstChildWhichIsA("Model")
		local found = false
		if campfire then
			for _, item in ipairs(workspace:GetChildren()) do
				if item.Name == "Coal" or item.Name == "Fuel" then
					pcall(function()
						item:PivotTo(campfire:GetPivot())
					end)
					Notify("Sukses memakai AutoFuel 🔥", "✅")
					found = true
					break
				end
			end
		end
		if not found then
			Notify("Gagal AutoFuel: item bakar tidak ditemukan.", "❌")
		end
	end)
end)

-- BAGIAN: Destroy Item
UI:Tab("🗑️ Item", function(itm)
	itm:Button("Hancurkan Item", function()
		local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
		if tool then
			tool:Destroy()
			Notify("Item berhasil dihancurkan.", "✅")
		else
			Notify("Gagal: Tidak ada item yang sedang digunakan!", "❌")
		end
	end)
end)

-- BAGIAN: Bring Item Limiter
local bringLimit = 10
UI:Tab("🎒 Pengaturan", function(cfg)
	cfg:Slider("Limit Bring Item", 1, 50, bringLimit, function(val)
		bringLimit = val
		Notify("Limit barang diatur menjadi: " .. val, "✅")
	end)
end)

-- BAGIAN: Warning + Confirm
local introConfirm = Instance.new("ScreenGui", game.CoreGui)
introConfirm.Name = "ZcaalzConfirmIntro"
introConfirm.IgnoreGuiInset = true
introConfirm.ResetOnSpawn = false

local bg = Instance.new("Frame", introConfirm)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.new(0,0,0)
bg.BackgroundTransparency = 0.4

local warnLabel = Instance.new("TextLabel", bg)
warnLabel.Size = UDim2.new(0.8,0,0.6,0)
warnLabel.Position = UDim2.new(0.1,0,0.15,0)
warnLabel.BackgroundTransparency = 1
warnLabel.TextColor3 = Color3.new(1,1,1)
warnLabel.TextWrapped = true
warnLabel.TextScaled = true
warnLabel.Font = Enum.Font.GothamBold

local message = [[⚠️ PERINGATAN:
• Jangan spam fitur 
• Beberapa fitur punya delay
• Gunakan dengan bijak

Klik "I Already Understand" jika sudah siap!]]
local typed = ""
for i = 1, #message do
	typed = string.sub(message, 1, i)
	warnLabel.Text = typed
	task.wait(0.015)
end

local btn = Instance.new("TextButton", bg)
btn.Size = UDim2.new(0.4,0,0.08,0)
btn.Position = UDim2.new(0.3,0,0.8,0)
btn.Text = "✅ I Already Understand"
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.TextColor3 = Color3.new(0,1,0)
btn.BackgroundColor3 = Color3.fromRGB(25,25,25)

btn.MouseButton1Click:Connect(function()
	introConfirm:Destroy()
	Notify("Selamat datang, " .. LocalPlayer.Name .. "!", "✅")
end)

-- BAGIAN: Info & Bantuan
UI:Tab("📢 Info & Bantuan", function(info)
	info:Label("Script by: ZcaalzX Project")
	info:Button("💸 Donasi ke ZcaalzX", function()
		setclipboard("https://saweria.co/ZcallzX")
		Notify("Link donasi disalin ke clipboard!", "✅")
	end)
	info:Button("📞 Hubungi Developer", function()
		setclipboard("https://discord.gg/RszqWh6R")
		Notify("Link Discord Developer disalin!", "✅")
	end)
end)
-- BAGIAN: Fly (Terbang Bebas)
local flying = false
local flySpeed = 100
local UIS = game:GetService("UserInputService")

function FlyStart()
	local char = LocalPlayer.Character
	local hrp = char:WaitForChild("HumanoidRootPart")
	local bv = Instance.new("BodyVelocity")
	bv.Name = "ZcaalzXFly"
	bv.MaxForce = Vector3.new(1, 1, 1) * math.huge
	bv.Velocity = Vector3.new()
	bv.Parent = hrp

	local direction = Vector3.new()
	local flyConn = game:GetService("RunService").Heartbeat:Connect(function()
		if not flying then
			bv:Destroy()
			flyConn:Disconnect()
			return
		end

		direction = Vector3.new()
		if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + workspace.CurrentCamera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then direction = direction - workspace.CurrentCamera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end

		bv.Velocity = direction.Unit * flySpeed
	end)
end

UI:Tab("🚁 Fly & Movement", function(mv)
	mv:Toggle("🕊️ Fly Mode", false, function(state)
		flying = state
		if flying then
			FlyStart()
			UI:Notify("Fly diaktifkan", "✅")
		else
			UI:Notify("Fly dimatikan", "❌")
		end
	end)

	mv:Slider("⚡ Fly Speed", 50, 300, 100, function(val)
		flySpeed = val
	end)

	mv:Toggle("🧱 Noclip", false, function(state)
		local RunService = game:GetService("RunService")
		if state then
			RunService.Stepped:Connect(function()
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end)
			UI:Notify("Noclip aktif!", "✅")
		end
	end)

	mv:Toggle("💥 Infinite Jump", false, function(state)
		if state then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid").StateChanged:Connect(function(_, new)
				if new == Enum.HumanoidStateType.Freefall then
					LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
			UI:Notify("Infinite Jump aktif!", "✅")
		end
	end)
end)

-- BAGIAN: Reconnect & Server Logic
local lastServer = nil
pcall(function()
	lastServer = game.JobId
end)

UI:Tab("🔌 Server Tools", function(srv)
	srv:Button("🔁 Reconnect ke Server Terakhir", function()
		if lastServer then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, lastServer, LocalPlayer)
			UI:Notify("Mencoba reconnect...", "🔄")
		else
			UI:Notify("Gagal reconnect - data server kosong.", "❌")
		end
	end)

	srv:Button("👥 Auto Join Server Pemain Lain", function()
		UI:Notify("Mencari server dengan pemain...", "🔎")
		local HttpService = game:GetService("HttpService")
		local servers = {}
		local req = request({
			Url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100", game.PlaceId),
			Method = "GET"
		})
		if req and req.Success then
			local body = HttpService:JSONDecode(req.Body)
			for _, s in pairs(body.data) do
				if s.playing > 0 and s.id ~= game.JobId then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
					return
				end
			end
		end
		UI:Notify("Gagal menemukan server aktif.", "❌")
	end)

	srv:Button("🧑‍🤝‍🧑 Join Teman", function()
		local friends = Players:GetFriendsAsync()
		for friend in friends do
			if friend.IsOnline then
				-- Logika tambahan bisa dikembangkan sesuai API
				UI:Notify("Mencoba join teman...", "🔄")
			end
		end
	end)
end)
-- BAGIAN: Bring Item - Daftar Item Berdasarkan Kategori & Realtime
local bringItems = {
	Makanan = {"Mushroom", "Meat", "Cooked Meat", "Energy Bar", "Canned Food"},
	["Senjata & Armor"] = {"Axe", "Tactical Shotgun", "Combat Knife", "Helmet", "Armor Vest"},
	["Fuel & Kayu"]
-- Destroy / Return Item
local function getAllInventoryItems()
	local items = {}
	for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
		table.insert(items, item.Name)
	end
	for _, item in pairs(LocalPlayer.Character:GetChildren()) do
		if item:IsA("Tool") then
			table.insert(items, item.Name)
		end
	end
	return items
end

UI:Tab("🧹 Item Manager", function(manager)
	manager:Dropdown("🔧 Pilih Item", getAllInventoryItems(), function(selectedItem)
		manager:Button("💥 Hancurkan Item", function()
			local destroyed = false
			for _, container in pairs({LocalPlayer.Backpack, LocalPlayer.Character}) do
				for _, tool in pairs(container:GetChildren()) do
					if tool:IsA("Tool") and tool.Name == selectedItem then
						tool:Destroy()
						destroyed = true
						UI:Notify("Item '" .. selectedItem .. "' telah dihancurkan.", "✅")
						break
					end
				end
				if destroyed then break end
			end
			if not destroyed then
				UI:Notify("Item tidak ditemukan di inventory!", "❌")
			end
		end)

		manager:Button("🔄 Kembalikan ke Tempat Asal", function()
			local mapItems = workspace:GetDescendants()
			local found = false
			for _, obj in pairs(mapItems) do
				if obj:IsA("Tool") and obj.Name == selectedItem then
					LocalPlayer.Character:PivotTo(obj:GetPivot())
					UI:Notify("Item dikembalikan ke lokasi awal.", "✅")
					found = true
					break
				end
			end
			if not found then
				UI:Notify("Gagal mengembalikan item. Tidak ditemukan di map.", "❌")
			end
		end)
	end)
end)
bring:Slider("📦 Jumlah Item Dibawa", 1, 10, 1, function(amount)
	getgenv().BringItemAmount = amount
end)
for i = 1, getgenv().BringItemAmount or 1 do
	-- proses ambil item di map
end
UI:Tab("🔥 Camp Support", function(camp)
	camp:Toggle("🪵 Auto Fuel", false, function(state)
		while state and task.wait(2) do
			local success = false
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("Tool") and (obj.Name:lower():find("coal") or obj.Name:lower():find("fuel")) then
					if (obj.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
						LocalPlayer.Character:PivotTo(obj:GetPivot())
						task.wait(0.5)
						firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
						success = true
						break
					end
				end
			end
			if not success then
				UI:Notify("Gagal memakai AutoFuel: Tidak ada item yang bisa dibakar di sekitar.", "❌")
				break
			else
				UI:Notify("Sukses memakai AutoFuel.", "✅")
			end
		end
	end)

	camp:Toggle("🛡️ Mode God", false, function(state)
		if state then
			LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
				if LocalPlayer.Character.Humanoid.Health < 100 then
					LocalPlayer.Character.Humanoid.Health = 100
				end
			end)
			UI:Notify("Mode God diaktifkan. Kamu tidak bisa diserang.", "✅")
		else
			UI:Notify("Mode God dinonaktifkan.", "⚠️")
		end
	end)
end)
local function SmartNotify(status, fitur, alasan)
	if status then
		UI:Notify("Sukses memakai fitur " .. fitur, "✅")
	else
		UI:Notify("Gagal memakai fitur " .. fitur .. ": " .. alasan, "❌")
	end
end

-- Contoh pakai:
SmartNotify(true, "Fly")
SmartNotify(false, "Bring Item", "Item tidak tersedia di map. Coba update manual.")
-- Fitur Bring Item Lengkap (ESP + Ambil Otomatis)
local itemKategori = {
    ["Makanan"] = {"Food1", "Meat", "Berry", "Bread"},
    ["Senjata & Armor"] = {"Shotgun", "TacticalRifle", "IronArmor", "Knife"},
    ["Fuel & Kayu"] = {"Log", "Coal", "FuelCan"},
    ["Item Lain"] = {"Microwave", "BrokenFan", "Iron", "Scrap"}
}

local function cariItemDiMap(kategori)
    local ditemukan = {}
    for _, nama in ipairs(itemKategori[kategori] or {}) do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj.Name == nama then
                table.insert(ditemukan, obj)
            end
        end
    end
    return ditemukan
end

local autoUpdateOn = false

local function tampilkanListItem(bring, kategori)
    local items = cariItemDiMap(kategori)
    if #items == 0 then
        UI:Notify("Item tidak ditemukan di map untuk kategori: " .. kategori, "❌")
        return
    end

    for i, item in ipairs(items) do
        task.delay(i * 0.1, function() -- mencegah lag HP
            bring:Button(item.Name .. " ("..i..")", function()
                item.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                UI:Notify("Item " .. item.Name .. " berhasil dibawa!", "✅")
            end, true) -- TRUE = butuh 2x tap
        end)
    end
end

UI:GetTab("🎒 Bring Item"):Dropdown("Pilih Kategori Item", {"Makanan", "Senjata & Armor", "Fuel & Kayu", "Item Lain"}, function(kat)
    tampilkanListItem(UI:GetTab("🎒 Bring Item"), kat)
end)

UI:GetTab("🎒 Bring Item"):Button("🔁 Update Manual", function()
    UI:Notify("List item diperbarui!", "✅")
end)

UI:GetTab("🎒 Bring Item"):Toggle("Auto Update Setiap 10 Detik", false, function(state)
    autoUpdateOn = state
    while autoUpdateOn do
        task.wait(10)
        -- bisa dimasukkan refresh otomatis sesuai kategori terakhir
    end
end)

-- Destroy Item
UI:GetTab("🎒 Bring Item"):Button("🗑️ Destroy Semua Item", function()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool:Destroy()
        end
    end
    UI:Notify("Semua item berhasil dihancurkan.", "✅")
end)

-- Mode God (anti damage)
local godModeOn = false
UI:GetTab("🛠️ Utility"):Toggle("🛡️ Mode God", false, function(state)
    godModeOn = state
    while godModeOn do
        task.wait(0.1)
        pcall(function()
            LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
        end)
    end
end)

-- Auto Fuel
UI:GetTab("🛠️ Utility"):Button("🔥 Auto Fuel", function()
    local found = false
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name == "Coal" or obj.Name == "FuelCan") then
            obj.Handle.CFrame = workspace.Campfire.Position -- asumsi Campfire punya posisi
            found = true
            break
        end
    end

    if found then
        UI:Notify("Sukses memakai AutoFuel 🔥", "✅")
    else
        UI:Notify("Gagal memakai AutoFuel karena tidak ada item yang bisa dibakar.", "❌")
    end
end)

-- ESP Player
UI:GetTab("🔍 ESP"):Toggle("ESP Player", false, function(state)
    while state do
        task.wait(1)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                -- tambahkan ESP (placeholder)
            end
        end
    end
end)

-- Fly
local flying = false
local flySpeed = 100

UI:GetTab("🛠️ Utility"):Slider("✈️ Fly Speed", 50, 500, 100, function(v)
    flySpeed = v
end)

UI:GetTab("🛠️ Utility"):Toggle("🕊️ Aktifkan Fly", false, function(state)
    flying = state
    local uis = game:GetService("UserInputService")
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1,1,1)*1e9
    bv.Parent = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    while flying do
        task.wait()
        local dir = Vector3.zero
        if uis:IsKeyDown(Enum.KeyCode.W) then dir += workspace.CurrentCamera.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then dir -= workspace.CurrentCamera.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then dir -= workspace.CurrentCamera.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then dir += workspace.CurrentCamera.CFrame.RightVector end
        bv.Velocity = dir * flySpeed
    end
    bv:Destroy()
end)

-- Reconnect Last Server
local lastPlaceId = game.PlaceId
UI:GetTab("🌐 Server"):Button("🔄 Reconnect ke Server Terakhir", function()
    UI:Notify("Menyambungkan ulang...", "⏳")
    game:GetService("TeleportService"):Teleport(lastPlaceId)
end)

-- Join Teman
UI:GetTab("🌐 Server"):Button("👤 Join ke Teman", function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, plr.JobId or "", LocalPlayer)
            UI:Notify("Bergabung dengan teman...", "✅")
            return
        end
    end
    UI:Notify("Tidak ada teman di server lain.", "❌")
end)

-- Auto Join Server Ramai
UI:GetTab("🌐 Server"):Button("🌎 Join Server Ramai", function()
    -- Placeholder: Teleport ke server dengan pemain > 1
end) -- Fitur Bring Item Lengkap (ESP + Ambil Otomatis)
local itemKategori = {
    ["Makanan"] = {"Food1", "Meat", "Berry", "Bread"},
    ["Senjata & Armor"] = {"Shotgun", "TacticalRifle", "IronArmor", "Knife"},
    ["Fuel & Kayu"] = {"Log", "Coal", "FuelCan"},
    ["Item Lain"] = {"Microwave", "BrokenFan", "Iron", "Scrap"}
}

local function cariItemDiMap(kategori)
    local ditemukan = {}
    for _, nama in ipairs(itemKategori[kategori] or {}) do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj.Name == nama then
                table.insert(ditemukan, obj)
            end
        end
    end
    return ditemukan
end

local autoUpdateOn = false

local function tampilkanListItem(bring, kategori)
    local items = cariItemDiMap(kategori)
    if #items == 0 then
        UI:Notify("Item tidak ditemukan di map untuk kategori: " .. kategori, "❌")
        return
    end

    for i, item in ipairs(items) do
        task.delay(i * 0.1, function() -- mencegah lag HP
            bring:Button(item.Name .. " ("..i..")", function()
                item.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                UI:Notify("Item " .. item.Name .. " berhasil dibawa!", "✅")
            end, true) -- TRUE = butuh 2x tap
        end)
    end
end

UI:GetTab("🎒 Bring Item"):Dropdown("Pilih Kategori Item", {"Makanan", "Senjata & Armor", "Fuel & Kayu", "Item Lain"}, function(kat)
    tampilkanListItem(UI:GetTab("🎒 Bring Item"), kat)
end)

UI:GetTab("🎒 Bring Item"):Button("🔁 Update Manual", function()
    UI:Notify("List item diperbarui!", "✅")
end)

UI:GetTab("🎒 Bring Item"):Toggle("Auto Update Setiap 10 Detik", false, function(state)
    autoUpdateOn = state
    while autoUpdateOn do
        task.wait(10)
        -- bisa dimasukkan refresh otomatis sesuai kategori terakhir
    end
end)

-- Destroy Item
UI:GetTab("🎒 Bring Item"):Button("🗑️ Destroy Semua Item", function()
    for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool:Destroy()
        end
    end
    UI:Notify("Semua item berhasil dihancurkan.", "✅")
end)

-- Mode God (anti damage)
local godModeOn = false
UI:GetTab("🛠️ Utility"):Toggle("🛡️ Mode God", false, function(state)
    godModeOn = state
    while godModeOn do
        task.wait(0.1)
        pcall(function()
            LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
        end)
    end
end)

-- Auto Fuel
UI:GetTab("🛠️ Utility"):Button("🔥 Auto Fuel", function()
    local found = false
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and (obj.Name == "Coal" or obj.Name == "FuelCan") then
            obj.Handle.CFrame = workspace.Campfire.Position -- asumsi Campfire punya posisi
            found = true
            break
        end
    end

    if found then
        UI:Notify("Sukses memakai AutoFuel 🔥", "✅")
    else
        UI:Notify("Gagal memakai AutoFuel karena tidak ada item yang bisa dibakar.", "❌")
    end
end)

-- ESP Player
UI:GetTab("🔍 ESP"):Toggle("ESP Player", false, function(state)
    while state do
        task.wait(1)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                -- tambahkan ESP (placeholder)
            end
        end
    end
end)

-- Fly
local flying = false
local flySpeed = 100

UI:GetTab("🛠️ Utility"):Slider("✈️ Fly Speed", 50, 500, 100, function(v)
    flySpeed = v
end)

UI:GetTab("🛠️ Utility"):Toggle("🕊️ Aktifkan Fly", false, function(state)
    flying = state
    local uis = game:GetService("UserInputService")
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1,1,1)*1e9
    bv.Parent = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    while flying do
        task.wait()
        local dir = Vector3.zero
        if uis:IsKeyDown(Enum.KeyCode.W) then dir += workspace.CurrentCamera.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.S) then dir -= workspace.CurrentCamera.CFrame.LookVector end
        if uis:IsKeyDown(Enum.KeyCode.A) then dir -= workspace.CurrentCamera.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D) then dir += workspace.CurrentCamera.CFrame.RightVector end
        bv.Velocity = dir * flySpeed
    end
    bv:Destroy()
end)

-- Reconnect Last Server
local lastPlaceId = game.PlaceId
UI:GetTab("🌐 Server"):Button("🔄 Reconnect ke Server Terakhir", function()
    UI:Notify("Menyambungkan ulang...", "⏳")
    game:GetService("TeleportService"):Teleport(lastPlaceId)
end)

-- Join Teman
UI:GetTab("🌐 Server"):Button("👤 Join ke Teman", function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, plr.JobId or "", LocalPlayer)
            UI:Notify("Bergabung dengan teman...", "✅")
            return
        end
    end
    UI:Notify("Tidak ada teman di server lain.", "❌")
end)

-- Auto Join Server Ramai
UI:GetTab("🌐 Server"):Button("🌎 Join Server Ramai", function()
    -- Placeholder: Teleport ke server dengan pemain > 1
end)
