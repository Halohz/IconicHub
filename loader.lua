-- Define game-specific loadstrings in a table
local gameidloadstrings = {
    [5130598377] = "https://raw.githubusercontent.com/Halohz/IconicHub/refs/heads/main/gamepage.lua",
    [6846458508] = "https://raw.githubusercontent.com/Halohz/IconicHub/refs/heads/main/maingame.lua"
}

-- Get the current game's ID
local currentGameId = game.PlaceId

-- Check if there's a matching URL for the current game
if gameidloadstrings[currentGameId] then
    -- Fetch the script content and execute it
    local scriptContent = game:HttpGet(gameidloadstrings[currentGameId])
    loadstring(scriptContent)()
else
    -- If the game ID does not match, print a message
    print("You're not in a supported AUT game :/")
end
