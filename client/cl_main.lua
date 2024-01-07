Main = {
    SavedPos = Config.Settings.RentLocation,
    TestDrive = false,
    Peds = {},
    Vehs = {},
    RentCar = nil,
}

CreateThread(function()
    Wait(1000)
    Wrapper:Blip('RentCarBlip','Rent A Car',Config.Settings.RentLocation,811,3)
    Wrapper:Target('bbv-rentacar-target','Rent a Car',vec3(Config.Settings.RentLocation.x,Config.Settings.RentLocation.y,Config.Settings.RentLocation.z + 1),'bbv-rentacar')
    Main:SpawnPed('bbv-rentacar-ped',Config.Settings.RentLocation,'a_m_y_business_02')
end)

function Main:SpawnPed(k,pos,model)
    Wrapper:LoadModel(model)
    Main.Peds[k] =  CreatePed(4, model,pos.x,pos.y,pos.z -1, pos.w,false)
    SetEntityHeading(Main.Peds[k], pos.w)
    FreezeEntityPosition(Main.Peds[k], true)
    SetEntityInvincible(Main.Peds[k], true)
    SetBlockingOfNonTemporaryEvents(Main.Peds[k], true)
    RequestAnimDict("anim@heists@heist_corona@single_team")
    while not HasAnimDictLoaded("anim@heists@heist_corona@single_team") do
    Citizen.Wait(0)
    end
    TaskPlayAnim(Main.Peds[k],"anim@heists@heist_corona@single_team","single_team_loop_boss", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end

RegisterNetEvent('bbv-rentacar',function()
    if Main.RentCar ~= nil and Config.Settings.LimitCars then Wrapper:Notify("You already have a car rented out.") return end
    RentACar()
end)

RegisterNUICallback('PreviewInformation', function(data)
    local carspawn = Config.Settings.CarSpawn
    local car = data.Rentid
    local price = data.RentPrice
    Wrapper.TriggerCallback('bbv-rentacar:hasmoney', function(money)
        if money then 
            Wrapper:Notify("You rented " .. car .. ' for ' .. price .. "$")
            Main:SpawnVeh(carspawn,car,true,false)
        else
            Wrapper:Notify("You don't have enough money!")
        end
    end,price)
end)

CarBlips = {}

function Main:SpawnVeh(coords,model,isnetworked,test)
    local ped = PlayerPedId()
    Wrapper:Blip('ReturnCar','Return Rent',Config.Settings.ReturnLocation,812,53)
    model = type(model) == 'string' and GetHashKey(model) or model
    if not IsModelInCdimage(model) then return end
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    isnetworked = isnetworked == nil or isnetworked
    Wrapper:LoadModel(model)
    Main.Vehs[coords] = CreateVehicle(model, coords.x, coords.y, coords.z - 1, coords.w, false, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleNumberPlateText(Main.Vehs[coords],'BBVXWRLD')
    SetVehicleHasBeenOwnedByPlayer(Main.Vehs[coords], true)
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(Main.Vehs[coords]))
    SetNetworkIdCanMigrate(netid, true)
    SetVehicleNeedsToBeHotwired(Main.Vehs[coords], false)
    SetVehRadioStation(Main.Vehs[coords], 'OFF')
    SetVehicleFuelLevel(Main.Vehs[coords], 100.0)
    SetModelAsNoLongerNeeded(model)
    SetVehicleOnGroundProperly(Main.Vehs[coords])
    SetVehicleNumberPlateText(Main.Vehs[coords], "RENT"..math.random(1,9)..math.random(1,9)..math.random(1,9)..math.random(1,9))
    
    if Config.Settings.CarBlip then
        CarBlips[coords] = AddBlipForEntity(Main.Vehs[coords])
        SetBlipScale(CarBlips[coords],0.6)
        SetBlipSprite(CarBlips[coords],672)
        SetBlipColour(CarBlips[coords],5)

        SetBlipDisplay(CarBlips[coords], 4)
        SetBlipAsShortRange(CarBlips[coords], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Rental Car')
        EndTextCommandSetBlipName(CarBlips[coords])
    end

    self.RentCar = Main.Vehs[coords]
    if Config.Settings.MaxTune then Main:MaxOut(ped,Main.Vehs[coords]) end
    if not test then 
        FreezeEntityPosition(Main.Vehs[coords],true)
        for i=1, 255 do
            SetEntityAlpha(Main.Vehs[coords], i)
            Wait(10)
        end
        FreezeEntityPosition(Main.Vehs[coords],false)
    end
    if test then
        DoScreenFadeOut(1000)
        Wait(2000)
        TaskWarpPedIntoVehicle(PlayerPedId(),Main.Vehs[coords],-1)
        DoScreenFadeIn(1000)
    end
end

function Main:MaxOut(ped,veh)
    if not veh then 
        veh = GetVehiclePedIsIn(ped, false)
    end 
        SetVehicleModKit(veh, 0)
        SetVehicleMod(veh, 0, GetNumVehicleMods(veh, 0) - 1, false)
        SetVehicleMod(veh, 1, GetNumVehicleMods(veh, 1) - 1, false)
        SetVehicleMod(veh, 2, GetNumVehicleMods(veh, 2) - 1, false)
        SetVehicleMod(veh, 3, GetNumVehicleMods(veh, 3) - 1, false)
        SetVehicleMod(veh, 4, GetNumVehicleMods(veh, 4) - 1, false)
        SetVehicleMod(veh, 5, GetNumVehicleMods(veh, 5) - 1, false)
        SetVehicleMod(veh, 6, GetNumVehicleMods(veh, 6) - 1, false)
        SetVehicleMod(veh, 7, GetNumVehicleMods(veh, 7) - 1, false)
        SetVehicleMod(veh, 8, GetNumVehicleMods(veh, 8) - 1, false)
        SetVehicleMod(veh, 9, GetNumVehicleMods(veh, 9) - 1, false)
        SetVehicleMod(veh, 10, GetNumVehicleMods(veh, 10) - 1, false)
        SetVehicleMod(veh, 11, GetNumVehicleMods(veh, 11) - 1, false)
        SetVehicleMod(veh, 12, GetNumVehicleMods(veh, 12) - 1, false)
        SetVehicleMod(veh, 13, GetNumVehicleMods(veh, 13) - 1, false)
        SetVehicleMod(veh, 14, 16, false)
        SetVehicleMod(veh, 15, GetNumVehicleMods(veh, 15) - 2, false)
        SetVehicleMod(veh, 16, GetNumVehicleMods(veh, 16) - 1, false)
        ToggleVehicleMod(veh, 17, true)
        ToggleVehicleMod(veh, 18, true)
        ToggleVehicleMod(veh, 19, true)
        ToggleVehicleMod(veh, 20, true)
        ToggleVehicleMod(veh, 21, true)
        ToggleVehicleMod(veh, 22, true)
        SetVehicleMod(veh, 24, 1, false)
        SetVehicleMod(veh, 25, GetNumVehicleMods(veh, 25) - 1, false)
        SetVehicleMod(veh, 27, GetNumVehicleMods(veh, 27) - 1, false)
        SetVehicleMod(veh, 28, GetNumVehicleMods(veh, 28) - 1, false)
        SetVehicleMod(veh, 30, GetNumVehicleMods(veh, 30) - 1, false)
        SetVehicleMod(veh, 33, GetNumVehicleMods(veh, 33) - 1, false)
        SetVehicleMod(veh, 34, GetNumVehicleMods(veh, 34) - 1, false)
        SetVehicleMod(veh, 35, GetNumVehicleMods(veh, 35) - 1, false)
        SetVehicleMod(veh, 38, GetNumVehicleMods(veh, 38) - 1, true)
        SetVehicleWindowTint(veh, 1)
        SetVehicleTyresCanBurst(veh, false)
        SetVehicleNumberPlateTextIndex(veh, 5)
end

RegisterNUICallback('InsideInformation', function(data)
    Main:TestDrive(data.Rentid)
end)

function Main:TestDrive(car)
    self.SavedPos = GetEntityCoords(PlayerPedId())
    self.TestDrive = true
    local carspawn = Config.Settings.TestDriveLocation
    Main:SpawnVeh(carspawn,car,true,true)
    TriggerEvent('bbv-renttimer')
    for i=1, Config.Settings.TestDriveTime do
        Wait(1000)
        msg = i
    end
    Main.TestDrive = false
    Main:LeaveTestDrive()
end

RegisterNetEvent('bbv-renttimer',function()
    msg = Config.Settings.TestDriveTime
    local spawnpos = vec3(Config.Settings.TestDriveLocation.x,Config.Settings.TestDriveLocation.y,Config.Settings.TestDriveLocation.z)
    local maxsize = Config.Settings.TestDriveLocationSize
    while Main.TestDrive do 
        Wait(0)
        local mypos = GetEntityCoords(PlayerPedId())
        local dist = #(mypos - spawnpos)
        Wrapper:Prompt('Seconds Left ' ..Config.Settings.TestDriveTime - msg)
        if not IsPedInAnyVehicle(PlayerPedId(), true) then 
            Main:LeaveTestDrive()
        end
        if dist > maxsize then 
            Main:LeaveTestDrive()
        end
    end
end)

function Main:LeaveTestDrive()
    if not Main.TestDrive then return end
    Main.TestDrive = false
    self.RentCar = nil
    DoScreenFadeOut(1000)
    Wait(1500)
    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
    SetEntityCoords(PlayerPedId(),self.SavedPos)
    DoScreenFadeIn(1000)
end

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k,v in pairs(Main.Vehs) do 
        DeleteVehicle(v)
    end
end)

CreateThread(function()
    local WaitTime = 3000
    while true do
        Wait(WaitTime)
        if Main.RentCar ~= nil then
            local mypos = GetEntityCoords(PlayerPedId())
            local dist = #(mypos - Config.Settings.ReturnLocation)
            if dist < 5 then 
                WaitTime = 0
                Wrapper:Prompt('Press [E] to return the car')
                DrawMarker(0, Config.Settings.ReturnLocation, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.75, 0.75, 0.75, 204, 204, 0, 100, false, true, 2, false, false, false, false)
                if IsControlPressed(0,46) then
                    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()))
                    if plate == GetVehicleNumberPlateText(Main.RentCar) then
                        Wrapper:RemoveBlip('ReturnCar')
                        Main.RentCar = nil
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                    else
                        Wrapper:Notify("This is not the same car you rented!")
                    end
                end
            else
                WaitTime = 3000
            end
        end
    end
end)