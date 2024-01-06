Wrapper.CreateCallback('bbv-rentacar:hasmoney', function(source, cb, money)
    if Config.Settings.Framework == "QB" then 
        local src = source 
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.money.cash >= money then
            Player.Functions.RemoveMoney('cash', money)
            cb(true)
        else
            cb(false)
        end
    end
    if Config.Settings.Framework == "ESX" then 
        local src = source 
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.getMoney() >= money then
            xPlayer.removeMoney(money)
            cb(true)
        else
            cb(false)
        end
    end
    if Config.Settings.Framework == "ST" then 
        cb(true)
    end
end)
