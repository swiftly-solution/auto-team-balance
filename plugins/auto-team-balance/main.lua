AddEventHandler("OnRoundEnd", function (event)
    local total_players = playermanager:GetPlayerCount()
    local CTData = GetTeamPlayerCount(Team.CT, false)
    local TData = GetTeamPlayerCount(Team.T, false)

    local targetDifference = total_players % 2

        while math.abs(CTData.count - TData.count) > targetDifference do
            if CTData.count > TData.count then
                local rIndex = math.random(1, #CTData.players)
                local random_playerobj = table.remove(CTData.players, rIndex)
                local random_player = GetPlayer(random_playerobj.id)
                if config:Fetch("auto-team-balance.KillOnSwitch") then
                    random_player:SwitchTeam(Team.T)
                else
                    print("changed")
                    random_player:ChangeTeam(Team.T)
                end
                TData.count = TData.count + 1
                CTData.count = CTData.count - 1
                ReplyToCommand(random_playerobj.id, config:Fetch("auto-team-balance.prefix"), FetchTranslation("autoteambalance.moved_player"):gsub("{TEAM}", "T"))
                for i = 1, playermanager:GetPlayerCap() do
                    ReplyToCommand(i-1, config:Fetch("auto-team-balance.prefix"), FetchTranslation("autoteambalance.moved_general"):gsub("{NAME}", random_player:CBasePlayerController().PlayerName):gsub("{TEAM}", "T"))
                end
            elseif TData.count > CTData.count then
                local rIndex = math.random(1, #TData.players)
                local random_playerobj = table.remove(TData.players, rIndex)
                local random_player = GetPlayer(random_playerobj.id)
                if config:Fetch("auto-team-balance.KillOnSwitch") then
                    random_player:SwitchTeam(Team.CT)
                else
                    print("changed")
                    random_player:ChangeTeam(Team.CT)
                end
                CTData.count = CTData.count + 1
                TData.count = TData.count - 1
                ReplyToCommand(random_playerobj.id, config:Fetch("auto-team-balance.prefix"), FetchTranslation("autoteambalance.moved_player"):gsub("{TEAM}", "CT"))
                print(random_player:CBasePlayerController().PlayerName)
                for i = 1, playermanager:GetPlayerCap() do
                    ReplyToCommand(i-1, config:Fetch("auto-team-balance.prefix"), FetchTranslation("autoteambalance.moved_general"):gsub("{NAME}", random_player:CBasePlayerController().PlayerName):gsub("{TEAM}", "CT"))
            end
        end
    end
end)
