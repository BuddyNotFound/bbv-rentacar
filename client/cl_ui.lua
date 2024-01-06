CreateThread(function()
    Wait(1000)
    LoadConfigCars()
end)

--// Functions \\ -- UI BUILD BY NEENGAME

function RentACar(bool)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'OpenRentui',
    })
end

function CloseUi()
    SendNUIMessage({
        action = 'CloseRentUI',
    })
    SetNuiFocus(false, false)
end

function LoadConfigCars()
    SendNUIMessage({
        action = 'LoadCars',
        cars = Config.Cars
    })
end

--// NuiCallbacks \\--

RegisterNUICallback('CloseRentUi', function()
    CloseUi()
end)
