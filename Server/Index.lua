Package.Require("Utils.lua")

local teamColours = {
    "red",
    "yellow",
    "pink",
    "green",
    "blue",
    "orange",
    "black",
    "white",
    "purple",
    "brown"
}
local gameStarted = false
local unavailableTeams = {}


-- Calls to check start gamemode function
local my_interval = Timer.SetInterval(function()
    StartGame()
end, 3000)

-- Checks if the gamemode should initialize depending on player count
function StartGame()
    local currentPlayerCount = #Player.GetAll()
    if currentPlayerCount >= 2 and not gameStarted then
        gameStarted = true
        Server.BroadcastChatMessage("Starting...")
        Timer.ClearInterval(my_interval)
    else
        Server.BroadcastChatMessage(string.format("Not enough players to start. %s connected", currentPlayerCount))
    end
end

-- Assigns a player and team when they spawn
Player.Subscribe("Spawn", function(player)
    SpawnPlayer(player)
    SelectRandomTeam(player)
    Server.BroadcastChatMessage(string.format("%s has joined <%s>team %s</>", player:GetName(), player:GetValue("Team", "Penis"), player:GetValue("Team", "Penis")))
end)

-- Removes assigned team and deletes character when player disconnects
Player.Subscribe("Destroy", function(player)
    local character = player:GetControlledCharacter()
    if character then
        RemoveTeam(player)
        character:Destroy()
    end
end)

-- Selects a random team for player
function SelectRandomTeam(player)
    local randomColour = teamColours[math.floor(math.random() * #teamColours) + 1]
    if table.contains(unavailableTeams, randomColour) then
        print("Team colour taken, picking a random one again.")
        SelectRandomTeam(player)
    else
        if #unavailableTeams == 10 or gameStarted then
            player:SetValue("Team", "Specatator", true)
        else
            unavailableTeams[#unavailableTeams + 1] = randomColour
            player:SetValue("Team", randomColour, true)
        end
    end
end

-- Removes players Team
function RemoveTeam(player)
    local currentTeam = player:GetValue("Team", nil)
    if currentTeam then
        for index, value in pairs (unavailableTeams) do
            if currentTeam == value then
                table.remove(unavailableTeams, index)
            end
        end
        Package.Log(((("Removed " .. tostring(currentTeam)) .. ": ") .. tostring(#unavailableTeams)) .. " teams taken.")
    end
end

-- Creates Character
function CreateCharacter()
    -- Add more custom stuff here
    local character = Character(Vector(0, 0, 0), Rotator(0, 0, 0), "nanos-world::SK_Female")
    return character
end
