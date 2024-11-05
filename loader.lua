local gameidloadstrings = {
    [5130598377] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Halohz/IconicHub/refs/heads/main/gamepage.lua'))()",
    [6846458508] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/Halohz/IconicHub/refs/heads/main/maingame.lua'))()"
}

local currentGameId = game.PlaceId

if gameidloadstrings[currentGameId] then
    gameidloadstrings(game:HttpGet(gameidloadstrings[currentGameId]))()
else
    print("You're not in a supported AUT game :/")
end
