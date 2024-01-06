Wrapper = {
    resname = GetCurrentResourceName(),
    ServerCallbacks = {}
}

RegisterNetEvent(Wrapper.resname.."Wrapper:RemoveMoney",function(type,amount)
    Wrapper:RemoveMoney(type,amount)
end)

function Wrapper:RemoveMoney(type,amount)
    local src = source
    if Config.Settings.Framework == "QB" then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        Player.Functions.RemoveMoney(type, amount)
    end
    if Config.Settings.Framework == "ESX" then 
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeAccountMoney(type, amount)
    end
end

