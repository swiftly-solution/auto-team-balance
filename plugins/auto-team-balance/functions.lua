function GetTeamPlayerCount(team, nobots) -- thanks a lot ilusion <3
    local playerCount = {}
    
    if type(team) == "table" then
        for i = 1, #team do
            playerCount[team[i]] = { count = 0, players = {} }
        end
    else
        playerCount[team] = { count = 0, players = {} }
    end
    
    for i = 1, playermanager:GetPlayerCap() do
        local player = GetPlayer(i - 1)
        
        if player and player:IsValid() then
            local playerTeam = player:CBaseEntity().TeamNum
            
            if playerCount[playerTeam] then
                    playerCount[playerTeam].count = playerCount[playerTeam].count + 1
                    
                    local playerData = {
                        id = player:GetSlot(),
                        name = player:CBasePlayerController().PlayerName
                    }
                    table.insert(playerCount[playerTeam].players, playerData)
            end
        end
    end
    
    return type(team) == "table" and playerCount or playerCount[team]
end