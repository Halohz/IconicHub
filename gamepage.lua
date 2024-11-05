-- Load Orion Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Create the main window and "Other" tab for Iconic Hub
local Window = OrionLib:MakeWindow({
    Name = "Iconic Hub - Home Screen",              
    HidePremium = false,               
    SaveConfig = true,                 
    ConfigFolder = "IconicHubConfig",  
    IntroEnabled = true,               
    IntroText = "Welcome to Iconic Hub!",
})

local OtherTab = Window:MakeTab({
    Name = "Other",                   
    Icon = "rbxassetid://4483345998",  
    PremiumOnly = false                
})

local OtherSection = OtherTab:AddSection({
    Name = "Private Server Cracker"
})

-- Variables to control the script's behavior
local crackingEnabled = false
local copyToClipboardEnabled = false

-- Function to generate a random private server code
local function generateRandomCode()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local code = ""
    for i = 1, 10 do
        local randomIndex = math.random(1, #chars)
        code = code .. chars:sub(randomIndex, randomIndex)
    end
    return code
end

-- Function to attempt joining a private server
local function attemptServerJoin(code)
    -- Access the necessary UI elements and remotes
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Validate the necessary GUI and remotes exist
    local PSCodeRemote = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("PSCode")
    local JoinButton = LocalPlayer.PlayerGui.MainMenu.Menus.PrivateServers.Frames.PrivateServer.Buttons.Join
    local CodeTextLabel = LocalPlayer.PlayerGui.MainMenu.Menus.PrivateServers.Frames.PrivateServer.Code.TextLabel

    if not PSCodeRemote or not JoinButton or not CodeTextLabel then
        print("Necessary elements for the Private Server Cracker are not found.")
        return false
    end

    -- Set the code in the TextLabel and attempt the join action
    CodeTextLabel.Text = code
    PSCodeRemote:InvokeServer(code)
    JoinButton:Activate()  -- Simulates pressing the "Join" button

    -- Copy code to clipboard if the option is enabled
    if copyToClipboardEnabled then
        setclipboard(code)  -- Copies the code to the clipboard
        print("Code copied to clipboard:", code)
    end
    
    print("Attempted server join with code:", code)
    return true
end

-- Function to handle the cracking loop
local function startCracking()
    while crackingEnabled do
        local code = generateRandomCode()
        local success = attemptServerJoin(code)
        
        -- Wait 4 seconds to respect the cooldown
        if success then
            wait(4)
        else
            print("Error attempting to join server.")
            return
        end
    end
end

-- Toggle for enabling/disabling the Private Server Cracker
OtherTab:AddToggle({
    Name = "Private Server Cracker",
    Default = false,
    Callback = function(value)
        crackingEnabled = value
        if crackingEnabled then
            print("Private Server Cracker enabled")
            startCracking()
        else
            print("Private Server Cracker disabled")
        end
    end
})

-- Toggle for enabling/disabling copying code to clipboard
OtherTab:AddToggle({
    Name = "Private Server to Clipboard",
    Default = false,
    Callback = function(value)
        copyToClipboardEnabled = value
        print("Private Server to Clipboard is now", value and "enabled" or "disabled")
    end
})

-- Initialize the UI
OrionLib:Init()
