local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Kyles YVH Script",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "You VS Homer (Kyles Script)",
   LoadingSubtitle = "by shurts",
   ShowText = "Rayfield", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Kyles YVH Script",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"1"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Player", 4483362458) -- Title, Image

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local CurrentSpeed = 16

-- Apply walkspeed safely
local function ApplySpeed(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.WalkSpeed = CurrentSpeed
    end
end

-- Re-apply on respawn
player.CharacterAdded:Connect(function(character)
    ApplySpeed(character)
end)

-- Slider
local Slider = Tab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 50},
    Increment = 1,
    Suffix = "",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        CurrentSpeed = Value

        if player.Character then
            ApplySpeed(player.Character)
        end
    end,
})


local Slider = Tab:CreateSlider({
   Name = "Jump Power",
   Range = {7, 50},
   Increment = 0.5,
   Suffix = "",
   CurrentValue = 7,
   Flag = "JumpHeightSlider",
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character
         and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then
         hum.UseJumpPower = false
         hum.JumpHeight = Value
      end
   end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local spinConnection

local Toggle = Tab:CreateToggle({
   Name = "Spin",
   CurrentValue = false,
   Flag = "SpinToggle",
   Callback = function(Value)
      local character = player.Character
      local humanoid = character and character:FindFirstChild("Humanoid")

      if Value then
         if humanoid then
            humanoid.AutoRotate = false -- 🔑 this is the fix
         end

         spinConnection = RunService.Heartbeat:Connect(function()
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(9), 0)
         end)
      else
         if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
         end

         if humanoid then
            humanoid.AutoRotate = true -- restore normal movement
         end
      end
   end,
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local spinConnection

local Toggle = Tab:CreateToggle({
   Name = "Spin",
   CurrentValue = false,
   Flag = "SpinToggle",
   Callback = function(Value)
      local character = player.Character
      local humanoid = character and character:FindFirstChild("Humanoid")

      if Value then
         if humanoid then
            humanoid.AutoRotate = false -- 🔑 this is the fix
         end

         spinConnection = RunService.Heartbeat:Connect(function()
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if not root then return end

            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(20), 0)
         end)
      else
         if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
         end

         if humanoid then
            humanoid.AutoRotate = true -- restore normal movement
         end
      end
   end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local flying = false
local flyConn

local SPEED = 60
local VERTICAL_SPEED = 45

local Toggle = Tab:CreateToggle({
    Name = "Goofy Fly (really goofy)",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        local hrp = char:WaitForChild("HumanoidRootPart")
        local cam = workspace.CurrentCamera

        flying = Value

        if flying then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)

            flyConn = RunService.Heartbeat:Connect(function()
                local velocity = Vector3.zero

                -- Horizontal movement
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    velocity += cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    velocity -= cam.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    velocity -= cam.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    velocity += cam.CFrame.RightVector
                end

                -- Vertical movement
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    velocity += Vector3.new(0, 1, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    velocity -= Vector3.new(0, 1, 0)
                end

                -- Normalize + apply
                if velocity.Magnitude > 0 then
                    hrp.AssemblyLinearVelocity =
                        Vector3.new(
                            velocity.X * SPEED,
                            velocity.Y * VERTICAL_SPEED,
                            velocity.Z * SPEED
                        )
                else
                    -- TRUE hover (no falling)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                end
            end)
        else
            if flyConn then
                flyConn:Disconnect()
                flyConn = nil
            end

            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
    end,
})

local InfiniteJumpEnabled = false

local Toggle = Tab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "InfiniteJump",
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end,
})

-- Run a loop to detect jumps and apply vertical velocity
game:GetService("RunService").Stepped:Connect(function()
    if InfiniteJumpEnabled then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") then
            local hrp = character.HumanoidRootPart
            local humanoid = character.Humanoid

            -- Check if player pressed jump
            if humanoid:GetState() ~= Enum.HumanoidStateType.Seated and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                -- Apply upward velocity without touching Humanoid jump state
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
            end
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local Enabled = false
local Looping = false

local TARGET_CFRAME = CFrame.new(-33.54, 210.90, 110.52)

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportCountdownGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Countdown Label
local CountdownLabel = Instance.new("TextLabel")
CountdownLabel.Size = UDim2.new(0, 300, 0, 120)
CountdownLabel.Position = UDim2.new(0.5, -150, 0.4, 0)
CountdownLabel.BackgroundTransparency = 0.2
CountdownLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CountdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CountdownLabel.TextScaled = true
CountdownLabel.Font = Enum.Font.GothamBold
CountdownLabel.Text = ""
CountdownLabel.Visible = false
CountdownLabel.Active = true
CountdownLabel.Parent = ScreenGui

-- 🔹 DRAGGING LOGIC
local dragging = false
local dragStart
local startPos

CountdownLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = CountdownLabel.Position
    end
end)

CountdownLabel.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        CountdownLabel.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- 🔹 TOGGLE
local Toggle = Tab:CreateToggle({
    Name = "Teleport w/ Movable Countdown",
    CurrentValue = false,
    Flag = "TeleportMovableCountdown",
    Callback = function(Value)
        Enabled = Value

        if Value and not Looping then
            Looping = true
            CountdownLabel.Visible = true

            task.spawn(function()
                while Enabled do
                    for i = 7, 1, -1 do
                        if not Enabled then
                            CountdownLabel.Visible = false
                            Looping = false
                            return
                        end

                        CountdownLabel.Text = "Teleporting in\n" .. i
                        task.wait(1)
                    end

                    local character = player.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character:PivotTo(TARGET_CFRAME)
                    end

                    CountdownLabel.Text = "TELEPORTED!"
                    task.wait(0.8)
                end

                CountdownLabel.Visible = false
                Looping = false
            end)
        end

        if not Value then
            CountdownLabel.Visible = false
        end
    end,
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local orbitConn, bp, bg
local angle = 0

local function getHomerHRP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer
        and plr.Team
        and plr.Team.Name == "Homer"
        and plr.Character
        and plr.Character:FindFirstChild("HumanoidRootPart") then
            return plr.Character.HumanoidRootPart
        end
    end
end

Tab:CreateToggle({
   Name = "Orbit Homer",
   CurrentValue = false,
   Flag = "OrbitHomerFinal",
   Callback = function(Value)
      local char = LocalPlayer.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      local hum = char and char:FindFirstChild("Humanoid")
      if not hrp or not hum then return end

      if Value then
         hum.AutoRotate = false

         bp = Instance.new("BodyPosition")
         bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
         bp.P = 30000
         bp.D = 1000
         bp.Parent = hrp

         bg = Instance.new("BodyGyro")
         bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
         bg.P = 30000
         bg.D = 1000
         bg.Parent = hrp

         orbitConn = RunService.RenderStepped:Connect(function(dt)
            local target = getHomerHRP()
            if not target then return end

            angle += dt * 0.6 -- smooth speed

            local radius = 20
            local height = 2

            local pos = target.Position + Vector3.new(
                math.cos(angle) * radius,
                height,
                math.sin(angle) * radius
            )

            bp.Position = pos

            -- Face Homer, perfectly level
            local lookPos = Vector3.new(
                target.Position.X,
                hrp.Position.Y,
                target.Position.Z
            )

            bg.CFrame = CFrame.lookAt(hrp.Position, lookPos)
         end)
      else
         if orbitConn then orbitConn:Disconnect() end
         if bp then bp:Destroy() end
         if bg then bg:Destroy() end
         hum.AutoRotate = true
      end
   end,
})









local Tab = Window:CreateTab("Bart", 4483362458) -- Title, Image


local Players = game:GetService("Players")
local player = Players.LocalPlayer

local TeleportEnabled = false
local Teleporting = false
local TeamConnection

local TARGET_CFRAME = CFrame.new(0.24, 105.00, 22.37)

local Toggle = Tab:CreateToggle({
    Name = "Auto Farm Bart Wins",
    CurrentValue = false,
    Flag = "BartTeleport",
    Callback = function(Value)
        TeleportEnabled = Value

        -- Disconnect old listener
        if TeamConnection then
            TeamConnection:Disconnect()
            TeamConnection = nil
        end

        if Value then
            -- Function that handles teleport logic
            local function TryTeleport()
                if Teleporting then return end
                if not TeleportEnabled then return end
                if not player.Team or player.Team.Name ~= "Bart" then return end

                Teleporting = true
                task.spawn(function()
                    task.wait(5)

                    if TeleportEnabled and player.Team
                        and player.Team.Name == "Bart" then

                        local character = player.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            character.HumanoidRootPart.CFrame = TARGET_CFRAME
                        end
                    end

                    Teleporting = false
                end)
            end

            -- Run immediately in case you're already Bart
            TryTeleport()

            -- Listen for team changes
            TeamConnection = player:GetPropertyChangedSignal("Team"):Connect(TryTeleport)
        end
    end,
})




local Tab = Window:CreateTab("Homer", 4483362458) -- Title, Image

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local Enabled = false
local Running = false
local TeamConnection
local FollowConnection

-- SAFE TEAM CHECK (Team OR TeamColor)
local function IsBart(plr)
    if plr.Team and plr.Team.Name == "Bart" then
        return true
    end
    if plr.TeamColor and plr.TeamColor.Name == "Bart" then
        return true
    end
    return false
end

local function GetChar(plr)
    if plr.Character then return plr.Character end
    return plr.CharacterAdded:Wait()
end

local Toggle = Tab:CreateToggle({
    Name = "Homer Win Auto Farm",
    CurrentValue = false,
    Flag = "HomerHuntBartFixed",
    Callback = function(Value)
        Enabled = Value
        Running = false

        if TeamConnection then TeamConnection:Disconnect() end
        if FollowConnection then FollowConnection:Disconnect() end

        if not Value then return end

        local function Start()
            if Running then return end
            if not player.Team or player.Team.Name ~= "Homer" then return end

            Running = true

            task.spawn(function()
                task.wait(30)

                if not Enabled then
                    Running = false
                    return
                end

                for _, target in ipairs(Players:GetPlayers()) do
                    if not Enabled then break end
                    if target ~= player and IsBart(target) then

                        local myChar = GetChar(player)
                        local targetChar = GetChar(target)

                        local myHRP = myChar:WaitForChild("HumanoidRootPart")
                        local targetHRP = targetChar:WaitForChild("HumanoidRootPart")
                        local targetHum = targetChar:WaitForChild("Humanoid")

                        -- FORCE FOLLOW (PivotTo beats CFrame)
                        FollowConnection = RunService.Heartbeat:Connect(function()
                            if not Enabled or targetHum.Health <= 0 then
                                FollowConnection:Disconnect()
                                FollowConnection = nil
                                return
                            end

                            myChar:PivotTo(
                                targetHRP.CFrame * CFrame.new(0, 0, -2)
                            )
                        end)

                        -- Wait until target dies
                        while Enabled and targetHum.Health > 0 do
                            task.wait(0.1)
                        end

                        if FollowConnection then
                            FollowConnection:Disconnect()
                            FollowConnection = nil
                        end
                    end
                end

                Running = false
            end)
        end

        -- Immediate check
        Start()

        -- Watch for team changes
        TeamConnection = player:GetPropertyChangedSignal("Team"):Connect(Start)
    end,
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

Tab:CreateButton({
    Name = "Rise Platform & Spin Ramp Up",
    Callback = function()
        local char = player.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        local startY = hrp.Position.Y
        local targetY = startY + 15 -- HEIGHT TO DIE AT
        local speed = 3 -- studs per second
        local minSpin = math.rad(720) -- start spin speed (2 spins/sec)
        local maxSpin = math.rad(1440) -- end spin speed (4 spins/sec)

        local accumulatedRotation = 0 -- keeps track of total rotation

        -- CLIENT-SIDED PLATFORM
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(8, 1, 8)
        platform.Anchored = true
        platform.CanCollide = true
        platform.Material = Enum.Material.SmoothPlastic
        platform.Color = Color3.fromRGB(80, 80, 80)
        platform.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
        platform.Parent = workspace

        -- Move platform up
        local conn
        conn = RunService.Heartbeat:Connect(function(dt)
            if not hrp.Parent then
                conn:Disconnect()
                platform:Destroy()
                return
            end

            -- Move platform up
            platform.CFrame += Vector3.new(0, speed * dt, 0)

            -- Calculate spin speed based on how far we've risen (linear interpolation)
            local progress = (platform.Position.Y - startY) / (targetY - startY)
            local currentSpinSpeed = minSpin + (maxSpin - minSpin) * progress

            -- accumulate rotation
            accumulatedRotation = accumulatedRotation + currentSpinSpeed * dt

            -- apply rotation while keeping player above platform
            local platformCFrame = platform.CFrame * CFrame.new(0, 3.5, 0)
            hrp.CFrame = platformCFrame * CFrame.Angles(0, accumulatedRotation, 0)

            if platform.Position.Y >= targetY then
                conn:Disconnect()
                platform:Destroy()
                hum.Health = 0 -- kill player
            end
        end)
    end,
})











local Tab = Window:CreateTab("Teleports", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Basic Teleports")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to BasePlate",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(0.00, 203.50, 0.00)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to Homers Cage",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(-17.25, 104.20, 1798.25)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to Lobby",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(0.24, 105.00, 22.37)
   end,
})

local Section = Tab:CreateSection("SpaceShip Teleports")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to SpaceShip Lights Out Button ",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(-73.48, -115.95, -217.20)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to SpaceShip Top ",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(8.60, -83.97, -250.87)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport out of Death Room",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(7.84, -115.95, -90.46)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to Death Button (Spaceship) ",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(61.17, -115.95, -89.99)
   end,
})

local Section = Tab:CreateSection("Island Bar")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to top of Light House (Island Bar)",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(56.49, -66.35, -56.97)
   end,
})

local Section = Tab:CreateSection("Krusty Krab")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to top of Krusty Krab Sign",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(24.66, -43.35, -96.88)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport outside Krusty Krab",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(-6.00, -79.80, -5.48)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Teleport to secret Krusty Krab Spot",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(-0.19, -55.70, -129.00)
   end,
})


local Tab = Window:CreateTab("Esp", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Bart Esp")

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GLOBAL COLOR (persist across respawns)
_G.BartESPColor = _G.BartESPColor or Color3.fromRGB(0, 255, 0)

-- ESP STORAGE
local bartESP = {}

-- CREATE ESP
local function createBartESP(player)
    if player == LocalPlayer then return end
    if not player.Team or player.Team.Name ~= "Bart" then return end
    if not player.Character then return end

    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not hrp or not head then return end

    -- prevent duplicates
    if hrp:FindFirstChild("BartBox") then return end

    -- 3D BOX
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "BartBox"
    box.Adornee = hrp
    box.Size = Vector3.new(4, 6, 4)
    box.Color3 = _G.BartESPColor
    box.Transparency = 0.6
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Parent = hrp

    -- NAME TAG
    local bill = Instance.new("BillboardGui")
    bill.Name = "BartName"
    bill.Adornee = head
    bill.Size = UDim2.new(0, 200, 0, 40)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.AlwaysOnTop = true

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = player.Name
    text.TextColor3 = _G.BartESPColor
    text.TextStrokeTransparency = 0
    text.TextScaled = true
    text.Font = Enum.Font.SourceSansBold
    text.Parent = bill

    bill.Parent = head

    bartESP[player] = { box, bill }
end

-- REMOVE ESP
local function removeBartESP()
    for _, objs in pairs(bartESP) do
        for _, obj in ipairs(objs) do
            if obj then obj:Destroy() end
        end
    end
    bartESP = {}
end

-- RAYFIELD TOGGLE
Tab:CreateToggle({
    Name = "Bart 3D ESP",
    CurrentValue = false,
    Flag = "Bart3DESP_TOGGLE_001",
    Callback = function(Value)
        if Value then
            for _, plr in ipairs(Players:GetPlayers()) do
                createBartESP(plr)

                plr.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    createBartESP(plr)
                end)
            end
        else
            removeBartESP()
        end
    end,
})

-- RAYFIELD COLOR PICKER
Tab:CreateColorPicker({
    Name = "Bart ESP Color",
    Color = _G.BartESPColor,
    Flag = "BartESPColor_PICKER_001",
    Callback = function(Color)
        _G.BartESPColor = Color

        -- UPDATE EXISTING ESP
        for _, objs in pairs(bartESP) do
            local box = objs[1]
            local bill = objs[2]

            if box then
                box.Color3 = Color
            end

            if bill then
                local label = bill:FindFirstChildOfClass("TextLabel")
                if label then
                    label.TextColor3 = Color
                end
            end
        end
    end,
})








local Section = Tab:CreateSection("Homer Esp")

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GLOBAL COLOR (persists)
_G.HomerESPColor = _G.HomerESPColor or Color3.fromRGB(255, 0, 0)

-- ESP STORAGE
local homerESP = {}

-- CREATE ESP
local function createHomerESP(player)
    if player == LocalPlayer then return end
    if not player.Team or player.Team.Name ~= "Homer" then return end
    if not player.Character then return end

    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not hrp or not head then return end

    -- prevent duplicates
    if hrp:FindFirstChild("HomerBox") then return end

    -- 3D BOX
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "HomerBox"
    box.Adornee = hrp
    box.Size = Vector3.new(4, 6, 4)
    box.Color3 = _G.HomerESPColor
    box.Transparency = 0.6
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Parent = hrp

    -- NAME TAG
    local bill = Instance.new("BillboardGui")
    bill.Name = "HomerName"
    bill.Adornee = head
    bill.Size = UDim2.new(0, 200, 0, 40)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.AlwaysOnTop = true

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = player.Name
    text.TextColor3 = _G.HomerESPColor
    text.TextStrokeTransparency = 0
    text.TextScaled = true
    text.Font = Enum.Font.SourceSansBold
    text.Parent = bill

    bill.Parent = head

    homerESP[player] = { box, bill }
end

-- REMOVE ESP
local function removeHomerESP()
    for _, objs in pairs(homerESP) do
        for _, obj in ipairs(objs) do
            if obj then obj:Destroy() end
        end
    end
    homerESP = {}
end

-- RAYFIELD TOGGLE
Tab:CreateToggle({
    Name = "Homer 3D ESP",
    CurrentValue = false,
    Flag = "Homer3DESP_TOGGLE_001",
    Callback = function(Value)
        if Value then
            for _, plr in ipairs(Players:GetPlayers()) do
                createHomerESP(plr)

                plr.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    createHomerESP(plr)
                end)
            end
        else
            removeHomerESP()
        end
    end,
})

-- RAYFIELD COLOR PICKER
Tab:CreateColorPicker({
    Name = "Homer ESP Color",
    Color = _G.HomerESPColor,
    Flag = "HomerESPColor_PICKER_001", -- UNIQUE
    Callback = function(Color)
        _G.HomerESPColor = Color

        -- UPDATE EXISTING ESP
        for _, objs in pairs(homerESP) do
            local box = objs[1]
            local bill = objs[2]

            if box then
                box.Color3 = Color
            end

            if bill then
                local label = bill:FindFirstChildOfClass("TextLabel")
                if label then
                    label.TextColor3 = Color
                end
            end
        end
    end,
})








local Tab = Window:CreateTab("Troll", 4483362458) -- Title, Image

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ToolName = "Pizza" -- or "Flashlight"
local Spamming = false

local Toggle = Tab:CreateToggle({
   Name = "Pizza Spam",
   CurrentValue = false,
   Flag = "EquipSpamSlow",
   Callback = function(Value)
      Spamming = Value

      task.spawn(function()
         while Spamming do
            task.wait(0.15) -- 🔧 SPEED CONTROL (increase = slower)

            local character = player.Character
            local backpack = player:FindFirstChild("Backpack")
            if not character or not backpack then continue end

            local tool = backpack:FindFirstChild(ToolName)
               or character:FindFirstChild(ToolName)

            if tool then
               if tool.Parent == backpack then
                  tool.Parent = character -- equip
               else
                  tool.Parent = backpack -- unequip
               end
            end
         end
      end)
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ToolName = "Flashlight" -- switched from Pizza
local Spamming = false

local Toggle = Tab:CreateToggle({
   Name = "Flashlight Spam",
   CurrentValue = false,
   Flag = "FlashlightEquipSpam",
   Callback = function(Value)
      Spamming = Value

      task.spawn(function()
         while Spamming do
            task.wait(0.15) -- speed control (higher = slower)

            local character = player.Character
            local backpack = player:FindFirstChild("Backpack")
            if not character or not backpack then continue end

            local tool = backpack:FindFirstChild(ToolName)
               or character:FindFirstChild(ToolName)

            if tool then
               if tool.Parent == backpack then
                  tool.Parent = character -- equip
               else
                  tool.Parent = backpack -- unequip
               end
            end
         end
      end)
   end,
})


local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Instant Quidz",
   Callback = function()
      local character = player.Character
      if not character then return end

      local root = character:FindFirstChild("HumanoidRootPart")
      if not root then return end

      root.CFrame = CFrame.new(-33.54, 210.90, 110.52)
   end,
})




local Tab = Window:CreateTab("Misc", 4483362458) -- Title, Image

local Lighting = game:GetService("Lighting")

local Button = Tab:CreateButton({
   Name = "Full Bright",
   Callback = function()
      Lighting.Brightness = 2
      Lighting.ClockTime = 14
      Lighting.FogEnd = 100000
      Lighting.GlobalShadows = false
      Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
   end,
})

local Camera = workspace.CurrentCamera

local Slider = Tab:CreateSlider({
   Name = "FOV Slider",
   Range = {70, 140},
   Increment = 1,
   Suffix = "FOV",
   CurrentValue = 70,
   Flag = "FOVSlider",
   Callback = function(Value)
      Camera.FieldOfView = Value
   end,
})

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Button = Tab:CreateButton({
   Name = "Unlock Zoom Distance",
   Callback = function()
      player.CameraMinZoomDistance = 0.5
      player.CameraMaxZoomDistance = 10000000
   end,
})

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local placeId = game.PlaceId

local Button = Tab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        TeleportService:Teleport(placeId, player)
    end,
})

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local originalJobId = game.JobId

local Enabled = false
local Connections = {}
local Hopping = false

-- Force hop until JobId changes
local function ForceServerHop()
    if Hopping then return end
    Hopping = true

    while game.JobId == originalJobId do
        TeleportService:Teleport(placeId, player)
        task.wait(2) -- let Roblox try another server
    end
end

local function HookPlayer(plr)
    if plr == player then return end

    local conn = plr.Chatted:Connect(function(msg)
        if Enabled and string.find(string.lower(msg), "hacker") then
            ForceServerHop()
        end
    end)

    table.insert(Connections, conn)
end

local Toggle = Tab:CreateToggle({
    Name = "Hop if Chat Says 'hacker'",
    CurrentValue = false,
    Flag = "HopOnHackerFixed",
    Callback = function(Value)
        Enabled = Value

        -- Cleanup
        for _, conn in ipairs(Connections) do
            conn:Disconnect()
        end
        table.clear(Connections)
        Hopping = false

        if not Value then return end

        -- Hook existing players
        for _, plr in ipairs(Players:GetPlayers()) do
            HookPlayer(plr)
        end

        -- Hook new players
        table.insert(Connections,
            Players.PlayerAdded:Connect(function(plr)
                HookPlayer(plr)
            end)
        )
    end,
})


local Button = Tab:CreateButton({
   Name = "Button Example",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})











Rayfield:LoadConfiguration()