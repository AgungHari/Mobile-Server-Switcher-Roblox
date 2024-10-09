local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local Players = game:GetService("Players")


local function createNotification()
    local player = Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui", player.PlayerGui)
    screenGui.Name = "TeleportNotification"
    
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0.5, 0, 0.1, 0)  
    frame.Position = UDim2.new(0.25, 0, 0.45, 0)  
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5  

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = "Mencari server lain..."
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.TextScaled = true
    
    return screenGui
end

local function GetServerList()
    local Servers = {}
    local cursor = ""

    repeat
        local url = "https://games.roblox.com/v1/games/".. PlaceId .."/servers/Public?sortOrder=Asc&limit=100"
        if cursor ~= "" then
            url = url .. "&cursor=" .. cursor
        end

        local response = HttpService:GetAsync(url, true)
        local data = HttpService:JSONDecode(response)

        for _, server in pairs(data.data) do
            if server.playing < server.maxPlayers then
                table.insert(Servers, server.id)
            end
        end

        cursor = data.nextPageCursor
    until not cursor

    return Servers
end

local function TeleportToAnotherServer()
    local servers = GetServerList()

    if #servers > 0 then

        local notification = createNotification()
        

        local randomServer = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(PlaceId, randomServer)
    else
        print("Tidak ada server yang tersedia!")
    end
end


local UIS = game:GetService("UserInputService")

UIS.TouchTap:Connect(function()
    TeleportToAnotherServer()
end)
