repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ZcaalzX Intro Effect
local intro = Instance.new("ScreenGui", game.CoreGui)
intro.IgnoreGuiInset = true
intro.ResetOnSpawn = false
intro.Name = "ZcaalzIntro"

local label = Instance.new("TextLabel", intro)
label.Size = UDim2.new(1, 0, 1, 0)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundTransparency = 1
label.Text = "ZcaalzX"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextStrokeTransparency = 0
label.TextScaled = true
label.Font = Enum.Font.Arcade

task.wait(2)
label.Text = ""
local greetingText = "Selamat datang, " .. LocalPlayer.Name .. "! Script ZcaalzX siap dijalankan..."
for i = 1, #greetingText do
	label.Text = string.sub(greetingText, 1, i)
	task.wait(0.03)
end

task.wait(2)
intro:Destroy()
local GuiLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZcaalzX/ZcaalzX-UI/main/gui_handler.lua"))()
local UI = GuiLib:CreateGUI("ZcaalzX", Color3.fromRGB(255, 140, 0), "🟠") -- Tema item/forest
UI:Tab("🌲 Main", function(main)
	main:Button("📍 Teleport ke Camp", function()
		LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(123, 10, -456))) -- Ganti ke posisi akurat
		UI:Notify("Sukses teleport ke Camp.", "✅")
	end)

	main:Button("🧒 Teleport ke Anak Hilang", function()
		for i = 1, 4 do
			local child = workspace:FindFirstChild("Child "..i)
			if child then
				LocalPlayer.Character:PivotTo(child:GetPivot())
				UI:Notify("Sukses teleport ke Child "..i, "✅")
				return
			end
		end
		UI:Notify("Gagal teleport - Anak belum ditemukan", "❌")
	end)

	main:Toggle("🪓 Kill Aura (Saat bawa kapak)", false, function(state)
		local holdingAxe = function()
			return tostring(LocalPlayer.Character:FindFirstChildOfClass("Tool")):lower():find("axe")
		end
		while state and task.wait(0.5) do
			if holdingAxe() then
				for _, mob in pairs(workspace:GetChildren()) do
					if mob:FindFirstChild("Humanoid") and (mob.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
						pcall(function()
							firetouchinterest(LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle, mob, 0)
						end)
					end
				end
			end
		end
	end)

	main:Button("🍖 Auto Fill Hunger", function()
		local backpack = LocalPlayer.Backpack
		for _, item in pairs(backpack:GetChildren()) do
			if tostring(item):lower():find("food") then
				item:Activate()
				UI:Notify("Sukses mengisi hunger otomatis.", "✅")
				return
			end
		end
		UI:Notify("Gagal - Tidak ada makanan di inventory.", "❌")
	end)
end)
UI:Tab("🔍 ESP", function(esp)
	esp:Toggle("Item ESP", false, function(state)
		-- Tambahkan sesuai item
	end)

	esp:Toggle("Player ESP", false, function(state)
		-- Tambahkan ESP player
	end)
end)
UI:Tab("🛠️ Utility", function(util)
	util:Slider("Speed", 16, 1000, 100, function(val)
		LocalPlayer.Character.Humanoid.WalkSpeed = val
	end)

	util:Toggle("🚀 Fly", false, function(state)
		-- Script fly dan pengaturan speed fly
	end)

	util:Toggle("🧱 NoClip", false, function(state)
		-- Noclip logic
	end)

	util:Toggle("🔁 Infinite Jump", false, function(state)
		-- Infinite Jump logic
	end)
end)
UI:Tab("🌐 Server", function(srv)
	srv:Button("🔁 Reconnect ke Server Terakhir", function()
		-- Logic reconnect server & restore state
	end)

	srv:Button("➡️ Auto Join Server Pemain Lain", function()
		-- Join server lain yang sudah ada player
	end)

	srv:Button("👥 Join Teman", function()
		-- Join server teman
	end)
end)
UI:Tab("🎒 Bring Item", function(bring)
	bring:Dropdown("Kategori", {"Makanan", "Senjata & Armor", "Fuel & Kayu", "Item Lain"}, function(kategori)
		-- Munculkan item satu per satu + 2x tap untuk pilih
	end)

	bring:Button("🔄 Update Manual", function()
		UI:Notify("Daftar item berhasil diperbarui.", "✅")
	end)

	bring:Toggle("⏱️ Update Otomatis (10s)", false, function(state)
		-- Loop update item list
	end)
end)
UI:Tab("📢 Info", function(info)
	info:Label("Hello, " .. LocalPlayer.Name)
	info:Label("Terima kasih telah menggunakan script ZcaalzX.")
	info:Button("💸 Donasi via Saweria", function()
		setclipboard("https://saweria.co/ZcallzX")
		UI:Notify("Link donasi disalin ke clipboard!", "✅")
	end)
end)
UI:Tab("💬 Hubungi Dev", function(dev)
	dev:Button("💌 Kirim Feedback atau Saran", function()
		UI:Notify("Silakan kirim pesan via Discord: ZcaalzX#1234", "📨")
	end)
end)
UI:Build()
