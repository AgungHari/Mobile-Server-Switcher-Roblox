local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local UIS = game:GetService("UserInputService")


local function createSimpleGUI()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui", 5) 

    if playerGui then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "TestGUI"
        screenGui.Parent = playerGui

        local frame = Instance.new("Frame", screenGui)
        frame.Size = UDim2.new(0.5, 0, 0.1, 0)  
        frame.Position = UDim2.new(0.25, 0, 0.45, 0) 
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 0.5  

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Text = "Pencet untuk pindah"
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.SourceSans
        label.TextScaled = true
    else
        warn("Komtowl!")
    end
end


createSimpleGUI()


local function teleportToAnotherServer()
    print("Mencoba untuk teleport...")
    
    local success, errorMessage = pcall(function()
        TeleportService:Teleport(PlaceId)
    end)

    if not success then
        warn("Gagal teleport: " .. errorMessage)
    else
        print("Teleport berhasil")
    end
end

local function detectTouchInput()
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            print("Input Touch terdeteksi")
            teleportToAnotherServer()
        end
    end)
end

detectTouchInput()
